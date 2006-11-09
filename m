Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id D3D8F67C7D
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 04:53:55 +1100 (EST)
Date: Thu, 9 Nov 2006 18:53:52 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix compile warnings with CONFIG_PM=n
Message-ID: <20061109175352.GA25289@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix compile warnings with CONFIG_PM=n

arch/powerpc/platforms/powermac/feature.c:489: warning: 'save_gpio_levels' defined but not used
arch/powerpc/platforms/powermac/feature.c:490: warning: 'save_gpio_extint' defined but not used
arch/powerpc/platforms/powermac/feature.c:491: warning: 'save_gpio_normal' defined but not used
arch/powerpc/platforms/powermac/feature.c:492: warning: 'save_unin_clock_ctl' defined but not used

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/powermac/feature.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/feature.c
+++ linux-2.6/arch/powerpc/platforms/powermac/feature.c
@@ -486,10 +486,6 @@ static long heathrow_sound_enable(struct
 
 static u32 save_fcr[6];
 static u32 save_mbcr;
-static u32 save_gpio_levels[2];
-static u8 save_gpio_extint[KEYLARGO_GPIO_EXTINT_CNT];
-static u8 save_gpio_normal[KEYLARGO_GPIO_CNT];
-static u32 save_unin_clock_ctl;
 static struct dbdma_regs save_dbdma[13];
 static struct dbdma_regs save_alt_dbdma[13];
 
@@ -1548,6 +1544,10 @@ void g5_phy_disable_cpu1(void)
 
 
 #ifdef CONFIG_PM
+static u32 save_gpio_levels[2];
+static u8 save_gpio_extint[KEYLARGO_GPIO_EXTINT_CNT];
+static u8 save_gpio_normal[KEYLARGO_GPIO_CNT];
+static u32 save_unin_clock_ctl;
 
 static void keylargo_shutdown(struct macio_chip *macio, int sleep_mode)
 {
