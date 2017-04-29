Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFh543Pr5zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 05:46:15 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id y10so17048784wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 12:46:15 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck hacking
 jiffies.
Date: Sat, 29 Apr 2017 21:46:04 +0200
Message-Id: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the jiffies into usecs then use it with usleep_range
such that instead of stuck doing nothing until action happens,
sleep with range improves responsiveness and power usage
and avoid hacking jiffies. it's used for approximate time.
You can check /kernel/time/timer.c.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 6f509f6..e0df4d1 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1084,11 +1084,9 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		u64 now, then = jiffies;
+		unsigned int udel_time = jiffies_to_usecs(10000);
 
-		do {
-			now = jiffies;
-		} while ((then + 10000) > now);
+		usleep_range(udel_time/2, udel_time);
 		msg = qm_mr_current(p);
 		if (!msg)
 			return 0;
-- 
2.7.4
