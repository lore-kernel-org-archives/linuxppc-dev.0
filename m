Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420xRK0HHHzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 06:04:28 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id x197-v6so11427392oix.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 13:04:28 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
Date: Wed, 29 Aug 2018 15:04:25 -0500
Message-Id: <20180829200425.16435-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the of_get_child_by_name() helper instead of open coding searching
for the 'firmware' child node. This removes directly accessing the name
pointer as well.

Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/fsl/qe/qe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2ef6fc6487c1..612d9c551be5 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -588,11 +588,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	}
 
 	/* Find the 'firmware' child node */
-	for_each_child_of_node(qe, fw) {
-		if (strcmp(fw->name, "firmware") == 0)
-			break;
-	}
-
+	fw = of_get_child_by_name(qe, "firmware");
 	of_node_put(qe);
 
 	/* Did we find the 'firmware' node? */
-- 
2.17.1
