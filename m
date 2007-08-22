Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15FEDDDE40
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 14:22:24 +1000 (EST)
Date: Tue, 21 Aug 2007 23:22:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Check _PAGE_RW and _PAGE_PRESENT on kernel addresses.
Message-ID: <20070822042216.GB18603@ld0162-tx32.am.freescale.net>
References: <20070821211048.GA8432@ld0162-tx32.am.freescale.net>
	<18123.45841.46703.125743@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18123.45841.46703.125743@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 01:52:49PM +1000, Paul Mackerras wrote:
> Scott Wood writes:
> 
> > Previously, the TLB miss handlers assumed that pages above KERNELBASE are
> > always present and read/write.  This assumption is false in the case of
> > CONFIG_DEBUG_PAGEALLOC.
> 
> >  	blt+	112f
> > +	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
> > +	rlwinm	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
> >  	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
> >  	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
> > -	mfspr	r1,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
> > -	rlwinm	r1,r1,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
> 
> I don't see that just moving those two lines up changes anything.  If
> you turned the rlwinm into an rlwimi (as you did in the DataStoreTLBMiss
> case) then it might make more sense.  Is this just an oversight?

Sorry, rlwimi was what I meant...

The data store path was what I found the problem and tested with, the
others were an apparently botched replication to the other handlers.

-Scott
