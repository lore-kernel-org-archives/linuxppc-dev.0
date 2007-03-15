Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 9F225DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 21:44:14 +1100 (EST)
Date: Thu, 15 Mar 2007 11:44:11 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] icecube/lite5200b: wakeup from low-power support
Message-ID: <20070315104411.GF22215@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315103959.GA22215@moe.telargo.com>
Cc: u-boot-users@lists.sourceforge.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

U-Boot part of Lite5200b low power mode support.
Puts SDRAM out of self-refresh and transfers control to
address saved at physical 0x0.


---
 board/icecube/icecube.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

Index: u-boot.git/board/icecube/icecube.c
===================================================================
--- u-boot.git.orig/board/icecube/icecube.c
+++ u-boot.git/board/icecube/icecube.c
@@ -42,6 +42,54 @@
 #include "mt48lc16m16a2-75.h"
 # endif
 #endif
+
+#ifdef CONFIG_LITE5200B
+/* u-boot part of low-power mode implementation */
+#define SAVED_ADDR (*(void **)0x00000000)
+#define PSC2_4 0x02
+
+void lite5200b_wakeup(void)
+{
+	unsigned char wakeup_pin;
+	void (*linux_wakeup)(void);
+
+	/* check PSC2_4, if it's down "QT" is signaling we have a wakeup
+	 * from low power mode */
+	*(vu_char *)MPC5XXX_WU_GPIO_ENABLE = PSC2_4;
+	__asm__ volatile ("sync");
+
+	wakeup_pin = *(vu_char *)MPC5XXX_WU_GPIO_DATA_I;
+	if (wakeup_pin & PSC2_4)
+		return;
+
+	/* acknowledge to "QT"
+	 * by holding pin at 1 for 10 uS */
+	*(vu_char *)MPC5XXX_WU_GPIO_DIR = PSC2_4;
+	__asm__ volatile ("sync");
+	*(vu_char *)MPC5XXX_WU_GPIO_DATA_O = PSC2_4;
+	__asm__ volatile ("sync");
+	udelay(10);
+
+	/* put ram out of self-refresh */
+	*(vu_long *)MPC5XXX_SDRAM_CTRL |= 0x80000000;	// mode_en
+	__asm__ volatile ("sync");
+	*(vu_long *)MPC5XXX_SDRAM_CTRL |= 0x50000000;	// cke ref_en
+	__asm__ volatile ("sync");
+	*(vu_long *)MPC5XXX_SDRAM_CTRL &= ~0x80000000;	// !mode_en
+	__asm__ volatile ("sync");
+	udelay(10); /* wait a bit */
+
+	/* jump back to linux kernel code */
+	linux_wakeup = SAVED_ADDR;
+	printf("\n\nLooks like we just woke, transferring control to 0x%08lx\n",
+			linux_wakeup);
+	linux_wakeup();
+}
+#else
+#define lite5200b_wakeup()
+#endif
+
+
 #ifndef CFG_RAMBOOT
 static void sdram_start (int hi_addr)
 {
@@ -208,6 +256,8 @@ long int initdram (int board_type)
 		__asm__ volatile ("sync");
 	}
 
+	lite5200b_wakeup();
+
 	return dramsize + dramsize2;
 }
 
