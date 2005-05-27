Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4E728679F2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 08:10:37 +1000 (EST)
Date: Fri, 27 May 2005 17:10:19 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505271709220.25368@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: shall@mvista.com, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: i8259 PIC should not be initialized if PCI is not
 configured
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Trying to initialize the i8259 PIC will not work if CONFIG_PCI is
not enabled.  The kernel hangs if the initialization is tried.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 947c0e2c89c4e5cda2093bcfca7c13e097641e3b
tree 12a3e07d44c69f110708c359da5132439c2527c5
parent 219d058f65dbd666964b1e951b8d491e4b19dc0c
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 27 May 2005 16:57:41 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 27 May 2005 16:57:41 -0500

 ppc/platforms/85xx/mpc85xx_cds_common.c |    2 ++
 1 files changed, 2 insertions(+)

Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- 109a4648d2cc627d17c129bc1ca102a736c817aa/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
+++ 12a3e07d44c69f110708c359da5132439c2527c5/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
@@ -200,12 +200,14 @@
 	 */
 	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
 
+#ifdef CONFIG_PCI
 	openpic_hookup_cascade(PIRQ0A, "82c59 cascade", i8259_irq);
 
 	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
 
 	i8259_init(0);
+#endif
 
 #ifdef CONFIG_CPM2
 	/* Setup CPM2 PIC */
