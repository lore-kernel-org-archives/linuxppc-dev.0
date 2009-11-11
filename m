Return-Path: <jonsmirl@gmail.com>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 8EAB9B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 03:38:07 +1100 (EST)
Received: by pzk29 with SMTP id 29so871529pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 08:38:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091107201233.GC31789@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
Date: Wed, 11 Nov 2009 11:38:06 -0500
Message-ID: <9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
From: Jon Smirl <jonsmirl@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 7, 2009 at 3:12 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Nov 07, 2009 at 11:51:16AM -0700, Grant Likely wrote:
>> On Sat, Nov 7, 2009 at 5:51 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> current period. =A0My understanding of ALSA is that the application is
>> supposed to make sure there is enough silence in the buffer to handle
>> the lag between notification that the last period with valid data has
>> been played out and the stop trigger.
>
> This is certainly the most robust approach for applications. =A0For a
> large proportion of hardware it won't matter too much since they're able
> to shut down the audio very quickly but that can't be entirely relied
> upon, especially at higher rates on slower machines.

I can comment but no access to test equipment...

Playing invalid data always happens in the current ALSA model. The
only question is does enough of it play to be audible.

on the mpc5200 batched driver...
At the end of song ALSA only pads out the last period with silence.
When this buffer is fully enqueued the DMA hardware generates an interrupt.
The DMA hardware also begins enqueuing the next period.

Now we start a race. Can ALSA come back from that interrupt and stop
the playing of the enqueued data before it makes it out of the FIFO?
An mpc5200 is slow enough that the CPU never makes it back in time.
This isn't a latency problem, it never makes it back in time. Latency
issues just make it play more invalid data.

There are two solutions:
1) tell me where the end of the valid data is. That allows me to
program the hardware to not enqueue the invalid data.
2) For batched hardware, pad an extra period with silence after the
end of the stream. (that what zeroing the buffer before handing it
back to ALSA

I believe this race is present in all ALSA drivers.  It's just a lot
harder to hit on different hardware. For example to hit it on Intel
HDA which is non-batched hardware, the song would need to end right at
the end of a period. Then the interrupt latency would need to be bad
enough that some invalid data got played. But x86 CPUs are very fast
so it is rare for the interrupt latency to be bad enough that the
stream doesn't get stopped in time.

>
>> occur. =A0That says to me that the real problem is an unbounded latency
>> caused by another part of the kernel (the tty console in this case).
>
> That's certainly not going to help anything here - if a delay is
> introduced in telling the hardware to shut down the DMA then that
> increases the chance for the DMA controller to start pushing valid audio
> data from the buffer to the audio interface.
>
>> > A much cleaner solution would be for ALSA to provide a field that
>> > indicates the last valid address in the ring buffer system. Then in
>> > the driver's buffer complete callback I could get that value and
>> > reprogram the DMA engine not to run off the end of valid data. As each
>> > buffer completes I would reread the value and update the DMA stop
>> > address. You also need the last valid address field when DMA is first
>> > started.
>
>> ... assuming that audio needs to stop exactly at the end of valid
>> data. =A0But if the last few periods are silence, then this assumption
>> isn't true.
>
> Indeed, it makes the whole thing much more reliable.
>
> Providing a final valid data point to the driver would possibly even
> make things worse since if it were used then you'd have the equivalent
> race where the application has initialized some data but not yet managed
> to update the driver to tell it it's being handed over; if the driver
> just carries on running through the data there's a reasonable chance
> nobody will notice that case.

That's an under run condition.

ALSA would need to track how many periods the driver has queue. If
ALSA has received enough interrupts to know that the driver is playing
the last period, it would not be safe to just tack the data onto the
end. You would also need to call into the driver with a 'append' call.
That's because it isn't possible for ALSA to deterministically know if
the last period has finished playing or not. In the 'append' call
implementation the driver would determine if the DMA hardware was
still running and restart it if needed.


>



--=20
Jon Smirl
jonsmirl@gmail.com
