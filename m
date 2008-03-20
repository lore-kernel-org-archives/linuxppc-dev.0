Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0D79DE48C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 03:24:44 +1100 (EST)
Date: Thu, 20 Mar 2008 11:24:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Message-ID: <20080320162440.GA3237@loki.buserror.net>
References: <200803071521.00383.laurentp@cse-semaphore.com>
	<200803201439.59806.laurentp@cse-semaphore.com>
	<20080320150823.GB31587@ld0162-tx32.am.freescale.net>
	<200803201618.37051.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803201618.37051.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 04:18:26PM +0100, Laurent Pinchart wrote:
> I don't want to kill it either. What I meant is that my first patch will not 
> care about udbg so that I can get feedback about the CPM serial driver part. 
> I'll then see how to make udbg fit into that.

OK.

> > Perhaps we should stick more initialization into the cpm udbg code, so it
> > isn't so dependent on the bootloader setup... though we'd have push the
> > CPM reset and SMC allocation earlier in such a case.
> 
> When SMC1 is used as a serial console, SMC1 is the first CPM dpram
> allocation user.

Typically yes, but I wouldn't want to depend on that...

> This means the CPM dpram allocator will allocate a buffer at the beginning
> of the dpram. As he SMC controller will already be using the 64 first
> bytes of the dpram, it will not see any difference when being
> reinitialized.

Not always.  Planetcore, for example, puts SMC parameter RAM at 0x1100
rather than zero.

> This of course depends on the boot loader allocating parameter ram at the 
> beginning of the dpram for SMC1, but we already depend on that if I'm not 
> mistaken.

We don't depend on it -- it's specified in the smc node's reg property, and
in the absence of said regions in the muram node.

-Scott
