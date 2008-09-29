Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-10.online-age.net (ext-nj2ut-10.online-age.net
	[64.14.54.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 36888DDDE3
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 22:31:52 +1000 (EST)
Received: from int-nj2ut-6.online-age.net (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by ext-nj2ut-10.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8TCVghO024047
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 08:31:42 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by int-nj2ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8TCVf7v018049
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 08:31:42 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc: Correct USB support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Mon, 29 Sep 2008 13:35:15 +0100
Message-ID: <20080929123515.26226.91402.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the SBC610 VPX Single Board Computer from GE Fanuc (PowerPC
MPC8641D).

Fixup to correctly reconfigure USB, provided by an NEC uPD720101, after
device is reset. This requires a set of chip specific registers in the
devices configuration space to be correctly written, enabling all ports
and switching the device to use an external 48-MHz Oscillator.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/platforms/86xx/gef_sbc610.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 3543a9e..605678c 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -12,6 +12,8 @@
  *
  * Based on: mpc86xx_hpcn.c (MPC86xx HPCN board specific routines)
  * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * NEC fixup adapted from arch/mips/pci/fixup-lm2e.c
  */
 
 #include <linux/stddef.h>
@@ -83,6 +85,21 @@ static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
+static void __init gef_sbc610_nec_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	printk(KERN_INFO "Running NEC uPD720101 Fixup\n");
+
+	/* Ensure ports 1, 2, 3, 4 & 5 are enabled */
+	pci_read_config_dword(pdev, 0xe0, &val);
+	pci_write_config_dword(pdev, 0xe0, (val & ~7) | 0x5);
+
+	/* System clock is 48-MHz Oscillator and EHCI Enabled. */
+	pci_write_config_dword(pdev, 0xe4, 1 << 5);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+	gef_sbc610_nec_fixup);
 
 /*
  * Called very early, device-tree isn't unflattened
