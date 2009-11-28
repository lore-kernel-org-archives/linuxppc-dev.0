Return-Path: <albert_herranz@yahoo.es>
Received: from smtp141.mail.ukl.yahoo.com (smtp141.mail.ukl.yahoo.com
	[77.238.184.72]) by ozlabs.org (Postfix) with SMTP id 1FFECB7CB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Nov 2009 07:44:13 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Sat, 28 Nov 2009 21:43:54 +0100
Message-Id: <1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
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
v1 -> v2
- Do not enclose declaration within #ifdef's. Suggestion by Arnd Bergmann.
- Document apparent double setting of BATs.
- Isolate hardcoded settings into functions.
- Prevent compilation if not targeted for the GameCube or Wii.

 arch/powerpc/Kconfig.debug                         |    8 +++
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/head_32.S                      |   21 ++++++++
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   53 ++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    2 +
 6 files changed, 87 insertions(+), 0 deletions(-)

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
index 829c3fe..c3f3737 100644
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
+#if defined(CONFIG_GAMECUBE)
+	lis	r8, 0x0c00
+#elif defined(CONFIG_WII)
+	lis	r8, 0x0d00
+#else
+#error Invalid platform for USB Gecko based early debugging.
+#endif
+	mr	r11, r8
+	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
+	ori	r11, r11, 0x3	/* 128K */
+	mtspr	SPRN_DBAT1L, r8
+	mtspr	SPRN_DBAT1U, r11
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
index 581ce61..f9d7991 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -270,3 +270,56 @@ done:
 		of_node_put(np);
 	return;
 }
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
+
+static void __iomem * __init udbg_early_grab_exi_io_base(void)
+{
+#if defined(CONFIG_GAMECUBE)
+	return (void __iomem *)0x0c006800;
+#elif defined(CONFIG_WII)
+	return (void __iomem *)0x0d006800;
+#else
+#error Invalid platform for USB Gecko based early debugging.
+#endif
+}
+
+/*
+ * USB Gecko early debug support initialization for udbg.
+ */
+void __init udbg_init_usbgecko(void)
+{
+	void __iomem *exi_io_base;
+	unsigned long addr;
+
+	/*
+	 * At this point we have a BAT already setup that enables I/O
+	 * to the EXI hardware.
+	 */
+
+	exi_io_base = udbg_early_grab_exi_io_base();
+	if (!exi_io_base)
+		return;
+
+	/* try to detect a USB Gecko */
+	if (!ug_udbg_probe(exi_io_base))
+		return;
+
+	/* we found a USB Gecko, load udbg hooks */
+	udbg_putc = ug_udbg_putc;
+	udbg_getc = ug_udbg_getc;
+	udbg_getc_poll = ug_udbg_getc_poll;
+
+	/*
+	 * Prepare again the same BAT for MMU_init.
+	 * This allows udbg I/O to continue working after the MMU is
+	 * turned on for real.
+	 *
+	 * We are assuming here that exi_io_base is identity mapped.
+	 */
+	addr = ((unsigned long)exi_io_base) & 0xffff0000;
+	setbat(1, addr, addr, 128*1024, PAGE_KERNEL_NCG);
+}
+
+#endif /* CONFIG_PPC_EARLY_DEBUG_USBGECKO */
+
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
index 3929de3..bb6cde4 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
@@ -27,4 +27,6 @@ static inline void __init ug_udbg_init(void)
 
 #endif /* CONFIG_USBGECKO_UDBG */
 
+void __init udbg_init_usbgecko(void);
+
 #endif /* __USBGECKO_UDBG_H */
-- 
1.6.3.3
