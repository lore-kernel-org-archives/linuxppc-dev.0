Return-Path: <vaishali.thakkar@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sh0wW7084zDrKg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 16:40:27 +1000 (AEST)
From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
To: qiang.zhao@nxp.com
Cc: davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Vaishali Thakkar <vaishali.thakkar@oracle.com>
Subject: [PATCH] fsl/qe: Use resource_size
Date: Sat, 24 Sep 2016 12:10:06 +0530
Message-Id: <1474699206-11075-1-git-send-email-vaishali.thakkar@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the function resource_size instead of explicit computation.

Problem found using Coccinelle.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
 drivers/soc/fsl/qe/qe_tdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index 5e48b14..124e222 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -167,7 +167,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	}
 
 	if (siram_init_flag == 0) {
-		memset_io(utdm->siram, 0,  res->end - res->start + 1);
+		memset_io(utdm->siram, 0,  resource_size(res));
 		siram_init_flag = 1;
 	}
 
-- 
2.1.4
