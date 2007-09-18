Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0942EDDEC1
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 01:12:32 +1000 (EST)
Date: Tue, 18 Sep 2007 10:11:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 16/28] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Message-ID: <20070918151147.GB736@ld0162-tx32.am.freescale.net>
References: <20070917165746.GP6563@loki.buserror.net>
	<58472170-34D3-43F4-A816-87AF0020A086@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58472170-34D3-43F4-A816-87AF0020A086@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 10:08:50AM -0500, Kumar Gala wrote:
> 
> On Sep 17, 2007, at 11:57 AM, Scott Wood wrote:
> 
> >On arch/ppc, Soft_emulate_8xx was used when full math emulation was
> >turned off to emulate a minimal subset of floating point load/store
> >instructions, to avoid needing a soft-float toolchain.  This function
> >is called, but not present, on arch/powerpc, causing a build error
> >if floating point emulation is turned off.
> >
> >As:
> >1. soft-float toolchains are now common,
> >2. partial emulation could mislead someone into thinking they have
> >a soft-float userspace because things usually work, only to have it
> >fail when actual FP gets executed under unusual circumstances, and
> >3. full emulation is still available for those who need to run
> >non-soft-float userspace,
> >
> >I'm deleting the call rather than moving Soft_emulate_8xx over to
> >arch/powerpc.
> >
> >Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> I'm still not in favor of this and think we should move the  
> Soft_emulate_8xx code over.

Any particular reasons that outweigh the reasons I gave, especially #2?

-Scott
