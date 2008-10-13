Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 84030DE4EC
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 02:16:52 +1100 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m9DFGlLN003127
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:16:47 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m9DFGkFJ008134
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:16:47 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v3] powerpc: FPGA support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Mon, 13 Oct 2008 16:16:45 +0100
Message-ID: <20081013151537.19033.25006.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sfr@canb.auug.org.au, paulus@samba.org
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

This patch adds support for the registers held in the devices main FPGA,
exposing extra information about the revision of the board through cpuinfo.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

Stephen: Thanks for spotting that error.

New to rev 3:
 * Added of_node_put()

 arch/powerpc/boot/dts/gef_sbc610.dts     |    4 +++
 arch/powerpc/platforms/86xx/gef_sbc610.c |   40 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 771a776..6ed6083 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -84,6 +84,10 @@
 			  6 0 0xfd000000 0x00800000     // IO FPGA (8-bit)
 			  7 0 0xfd800000 0x00800000>;   // IO FPGA (32-bit)
 
+		fpga@4,0 {
+			compatible = "gef,fpga-regs";
+			reg = <0x4 0x0 0x40>;
+		};
 		gef_pic: pic@4,4000 {
 			#interrupt-cells = <1>;
 			interrupt-controller;
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 3873c20..821c45f 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -73,6 +73,7 @@ static void __init gef_sbc610_init_irq(void)
 
 static void __init gef_sbc610_setup_arch(void)
 {
+	struct device_node *regs;
 #ifdef CONFIG_PCI
 	struct device_node *np;
 
@@ -86,8 +87,43 @@ static void __init gef_sbc610_setup_arch(void)
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
 #endif
+
+	/* Remap basic board registers */
+	regs = of_find_compatible_node(NULL, NULL, "gef,fpga-regs");
+	if (regs) {
+		sbc610_regs = of_iomap(regs, 0);
+		if (sbc610_regs == NULL)
+			printk(KERN_WARNING "Unable to map board registers\n");
+		of_node_put(regs);
+	}
+}
+
+/* Return the PCB revision */
+static unsigned int gef_sbc610_get_pcb_rev(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc610_regs);
+	return (reg >> 8) & 0xff;
+}
+
+/* Return the board (software) revision */
+static unsigned int gef_sbc610_get_board_rev(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc610_regs);
+	return (reg >> 16) & 0xff;
 }
 
+/* Return the FPGA revision */
+static unsigned int gef_sbc610_get_fpga_rev(void)
+{
+	unsigned int reg;
+
+	reg = ioread32(sbc610_regs);
+	return (reg >> 24) & 0xf;
+}
 
 static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 {
@@ -96,6 +132,10 @@ static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 
 	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
 
+	seq_printf(m, "Revision\t: %u%c\n", gef_sbc610_get_pcb_rev(),
+		('A' + gef_sbc610_get_board_rev() - 1));
+	seq_printf(m, "FPGA Revision\t: %u\n", gef_sbc610_get_fpga_rev());
+
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
