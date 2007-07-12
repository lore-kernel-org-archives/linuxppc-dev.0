Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DE9BDDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 01:51:49 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6CFpjju954548
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 15:51:45 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6CFpjkJ2109580
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:51:45 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6CFpifj007086
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:51:45 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 06/10] IB/ehca: use macro to calculate number of chunks in a
	mem block
References: <200707121745.27592.fenkes@de.ibm.com>
In-Reply-To: <200707121745.27592.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Thu, 12 Jul 2007 17:51:43 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707121751.44394.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_mrmw.c |   47 ++++++++++++++++---------------
 1 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 1fe4f72..58e8b33 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -48,6 +48,8 @@
 #include "hcp_if.h"
 #include "hipz_hw.h"
 
+#define NUM_CHUNKS(length, chunk_size) \
+	(((length) + (chunk_size - 1)) / (chunk_size))
 /* max number of rpages (per hcall register_rpages) */
 #define MAX_RPAGES 512
 
@@ -195,10 +197,10 @@ struct ib_mr *ehca_reg_phys_mr(struct ib_pd *pd,
 	}
 
 	/* determine number of MR pages */
-	num_pages_mr = ((((u64)iova_start % PAGE_SIZE) + size +
-			 PAGE_SIZE - 1) / PAGE_SIZE);
-	num_pages_4k = ((((u64)iova_start % EHCA_PAGESIZE) + size +
-			 EHCA_PAGESIZE - 1) / EHCA_PAGESIZE);
+	num_pages_mr = NUM_CHUNKS(((u64)iova_start % PAGE_SIZE) + size,
+				  PAGE_SIZE);
+	num_pages_4k = NUM_CHUNKS(((u64)iova_start % EHCA_PAGESIZE) + size,
+				  EHCA_PAGESIZE);
 
 	/* register MR on HCA */
 	if (ehca_mr_is_maxmr(size, iova_start)) {
@@ -305,10 +307,9 @@ struct ib_mr *ehca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length, u64 virt
 	}
 
 	/* determine number of MR pages */
-	num_pages_mr = (((virt % PAGE_SIZE) + length + PAGE_SIZE - 1) /
-			PAGE_SIZE);
-	num_pages_4k = (((virt % EHCA_PAGESIZE) + length + EHCA_PAGESIZE - 1) /
-			EHCA_PAGESIZE);
+	num_pages_mr = NUM_CHUNKS((virt % PAGE_SIZE) + length, PAGE_SIZE);
+	num_pages_4k = NUM_CHUNKS((virt % EHCA_PAGESIZE) + length,
+				  EHCA_PAGESIZE);
 
 	/* register MR on HCA */
 	pginfo.type       = EHCA_MR_PGI_USER;
@@ -462,10 +463,10 @@ int ehca_rereg_phys_mr(struct ib_mr *mr,
 			ret = -EINVAL;
 			goto rereg_phys_mr_exit1;
 		}
-		num_pages_mr = ((((u64)new_start % PAGE_SIZE) + new_size +
-				 PAGE_SIZE - 1) / PAGE_SIZE);
-		num_pages_4k = ((((u64)new_start % EHCA_PAGESIZE) + new_size +
-				 EHCA_PAGESIZE - 1) / EHCA_PAGESIZE);
+		num_pages_mr = NUM_CHUNKS(((u64)new_start % PAGE_SIZE) +
+					  new_size, PAGE_SIZE);
+		num_pages_4k = NUM_CHUNKS(((u64)new_start % EHCA_PAGESIZE) +
+					  new_size, EHCA_PAGESIZE);
 		pginfo.type           = EHCA_MR_PGI_PHYS;
 		pginfo.num_pages      = num_pages_mr;
 		pginfo.num_4k         = num_pages_4k;
@@ -1030,9 +1031,9 @@ int ehca_reg_mr_rpages(struct ehca_shca *shca,
 	}
 
 	/* max 512 pages per shot */
-	for (i = 0; i < ((pginfo->num_4k + MAX_RPAGES - 1) / MAX_RPAGES); i++) {
+	for (i = 0; i < NUM_CHUNKS(pginfo->num_4k, MAX_RPAGES); i++) {
 
-		if (i == ((pginfo->num_4k + MAX_RPAGES - 1) / MAX_RPAGES) - 1) {
+		if (i == NUM_CHUNKS(pginfo->num_4k, MAX_RPAGES) - 1) {
 			rnum = pginfo->num_4k % MAX_RPAGES; /* last shot */
 			if (rnum == 0)
 				rnum = MAX_RPAGES;      /* last shot is full */
@@ -1069,7 +1070,7 @@ int ehca_reg_mr_rpages(struct ehca_shca *shca,
 						 0, /* pagesize 4k */
 						 0, rpage, rnum);
 
-		if (i == ((pginfo->num_4k + MAX_RPAGES - 1) / MAX_RPAGES) - 1) {
+		if (i == NUM_CHUNKS(pginfo->num_4k, MAX_RPAGES) - 1) {
 			/*
 			 * check for 'registration complete'==H_SUCCESS
 			 * and for 'page registered'==H_PAGE_REGISTERED
@@ -1475,10 +1476,10 @@ int ehca_reg_internal_maxmr(
 	iova_start = (u64*)KERNELBASE;
 	ib_pbuf.addr = 0;
 	ib_pbuf.size = size_maxmr;
-	num_pages_mr = ((((u64)iova_start % PAGE_SIZE) + size_maxmr +
-			 PAGE_SIZE - 1) / PAGE_SIZE);
-	num_pages_4k = ((((u64)iova_start % EHCA_PAGESIZE) + size_maxmr +
-			 EHCA_PAGESIZE - 1) / EHCA_PAGESIZE);
+	num_pages_mr = NUM_CHUNKS(((u64)iova_start % PAGE_SIZE) + size_maxmr,
+				  PAGE_SIZE);
+	num_pages_4k = NUM_CHUNKS(((u64)iova_start % EHCA_PAGESIZE)
+				  + size_maxmr, EHCA_PAGESIZE);
 
 	pginfo.type           = EHCA_MR_PGI_PHYS;
 	pginfo.num_pages      = num_pages_mr;
@@ -1700,8 +1701,8 @@ int ehca_set_pagebuf(struct ehca_mr *e_mr,
 		/* loop over desired phys_buf_array entries */
 		while (i < number) {
 			pbuf   = pginfo->phys_buf_array + pginfo->next_buf;
-			num4k  = ((pbuf->addr % EHCA_PAGESIZE) + pbuf->size +
-				  EHCA_PAGESIZE - 1) / EHCA_PAGESIZE;
+			num4k  = NUM_CHUNKS((pbuf->addr % EHCA_PAGESIZE)
+					    + pbuf->size, EHCA_PAGESIZE);
 			offs4k = (pbuf->addr & ~PAGE_MASK) / EHCA_PAGESIZE;
 			while (pginfo->next_4k < offs4k + num4k) {
 				/* sanity check */
@@ -1873,8 +1874,8 @@ int ehca_set_pagebuf_1(struct ehca_mr *e_mr,
 			goto ehca_set_pagebuf_1_exit0;
 		}
 		tmp_pbuf = pginfo->phys_buf_array + pginfo->next_buf;
-		num4k  = ((tmp_pbuf->addr % EHCA_PAGESIZE) + tmp_pbuf->size +
-			  EHCA_PAGESIZE - 1) / EHCA_PAGESIZE;
+		num4k  = NUM_CHUNKS((tmp_pbuf->addr % EHCA_PAGESIZE) +
+				    tmp_pbuf->size, EHCA_PAGESIZE);
 		offs4k = (tmp_pbuf->addr & ~PAGE_MASK) / EHCA_PAGESIZE;
 		*rpage = phys_to_abs((tmp_pbuf->addr & EHCA_PAGEMASK) +
 				     (pginfo->next_4k * EHCA_PAGESIZE));
-- 
1.5.2
