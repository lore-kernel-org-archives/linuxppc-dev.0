Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0048.outbound.protection.outlook.com [104.47.36.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4V1t9LzDvb7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:58 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 13/17] soc/qman: Drop unused field from eqcr/dqrr descriptors
Date: Wed, 16 Nov 2016 16:40:26 +0200
Message-ID: <1479307230-16650-14-git-send-email-claudiu.manoil@nxp.com>
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

ORP ("Order Restoration Point") mechanism not supported.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 3 +--
 include/soc/fsl/qman.h       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 099ba8e..fd335bc 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -141,7 +141,7 @@ struct qm_eqcr_entry {
 	u8 _ncw_verb; /* writes to this are non-coherent */
 	u8 dca;
 	u16 seqnum;
-	u32 orp;	/* 24-bit */
+	u8 __reserved[4];
 	u32 fqid;	/* 24-bit */
 	u32 tag;
 	struct qm_fd fd;
@@ -470,7 +470,6 @@ static inline struct qm_eqcr_entry *qm_eqcr_start_stash(struct qm_portal
 static inline void eqcr_commit_checks(struct qm_eqcr *eqcr)
 {
 	DPAA_ASSERT(eqcr->busy);
-	DPAA_ASSERT(eqcr->cursor->orp == (eqcr->cursor->orp & 0x00ffffff));
 	DPAA_ASSERT(!(eqcr->cursor->fqid & ~QM_FQID_MASK));
 	DPAA_ASSERT(eqcr->available >= 1);
 }
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index f3fa53f..20bbc71 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -279,8 +279,7 @@ struct qm_dqrr_entry {
 		u8 dca;
 		u16 seqnum;
 		u8 rc;		/* Rej Code: 8-bit */
-		u8 orp_hi;	/* ORP: 24-bit */
-		u16 orp_lo;
+		u8 __reserved[3];
 		u32 fqid;	/* 24-bit */
 		u32 tag;
 		struct qm_fd fd;
-- 
1.7.11.7
