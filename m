Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 1708D1A0D38
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 03:41:48 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 13/17] crypto: talitos - move sg_count() helper into
 talitos.h
Message-Id: <20150306164146.1751B1A241C@localhost.localdomain>
Date: Fri,  6 Mar 2015 17:41:46 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

move sg_count() helper into talitos.h as it will be needed by SEC1 specific functions

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/crypto/talitos.c | 20 --------------------
 drivers/crypto/talitos.h | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 0262e75..76209e8 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -457,26 +457,6 @@ static void talitos_unregister_rng(struct device *dev)
 #define TALITOS_CRA_PRIORITY		3000
 
 /*
- * derive number of elements in scatterlist
- */
-static int sg_count(struct scatterlist *sg_list, int nbytes, bool *chained)
-{
-	struct scatterlist *sg = sg_list;
-	int sg_nents = 0;
-
-	*chained = false;
-	while (nbytes > 0) {
-		sg_nents++;
-		nbytes -= sg->length;
-		if (!sg_is_last(sg) && (sg + 1)->length == 0)
-			*chained = true;
-		sg = sg_next(sg);
-	}
-
-	return sg_nents;
-}
-
-/*
  * allocate and map the extended descriptor
  */
 struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index f5e8013..f0ffbb0 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -153,6 +153,27 @@ extern void talitos_error(struct device *dev, u32 isr, u32 isr_lo);
 
 extern int talitos_cra_init(struct crypto_tfm *tfm);
 
+/*
+ * derive number of elements in scatterlist
+ */
+static inline int sg_count(struct scatterlist *sg_list, int nbytes,
+			   bool *chained)
+{
+	struct scatterlist *sg = sg_list;
+	int sg_nents = 0;
+
+	*chained = false;
+	while (nbytes > 0) {
+		sg_nents++;
+		nbytes -= sg->length;
+		if (!sg_is_last(sg) && (sg + 1)->length == 0)
+			*chained = true;
+		sg = sg_next(sg);
+	}
+
+	return sg_nents;
+}
+
 /* .features flag */
 #define TALITOS_FTR_SRC_LINK_TBL_LEN_INCLUDES_EXTENT 0x00000001
 #define TALITOS_FTR_HW_AUTH_CHECK 0x00000002
-- 
2.1.0
