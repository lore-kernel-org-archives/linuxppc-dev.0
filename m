Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 897B867B1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 02:01:06 +1000 (EST)
Date: Wed, 8 Jun 2005 09:01:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050608090103.A32468@cox.net>
References: <20050607225210.A28898@cox.net>
	<609b05dd2d9806d7d1cd68696b1f49e2@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <609b05dd2d9806d7d1cd68696b1f49e2@freescale.com>;
	from kumar.gala@freescale.com on Wed, Jun 08, 2005 at 10:34:03AM
	-0500
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][4/5] RapidIO support: ppc32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2005 at 10:34:03AM -0500, Kumar Gala wrote:
> 
> On Jun 8, 2005, at 12:52 AM, Matt Porter wrote:
> 
> > On Tue, Jun 07, 2005 at 11:43:26PM -0500, Kumar Gala wrote:
> >> Two questions:
> >> 1. how well does will all of this handle > 32-bit phys addr?
> >
> > It does and it doesn't handle > 32-bit phys addr. It depends on which
> > configuration you are talking about.  If you are talking about I/O
> >> 32-bit, it's no problem.  If you are talking about handling DMA
> >> 32-bit,
> > then we need to handle a 64-bit DMA addr in the ppc32 implementations
> > and
> > also extend the arch messaging interface to let callers know when an
> > implementation can handle high DMA (system memory >4GB). This is all
> > pretty easy to handle once we need to support such a processor. So
> > far, nothing is available publicly. :)
> 
> Well 8548 is semi-public :)

Heh, well my definition is when Fscale has the reference manual
downloadable from the main website...as of last night that wasn't
the case for 8548. :)

<snip>

> >> I would prefer if we could have the memory offsets and irq's not be
> >> straight from the #define's
> >
> > I think this and #2 are separate issues. We can pass the mpc85xx
> > rio init code some parameters to abstract things to different
> > parts. This is similar to how we init different SoC's PCI host
> > bridges with some common code on PPC32 (marvell, 85xx, etc).
> >
> > I was just looking at doing this to support RIO on the 8548. At
> > the time I wrote this 85xx support there wasn't any info on the
> > 8548 available, but it's an easy thing to extend.
> 
> Agreed, they are separate issues, I'm cool on waiting to see what 
> happens with RIO <-> PCIE bridges in the future.  For now if you can 
> look at abstracting the offset, irq info that would be good (especially 
> since 8548 does msg'g a bit differently).

No problem. The first "ppc85xx_rio.c" was only intended to work on
the 8540/8560 stuff where I had hardware. From my look at 8548, it
shouldn't take much work.

-Matt
