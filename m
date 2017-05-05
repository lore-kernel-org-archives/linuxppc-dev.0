Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK18D6QL6zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 15:45:32 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id z129so7543458wmb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 22:45:32 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: RE: [PATCH v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
Date: Fri,  5 May 2017 07:45:18 +0200
Message-Id: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
References: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use msleep() instead of stucking with
long delay will be more efficient.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 3d891db..18d391e 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1084,11 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		u64 now, then = jiffies;
-
-		do {
-			now = jiffies;
-		} while ((then + 10000) > now);
+		msleep(1);
 		msg = qm_mr_current(p);
 		if (!msg)
 			return 0;
-- 
2.7.4
