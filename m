Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39539686BB
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 16:44:12 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 16:41:59 +1100
Message-Id: <1131342120.11406.20.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc: fix a bunch of warnings
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Building a PowerMac kernel with ARCH=powerpc causes a bunch of warnings,
this fixes some of them

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2005-11-07 15:10:26.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_init.c	2005-11-07 16:14:43.000000000 +1100
@@ -403,19 +403,19 @@
 	}
 }
 
-static int __init prom_getprop(phandle node, const char *pname,
+static int inline prom_getprop(phandle node, const char *pname,
 			       void *value, size_t valuelen)
 {
 	return call_prom("getprop", 4, 1, node, ADDR(pname),
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
-static int __init prom_getproplen(phandle node, const char *pname)
+static int inline prom_getproplen(phandle node, const char *pname)
 {
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
 }
 
-static int __init prom_setprop(phandle node, const char *pname,
+static int inline prom_setprop(phandle node, const char *pname,
 			       void *value, size_t valuelen)
 {
 	return call_prom("setprop", 4, 1, node, ADDR(pname),
@@ -1408,8 +1408,9 @@
 	struct prom_t *_prom = &RELOC(prom);
 	char compat[256];
 	int len, i = 0;
+#ifdef CONFIG_PPC64
 	phandle rtas;
-
+#endif
 	len = prom_getprop(_prom->root, "compatible",
 			   compat, sizeof(compat)-1);
 	if (len > 0) {
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-11-07 15:10:26.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2005-11-07 16:12:41.000000000 +1100
@@ -2667,10 +2667,10 @@
 	asleep = 1;
 
 	/* Put the CPU into sleep mode */
-	asm volatile("mfspr %0,1008" : "=r" (hid0) :);
+	hid0 = mfspr(SPRN_HID0);
 	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
-	asm volatile("mtspr 1008,%0" : : "r" (hid0));
-	_nmask_and_or_msr(0, MSR_POW | MSR_EE);
+	mtspr(SPRN_HID0, hid0);
+	mtmsr(mfmsr() | MSR_POW | MSR_EE);
 	udelay(10);
 
 	/* OK, we're awake again, start restoring things */
Index: linux-work/include/asm-ppc/btext.h
===================================================================
--- linux-work.orig/include/asm-ppc/btext.h	2005-09-22 14:07:27.000000000 +1000
+++ linux-work/include/asm-ppc/btext.h	2005-11-07 16:16:52.000000000 +1100
@@ -17,18 +17,18 @@
 extern boot_infos_t disp_bi;
 extern int boot_text_mapped;
 
-void btext_init(boot_infos_t *bi);
-void btext_welcome(void);
-void btext_prepare_BAT(void);
-void btext_setup_display(int width, int height, int depth, int pitch,
-			 unsigned long address);
-void map_boot_text(void);
-void btext_update_display(unsigned long phys, int width, int height,
-			  int depth, int pitch);
+extern void init_boot_display(void);
+extern void btext_welcome(void);
+extern void btext_prepare_BAT(void);
+extern void btext_setup_display(int width, int height, int depth, int pitch,
+				unsigned long address);
+extern void map_boot_text(void);
+extern void btext_update_display(unsigned long phys, int width, int height,
+				 int depth, int pitch);
 
-void btext_drawchar(char c);
-void btext_drawstring(const char *str);
-void btext_drawhex(unsigned long v);
+extern void btext_drawchar(char c);
+extern void btext_drawstring(const char *str);
+extern void btext_drawhex(unsigned long v);
 
 #endif /* __KERNEL__ */
 #endif /* __PPC_BTEXT_H */
Index: linux-work/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas.c	2005-11-07 15:10:26.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas.c	2005-11-07 16:18:49.000000000 +1100
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -83,7 +84,7 @@
 		while (width-- > 0)
 			call_rtas_display_status(' ');
 		width = 16;
-		udelay(500000);
+		mdelay(500);
 		pending_newline = 1;
 	} else {
 		if (pending_newline) {
Index: linux-work/include/asm-powerpc/xmon.h
===================================================================
--- linux-work.orig/include/asm-powerpc/xmon.h	2005-11-03 09:41:19.000000000 +1100
+++ linux-work/include/asm-powerpc/xmon.h	2005-11-07 16:20:21.000000000 +1100
@@ -7,6 +7,7 @@
 extern int xmon(struct pt_regs *excp);
 extern void xmon_printf(const char *fmt, ...);
 extern void xmon_init(int);
+extern void xmon_map_scc(void);
 
 #endif
 #endif
