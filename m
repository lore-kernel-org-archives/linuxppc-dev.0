Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp7.wanadoo.fr (smtp7.wanadoo.fr [193.252.22.24])
	by ozlabs.org (Postfix) with ESMTP id 9930167A70
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 01:26:49 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0701.wanadoo.fr (SMTP Server) with ESMTP id C436770000A6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 17:26:45 +0200 (CEST)
Date: Tue, 5 Apr 2005 17:23:22 +0200
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050405152322.GC25311@pegasos>
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050405143802.GS25923@smtp.west.cox.net>
From: Sven Luther <sven.luther@wanadoo.fr>
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

On Tue, Apr 05, 2005 at 07:38:02AM -0700, Tom Rini wrote:
> On Tue, Apr 05, 2005 at 07:39:31AM +0200, Sven Luther wrote:
> > On Tue, Apr 05, 2005 at 02:03:06AM +0200, Christian wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > Sven Luther wrote:
> > > >>># This is a BitKeeper generated diff -Nru style patch.
> > > >>>#
> > > >>># ChangeSet
> > > >>>#   2004/08/16 10:35:18-07:00 trini@kernel.crashing.org
> > > >>>#   ppc32: On PReP, use residual data for PCI dev -> IRQ, and use it.
> > > >
> > > > I got through all the changesets one by one, and it is most definitively this
> > > > one. i unapply it and it works, i apply it and it breaks.
> > > 
> > > i can confirm this one.
> > > 
> > > the changesets are listed here:
> > > http://linux.bkbits.net:8080/linux-2.6/patch@1.1803.125.6
> > > 
> > > ...and because i had some troubles getting a GNU diff-style patch with
> > > /usr/bin/bk, i made one against 2.6.11.6:
> > > 
> > > http://nerdbynature.de/bits/hal/2.6.11.6/1.1803.125.6.diff
> > > 
> > > more info and dmesg under:
> > > 
> > > http://nerdbynature.de/bits/hal/2.6.11.6/
> > > 
> > > to summarize: i don't know exactly which changes, but *some* changes had
> > > to be made to arch/ppc/platforms/prep_pci.c to get the network card
> > > working [1] again (network code kept locking up the machine). after this
> > > issue was resolved, i too noticed the scsi errors [2] others were
> > > complaing about.
> > 
> > The issue seems obvious, the patch adds some different way of setting the
> > irqs, based on the residual data, which fails to do what it should on the
> > powerstack, and thus the irqs are fully left uninitialized. 
> 
> Can either of you verify that say 2.6.11.6 w/ "noresidual" on the
> command-line works?  Thanks.

Notice that last i checked, there was a typo which forced you to say
"nopresidual", and i think i did add this when i was testing, and it didn't
help.

Will try booting the debian 2.6.11-1 powerpc kernels which should include all
2.6.11.6 patches.

Friendly,

Sven Luther
