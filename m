Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06498DDF8B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 23:51:47 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6KDpf6j179972
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:51:41 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6KDpfsV2216122
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:51:41 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6KDpO6e024643
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:51:25 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 4/5] ehca: Make internal_create/destroy_qp() static
Date: Fri, 20 Jul 2007 16:03:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707201603.10321.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joachim Fenkes <fenkes@de.ibm.com>
Date: Thu, 19 Jul 2007 21:40:00 +0200
Subject: [PATCH 4/5] IB/ehca: Make internal_{create,destroy}_qp() static

They're only used in ehca_qp.c

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 48e9cea..b916d9c 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -363,10 +363,11 @@ init_qp_queue1:
  * the value of the is_srq parameter. If init_attr and srq_init_attr share
  * fields, the field out of init_attr is used.
  */
-struct ehca_qp *internal_create_qp(struct ib_pd *pd,
-				   struct ib_qp_init_attr *init_attr,
-				   struct ib_srq_init_attr *srq_init_attr,
-				   struct ib_udata *udata, int is_srq)
+static struct ehca_qp *internal_create_qp(
+	struct ib_pd *pd,
+	struct ib_qp_init_attr *init_attr,
+	struct ib_srq_init_attr *srq_init_attr,
+	struct ib_udata *udata, int is_srq)
 {
 	struct ehca_qp *my_qp;
 	struct ehca_pd *my_pd = container_of(pd, struct ehca_pd, ib_pd);
@@ -752,8 +753,8 @@ struct ib_qp *ehca_create_qp(struct ib_pd *pd,
 	return IS_ERR(ret) ? (struct ib_qp *)ret : &ret->ib_qp;
 }
 
-int internal_destroy_qp(struct ib_device *dev, struct ehca_qp *my_qp,
-			struct ib_uobject *uobject);
+static int internal_destroy_qp(struct ib_device *dev, struct ehca_qp *my_qp,
+			       struct ib_uobject *uobject);
 
 struct ib_srq *ehca_create_srq(struct ib_pd *pd,
 			       struct ib_srq_init_attr *srq_init_attr,
@@ -1669,8 +1670,8 @@ query_srq_exit1:
 	return ret;
 }
 
-int internal_destroy_qp(struct ib_device *dev, struct ehca_qp *my_qp,
-			struct ib_uobject *uobject)
+static int internal_destroy_qp(struct ib_device *dev, struct ehca_qp *my_qp,
+			       struct ib_uobject *uobject)
 {
 	struct ehca_shca *shca = container_of(dev, struct ehca_shca, ib_device);
 	struct ehca_pd *my_pd = container_of(my_qp->ib_qp.pd, struct ehca_pd,
-- 
1.5.2
