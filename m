Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id 42F5267A46
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 04:48:01 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0208.wanadoo.fr (SMTP Server) with ESMTP id 924491C002B4
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2005 20:47:58 +0200 (CEST)
Date: Thu, 31 Mar 2005 20:45:49 +0200
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050331184549.GA28069@pegasos>
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050331142813.GH25923@smtp.west.cox.net>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due to 2.6.9-rc1-bk1
	introduced residual data patch ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 07:28:13AM -0700, Tom Rini wrote:
> On Tue, Mar 29, 2005 at 01:23:55AM +0200, Sven Luther wrote:
> > Hello,
> > 
> > I have been investigating the prep breakage of the sym53c8xx driver on my
> > powerstack II in recent kernels, and traced it to the residual data patch,
> > or more exactly to the whole prep_pci.c/prep_setup.c patches that where
> > introduced between 2.6.9-rc1 and 2.6.9-rc1-bk1. I didn't have time to find
> > more details as the patch is not so small, and seems to do many things, and
> > linux.bkbits.net seems done right now.
> > 
> > Mmm, after a bit more of investigation, the changeset breaking it is :
> > 
> > # This is a BitKeeper generated diff -Nru style patch.
> > #
> > # ChangeSet
> > #   2004/08/16 10:35:18-07:00 trini@kernel.crashing.org
> > #   ppc32: On PReP, use residual data for PCI dev -> IRQ, and use it.
> > #
> > #   Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
> > #   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > #
> > # include/asm-ppc/residual.h
> > #   2004/08/16 10:35:09-07:00 trini@kernel.crashing.org +7 -0
> > #   This adds a function to use the residual data to determine the IRQ
> > #   for a given PCI device, and changes prep_pcibios_fixup() to use it.
> > #
> > # arch/ppc/platforms/residual.c
> > #   2004/08/16 10:35:09-07:00 trini@kernel.crashing.org +60 -0
> > #   This adds a function to use the residual data to determine the IRQ
> > #   for a given PCI device, and changes prep_pcibios_fixup() to use it.
> > #
> > # arch/ppc/platforms/prep_pci.c
> > #   2004/08/16 10:35:09-07:00 trini@kernel.crashing.org +37 -23
> > #   This adds a function to use the residual data to determine the IRQ
> > #   for a given PCI device, and changes prep_pcibios_fixup() to use it.
> > 
> > Mmm, i guess this makes sense, since it seems the sym53c8xx doesn'y find its
> > irq anymore or something. Tom Rini, or Leigh Brown, do you have any comments
> > on this one ? 
> 
> Well, we'd need to be certain it's this patch.  If it's this patch, I
> think Leigh was suggesting at the time that the fix would be to fixup
> the residual data with the correct information.

I got through all the changesets one by one, and it is most definitively this
one. i unapply it and it works, i apply it and it breaks.

/me went through a couple hours of binary diff in this way monday evening :/

> But what also went in were changes to specific irq maps, based on what
> fixed a given machine for someone else, so one of those changes could
> also be it.

Nope, it is most definitively the patch above which causes the problem.

I believe the new irq setting method is borked somehow.

Friendly,

Sven Luther
