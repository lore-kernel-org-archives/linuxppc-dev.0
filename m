Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E623DDE45
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 22:49:40 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9HBmw1p028069
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 05:48:58 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9HBnYKr102934
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 05:49:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9HBnXHX003340
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 05:49:34 -0600
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] IB/ehca: Fix problem with max number of QPs and CQs in
	systems with different adapters
Date: Fri, 17 Oct 2008 13:49:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810171349.12686.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, stefan.roscher@de.ibm.com, alexschm@de.ibm.com,
	raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because ehca adapters can differ in the maximum number of QPs and CQs
we have to save the maximum number of these ressources per adapter and not
globally per ehca driver. This fix introduces 2 new members to the shca
structure to store the maximum value for QPs and CQs per adapter.
The module parameters are now used as initial values for those variables.
If a user selects an invalid number of CQs or QPs we don't print an error any
longer, instead we will inform the user with a warning and set the values to
the respective maximum supported by the HW.

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    2 +
 drivers/infiniband/hw/ehca/ehca_cq.c      |    4 +-
 drivers/infiniband/hw/ehca/ehca_main.c    |   35 ++++++++++++++++------------
 drivers/infiniband/hw/ehca/ehca_qp.c      |    4 +-
 4 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 5d7b785..4df887a 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -128,6 +128,8 @@ struct ehca_shca {
 	/* MR pgsize: bit 0-3 means 4K, 64K, 1M, 16M respectively */
 	u32 hca_cap_mr_pgsize;
 	int max_mtu;
+	int max_num_qps;
+	int max_num_cqs;
 	atomic_t num_cqs;
 	atomic_t num_qps;
 };
diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 33647a9..2f4c28a 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -132,9 +132,9 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe, int comp_vector,
 	if (cqe >= 0xFFFFFFFF - 64 - additional_cqe)
 		return ERR_PTR(-EINVAL);
 
-	if (!atomic_add_unless(&shca->num_cqs, 1, ehca_max_cq)) {
+	if (!atomic_add_unless(&shca->num_cqs, 1, shca->max_num_cqs)) {
 		ehca_err(device, "Unable to create CQ, max number of %i "
-			"CQs reached.", ehca_max_cq);
+			"CQs reached.", shca->max_num_cqs);
 		ehca_err(device, "To increase the maximum number of CQs "
 			"use the number_of_cqs module parameter.\n");
 		return ERR_PTR(-ENOSPC);
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 598844d..086959a 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -366,22 +366,23 @@ static int ehca_sense_attributes(struct ehca_shca *shca)
 			shca->hca_cap_mr_pgsize |= pgsize_map[i + 1];
 
 	/* Set maximum number of CQs and QPs to calculate EQ size */
-	if (ehca_max_qp == -1)
-		ehca_max_qp = min_t(int, rblock->max_qp, EHCA_MAX_NUM_QUEUES);
-	else if (ehca_max_qp < 1 || ehca_max_qp > rblock->max_qp) {
-		ehca_gen_err("Requested number of QPs is out of range (1 - %i) "
-			"specified by HW", rblock->max_qp);
-		ret = -EINVAL;
-		goto sense_attributes1;
+	if (shca->max_num_qps == -1)
+		shca->max_num_qps = min_t(int, rblock->max_qp,
+					  EHCA_MAX_NUM_QUEUES);
+	else if (shca->max_num_qps < 1 || shca->max_num_qps > rblock->max_qp) {
+		ehca_gen_warn("The requested number of QPs is out of range "
+			      "(1 - %i) specified by HW. Value is set to %i",
+			      rblock->max_qp, rblock->max_qp);
+		shca->max_num_qps = rblock->max_qp;
 	}
 
-	if (ehca_max_cq == -1)
-		ehca_max_cq = min_t(int, rblock->max_cq, EHCA_MAX_NUM_QUEUES);
-	else if (ehca_max_cq < 1 || ehca_max_cq > rblock->max_cq) {
-		ehca_gen_err("Requested number of CQs is out of range (1 - %i) "
-			"specified by HW", rblock->max_cq);
-		ret = -EINVAL;
-		goto sense_attributes1;
+	if (shca->max_num_cqs == -1)
+		shca->max_num_cqs = min_t(int, rblock->max_cq,
+					  EHCA_MAX_NUM_QUEUES);
+	else if (shca->max_num_cqs < 1 || shca->max_num_cqs > rblock->max_cq) {
+		ehca_gen_warn("The requested number of CQs is out of range "
+			      "(1 - %i) specified by HW. Value is set to %i",
+			      rblock->max_cq, rblock->max_cq);
 	}
 
 	/* query max MTU from first port -- it's the same for all ports */
@@ -733,9 +734,13 @@ static int __devinit ehca_probe(struct of_device *dev,
 		ehca_gen_err("Cannot allocate shca memory.");
 		return -ENOMEM;
 	}
+
 	mutex_init(&shca->modify_mutex);
 	atomic_set(&shca->num_cqs, 0);
 	atomic_set(&shca->num_qps, 0);
+	shca->max_num_qps = ehca_max_qp;
+	shca->max_num_cqs = ehca_max_cq;
+
 	for (i = 0; i < ARRAY_SIZE(shca->sport); i++)
 		spin_lock_init(&shca->sport[i].mod_sqp_lock);
 
@@ -755,7 +760,7 @@ static int __devinit ehca_probe(struct of_device *dev,
 		goto probe1;
 	}
 
-	eq_size = 2 * ehca_max_cq + 4 * ehca_max_qp;
+	eq_size = 2 * shca->max_num_cqs + 4 * shca->max_num_qps;
 	/* create event queues */
 	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, eq_size);
 	if (ret) {
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 40b578d..4d54b9f 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -465,9 +465,9 @@ static struct ehca_qp *internal_create_qp(
 	u32 swqe_size = 0, rwqe_size = 0, ib_qp_num;
 	unsigned long flags;
 
-	if (!atomic_add_unless(&shca->num_qps, 1, ehca_max_qp)) {
+	if (!atomic_add_unless(&shca->num_qps, 1, shca->max_num_qps)) {
 		ehca_err(pd->device, "Unable to create QP, max number of %i "
-			 "QPs reached.", ehca_max_qp);
+			 "QPs reached.", shca->max_num_qps);
 		ehca_err(pd->device, "To increase the maximum number of QPs "
 			 "use the number_of_qps module parameter.\n");
 		return ERR_PTR(-ENOSPC);
-- 
1.5.5
