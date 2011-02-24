Return-Path: <prabhakar@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03635B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 20:50:18 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] fsl_pci: Add support for FSL PCIe controllers v2.x
Date: Thu, 24 Feb 2011 15:05:04 +0530
Message-ID: <1298540104-16545-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSL PCIe controller v2.1:
     - New MSI inbound window
     - Same Inbound windows address as PCIe controller v1.x

Added new pit_t member(pmit) to struct ccsr_pci for MSI inbound window

FSL PCIe controller v2.2 and v2.3:
     - Different addresses for PCIe inbound window 3,2,1
     - Exposed PCIe inbound window 0
     - New PCIe interrupt status register

Added new config and interrupt Status register to struct ccsr_pci & updated
pit_t array size to reflect the 4 inbound windows.

Device tree is used to maintain backward compatibility i.e. update inbound
window 1 index depending upon "compatible" field witin PCIE node.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Acked-by: Kumar Gala <kumar.gala@freescale.com>
---

 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master )

 arch/powerpc/sysdev/fsl_pci.c |   15 +++++++++++----
 arch/powerpc/sysdev/fsl_pci.h |   17 ++++++++++-------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 818f7c6..f8f7f28 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,7 +1,7 @@
 /*
  * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ * Copyright 2007-2011 Freescale Semiconductor, Inc.
  * Copyright 2008-2009 MontaVista Software, Inc.
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
@@ -99,7 +99,7 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 				  struct resource *rsrc)
 {
 	struct ccsr_pci __iomem *pci;
-	int i, j, n, mem_log, win_idx = 2;
+	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
 	u64 mem, sz, paddr_hi = 0;
 	u64 paddr_lo = ULLONG_MAX;
 	u32 pcicsrbar = 0, pcicsrbar_sz;
@@ -109,6 +109,13 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 
 	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
 		    (u64)rsrc->start, (u64)rsrc->end - (u64)rsrc->start + 1);
+
+	if (of_device_is_compatible(hose->dn, "fsl,qoriq-pcie-v2.2")) {
+		win_idx = 2;
+		start_idx = 0;
+		end_idx = 3;
+	}
+
 	pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
 	if (!pci) {
 	    dev_err(hose->parent, "Unable to map ATMU registers\n");
@@ -118,7 +125,7 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 	/* Disable all windows (except powar0 since it's ignored) */
 	for(i = 1; i < 5; i++)
 		out_be32(&pci->pow[i].powar, 0);
-	for(i = 0; i < 3; i++)
+	for (i = start_idx; i < end_idx; i++)
 		out_be32(&pci->piw[i].piwar, 0);
 
 	/* Setup outbound MEM window */
@@ -204,7 +211,7 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 			mem_log++;
 		}
 
-		piwar |= (mem_log - 1);
+		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
 
 		/* Setup inbound memory window */
 		out_be32(&pci->piw[win_idx].pitar,  0x00000000);
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 8ad72a1..a39ed5c 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -1,7 +1,7 @@
 /*
  * MPC85xx/86xx PCI Express structure define
  *
- * Copyright 2007 Freescale Semiconductor, Inc
+ * Copyright 2007,2011 Freescale Semiconductor, Inc
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -21,6 +21,7 @@
 #define PIWAR_TGI_LOCAL		0x00f00000	/* target - local memory */
 #define PIWAR_READ_SNOOP	0x00050000
 #define PIWAR_WRITE_SNOOP	0x00005000
+#define PIWAR_SZ_MASK          0x0000003f
 
 /* PCI/PCI Express outbound window reg */
 struct pci_outbound_window_regs {
@@ -49,7 +50,9 @@ struct ccsr_pci {
 	__be32	int_ack;		/* 0x.008 - PCI Interrupt Acknowledge Register */
 	__be32	pex_otb_cpl_tor;	/* 0x.00c - PCIE Outbound completion timeout register */
 	__be32	pex_conf_tor;		/* 0x.010 - PCIE configuration timeout register */
-	u8	res2[12];
+	__be32	pex_config;		/* 0x.014 - PCIE CONFIG Register */
+	__be32	pex_int_status;		/* 0x.018 - PCIE interrupt status */
+	u8	res2[4];
 	__be32	pex_pme_mes_dr;		/* 0x.020 - PCIE PME and message detect register */
 	__be32	pex_pme_mes_disr;	/* 0x.024 - PCIE PME and message disable register */
 	__be32	pex_pme_mes_ier;	/* 0x.028 - PCIE PME and message interrupt enable register */
@@ -62,14 +65,14 @@ struct ccsr_pci {
  * in all of the other outbound windows.
  */
 	struct pci_outbound_window_regs pow[5];
-
-	u8	res14[256];
-
-/* PCI/PCI Express inbound window 3-1
+	u8	res14[96];
+	struct pci_inbound_window_regs	pmit;	/* 0xd00 - 0xd9c Inbound MSI */
+	u8	res6[96];
+/* PCI/PCI Express inbound window 3-0
  * inbound window 1 supports only a 32-bit base address and does not
  * define an inbound window base extended address register.
  */
-	struct pci_inbound_window_regs piw[3];
+	struct pci_inbound_window_regs piw[4];
 
 	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
 	u8	res21[4];
-- 
1.7.3
