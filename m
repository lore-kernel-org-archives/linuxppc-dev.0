Return-Path: <albert_herranz@yahoo.es>
Received: from smtp125.mail.ukl.yahoo.com (smtp125.mail.ukl.yahoo.com
	[77.238.184.56]) by ozlabs.org (Postfix) with SMTP id 9D0041007FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 10:09:54 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 3/3] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Tue,  1 Dec 2009 00:09:50 +0100
Message-Id: <86935119c483c2d6e4c810c0afd079e049443b18.1259609263.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
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
 arch/powerpc/Kconfig.debug                         |    8 +++
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/head_32.S                      |   21 +++++++
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   59 ++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    2 +
 6 files changed, 93 insertions(+), 0 deletions(-)

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
index 9dfedec..5abfd0f 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -54,6 +54,7 @@ extern void __init udbg_init_btext(void);
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
index 2711050..65a7926 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -63,6 +63,8 @@ void __init udbg_early_init(void)
 	udbg_init_40x_realmode();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
 	udbg_init_cpm();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_USBGECKO)
+	udbg_init_usbgecko();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index ba4c7cc..3f125b6 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
+#include <asm/fixmap.h>
 
 #include "usbgecko_udbg.h"
 
@@ -270,3 +271,61 @@ done:
 		of_node_put(np);
 	return;
 }
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
+
+static void __init ug_early_remap(void)
+{
+	unsigned long addr;
+	void __iomem *io;
+
+	if (ug_io_base) {
+		addr = (unsigned long)ug_io_base;
+		set_fixmap_nocache(FIX_EARLY_DEBUG_BASE, addr & PAGE_MASK);
+		io = (void __iomem *)__fix_to_virt(FIX_EARLY_DEBUG_BASE);
+		io += addr & ~PAGE_MASK;
+		udbg_printf("%s: %p -> %p\n", __func__, ug_io_base, io);
+		ug_io_base = io;
+	}
+}
+
+static void __iomem * __init ug_early_grab_exi_io_base(void)
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
+
+	/*
+	 * At this point we have a BAT already setup that enables I/O
+	 * to the EXI hardware.
+	 */
+
+	exi_io_base = ug_early_grab_exi_io_base();
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
+	udbg_early_remap = ug_early_remap;
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
