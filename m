Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id 196BB67A84
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 09:25:23 +1000 (EST)
Received: from me-wanadoo.net (fake.juicyvision.com [127.0.0.1])
	by mwinf0112.wanadoo.fr (SMTP Server) with ESMTP id E13601C00614
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 01:25:20 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-52-128.w82-126.abo.wanadoo.fr
	[82.126.142.128])
	by mwinf0112.wanadoo.fr (SMTP Server) with ESMTP id C1B1B1C00613
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 01:25:20 +0200 (CEST)
Received: from luther by pegasos with local (Exim 4.50) id 1DG3aN-0000zi-Ja
	for linuxppc-dev@ozlabs.org; Tue, 29 Mar 2005 01:23:55 +0200
Date: Tue, 29 Mar 2005 01:23:55 +0200
To: linuxppc-dev@ozlabs.org
Message-ID: <20050328232355.GA1982@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: Sven Luther <sven.luther@wanadoo.fr>
Subject: PREP sym53c8xx sym53c8xx brokeness due to 2.6.9-rc1-bk1 introduced
	residual data patch ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have been investigating the prep breakage of the sym53c8xx driver on my
powerstack II in recent kernels, and traced it to the residual data patch,
or more exactly to the whole prep_pci.c/prep_setup.c patches that where
introduced between 2.6.9-rc1 and 2.6.9-rc1-bk1. I didn't have time to find
more details as the patch is not so small, and seems to do many things, and
linux.bkbits.net seems done right now.

Mmm, after a bit more of investigation, the changeset breaking it is :

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/16 10:35:18-07:00 trini@kernel.crashing.org
#   ppc32: On PReP, use residual data for PCI dev -> IRQ, and use it.
#
#   Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
#   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
#
# include/asm-ppc/residual.h
#   2004/08/16 10:35:09-07:00 trini@kernel.crashing.org +7 -0
#   This adds a function to use the residual data to determine the IRQ
#   for a given PCI device, and changes prep_pcibios_fixup() to use it.
#
# arch/ppc/platforms/residual.c
#   2004/08/16 10:35:09-07:00 trini@kernel.crashing.org +60 -0
#   This adds a function to use the residual data to determine the IRQ
#   for a given PCI device, and changes prep_pcibios_fixup() to use it.
#
# arch/ppc/platforms/prep_pci.c
#   2004/08/16 10:35:09-07:00 trini@kernel.crashing.org +37 -23
#   This adds a function to use the residual data to determine the IRQ
#   for a given PCI device, and changes prep_pcibios_fixup() to use it.

Mmm, i guess this makes sense, since it seems the sym53c8xx doesn'y find its
irq anymore or something. Tom Rini, or Leigh Brown, do you have any comments
on this one ? 

Friendly,

Sven Luther
