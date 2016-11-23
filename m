Return-Path: <geliangtang@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP5GQ5nDFzDvY9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 02:04:30 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so795898pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 07:04:30 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Scott Wood <oss@buserror.net>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc/fsl/qe: use builtin_platform_driver
Date: Wed, 23 Nov 2016 23:04:21 +0800
Message-Id: <2fd43af1f6666eb4ebdbaeb80aa8618b97236813.1479913430.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/soc/fsl/qe/qe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2707a82..ade168f 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -717,9 +717,5 @@ static struct platform_driver qe_driver = {
 	.resume = qe_resume,
 };
 
-static int __init qe_drv_init(void)
-{
-	return platform_driver_register(&qe_driver);
-}
-device_initcall(qe_drv_init);
+builtin_platform_driver(qe_driver);
 #endif /* defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx) */
-- 
2.9.3
