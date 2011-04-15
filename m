Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <5a3ea04cbe926026e0ab1168c957807b16cf954d.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 15/15] powerpc: Add early debug for WSP platforms
Date: Fri, 15 Apr 2011 18:32:08 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jack Miller <jack@codezen.org>

Signed-off-by: Jack Miller <jack@codezen.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug           |    5 +++
 arch/powerpc/include/asm/reg_a2.h    |    9 ++++++
 arch/powerpc/include/asm/udbg.h      |    1 +
 arch/powerpc/kernel/exceptions-64e.S |   17 +++++++++++
 arch/powerpc/kernel/udbg.c           |    2 +
 arch/powerpc/kernel/udbg_16550.c     |   51 ++++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 2d38a50..a597dd7 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -267,6 +267,11 @@ config PPC_EARLY_DEBUG_USBGECKO
 	  Select this to enable early debugging for Nintendo GameCube/Wii
 	  consoles via an external USB Gecko adapter.
 
+config PPC_EARLY_DEBUG_WSP
+	bool "Early debugging via WSP's internal UART"
+	depends on PPC_WSP
+	select PPC_UDBG_16550
+
 endchoice
 
 config PPC_EARLY_DEBUG_44x_PHYSLOW
diff --git a/arch/powerpc/include/asm/reg_a2.h b/arch/powerpc/include/asm/reg_a2.h
index 3ba9c6f..3d52a11 100644
--- a/arch/powerpc/include/asm/reg_a2.h
+++ b/arch/powerpc/include/asm/reg_a2.h
@@ -110,6 +110,15 @@
 #define TLB1_UR			ASM_CONST(0x0000000000000002)
 #define TLB1_SR			ASM_CONST(0x0000000000000001)
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_WSP
+#define WSP_UART_PHYS	0xffc000c000
+/* This needs to be careful chosen to hit a !0 congruence class
+ * in the TLB since we bolt it in way 3, which is already occupied
+ * by our linear mapping primary bolted entry in CC 0.
+ */
+#define WSP_UART_VIRT	0xf000000000001000
+#endif
+
 /* A2 erativax attributes definitions */
 #define ERATIVAX_RS_IS_ALL		0x000
 #define ERATIVAX_RS_IS_TID		0x040
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index 11ae699..58580e9 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -52,6 +52,7 @@ extern void __init udbg_init_44x_as1(void);
 extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
 extern void __init udbg_init_usbgecko(void);
+extern void __init udbg_init_wsp(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 8e5d2c1..f4ed2cb 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -17,6 +17,7 @@
 #include <asm/cputable.h>
 #include <asm/setup.h>
 #include <asm/thread_info.h>
+#include <asm/reg_a2.h>
 #include <asm/exception-64e.h>
 #include <asm/bug.h>
 #include <asm/irqflags.h>
@@ -951,6 +952,22 @@ a2_tlbinit_after_linear_map:
 	.globl  a2_tlbinit_after_iprot_flush
 a2_tlbinit_after_iprot_flush:
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_WSP
+	/* Now establish early debug mappings if applicable */
+	/* Restore the MAS0 we used for linear mapping load */
+	mtspr	SPRN_MAS0,r11
+
+	lis	r3,(MAS1_VALID | MAS1_IPROT)@h
+	ori	r3,r3,(BOOK3E_PAGESZ_4K << MAS1_TSIZE_SHIFT)
+	mtspr	SPRN_MAS1,r3
+	LOAD_REG_IMMEDIATE(r3, WSP_UART_VIRT | MAS2_I | MAS2_G)
+	mtspr	SPRN_MAS2,r3
+	LOAD_REG_IMMEDIATE(r3, WSP_UART_PHYS | MAS3_SR | MAS3_SW)
+	mtspr	SPRN_MAS7_MAS3,r3
+	/* re-use the MAS8 value from the linear mapping */
+	tlbwe
+#endif /* CONFIG_PPC_EARLY_DEBUG_WSP */
+
 	PPC_TLBILX(0,0,0)
 	sync
 	isync
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index e39cad8..23d65ab 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -62,6 +62,8 @@ void __init udbg_early_init(void)
 	udbg_init_cpm();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_USBGECKO)
 	udbg_init_usbgecko();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_WSP)
+	udbg_init_wsp();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index b4b167b..ed7ac57 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/udbg.h>
 #include <asm/io.h>
+#include <asm/reg_a2.h>
 
 extern u8 real_readb(volatile u8 __iomem  *addr);
 extern void real_writeb(u8 data, volatile u8 __iomem *addr);
@@ -298,3 +299,53 @@ void __init udbg_init_40x_realmode(void)
 	udbg_getc_poll = NULL;
 }
 #endif /* CONFIG_PPC_EARLY_DEBUG_40x */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_WSP
+static void udbg_wsp_flush(void)
+{
+	if (udbg_comport) {
+		while ((readb(&udbg_comport->lsr) & LSR_THRE) == 0)
+			/* wait for idle */;
+	}
+}
+
+static void udbg_wsp_putc(char c)
+{
+	if (udbg_comport) {
+		if (c == '\n')
+			udbg_wsp_putc('\r');
+		udbg_wsp_flush();
+		writeb(c, &udbg_comport->thr); eieio();
+	}
+}
+
+static int udbg_wsp_getc(void)
+{
+	if (udbg_comport) {
+		while ((readb(&udbg_comport->lsr) & LSR_DR) == 0)
+			; /* wait for char */
+		return readb(&udbg_comport->rbr);
+	}
+	return -1;
+}
+
+static int udbg_wsp_getc_poll(void)
+{
+	if (udbg_comport)
+		if (readb(&udbg_comport->lsr) & LSR_DR)
+			return readb(&udbg_comport->rbr);
+	return -1;
+}
+
+void __init udbg_init_wsp(void)
+{
+	udbg_comport = (struct NS16550 __iomem *)WSP_UART_VIRT;
+
+	udbg_init_uart(udbg_comport, 57600, 50000000);
+
+	udbg_putc = udbg_wsp_putc;
+	udbg_flush = udbg_wsp_flush;
+	udbg_getc = udbg_wsp_getc;
+	udbg_getc_poll = udbg_wsp_getc_poll;
+}
+#endif /* CONFIG_PPC_EARLY_DEBUG_WSP */
-- 
1.7.1
