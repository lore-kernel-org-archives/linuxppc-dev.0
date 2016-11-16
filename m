Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0056.outbound.protection.outlook.com [104.47.32.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4W4VDQzDvXN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:59 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 14/17] soc/qbman: Handle endianness of qm/bm_in/out()
Date: Wed, 16 Nov 2016 16:40:27 +0200
Message-ID: <1479307230-16650-15-git-send-email-claudiu.manoil@nxp.com>
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

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 6 +++---
 drivers/soc/fsl/qbman/qman.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index ffa48fd..345e50c 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -167,12 +167,12 @@ struct bm_portal {
 /* Cache-inhibited register access. */
 static inline u32 bm_in(struct bm_portal *p, u32 offset)
 {
-	return __raw_readl(p->addr.ci + offset);
+	return be32_to_cpu(__raw_readl(p->addr.ci + offset));
 }
 
 static inline void bm_out(struct bm_portal *p, u32 offset, u32 val)
 {
-	__raw_writel(val, p->addr.ci + offset);
+	__raw_writel(cpu_to_be32(val), p->addr.ci + offset);
 }
 
 /* Cache Enabled Portal Access */
@@ -188,7 +188,7 @@ static inline void bm_cl_touch_ro(struct bm_portal *p, u32 offset)
 
 static inline u32 bm_ce_in(struct bm_portal *p, u32 offset)
 {
-	return __raw_readl(p->addr.ce + offset);
+	return be32_to_cpu(__raw_readl(p->addr.ce + offset));
 }
 
 struct bman_portal {
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index fd335bc..e7e1314 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -321,12 +321,12 @@ struct qm_portal {
 /* Cache-inhibited register access. */
 static inline u32 qm_in(struct qm_portal *p, u32 offset)
 {
-	return __raw_readl(p->addr.ci + offset);
+	return be32_to_cpu(__raw_readl(p->addr.ci + offset));
 }
 
 static inline void qm_out(struct qm_portal *p, u32 offset, u32 val)
 {
-	__raw_writel(val, p->addr.ci + offset);
+	__raw_writel(cpu_to_be32(val), p->addr.ci + offset);
 }
 
 /* Cache Enabled Portal Access */
@@ -342,7 +342,7 @@ static inline void qm_cl_touch_ro(struct qm_portal *p, u32 offset)
 
 static inline u32 qm_ce_in(struct qm_portal *p, u32 offset)
 {
-	return __raw_readl(p->addr.ce + offset);
+	return be32_to_cpu(__raw_readl(p->addr.ce + offset));
 }
 
 /* --- EQCR API --- */
-- 
1.7.11.7
