Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FE9068952
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:44:21 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKi6Uo000609
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:44:07 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <8.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:44:04 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 8/9] ppc32: Fix MPC52xx PCI init in cas the bootloader
	didn't do it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Fix MPC52xx PCI init in cas the bootloader didn't do it

We were counting on the bootloader to init some stuff, like get
the bus out of reset and enable accesses.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit ebf0598ce7564d4c1db16d995e609923bbb2eba8
tree 3ba738b8bf64ebe609c5f8301f87b55d25c2d9fd
parent 20734ce8dc6fafd40c421bd275712d7bb6124d20
author Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 20:09:13 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 20:09:13 +0100

 arch/ppc/syslib/mpc52xx_pci.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
index 2c5e6dd..313c96e 100644
--- a/arch/ppc/syslib/mpc52xx_pci.c
+++ b/arch/ppc/syslib/mpc52xx_pci.c
@@ -154,9 +154,12 @@ static struct pci_ops mpc52xx_pci_ops = 
 static void __init
 mpc52xx_pci_setup(struct mpc52xx_pci __iomem *pci_regs)
 {
+	u32 tmp;
 
 	/* Setup control regs */
-		/* Nothing to do afaik */
+	tmp = in_be32(&pci_regs->scr);
+	tmp |= PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+	out_be32(&pci_regs->scr, tmp);
 
 	/* Setup windows */
 	out_be32(&pci_regs->iw0btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
@@ -197,13 +200,12 @@ mpc52xx_pci_setup(struct mpc52xx_pci __i
 	/* Not necessary and can be a bad thing if for example the bootloader
 	   is displaying a splash screen or ... Just left here for
 	   documentation purpose if anyone need it */
-#if 0
-	u32 tmp;
 	tmp = in_be32(&pci_regs->gscr);
+#if 0
 	out_be32(&pci_regs->gscr, tmp | MPC52xx_PCI_GSCR_PR);
 	udelay(50);
-	out_be32(&pci_regs->gscr, tmp);
 #endif
+	out_be32(&pci_regs->gscr, tmp & ~MPC52xx_PCI_GSCR_PR);
 }
 
 static void
