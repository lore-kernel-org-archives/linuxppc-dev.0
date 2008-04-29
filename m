Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B02ADDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:44:23 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3TFiJB3016960
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:44:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3TFiJon303916
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:44:19 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3TFiJuU009431
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:44:19 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Allocate event queue size depending on max number of
	CQs and QPs
Date: Tue, 29 Apr 2008 17:44:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804291744.17235.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Signed-off-by: Stefan Roscher <stefan.roscher at de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    5 ++++
 drivers/infiniband/hw/ehca/ehca_cq.c      |   10 ++++++++
 drivers/infiniband/hw/ehca/ehca_main.c    |   36 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/ehca/ehca_qp.c      |   10 ++++++++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 3d6d946..00bab60 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -66,6 +66,7 @@ struct ehca_av;
 #include "ehca_irq.h"
 
 #define EHCA_EQE_CACHE_SIZE 20
+#define EHCA_MAX_NUM_QUEUES 0xffff
 
 struct ehca_eqe_cache_entry {
 	struct ehca_eqe *eqe;
@@ -127,6 +128,8 @@ struct ehca_shca {
 	/* MR pgsize: bit 0-3 means 4K, 64K, 1M, 16M respectively */
 	u32 hca_cap_mr_pgsize;
 	int max_mtu;
+	atomic_t num_cqs;
+	atomic_t num_qps;
 };
 
 struct ehca_pd {
@@ -344,6 +347,8 @@ extern int ehca_use_hp_mr;
 extern int ehca_scaling_code;
 extern int ehca_lock_hcalls;
 extern int ehca_nr_ports;
+extern int ehca_max_cq;
+extern int ehca_max_qp;
 
 struct ipzu_queue_resp {
 	u32 qe_size;      /* queue entry size */
diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index ec0cfcf..5b4f9a3 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -132,6 +132,14 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe, int comp_vector,
 	if (cqe >= 0xFFFFFFFF - 64 - additional_cqe)
 		return ERR_PTR(-EINVAL);
 
+	if (atomic_read(&shca->num_cqs) >= ehca_max_cq) {
+		ehca_err(device, "Unable to create CQ, max number of %i "
+			"CQs reached.", ehca_max_cq);
+		ehca_err(device, "To increase the maximum number of CQs "
+			"use the number_of_cqs module parameter.\n");
+		return ERR_PTR(-ENOSPC);
+	}
+
 	my_cq = kmem_cache_zalloc(cq_cache, GFP_KERNEL);
 	if (!my_cq) {
 		ehca_err(device, "Out of memory for ehca_cq struct device=%p",
@@ -286,6 +294,7 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe, int comp_vector,
 		}
 	}
 
+	atomic_inc(&shca->num_cqs);
 	return cq;
 
 create_cq_exit4:
@@ -359,6 +368,7 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	ipz_queue_dtor(NULL, &my_cq->ipz_queue);
 	kmem_cache_free(cq_cache, my_cq);
 
+	atomic_dec(&shca->num_cqs);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 6504897..401907f 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -68,6 +68,8 @@ int ehca_port_act_time = 30;
 int ehca_static_rate   = -1;
 int ehca_scaling_code  = 0;
 int ehca_lock_hcalls   = -1;
+int ehca_max_cq        = -1;
+int ehca_max_qp        = -1;
 
 module_param_named(open_aqp1,     ehca_open_aqp1,     bool, S_IRUGO);
 module_param_named(debug_level,   ehca_debug_level,   int,  S_IRUGO);
@@ -79,6 +81,8 @@ module_param_named(poll_all_eqs,  ehca_poll_all_eqs,  bool, S_IRUGO);
 module_param_named(static_rate,   ehca_static_rate,   int,  S_IRUGO);
 module_param_named(scaling_code,  ehca_scaling_code,  bool, S_IRUGO);
 module_param_named(lock_hcalls,   ehca_lock_hcalls,   bool, S_IRUGO);
+module_param_named(number_of_cqs, ehca_max_cq,        int, S_IRUGO);
+module_param_named(number_of_qps, ehca_max_qp,        int, S_IRUGO);
 
 MODULE_PARM_DESC(open_aqp1,
 		 "Open AQP1 on startup (default: no)");
@@ -104,6 +108,12 @@ MODULE_PARM_DESC(scaling_code,
 MODULE_PARM_DESC(lock_hcalls,
 		 "Serialize all hCalls made by the driver "
 		 "(default: autodetect)");
+MODULE_PARM_DESC(number_of_cqs,
+		"Max number of CQs which can be allocated "
+		"(default: autodetect)");
+MODULE_PARM_DESC(number_of_qps,
+		"Max number of QPs which can be allocated "
+		"(default: autodetect)");
 
 DEFINE_RWLOCK(ehca_qp_idr_lock);
 DEFINE_RWLOCK(ehca_cq_idr_lock);
@@ -355,6 +365,25 @@ static int ehca_sense_attributes(struct ehca_shca *shca)
 		if (rblock->memory_page_size_supported & pgsize_map[i])
 			shca->hca_cap_mr_pgsize |= pgsize_map[i + 1];
 
+	/* Set maximum number of CQs and QPs to calculate EQ size */
+	if (ehca_max_qp == -1)
+		ehca_max_qp = min_t(int, rblock->max_qp, EHCA_MAX_NUM_QUEUES);
+	else if (ehca_max_qp < 1 || ehca_max_qp > rblock->max_qp) {
+		ehca_gen_err("Requested number of QPs is out of range (1 - %i) "
+			"specified by HW", rblock->max_qp);
+		ret = -EINVAL;
+		goto sense_attributes1;
+	}
+
+	if (ehca_max_cq == -1)
+		ehca_max_cq = min_t(int, rblock->max_cq, EHCA_MAX_NUM_QUEUES);
+	else if (ehca_max_cq < 1 || ehca_max_cq > rblock->max_cq) {
+		ehca_gen_err("Requested number of CQs is out of range (1 - %i) "
+			"specified by HW", rblock->max_cq);
+		ret = -EINVAL;
+		goto sense_attributes1;
+	}
+
 	/* query max MTU from first port -- it's the same for all ports */
 	port = (struct hipz_query_port *)rblock;
 	h_ret = hipz_h_query_port(shca->ipz_hca_handle, 1, port);
@@ -684,7 +713,7 @@ static int __devinit ehca_probe(struct of_device *dev,
 	struct ehca_shca *shca;
 	const u64 *handle;
 	struct ib_pd *ibpd;
-	int ret, i;
+	int ret, i, eq_size;
 
 	handle = of_get_property(dev->node, "ibm,hca-handle", NULL);
 	if (!handle) {
@@ -705,6 +734,8 @@ static int __devinit ehca_probe(struct of_device *dev,
 		return -ENOMEM;
 	}
 	mutex_init(&shca->modify_mutex);
+	atomic_set(&shca->num_cqs, 0);
+	atomic_set(&shca->num_qps, 0);
 	for (i = 0; i < ARRAY_SIZE(shca->sport); i++)
 		spin_lock_init(&shca->sport[i].mod_sqp_lock);
 
@@ -724,8 +755,9 @@ static int __devinit ehca_probe(struct of_device *dev,
 		goto probe1;
 	}
 
+	eq_size = 2 * ehca_max_cq + 4 * ehca_max_qp;
 	/* create event queues */
-	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
+	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, eq_size);
 	if (ret) {
 		ehca_err(&shca->ib_device, "Cannot create EQ.");
 		goto probe1;
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 57bef11..73d9c4a 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -421,6 +421,14 @@ static struct ehca_qp *internal_create_qp(
 	u32 swqe_size = 0, rwqe_size = 0, ib_qp_num;
 	unsigned long flags;
 
+	if (atomic_read(&shca->num_qps) >= ehca_max_qp) {
+		ehca_err(pd->device, "Unable to create QP, max number of %i "
+			 "QPs reached.", ehca_max_qp);
+		ehca_err(pd->device, "To increase the maximum number of QPs "
+			 "use the number_of_qps module parameter.\n");
+		return ERR_PTR(-ENOSPC);
+	}
+
 	if (init_attr->create_flags)
 		return ERR_PTR(-EINVAL);
 
@@ -797,6 +805,7 @@ static struct ehca_qp *internal_create_qp(
 		}
 	}
 
+	atomic_inc(&shca->num_qps);
 	return my_qp;
 
 create_qp_exit6:
@@ -1948,6 +1957,7 @@ static int internal_destroy_qp(struct ib_device *dev, struct ehca_qp *my_qp,
 	if (HAS_SQ(my_qp))
 		ipz_queue_dtor(my_pd, &my_qp->ipz_squeue);
 	kmem_cache_free(qp_cache, my_qp);
+	atomic_dec(&shca->num_qps);
 	return 0;
 }
 
-- 
1.5.5
