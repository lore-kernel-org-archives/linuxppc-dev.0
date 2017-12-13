Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxkNC3hlpzDrp4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 04:34:51 +1100 (AEDT)
Subject: [PATCH 2/3] soc/fsl/qe: Improve a size determination in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Message-ID: <24d6e67d-6bbf-5d2b-5003-79b50a84f268@users.sourceforge.net>
Date: Wed, 13 Dec 2017 18:34:42 +0100
MIME-Version: 1.0
In-Reply-To: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 13 Dec 2017 17:51:21 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/soc/fsl/qe/ucc_fast.c | 2 +-
 drivers/soc/fsl/qe/ucc_slow.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index 59b68bf4aebb..2092bfdcf1bc 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -194,7 +194,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		return -EINVAL;
 	}
 
-	uccf = kzalloc(sizeof(struct ucc_fast_private), GFP_KERNEL);
+	uccf = kzalloc(sizeof(*uccf), GFP_KERNEL);
 	if (!uccf)
 		return -ENOMEM;
 
diff --git a/drivers/soc/fsl/qe/ucc_slow.c b/drivers/soc/fsl/qe/ucc_slow.c
index fc91412e2300..c21a42c11080 100644
--- a/drivers/soc/fsl/qe/ucc_slow.c
+++ b/drivers/soc/fsl/qe/ucc_slow.c
@@ -152,7 +152,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 		return -EINVAL;
 	}
 
-	uccs = kzalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
+	uccs = kzalloc(sizeof(*uccs), GFP_KERNEL);
 	if (!uccs)
 		return -ENOMEM;
 
-- 
2.15.1
