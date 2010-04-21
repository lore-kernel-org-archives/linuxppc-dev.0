Return-Path: <tklein@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 638E6B7C06
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 19:11:01 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id o3L9AuQ0031066
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 09:10:56 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o3L9AunL1679494
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 11:10:56 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o3L9AuCS025306
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 11:10:56 +0200
From: Thomas Klein <tklein@de.ibm.com>
To: davem@davemloft.net
Subject: [PATCH 1/2][RESEND] ehea: error handling improvement
Date: Wed, 21 Apr 2010 11:10:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201004211110.55986.tklein@de.ibm.com>
Cc: netdev@vger.kernel.org, themann@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reset a port's resources only if they're actually in an error state

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---

Patch created against net-2.6

diff -Nurp net-2.6.orig/drivers/net/ehea/ehea_main.c net-2.6/drivers/net/ehea/ehea_main.c
--- net-2.6.orig/drivers/net/ehea/ehea_main.c	2010-04-21 10:23:21.000000000 +0200
+++ net-2.6/drivers/net/ehea/ehea_main.c	2010-04-21 10:41:21.000000000 +0200
@@ -791,11 +791,17 @@ static struct ehea_cqe *ehea_proc_cqes(s
 		cqe_counter++;
 		rmb();
 		if (cqe->status & EHEA_CQE_STAT_ERR_MASK) {
-			ehea_error("Send Completion Error: Resetting port");
+			ehea_error("Bad send completion status=0x%04X",
+				   cqe->status);
+
 			if (netif_msg_tx_err(pr->port))
 				ehea_dump(cqe, sizeof(*cqe), "Send CQE");
-			ehea_schedule_port_reset(pr->port);
-			break;
+
+			if (cqe->status & EHEA_CQE_STAT_RESET_MASK) {
+				ehea_error("Resetting port");
+				ehea_schedule_port_reset(pr->port);
+				break;
+			}
 		}
 
 		if (netif_msg_tx_done(pr->port))
@@ -901,6 +907,8 @@ static irqreturn_t ehea_qp_aff_irq_handl
 	struct ehea_eqe *eqe;
 	struct ehea_qp *qp;
 	u32 qp_token;
+	u64 resource_type, aer, aerr;
+	int reset_port = 0;
 
 	eqe = ehea_poll_eq(port->qp_eq);
 
@@ -910,11 +918,24 @@ static irqreturn_t ehea_qp_aff_irq_handl
 			   eqe->entry, qp_token);
 
 		qp = port->port_res[qp_token].qp;
-		ehea_error_data(port->adapter, qp->fw_handle);
+
+		resource_type = ehea_error_data(port->adapter, qp->fw_handle,
+						&aer, &aerr);
+
+		if (resource_type == EHEA_AER_RESTYPE_QP) {
+			if ((aer & EHEA_AER_RESET_MASK) ||
+			    (aerr & EHEA_AERR_RESET_MASK))
+				 reset_port = 1;
+		} else
+			reset_port = 1;   /* Reset in case of CQ or EQ error */
+
 		eqe = ehea_poll_eq(port->qp_eq);
 	}
 
-	ehea_schedule_port_reset(port);
+	if (reset_port) {
+		ehea_error("Resetting port");
+		ehea_schedule_port_reset(port);
+	}
 
 	return IRQ_HANDLED;
 }
diff -Nurp net-2.6.orig/drivers/net/ehea/ehea_qmr.c net-2.6/drivers/net/ehea/ehea_qmr.c
--- net-2.6.orig/drivers/net/ehea/ehea_qmr.c	2010-04-21 10:23:21.000000000 +0200
+++ net-2.6/drivers/net/ehea/ehea_qmr.c	2010-04-21 10:41:21.000000000 +0200
@@ -229,14 +229,14 @@ u64 ehea_destroy_cq_res(struct ehea_cq *
 
 int ehea_destroy_cq(struct ehea_cq *cq)
 {
-	u64 hret;
+	u64 hret, aer, aerr;
 	if (!cq)
 		return 0;
 
 	hcp_epas_dtor(&cq->epas);
 	hret = ehea_destroy_cq_res(cq, NORMAL_FREE);
 	if (hret == H_R_STATE) {
-		ehea_error_data(cq->adapter, cq->fw_handle);
+		ehea_error_data(cq->adapter, cq->fw_handle, &aer, &aerr);
 		hret = ehea_destroy_cq_res(cq, FORCE_FREE);
 	}
 
@@ -357,7 +357,7 @@ u64 ehea_destroy_eq_res(struct ehea_eq *
 
 int ehea_destroy_eq(struct ehea_eq *eq)
 {
-	u64 hret;
+	u64 hret, aer, aerr;
 	if (!eq)
 		return 0;
 
@@ -365,7 +365,7 @@ int ehea_destroy_eq(struct ehea_eq *eq)
 
 	hret = ehea_destroy_eq_res(eq, NORMAL_FREE);
 	if (hret == H_R_STATE) {
-		ehea_error_data(eq->adapter, eq->fw_handle);
+		ehea_error_data(eq->adapter, eq->fw_handle, &aer, &aerr);
 		hret = ehea_destroy_eq_res(eq, FORCE_FREE);
 	}
 
@@ -540,7 +540,7 @@ u64 ehea_destroy_qp_res(struct ehea_qp *
 
 int ehea_destroy_qp(struct ehea_qp *qp)
 {
-	u64 hret;
+	u64 hret, aer, aerr;
 	if (!qp)
 		return 0;
 
@@ -548,7 +548,7 @@ int ehea_destroy_qp(struct ehea_qp *qp)
 
 	hret = ehea_destroy_qp_res(qp, NORMAL_FREE);
 	if (hret == H_R_STATE) {
-		ehea_error_data(qp->adapter, qp->fw_handle);
+		ehea_error_data(qp->adapter, qp->fw_handle, &aer, &aerr);
 		hret = ehea_destroy_qp_res(qp, FORCE_FREE);
 	}
 
@@ -986,42 +986,45 @@ void print_error_data(u64 *data)
 	if (length > EHEA_PAGESIZE)
 		length = EHEA_PAGESIZE;
 
-	if (type == 0x8) /* Queue Pair */
+	if (type == EHEA_AER_RESTYPE_QP)
 		ehea_error("QP (resource=%llX) state: AER=0x%llX, AERR=0x%llX, "
 			   "port=%llX", resource, data[6], data[12], data[22]);
-
-	if (type == 0x4) /* Completion Queue */
+	else if (type == EHEA_AER_RESTYPE_CQ)
 		ehea_error("CQ (resource=%llX) state: AER=0x%llX", resource,
 			   data[6]);
-
-	if (type == 0x3) /* Event Queue */
+	else if (type == EHEA_AER_RESTYPE_EQ)
 		ehea_error("EQ (resource=%llX) state: AER=0x%llX", resource,
 			   data[6]);
 
 	ehea_dump(data, length, "error data");
 }
 
-void ehea_error_data(struct ehea_adapter *adapter, u64 res_handle)
+u64 ehea_error_data(struct ehea_adapter *adapter, u64 res_handle,
+		    u64 *aer, u64 *aerr)
 {
 	unsigned long ret;
 	u64 *rblock;
+	u64 type = 0;
 
 	rblock = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!rblock) {
 		ehea_error("Cannot allocate rblock memory.");
-		return;
+		goto out;
 	}
 
-	ret = ehea_h_error_data(adapter->handle,
-				res_handle,
-				rblock);
+	ret = ehea_h_error_data(adapter->handle, res_handle, rblock);
 
-	if (ret == H_R_STATE)
-		ehea_error("No error data is available: %llX.", res_handle);
-	else if (ret == H_SUCCESS)
+	if (ret == H_SUCCESS) {
+		type = EHEA_BMASK_GET(ERROR_DATA_TYPE, rblock[2]);
+		*aer = rblock[6];
+		*aerr = rblock[12];
 		print_error_data(rblock);
-	else
+	} else if (ret == H_R_STATE) {
+		ehea_error("No error data available: %llX.", res_handle);
+	} else
 		ehea_error("Error data could not be fetched: %llX", res_handle);
 
 	free_page((unsigned long)rblock);
+out:
+	return type;
 }
diff -Nurp net-2.6.orig/drivers/net/ehea/ehea_qmr.h net-2.6/drivers/net/ehea/ehea_qmr.h
--- net-2.6.orig/drivers/net/ehea/ehea_qmr.h	2010-04-21 10:23:21.000000000 +0200
+++ net-2.6/drivers/net/ehea/ehea_qmr.h	2010-04-21 10:41:21.000000000 +0200
@@ -154,6 +154,9 @@ struct ehea_rwqe {
 #define EHEA_CQE_STAT_ERR_IP       0x2000
 #define EHEA_CQE_STAT_ERR_CRC      0x1000
 
+/* Defines which bad send cqe stati lead to a port reset */
+#define EHEA_CQE_STAT_RESET_MASK   0x0002
+
 struct ehea_cqe {
 	u64 wr_id;		/* work request ID from WQE */
 	u8 type;
@@ -187,6 +190,14 @@ struct ehea_cqe {
 #define EHEA_EQE_SM_MECH_NUMBER  EHEA_BMASK_IBM(48, 55)
 #define EHEA_EQE_SM_PORT_NUMBER  EHEA_BMASK_IBM(56, 63)
 
+#define EHEA_AER_RESTYPE_QP  0x8
+#define EHEA_AER_RESTYPE_CQ  0x4
+#define EHEA_AER_RESTYPE_EQ  0x3
+
+/* Defines which affiliated errors lead to a port reset */
+#define EHEA_AER_RESET_MASK   0xFFFFFFFFFEFFFFFFULL
+#define EHEA_AERR_RESET_MASK  0xFFFFFFFFFFFFFFFFULL
+
 struct ehea_eqe {
 	u64 entry;
 };
@@ -379,7 +390,8 @@ int ehea_gen_smr(struct ehea_adapter *ad
 
 int ehea_rem_mr(struct ehea_mr *mr);
 
-void ehea_error_data(struct ehea_adapter *adapter, u64 res_handle);
+u64 ehea_error_data(struct ehea_adapter *adapter, u64 res_handle,
+		    u64 *aer, u64 *aerr);
 
 int ehea_add_sect_bmap(unsigned long pfn, unsigned long nr_pages);
 int ehea_rem_sect_bmap(unsigned long pfn, unsigned long nr_pages);
