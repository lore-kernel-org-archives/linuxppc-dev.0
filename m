Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 92FA7DDF93
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 22:54:12 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix Book-E watchdog timer interval setting
Date: Thu, 7 Aug 2008 14:48:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808071448.06183.matthias.fuchs@esd-electronics.com>
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

Tested on PPC440EPx sequoia evaluation board.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
---
 drivers/watchdog/booke_wdt.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 7708244..9db5478 100644
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
@@ -106,7 +109,8 @@ static int booke_wdt_ioctl(struct inode *inode, struct file *file,
 	case WDIOC_SETTIMEOUT:
 		if (get_user(booke_wdt_period, p))
 			return -EFAULT;
-		mtspr(SPRN_TCR, (mfspr(SPRN_TCR)&~WDTP(0))|WDTP(booke_wdt_period));
+		tmp = mfspr(SPRN_TCR) & ~WDTP_MASK;
+		mtspr(SPRN_TCR, tmp | WDTP(booke_wdt_period));
 		return 0;
 	case WDIOC_GETTIMEOUT:
 		return put_user(booke_wdt_period, p);
-- 
1.5.3
