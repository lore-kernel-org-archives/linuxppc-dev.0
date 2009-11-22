Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id C47401007F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:10 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Sun, 22 Nov 2009 23:01:41 +0100
Message-Id: <1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for using the USB Gecko adapter as an early debugging
console on the Nintendo GameCube and Wii video game consoles.
The USB Gecko is a 3rd party memory card interface adapter that provides
a EXI (External Interface) to USB serial converter.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/Kconfig.debug                         |    8 +++++
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/head_32.S                      |   21 ++++++++++++
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   33 ++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    6 +++
 6 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 3b10051..11e385b 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -254,6 +254,14 @@ config PPC_EARLY_DEBUG_CPM
 	  using a CPM-based serial port.  This assumes that the bootwrapper
 	  has run, and set up the CPM in a particular way.
 
+config PPC_EARLY_DEBUG_USBGECKO
+	bool "Early debugging through the USB Gecko adapter"
+	depends on GAMECUBE_COMMON
+	select USBGECKO_UDBG
+	help
+	  Select this to enable early debugging for Nintendo GameCube/Wii
+	  consoles via an external USB Gecko adapter.
+
 endchoice
 
 config PPC_EARLY_DEBUG_44x_PHYSLOW
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index cd21e5e..11ae699 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -51,6 +51,7 @@ extern void __init udbg_init_btext(void);
 extern void __init udbg_init_44x_as1(void);
 extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
+extern void __init udbg_init_usbgecko(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 829c3fe..83a0b79 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -164,6 +164,9 @@ __after_mmu_off:
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
 	bl	setup_cpm_bat
 #endif
+#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
+	bl	setup_usbgecko_bat
+#endif
 
 /*
  * Call setup_cpu for CPU 0 and initialize 6xx Idle
@@ -1203,6 +1206,24 @@ setup_cpm_bat:
 	blr
 #endif
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
+setup_usbgecko_bat:
+	/* prepare a BAT for early io */
+	lis	r8, 0x0c00
+	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
+	lis	r11, 0xcc00
+	ori	r11, r11, 0x3	/* 128K */
+#ifdef CONFIG_WII
+	oris	r8, r8, 0x0100
+	oris	r11, r11, 0x0100
+#endif
+	mtspr	SPRN_DBAT1L, r8
+	mtspr	SPRN_DBAT1U, r11
+	sync
+	isync
+	blr
+#endif
+
 #ifdef CONFIG_8260
 /* Jump into the system reset for the rom.
  * We first disable the MMU, and then jump to the ROM reset address.
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index fc9af47..e39cad8 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -60,6 +60,8 @@ void __init udbg_early_init(void)
 	udbg_init_40x_realmode();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
 	udbg_init_cpm();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_USBGECKO)
+	udbg_init_usbgecko();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index 49f86e8..9f5e7ed 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -234,6 +234,9 @@ void __init ug_udbg_init(void)
 	struct device_node *stdout;
 	const char *path;
 
+	if (ug_io_base)
+		udbg_printf("%s: early -> final\n", __func__);
+
 	if (!of_chosen) {
 		udbg_printf("%s: missing of_chosen\n", __func__);
 		goto done;
@@ -283,3 +286,33 @@ done:
 		of_node_put(np);
 	return;
 }
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
+
+/*
+ * USB Gecko early debug support initialization for udbg.
+ *
+ */
+void __init udbg_init_usbgecko(void)
+{
+	unsigned long vaddr, paddr;
+
+#if defined(CONFIG_GAMECUBE)
+	paddr = 0x0c000000;
+#elif defined(CONFIG_WII)
+	paddr = 0x0d000000;
+#else
+#error Invalid platform for USB Gecko based early debugging.
+#endif
+
+	vaddr = 0xc0000000 | paddr;
+	setbat(1, vaddr, paddr, 128*1024, PAGE_KERNEL_NCG);
+
+	ug_io_base = (void __iomem *)(vaddr | 0x6814);
+
+	udbg_putc = ug_udbg_putc;
+	udbg_getc = ug_udbg_getc;
+	udbg_getc_poll = ug_udbg_getc_poll;
+}
+
+#endif /* CONFIG_PPC_EARLY_DEBUG_USBGECKO */
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
index 3929de3..98034ee 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
@@ -27,4 +27,10 @@ static inline void __init ug_udbg_init(void)
 
 #endif /* CONFIG_USBGECKO_UDBG */
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
+
+void __init udbg_init_usbgecko(void);
+
+#endif /* CONFIG_PPC_EARLY_DEBUG_USBGECKO */
+
 #endif /* __USBGECKO_UDBG_H */
-- 
1.6.3.3
