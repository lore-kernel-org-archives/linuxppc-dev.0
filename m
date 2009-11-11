Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f198.google.com (mail-qy0-f198.google.com
	[209.85.221.198]) by ozlabs.org (Postfix) with ESMTP id ECD41B7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 10:13:27 +1100 (EST)
Received: by qyk36 with SMTP id 36so721819qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 15:13:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40911111357q22f57728va1b4bc8b5bc0425f@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
	<fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
	<9e4733910911111334o24f3114as6baaef82d7b17a05@mail.gmail.com>
	<fa686aa40911111357q22f57728va1b4bc8b5bc0425f@mail.gmail.com>
Date: Wed, 11 Nov 2009 18:13:25 -0500
Message-ID: <9e4733910911111513w5423333cp6cf08ceec9a94ac3@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 4:57 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Wed, Nov 11, 2009 at 2:34 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On Wed, Nov 11, 2009 at 2:24 PM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>> On Wed, Nov 11, 2009 at 11:37 AM, Mark Brown
>>> <broonie@opensource.wolfsonmicro.com> wrote:
>>>> On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:
>>>>> > Providing a final valid data point to the driver would possibly eve=
n
>>>>> > make things worse since if it were used then you'd have the equival=
ent
>>>>> > race where the application has initialized some data but not yet ma=
naged
>>>>> > to update the driver to tell it it's being handed over; if the driv=
er
>>>>
>>>>> That's an under run condition.
>>>>
>>>> Yes, of course - the issue is that this approach encourages them, maki=
ng
>>>> the system less robust if things are on the edge. =A0The mpc5200 seems=
 to
>>>> be not just on the edge but comfortably beyond it for some reason.
>>>
>>> I can't reproduce the issue at all as long at the dev_dbg() statement
>>> in the trigger stop path is disabled. =A0With it enabled, I hear the
>>> problem every time. =A0The 5200 may not be a speedy beast, but it is
>>> plenty fast enough to shut down the audio stream before stale data
>>> starts getting played out.
>>
>> "fast enough" - you just said it is a race.
>> I've been saying it is a race too.
>
> Yes, it is a race; but not the kind that is dangerous. =A0Audio playout
> is always a real-time problem; whether in the middle of a stream or at
> the end. =A0If the CPU gets nailed with an unbounded latency, then there
> will be audible artifacts - Regardless of whether the driver knows
> where the end of data is or not. =A0If it does know, then audio will
> stutter. =A0If it doesn't know, then there will be repeated samples.
> Both are nasty to the human ear. =A0So, making the driver do extra work
> to keep the extra data in sync will probably force larger minimum
> latencies for playout (trouble for VoIP apps) so the CPU can keep up,
> and won't help one iota for making audio better.

I don't think it is that much more work for ALSA to provide an
accessible field indicating the end of valid data. It's already
tracking appl_ptr. Appl_ptr just needs to be translated into a
physical DMA buffer address and we've been making mistakes doing that
translation.


>
> The real solution is to fix the worst case latencies.
>
>> There are two options:
>> 1) Eliminate the race by developing a system to deterministically flag
>> the end of valid data.
>> 2) Fudge everything around making it almost impossible to lose the
>> race, but the race is still there.
>
> 3) eliminate the unbounded latencies (fix the PSC driver and/or use a
> real time kernel)
> 4) make sure userspace fills all the periods with silence before
> triggering stop. =A0Gstreamer seems to already do this. =A0I suspect
> pulseaudio does the same.
>
>> The dev_dbg() aggravates the race until it is obviously visible every
>> time. A deterministic solution would not be impacted by the dev_dbg().
>
> But it still wouldn't help a bit when the same latency occurs in the
> middle of playback.

The deterministic solution of tracking the end of valid data ensures
that under run will be silent instead of playing invalid data.


>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Jon Smirl
jonsmirl@gmail.com
