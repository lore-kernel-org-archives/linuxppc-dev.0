Return-Path: <rvinson@mvista.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) by ozlabs.org (Postfix) with ESMTP id 2E4A6B6EF1
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 08:03:02 +1100 (EST)
Received: by qwj8 with SMTP id 8so10375601qwj.15
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Dec 2010 13:03:00 -0800 (PST)
Message-ID: <4CFD4F5F.8070108@mvista.com>
Date: Mon, 06 Dec 2010 14:02:23 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-watchdog@vger.kernel.org, Kumar Gala <kumar.gala@freescale.com>
Subject: [PATCH] powerpc/watchdog: Propagate Book E WDT period changes to
	all cores
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the watchdog period is changed, it needs to be propagated to all cores
in addition to the core that performed the change.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 drivers/watchdog/booke_wdt.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index d11ffb0..c8ffa6c 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -85,6 +85,22 @@ static unsigned int sec_to_period(unsigned int secs)
 	return 0;
 }
 
+static void __booke_wdt_set(void *data)
+{
+	u32 val;
+
+	val = mfspr(SPRN_TCR);
+	val &= ~WDTP_MASK;
+	val |= WDTP(booke_wdt_period);
+
+	mtspr(SPRN_TCR, val);
+}
+
+static void booke_wdt_set(void)
+{
+	on_each_cpu(__booke_wdt_set, NULL, 0);
+}
+
 static void __booke_wdt_ping(void *data)
 {
 	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
@@ -181,8 +197,7 @@ static long booke_wdt_ioctl(struct file *file,
 #else
 		booke_wdt_period = tmp;
 #endif
-		mtspr(SPRN_TCR, (mfspr(SPRN_TCR) & ~WDTP_MASK) |
-						WDTP(booke_wdt_period));
+		booke_wdt_set();
 		return 0;
 	case WDIOC_GETTIMEOUT:
 		return put_user(booke_wdt_period, p);
-- 
1.6.3.3.328.ge81f
