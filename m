Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C49DDDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 01:51:11 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6CFp6Xc062450
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 15:51:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6CFp6uW2134236
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:51:06 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6CFp5Yh002340
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:51:06 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 05/10] IB/ehca: use #define for "pages per register_rpage"
	instead of hardcoded value
References: <200707121745.27592.fenkes@de.ibm.com>
In-Reply-To: <200707121745.27592.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Thu, 12 Jul 2007 17:51:04 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707121751.05587.fenkes@de.ibm.com>
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
 drivers/infiniband/hw/ehca/ehca_mrmw.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 7c1656a..1fe4f72 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -48,6 +48,9 @@
 #include "hcp_if.h"
 #include "hipz_hw.h"
 
+/* max number of rpages (per hcall register_rpages) */
+#define MAX_RPAGES 512
+
 static struct kmem_cache *mr_cache;
 static struct kmem_cache *mw_cache;
 
@@ -1027,14 +1030,14 @@ int ehca_reg_mr_rpages(struct ehca_shca *shca,
 	}
 
 	/* max 512 pages per shot */
-	for (i = 0; i < ((pginfo->num_4k + 512 - 1) / 512); i++) {
+	for (i = 0; i < ((pginfo->num_4k + MAX_RPAGES - 1) / MAX_RPAGES); i++) {
 
-		if (i == ((pginfo->num_4k + 512 - 1) / 512) - 1) {
-			rnum = pginfo->num_4k % 512; /* last shot */
+		if (i == ((pginfo->num_4k + MAX_RPAGES - 1) / MAX_RPAGES) - 1) {
+			rnum = pginfo->num_4k % MAX_RPAGES; /* last shot */
 			if (rnum == 0)
-				rnum = 512;      /* last shot is full */
+				rnum = MAX_RPAGES;      /* last shot is full */
 		} else
-			rnum = 512;
+			rnum = MAX_RPAGES;
 
 		if (rnum > 1) {
 			ret = ehca_set_pagebuf(e_mr, pginfo, rnum, kpage);
@@ -1066,7 +1069,7 @@ int ehca_reg_mr_rpages(struct ehca_shca *shca,
 						 0, /* pagesize 4k */
 						 0, rpage, rnum);
 
-		if (i == ((pginfo->num_4k + 512 - 1) / 512) - 1) {
+		if (i == ((pginfo->num_4k + MAX_RPAGES - 1) / MAX_RPAGES) - 1) {
 			/*
 			 * check for 'registration complete'==H_SUCCESS
 			 * and for 'page registered'==H_PAGE_REGISTERED
@@ -1215,7 +1218,7 @@ int ehca_rereg_mr(struct ehca_shca *shca,
 	int rereg_3_hcall = 0; /* 1: use 3 hipz calls for reregistration */
 
 	/* first determine reregistration hCall(s) */
-	if ((pginfo->num_4k > 512) || (e_mr->num_4k > 512) ||
+	if ((pginfo->num_4k > MAX_RPAGES) || (e_mr->num_4k > MAX_RPAGES) ||
 	    (pginfo->num_4k > e_mr->num_4k)) {
 		ehca_dbg(&shca->ib_device, "Rereg3 case, pginfo->num_4k=%lx "
 			 "e_mr->num_4k=%x", pginfo->num_4k, e_mr->num_4k);
@@ -1306,7 +1309,7 @@ int ehca_unmap_one_fmr(struct ehca_shca *shca,
 	struct ehca_mr_hipzout_parms hipzout = {{0},0,0,0,0,0};
 
 	/* first check if reregistration hCall can be used for unmap */
-	if (e_fmr->fmr_max_pages > 512) {
+	if (e_fmr->fmr_max_pages > MAX_RPAGES) {
 		rereg_1_hcall = 0;
 		rereg_3_hcall = 1;
 	}
-- 
1.5.2
