Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0041.outbound.protection.outlook.com [104.47.34.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn481SWZzDvTQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:40 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>, Madalin Bucur
 <madalin.bucur@nxp.com>
Subject: [PATCH 01/17] soc/qman: Check ioremap return value
Date: Wed, 16 Nov 2016 16:40:14 +0200
Message-ID: <1479307230-16650-2-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 0cace9e..f4e6e70 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -444,6 +444,9 @@ static int zero_priv_mem(struct device *dev, struct device_node *node,
 	/* map as cacheable, non-guarded */
 	void __iomem *tmpp = ioremap_prot(addr, sz, 0);
 
+	if (!tmpp)
+		return -ENOMEM;
+
 	memset_io(tmpp, 0, sz);
 	flush_dcache_range((unsigned long)tmpp,
 			   (unsigned long)tmpp + sz);
-- 
1.7.11.7
