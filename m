Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D51ADE699
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 02:53:35 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m3SGrUke216064
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 16:53:30 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3SGrUKx3514532
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 18:53:30 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3SGrT0V012738
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 18:53:29 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, general@lists.openfabrics.org,
	Roel Kluin <12o3l@tiscali.nl>
Subject: IB/ehca: handle negative return value from ibmebus_request_irq()
	properly in ehca_create_eq()
Date: Mon, 28 Apr 2008 18:47:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804281847.44968.hnguyen@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_eq.c |   35 ++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_eq.c b/drivers/infiniband/hw/ehca/ehca_eq.c
index b4ac617..49660df 100644
--- a/drivers/infiniband/hw/ehca/ehca_eq.c
+++ b/drivers/infiniband/hw/ehca/ehca_eq.c
@@ -54,7 +54,8 @@ int ehca_create_eq(struct ehca_shca *shca,
 		   struct ehca_eq *eq,
 		   const enum ehca_eq_type type, const u32 length)
 {
-	u64 ret;
+	int ret;
+	u64 h_ret;
 	u32 nr_pages;
 	u32 i;
 	void *vpage;
@@ -73,15 +74,15 @@ int ehca_create_eq(struct ehca_shca *shca,
 		return -EINVAL;
 	}
 
-	ret = hipz_h_alloc_resource_eq(shca->ipz_hca_handle,
-				       &eq->pf,
-				       type,
-				       length,
-				       &eq->ipz_eq_handle,
-				       &eq->length,
-				       &nr_pages, &eq->ist);
+	h_ret = hipz_h_alloc_resource_eq(shca->ipz_hca_handle,
+					 &eq->pf,
+					 type,
+					 length,
+					 &eq->ipz_eq_handle,
+					 &eq->length,
+					 &nr_pages, &eq->ist);
 
-	if (ret != H_SUCCESS) {
+	if (h_ret != H_SUCCESS) {
 		ehca_err(ib_dev, "Can't allocate EQ/NEQ. eq=%p", eq);
 		return -EINVAL;
 	}
@@ -97,24 +98,22 @@ int ehca_create_eq(struct ehca_shca *shca,
 		u64 rpage;
 
 		vpage = ipz_qpageit_get_inc(&eq->ipz_queue);
-		if (!vpage) {
-			ret = H_RESOURCE;
+		if (!vpage)
 			goto create_eq_exit2;
-		}
 
 		rpage = virt_to_abs(vpage);
-		ret = hipz_h_register_rpage_eq(shca->ipz_hca_handle,
-					       eq->ipz_eq_handle,
-					       &eq->pf,
-					       0, 0, rpage, 1);
+		h_ret = hipz_h_register_rpage_eq(shca->ipz_hca_handle,
+						 eq->ipz_eq_handle,
+						 &eq->pf,
+						 0, 0, rpage, 1);
 
 		if (i == (nr_pages - 1)) {
 			/* last page */
 			vpage = ipz_qpageit_get_inc(&eq->ipz_queue);
-			if (ret != H_SUCCESS || vpage)
+			if (h_ret != H_SUCCESS || vpage)
 				goto create_eq_exit2;
 		} else {
-			if (ret != H_PAGE_REGISTERED || !vpage)
+			if (h_ret != H_PAGE_REGISTERED || !vpage)
 				goto create_eq_exit2;
 		}
 	}
-- 
1.5.5
