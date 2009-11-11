Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9BFCB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 05:37:59 +1100 (EST)
Date: Wed, 11 Nov 2009 18:37:53 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Message-ID: <20091111183753.GA31815@rakim.wolfsonmicro.main>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
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

On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:

> There are two solutions:
> 1) tell me where the end of the valid data is. That allows me to
> program the hardware to not enqueue the invalid data.
> 2) For batched hardware, pad an extra period with silence after the
> end of the stream. (that what zeroing the buffer before handing it
> back to ALSA

You've also got the option of lying about where the hardware is in some
form in order to give you more headroom.

I'm not sure what you mean by "batched hardware" here.

> I believe this race is present in all ALSA drivers.  It's just a lot
> harder to hit on different hardware. For example to hit it on Intel
> HDA which is non-batched hardware, the song would need to end right at
> the end of a period. Then the interrupt latency would need to be bad
> enough that some invalid data got played. But x86 CPUs are very fast
> so it is rare for the interrupt latency to be bad enough that the
> stream doesn't get stopped in time.

The potential is there for this to happen on any hardware, yes.   On the
other hand, it's not been a pressing issue elswhere - including on
things like older ARM systems which aren't exactly noted for their
snappy performance.  It really does sound like there's something special
going on with these systems that's at least somewhat unique to them.

> > Providing a final valid data point to the driver would possibly even
> > make things worse since if it were used then you'd have the equivalent
> > race where the application has initialized some data but not yet managed
> > to update the driver to tell it it's being handed over; if the driver

> That's an under run condition.

Yes, of course - the issue is that this approach encourages them, making
the system less robust if things are on the edge.  The mpc5200 seems to
be not just on the edge but comfortably beyond it for some reason.
