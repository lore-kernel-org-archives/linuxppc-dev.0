Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 037091A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 14:25:39 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2527140081
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 14:25:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 28 Oct 2014 13:25:37 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH v2 4/4] CXL: Fix PSL error due to duplicate segment table
 entries
Date: Tue, 28 Oct 2014 14:25:30 +1100
Message-Id: <1414466730-15591-5-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1414466730-15591-1-git-send-email-imunsie@au.ibm.com>
References: <1414466730-15591-1-git-send-email-imunsie@au.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 greg <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

In certain circumstances the PSL (Power Service Layer, which provides
translation services for CXL hardware) can send an interrupt for a
segment miss that the kernel has already handled. This can happen if
multiple translations for the same segment are queued in the PSL before
the kernel has restarted the first translation.

The CXL driver does not expect this situation and does not check if a
segment had already been handled. This could cause a duplicate segment
table entry which in turn caused a PSL error taking down the card.

This patch fixes the issue by checking for existing entries in the
segment table that match the segment it is trying to insert to avoid
inserting duplicate entries.

This patch requires "powerpc/copro: Use appropriate ESID mask in
copro_calculate_slb" for the sste_matches function to operate correctly.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/fault.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index cb4f323..c99e896 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -21,11 +21,20 @@
 
 #include "cxl.h"
 
-/* This finds a free SSTE for the given SLB */
+static bool sste_matches(struct cxl_sste *sste, struct copro_slb *slb)
+{
+	return ((sste->vsid_data == cpu_to_be64(slb->vsid)) &&
+		(sste->esid_data == cpu_to_be64(slb->esid)));
+}
+
+/*
+ * This finds a free SSTE for the given SLB, or returns NULL if it's already in
+ * the segment table.
+ */
 static struct cxl_sste* find_free_sste(struct cxl_context *ctx,
 				       struct copro_slb *slb)
 {
-	struct cxl_sste *primary, *sste;
+	struct cxl_sste *primary, *sste, *ret = NULL;
 	unsigned int mask = (ctx->sst_size >> 7) - 1; /* SSTP0[SegTableSize] */
 	unsigned int entry;
 	unsigned int hash;
@@ -38,15 +47,19 @@ static struct cxl_sste* find_free_sste(struct cxl_context *ctx,
 	primary = ctx->sstp + (hash << 3);
 
 	for (entry = 0, sste = primary; entry < 8; entry++, sste++) {
-		if (!(be64_to_cpu(sste->esid_data) & SLB_ESID_V))
-			return sste;
+		if (!ret && !(be64_to_cpu(sste->esid_data) & SLB_ESID_V))
+			ret = sste;
+		if (sste_matches(sste, slb))
+			return NULL;
 	}
+	if (ret)
+		return ret;
 
 	/* Nothing free, select an entry to cast out */
-	sste = primary + ctx->sst_lru;
+	ret = primary + ctx->sst_lru;
 	ctx->sst_lru = (ctx->sst_lru + 1) & 0x7;
 
-	return sste;
+	return ret;
 }
 
 static void cxl_load_segment(struct cxl_context *ctx, struct copro_slb *slb)
@@ -57,12 +70,15 @@ static void cxl_load_segment(struct cxl_context *ctx, struct copro_slb *slb)
 
 	spin_lock_irqsave(&ctx->sste_lock, flags);
 	sste = find_free_sste(ctx, slb);
+	if (!sste)
+		goto out_unlock;
 
 	pr_devel("CXL Populating SST[%li]: %#llx %#llx\n",
 			sste - ctx->sstp, slb->vsid, slb->esid);
 
 	sste->vsid_data = cpu_to_be64(slb->vsid);
 	sste->esid_data = cpu_to_be64(slb->esid);
+out_unlock:
 	spin_unlock_irqrestore(&ctx->sste_lock, flags);
 }
 
-- 
2.1.1
