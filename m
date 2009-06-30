Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4790CB70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:32 +1000 (EST)
Received: from exprod5og109.obsmtp.com (exprod5og109.obsmtp.com [64.18.0.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 150FDDDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 00:37:36 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Correct reading of information presented in
	cpuinfo
To: galak@kernel.crashing.org
Date: Tue, 30 Jun 2009 15:32:26 +0100
Message-ID: <20090630143226.10778.29002.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

/proc/cpuinfo should be showing the boards revision and the revision of the FPGA fitted. The functions currently used to access this information as incorrect.

Additionally the VME geographical address of the PPC9A and it's status as system contoller are available in the board registers. Show these in cpuinfo.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/platforms/86xx/gef_ppc9a.c |   37 +++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index 2efa052..287f7bd 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -102,8 +102,8 @@ static unsigned int gef_ppc9a_get_pcb_rev(void)
 {
 	unsigned int reg;
 
-	reg = ioread32(ppc9a_regs);
-	return (reg >> 8) & 0xff;
+	reg = ioread32be(ppc9a_regs);
+	return (reg >> 16) & 0xff;
 }
 
 /* Return the board (software) revision */
@@ -111,8 +111,8 @@ static unsigned int gef_ppc9a_get_board_rev(void)
 {
 	unsigned int reg;
 
-	reg = ioread32(ppc9a_regs);
-	return (reg >> 16) & 0xff;
+	reg = ioread32be(ppc9a_regs);
+	return (reg >> 8) & 0xff;
 }
 
 /* Return the FPGA revision */
@@ -120,8 +120,26 @@ static unsigned int gef_ppc9a_get_fpga_rev(void)
 {
 	unsigned int reg;
 
-	reg = ioread32(ppc9a_regs);
-	return (reg >> 24) & 0xf;
+	reg = ioread32be(ppc9a_regs);
+	return reg & 0xf;
+}
+
+/* Return VME Geographical Address */
+static unsigned int gef_ppc9a_get_vme_geo_addr(void)
+{
+	unsigned int reg;
+
+	reg = ioread32be(ppc9a_regs + 0x4);
+	return reg & 0x1f;
+}
+
+/* Return VME System Controller Status */
+static unsigned int gef_ppc9a_get_vme_is_syscon(void)
+{
+	unsigned int reg;
+
+	reg = ioread32be(ppc9a_regs + 0x4);
+	return (reg >> 9) & 0x1;
 }
 
 static void gef_ppc9a_show_cpuinfo(struct seq_file *m)
@@ -131,10 +149,15 @@ static void gef_ppc9a_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
 
 	seq_printf(m, "Revision\t: %u%c\n", gef_ppc9a_get_pcb_rev(),
-		('A' + gef_ppc9a_get_board_rev() - 1));
+		('A' + gef_ppc9a_get_board_rev()));
 	seq_printf(m, "FPGA Revision\t: %u\n", gef_ppc9a_get_fpga_rev());
 
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	seq_printf(m, "VME geo. addr\t: %u\n", gef_ppc9a_get_vme_geo_addr());
+
+	seq_printf(m, "VME syscon\t: %s\n",
+		gef_ppc9a_get_vme_is_syscon() ? "yes" : "no");
 }
 
 static void __init gef_ppc9a_nec_fixup(struct pci_dev *pdev)
