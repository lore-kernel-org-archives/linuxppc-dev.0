Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B17F2DE29F
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:11:37 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0BJBX9K196052
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:11:33 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0BJBXmc1597504
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:11:33 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0BJBV9k002714
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:11:32 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 1/5] ehca: declaration of queue structures
Date: Thu, 11 Jan 2007 20:07:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701112007.49620.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland and Christoph H.!
This is a patch for ehca structs. It enhances completion queue and queue pair
with use counters for associated mmap-ed resources, ie. hardware register block
and queue pages. Furthermore it removes redundant prototypes.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_classes.h |   29 +++++++----------------------
 ehca_iverbs.h  |   10 +---------
 2 files changed, 8 insertions(+), 31 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 1c72203..cf95ee4 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -119,13 +119,14 @@ struct ehca_qp {
 	struct ipz_qp_handle ipz_qp_handle;
 	struct ehca_pfqp pf;
 	struct ib_qp_init_attr init_attr;
-	u64 uspace_squeue;
-	u64 uspace_rqueue;
-	u64 uspace_fwh;
 	struct ehca_cq *send_cq;
 	struct ehca_cq *recv_cq;
 	unsigned int sqerr_purgeflag;
 	struct hlist_node list_entries;
+	/* mmap counter for resources mapped into user space */
+	u32 mm_count_squeue;
+	u32 mm_count_rqueue;
+	u32 mm_count_galpa;
 };
 
 /* must be power of 2 */
@@ -142,13 +143,14 @@ struct ehca_cq {
 	struct ipz_cq_handle ipz_cq_handle;
 	struct ehca_pfcq pf;
 	spinlock_t cb_lock;
-	u64 uspace_queue;
-	u64 uspace_fwh;
 	struct hlist_head qp_hashtab[QP_HASHTAB_LEN];
 	struct list_head entry;
 	u32 nr_callbacks;
 	spinlock_t task_lock;
 	u32 ownpid;
+	/* mmap counter for resources mapped into user space */
+	u32 mm_count_queue;
+	u32 mm_count_galpa;
 };
 
 enum ehca_mr_flag {
@@ -248,20 +250,6 @@ struct ehca_ucontext {
 	struct ib_ucontext ib_ucontext;
 };
 
-struct ehca_module *ehca_module_new(void);
-
-int ehca_module_delete(struct ehca_module *me);
-
-int ehca_eq_ctor(struct ehca_eq *eq);
-
-int ehca_eq_dtor(struct ehca_eq *eq);
-
-struct ehca_shca *ehca_shca_new(void);
-
-int ehca_shca_delete(struct ehca_shca *me);
-
-struct ehca_sport *ehca_sport_new(struct ehca_shca *anchor);
-
 int ehca_init_pd_cache(void);
 void ehca_cleanup_pd_cache(void);
 int ehca_init_cq_cache(void);
@@ -283,7 +271,6 @@ extern int ehca_port_act_time;
 extern int ehca_use_hp_mr;
 
 struct ipzu_queue_resp {
-	u64 queue;        /* points to first queue entry */
 	u32 qe_size;      /* queue entry size */
 	u32 act_nr_of_sg;
 	u32 queue_length; /* queue length allocated in bytes */
@@ -296,7 +283,6 @@ struct ehca_create_cq_resp {
 	u32 cq_number;
 	u32 token;
 	struct ipzu_queue_resp ipz_queue;
-	struct h_galpas galpas;
 };
 
 struct ehca_create_qp_resp {
@@ -309,7 +295,6 @@ struct ehca_create_qp_resp {
 	u32 dummy; /* padding for 8 byte alignment */
 	struct ipzu_queue_resp ipz_squeue;
 	struct ipzu_queue_resp ipz_rqueue;
-	struct h_galpas galpas;
 };
 
 struct ehca_alloc_cq_parms {
diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
index cd7789f..85e7916 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -171,19 +171,11 @@ int ehca_mmap(struct ib_ucontext *contex
 
 void ehca_poll_eqs(unsigned long data);
 
-int ehca_mmap_nopage(u64 foffset,u64 length,void **mapped,
-		     struct vm_area_struct **vma);
-
-int ehca_mmap_register(u64 physical,void **mapped,
-		       struct vm_area_struct **vma);
-
-int ehca_munmap(unsigned long addr, size_t len);
-
 #ifdef CONFIG_PPC_64K_PAGES
 void *ehca_alloc_fw_ctrlblock(gfp_t flags);
 void ehca_free_fw_ctrlblock(void *ptr);
 #else
-#define ehca_alloc_fw_ctrlblock(flags) ((void *) get_zeroed_page(flags))
+#define ehca_alloc_fw_ctrlblock(flags) ((void*) get_zeroed_page(flags))
 #define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
 #endif
 
