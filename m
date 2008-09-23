Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id AEBDEDDFCC
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 01:06:05 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH V2] powerpc: Fix Book-E watchdog timer interval setting
Date: Tue, 23 Sep 2008 17:04:56 +0200
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<200809192328.36159.matthias.fuchs@esd-electronics.com>
	<7CA29A12-6DC4-4939-9541-6270FE5D910A@kernel.crashing.org>
In-Reply-To: <7CA29A12-6DC4-4939-9541-6270FE5D910A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809231704.56449.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the setting of the Book-E watchdog timer interval setup
on initialization and by ioctl().

On initialization the period bits have to be masked before setting
a new period.

In WDIOC_SETTIMEOUT ioctl we have to use the currect mask.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
---
 drivers/watchdog/booke_wdt.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index c3b78a7..41ba9b8 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -42,8 +42,10 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 
 #ifdef	CONFIG_FSL_BOOKE
 #define WDTP(x)		((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
+#define WDTP_MASK	(WDTP(63))
 #else
 #define WDTP(x)		(TCR_WP(x))
+#define WDTP_MASK	(TCR_WP_MASK)
 #endif
 
 static DEFINE_SPINLOCK(booke_wdt_lock);
@@ -65,6 +67,7 @@ static void __booke_wdt_enable(void *data)
 	/* clear status before enabling watchdog */
 	__booke_wdt_ping(NULL);
 	val = mfspr(SPRN_TCR);
+	val &= ~WDTP_MASK;
 	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
 
 	mtspr(SPRN_TCR, val);
@@ -114,7 +117,7 @@ static long booke_wdt_ioctl(struct file *file,
 	case WDIOC_SETTIMEOUT:
 		if (get_user(booke_wdt_period, p))
 			return -EFAULT;
-		mtspr(SPRN_TCR, (mfspr(SPRN_TCR) & ~WDTP(0)) |
+		mtspr(SPRN_TCR, (mfspr(SPRN_TCR) & ~WDTP_MASK) |
 						WDTP(booke_wdt_period));
 		return 0;
 	case WDIOC_GETTIMEOUT:
-- 
1.5.3
