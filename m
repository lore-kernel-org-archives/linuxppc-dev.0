Return-Path: <weiyj_lk@163.com>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rtylz0hfwzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 21:40:43 +1000 (AEST)
From: Wei Yongjun <weiyj_lk@163.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -next] wan/fsl_ucc_hdlc: use module_platform_driver to
 simplify the code
Date: Tue, 19 Jul 2016 11:25:16 +0000
Message-Id: <1468927516-32569-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_platform_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index b3861bf..3f6b218 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1175,15 +1175,4 @@ static struct platform_driver ucc_hdlc_driver = {
 	},
 };
 
-static int __init ucc_hdlc_init(void)
-{
-	return platform_driver_register(&ucc_hdlc_driver);
-}
-
-static void __exit ucc_hdlc_exit(void)
-{
-	platform_driver_unregister(&ucc_hdlc_driver);
-}
-
-module_init(ucc_hdlc_init);
-module_exit(ucc_hdlc_exit);
+module_platform_driver(ucc_hdlc_driver);
