Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA4B5DDFC0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:12:24 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0BJCKwv066164
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:12:20 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0BJCKMl1814626
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:12:20 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0BJCJdC031311
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:12:20 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of do_mmap()
Date: Thu, 11 Jan 2007 20:08:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
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
This is a patch for ehca_cq.c. It removes all direct calls of do_mmap()/munmap()
when creating and destroying a completion queue respectively. 
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_cq.c |   65 +++++++++++++++-----------------------------------------------
 1 files changed, 16 insertions(+), 49 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 93995b6..e86585a 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -267,7 +267,6 @@ struct ib_cq *ehca_create_cq(struct ib_d
 	if (context) {
 		struct ipz_queue *ipz_queue = &my_cq->ipz_queue;
 		struct ehca_create_cq_resp resp;
-		struct vm_area_struct *vma;
 		memset(&resp, 0, sizeof(resp));
 		resp.cq_number = my_cq->cq_number;
 		resp.token = my_cq->token;
@@ -276,40 +275,14 @@ struct ib_cq *ehca_create_cq(struct ib_d
 		resp.ipz_queue.queue_length = ipz_queue->queue_length;
 		resp.ipz_queue.pagesize = ipz_queue->pagesize;
 		resp.ipz_queue.toggle_state = ipz_queue->toggle_state;
-		ret = ehca_mmap_nopage(((u64)(my_cq->token) << 32) | 0x12000000,
-				       ipz_queue->queue_length,
-				       (void**)&resp.ipz_queue.queue,
-				       &vma);
-		if (ret) {
-			ehca_err(device, "Could not mmap queue pages");
-			cq = ERR_PTR(ret);
-			goto create_cq_exit4;
-		}
-		my_cq->uspace_queue = resp.ipz_queue.queue;
-		resp.galpas = my_cq->galpas;
-		ret = ehca_mmap_register(my_cq->galpas.user.fw_handle,
-					 (void**)&resp.galpas.kernel.fw_handle,
-					 &vma);
-		if (ret) {
-			ehca_err(device, "Could not mmap fw_handle");
-			cq = ERR_PTR(ret);
-			goto create_cq_exit5;
-		}
-		my_cq->uspace_fwh = (u64)resp.galpas.kernel.fw_handle;
 		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
 			ehca_err(device, "Copy to udata failed.");
-			goto create_cq_exit6;
+			goto create_cq_exit4;
 		}
 	}
 
 	return cq;
 
-create_cq_exit6:
-	ehca_munmap(my_cq->uspace_fwh, EHCA_PAGESIZE);
-
-create_cq_exit5:
-	ehca_munmap(my_cq->uspace_queue, my_cq->ipz_queue.queue_length);
-
 create_cq_exit4:
 	ipz_queue_dtor(&my_cq->ipz_queue);
 
@@ -333,7 +306,6 @@ create_cq_exit1:
 int ehca_destroy_cq(struct ib_cq *cq)
 {
 	u64 h_ret;
-	int ret;
 	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
 	int cq_num = my_cq->cq_number;
 	struct ib_device *device = cq->device;
@@ -343,6 +315,20 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	u32 cur_pid = current->tgid;
 	unsigned long flags;
 
+	if (cq->uobject) {
+		if (my_cq->mm_count_galpa || my_cq->mm_count_queue) {
+			ehca_err(device, "Resources still referenced in "
+				 "user space cq_num=%x", my_cq->cq_number);
+			return -EINVAL;
+		}
+		if (my_cq->ownpid != cur_pid) {
+			ehca_err(device, "Invalid caller pid=%x ownpid=%x "
+				 "cq_num=%x",
+				 cur_pid, my_cq->ownpid, my_cq->cq_number);
+			return -EINVAL;
+		}
+	}
+
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
 	while (my_cq->nr_callbacks)
 		yield();
@@ -350,25 +336,6 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	idr_remove(&ehca_cq_idr, my_cq->token);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 
-	if (my_cq->uspace_queue && my_cq->ownpid != cur_pid) {
-		ehca_err(device, "Invalid caller pid=%x ownpid=%x",
-			 cur_pid, my_cq->ownpid);
-		return -EINVAL;
-	}
-
-	/* un-mmap if vma alloc */
-	if (my_cq->uspace_queue ) {
-		ret = ehca_munmap(my_cq->uspace_queue,
-				  my_cq->ipz_queue.queue_length);
-		if (ret)
-			ehca_err(device, "Could not munmap queue ehca_cq=%p "
-				 "cq_num=%x", my_cq, cq_num);
-		ret = ehca_munmap(my_cq->uspace_fwh, EHCA_PAGESIZE);
-		if (ret)
-			ehca_err(device, "Could not munmap fwh ehca_cq=%p "
-				 "cq_num=%x", my_cq, cq_num);
-	}
-
 	h_ret = hipz_h_destroy_cq(adapter_handle, my_cq, 0);
 	if (h_ret == H_R_STATE) {
 		/* cq in err: read err data and destroy it forcibly */
@@ -397,7 +364,7 @@ int ehca_resize_cq(struct ib_cq *cq, int
 	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
 	u32 cur_pid = current->tgid;
 
-	if (my_cq->uspace_queue && my_cq->ownpid != cur_pid) {
+	if (cq->uobject && my_cq->ownpid != cur_pid) {
 		ehca_err(cq->device, "Invalid caller pid=%x ownpid=%x",
 			 cur_pid, my_cq->ownpid);
 		return -EINVAL;
