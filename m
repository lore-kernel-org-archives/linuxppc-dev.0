Return-Path: <qiang.zhao@nxp.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0043.outbound.protection.outlook.com [104.47.40.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryVpQ21kMzDqcn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 15:55:09 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <xiaobo.xie@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v5 1/2] qe: modify get_qe_base function
Date: Mon, 25 Jul 2016 13:43:46 +0800
Message-ID: <1469425427-33883-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

modify get_qe_base function with of_address_to_resource
instead of of_get_property and of_translate_address.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- na
Changes for v3:
	- na
Changes for v4:
	- na
Changes for v5:
	- na

 drivers/soc/fsl/qe/qe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 7026507..2707a82 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -69,8 +69,8 @@ static phys_addr_t qebase = -1;
 phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
-	int size;
-	const u32 *prop;
+	int ret;
+	struct resource res;
 
 	if (qebase != -1)
 		return qebase;
@@ -82,9 +82,9 @@ phys_addr_t get_qe_base(void)
 			return qebase;
 	}
 
-	prop = of_get_property(qe, "reg", &size);
-	if (prop && size >= sizeof(*prop))
-		qebase = of_translate_address(qe, prop);
+	ret = of_address_to_resource(qe, 0, &res);
+	if (!ret)
+		qebase = res.start;
 	of_node_put(qe);
 
 	return qebase;
-- 
2.1.0.27.g96db324
