Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0B5E2C0097
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2012 12:05:11 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <B04825@freescale.com>
Subject: [v2 PATCH 1/1] booke/wdt: some ioctls do not return values properly
Date: Tue, 7 Aug 2012 09:59:40 +0800
Message-ID: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix some booke wdt ioctls return value error.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 drivers/watchdog/booke_wdt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 3fe82d0..5b06d31 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -166,18 +166,17 @@ static long booke_wdt_ioctl(struct file *file,
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if (copy_to_user((void *)arg, &ident, sizeof(ident)))
-			return -EFAULT;
+		return copy_to_user(p, &ident, sizeof(ident)) ? -EFAULT : 0;
 	case WDIOC_GETSTATUS:
 		return put_user(0, p);
 	case WDIOC_GETBOOTSTATUS:
 		/* XXX: something is clearing TSR */
 		tmp = mfspr(SPRN_TSR) & TSR_WRS(3);
 		/* returns CARDRESET if last reset was caused by the WDT */
-		return (tmp ? WDIOF_CARDRESET : 0);
+		return put_user((tmp ? WDIOF_CARDRESET : 0), p);
 	case WDIOC_SETOPTIONS:
 		if (get_user(tmp, p))
-			return -EINVAL;
+			return -EFAULT;
 		if (tmp == WDIOS_ENABLECARD) {
 			booke_wdt_ping();
 			break;
-- 
1.5.6
