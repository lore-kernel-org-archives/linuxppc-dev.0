Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 9643767A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 01:47:07 +1000 (EST)
Date: Tue, 5 Apr 2005 08:47:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20050405154700.GY25923@smtp.west.cox.net>
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
	<20050405152322.GC25311@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050405152322.GC25311@pegasos>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due to
	2.6.9-rc1-bk1	introduced residual data patch ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2005 at 05:23:22PM +0200, Sven Luther wrote:
> On Tue, Apr 05, 2005 at 07:38:02AM -0700, Tom Rini wrote:
> > On Tue, Apr 05, 2005 at 07:39:31AM +0200, Sven Luther wrote:
> > > On Tue, Apr 05, 2005 at 02:03:06AM +0200, Christian wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > > 
> > > > Sven Luther wrote:
> > > > >>># This is a BitKeeper generated diff -Nru style patch.
> > > > >>>#
> > > > >>># ChangeSet
> > > > >>>#   2004/08/16 10:35:18-07:00 trini@kernel.crashing.org
> > > > >>>#   ppc32: On PReP, use residual data for PCI dev -> IRQ, and use it.
> > > > >
> > > > > I got through all the changesets one by one, and it is most definitively this
> > > > > one. i unapply it and it works, i apply it and it breaks.
> > > > 
> > > > i can confirm this one.
> > > > 
> > > > the changesets are listed here:
> > > > http://linux.bkbits.net:8080/linux-2.6/patch@1.1803.125.6
> > > > 
> > > > ...and because i had some troubles getting a GNU diff-style patch with
> > > > /usr/bin/bk, i made one against 2.6.11.6:
> > > > 
> > > > http://nerdbynature.de/bits/hal/2.6.11.6/1.1803.125.6.diff
> > > > 
> > > > more info and dmesg under:
> > > > 
> > > > http://nerdbynature.de/bits/hal/2.6.11.6/
> > > > 
> > > > to summarize: i don't know exactly which changes, but *some* changes had
> > > > to be made to arch/ppc/platforms/prep_pci.c to get the network card
> > > > working [1] again (network code kept locking up the machine). after this
> > > > issue was resolved, i too noticed the scsi errors [2] others were
> > > > complaing about.
> > > 
> > > The issue seems obvious, the patch adds some different way of setting the
> > > irqs, based on the residual data, which fails to do what it should on the
> > > powerstack, and thus the irqs are fully left uninitialized. 
> > 
> > Can either of you verify that say 2.6.11.6 w/ "noresidual" on the
> > command-line works?  Thanks.
> 
> Notice that last i checked, there was a typo which forced you to say
> "nopresidual", and i think i did add this when i was testing, and it didn't
> help.

That's a problem, as 'noresidual' was supposed to disable the new stuff
introduced here, for boxes that it may have broken.

-- 
Tom Rini
http://gate.crashing.org/~trini/
