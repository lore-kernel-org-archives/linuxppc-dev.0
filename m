Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by ozlabs.org (Postfix) with ESMTP id 12D68B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 08:26:34 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 4so265864qwk.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 13:26:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091111183753.GA31815@rakim.wolfsonmicro.main>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
Date: Wed, 11 Nov 2009 16:26:31 -0500
Message-ID: <9e4733910911111326w7b1e465an9343e1f9a1815e43@mail.gmail.com>
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

On Wed, Nov 11, 2009 at 1:37 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:
>
>> There are two solutions:
>> 1) tell me where the end of the valid data is. That allows me to
>> program the hardware to not enqueue the invalid data.
>> 2) For batched hardware, pad an extra period with silence after the
>> end of the stream. (that what zeroing the buffer before handing it
>> back to ALSA
>
> You've also got the option of lying about where the hardware is in some
> form in order to give you more headroom.
>
> I'm not sure what you mean by "batched hardware" here.

SNDRV_PCM_INFO_BATCH

Hardware that can't give you the DMA position except at the end of DMA
transfers.


>
>> I believe this race is present in all ALSA drivers. =A0It's just a lot
>> harder to hit on different hardware. For example to hit it on Intel
>> HDA which is non-batched hardware, the song would need to end right at
>> the end of a period. Then the interrupt latency would need to be bad
>> enough that some invalid data got played. But x86 CPUs are very fast
>> so it is rare for the interrupt latency to be bad enough that the
>> stream doesn't get stopped in time.
>
> The potential is there for this to happen on any hardware, yes. =A0 On th=
e
> other hand, it's not been a pressing issue elswhere - including on
> things like older ARM systems which aren't exactly noted for their
> snappy performance. =A0It really does sound like there's something specia=
l
> going on with these systems that's at least somewhat unique to them.
>
>> > Providing a final valid data point to the driver would possibly even
>> > make things worse since if it were used then you'd have the equivalent
>> > race where the application has initialized some data but not yet manag=
ed
>> > to update the driver to tell it it's being handed over; if the driver
>
>> That's an under run condition.
>
> Yes, of course - the issue is that this approach encourages them, making
> the system less robust if things are on the edge. =A0The mpc5200 seems to
> be not just on the edge but comfortably beyond it for some reason.
>



--=20
Jon Smirl
jonsmirl@gmail.com
