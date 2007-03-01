Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 0EF21DE01B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:59:43 +1100 (EST)
Date: Thu, 1 Mar 2007 08:59:19 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [u-boot patch] support lite5200b wakeup in u-boot
Message-ID: <20070301075919.GG17184@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
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
address saved at physical 0x0


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

diff --git a/board/icecube/icecube.c b/board/icecube/icecube.c
index 9b222da..4b35776 100644
--- a/board/icecube/icecube.c
+++ b/board/icecube/icecube.c
@@ -42,6 +42,54 @@ # else
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
+	*(vu_char *)MPC5XXX_WU_GPIO_DATA = PSC2_4;
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
+#define lite5200b_wakeup
+#endif
+
+
 #ifndef CFG_RAMBOOT
 static void sdram_start (int hi_addr)
 {
@@ -208,6 +256,8 @@ #endif /* CFG_RAMBOOT */
 		__asm__ volatile ("sync");
 	}
 
+	lite5200b_wakeup();
+
 	return dramsize + dramsize2;
 }
 
diff --git a/include/mpc5xxx.h b/include/mpc5xxx.h
index 1d20d1d..c7eb090 100644
--- a/include/mpc5xxx.h
+++ b/include/mpc5xxx.h
@@ -189,6 +189,7 @@ #define MPC5XXX_WU_GPIO_ENABLE  (MPC5XXX
 #define MPC5XXX_WU_GPIO_ODE     (MPC5XXX_WU_GPIO + 0x0004)
 #define MPC5XXX_WU_GPIO_DIR     (MPC5XXX_WU_GPIO + 0x0008)
 #define MPC5XXX_WU_GPIO_DATA    (MPC5XXX_WU_GPIO + 0x000c)
+#define MPC5XXX_WU_GPIO_DATA_I  (MPC5XXX_WU_GPIO + 0x0020)
 
 /* PCI registers */
 #define MPC5XXX_PCI_CMD		(MPC5XXX_PCI + 0x04)
