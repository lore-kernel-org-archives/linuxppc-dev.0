Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59D60DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 22:57:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m37CvcT4029513
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 08:57:38 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m37CvcEn304004
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 08:57:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m37Cvb9d017688
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 08:57:38 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: ewg@lists.openfabrics.org, general@lists.openfabrics.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, rolandd@cisco.com
Subject: [PATCH] IB/ehca: extend query_device() and query_port() to support
	all values for ibv_devinfo
Date: Mon, 7 Apr 2008 13:57:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804071457.36248.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also, introduce a few inline helper functions to make the code more readable.

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_hca.c |  128 ++++++++++++++++++++------------
 1 files changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index 8832123..f89c5f8 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -43,6 +43,11 @@
 #include "ehca_iverbs.h"
 #include "hcp_if.h"
 
+static inline unsigned int limit_uint(unsigned int value)
+{
+	return min_t(unsigned int, value, INT_MAX);
+}
+
 int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 {
 	int i, ret = 0;
@@ -83,37 +88,40 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 	props->vendor_id       = rblock->vendor_id >> 8;
 	props->vendor_part_id  = rblock->vendor_part_id >> 16;
 	props->hw_ver          = rblock->hw_ver;
-	props->max_qp          = min_t(unsigned, rblock->max_qp, INT_MAX);
-	props->max_qp_wr       = min_t(unsigned, rblock->max_wqes_wq, INT_MAX);
-	props->max_sge         = min_t(unsigned, rblock->max_sge, INT_MAX);
-	props->max_sge_rd      = min_t(unsigned, rblock->max_sge_rd, INT_MAX);
-	props->max_cq          = min_t(unsigned, rblock->max_cq, INT_MAX);
-	props->max_cqe         = min_t(unsigned, rblock->max_cqe, INT_MAX);
-	props->max_mr          = min_t(unsigned, rblock->max_mr, INT_MAX);
-	props->max_mw          = min_t(unsigned, rblock->max_mw, INT_MAX);
-	props->max_pd          = min_t(unsigned, rblock->max_pd, INT_MAX);
-	props->max_ah          = min_t(unsigned, rblock->max_ah, INT_MAX);
-	props->max_fmr         = min_t(unsigned, rblock->max_mr, INT_MAX);
+	props->max_qp          = limit_uint(rblock->max_qp);
+	props->max_qp_wr       = limit_uint(rblock->max_wqes_wq);
+	props->max_sge         = limit_uint(rblock->max_sge);
+	props->max_sge_rd      = limit_uint(rblock->max_sge_rd);
+	props->max_cq          = limit_uint(rblock->max_cq);
+	props->max_cqe         = limit_uint(rblock->max_cqe);
+	props->max_mr          = limit_uint(rblock->max_mr);
+	props->max_mw          = limit_uint(rblock->max_mw);
+	props->max_pd          = limit_uint(rblock->max_pd);
+	props->max_ah          = limit_uint(rblock->max_ah);
+	props->max_ee          = limit_uint(rblock->max_rd_ee_context);
+	props->max_rdd         = limit_uint(rblock->max_rd_domain);
+	props->max_fmr         = limit_uint(rblock->max_mr);
+	props->local_ca_ack_delay  = limit_uint(rblock->local_ca_ack_delay);
+	props->max_qp_rd_atom  = limit_uint(rblock->max_rr_qp);
+	props->max_ee_rd_atom  = limit_uint(rblock->max_rr_ee_context);
+	props->max_res_rd_atom = limit_uint(rblock->max_rr_hca);
+	props->max_qp_init_rd_atom = limit_uint(rblock->max_act_wqs_qp);
+	props->max_ee_init_rd_atom = limit_uint(rblock->max_act_wqs_ee_context);
 
 	if (EHCA_BMASK_GET(HCA_CAP_SRQ, shca->hca_cap)) {
-		props->max_srq         = props->max_qp;
-		props->max_srq_wr      = props->max_qp_wr;
+		props->max_srq         = limit_uint(props->max_qp);
+		props->max_srq_wr      = limit_uint(props->max_qp_wr);
 		props->max_srq_sge     = 3;
 	}
 
-	props->max_pkeys       = 16;
-	props->local_ca_ack_delay
-		= rblock->local_ca_ack_delay;
-	props->max_raw_ipv6_qp
-		= min_t(unsigned, rblock->max_raw_ipv6_qp, INT_MAX);
-	props->max_raw_ethy_qp
-		= min_t(unsigned, rblock->max_raw_ethy_qp, INT_MAX);
-	props->max_mcast_grp
-		= min_t(unsigned, rblock->max_mcast_grp, INT_MAX);
-	props->max_mcast_qp_attach
-		= min_t(unsigned, rblock->max_mcast_qp_attach, INT_MAX);
+	props->max_pkeys           = 16;
+	props->local_ca_ack_delay  = limit_uint(rblock->local_ca_ack_delay);
+	props->max_raw_ipv6_qp     = limit_uint(rblock->max_raw_ipv6_qp);
+	props->max_raw_ethy_qp     = limit_uint(rblock->max_raw_ethy_qp);
+	props->max_mcast_grp       = limit_uint(rblock->max_mcast_grp);
+	props->max_mcast_qp_attach = limit_uint(rblock->max_mcast_qp_attach);
 	props->max_total_mcast_qp_attach
-		= min_t(unsigned, rblock->max_total_mcast_qp_attach, INT_MAX);
+		= limit_uint(rblock->max_total_mcast_qp_attach);
 
 	/* translate device capabilities */
 	props->device_cap_flags = IB_DEVICE_SYS_IMAGE_GUID |
@@ -128,6 +136,46 @@ query_device1:
 	return ret;
 }
 
+static inline int map_mtu(struct ehca_shca *shca, u32 fw_mtu)
+{
+	switch (fw_mtu) {
+	case 0x1:
+		return IB_MTU_256;
+	case 0x2:
+		return IB_MTU_512;
+	case 0x3:
+		return IB_MTU_1024;
+	case 0x4:
+		return IB_MTU_2048;
+	case 0x5:
+		return IB_MTU_4096;
+	default:
+		ehca_err(&shca->ib_device, "Unknown MTU size: %x.",
+			 fw_mtu);
+		return 0;
+	}
+}
+
+static inline int map_number_of_vls(struct ehca_shca *shca, u32 vl_cap)
+{
+	switch (vl_cap) {
+	case 0x1:
+		return 1;
+	case 0x2:
+		return 2;
+	case 0x3:
+		return 4;
+	case 0x4:
+		return 8;
+	case 0x5:
+		return 15;
+	default:
+		ehca_err(&shca->ib_device, "invalid Vl Capability: %x.",
+			 vl_cap);
+		return 0;
+	}
+}
+
 int ehca_query_port(struct ib_device *ibdev,
 		    u8 port, struct ib_port_attr *props)
 {
@@ -152,31 +200,14 @@ int ehca_query_port(struct ib_device *ibdev,
 
 	memset(props, 0, sizeof(struct ib_port_attr));
 
-	switch (rblock->max_mtu) {
-	case 0x1:
-		props->active_mtu = props->max_mtu = IB_MTU_256;
-		break;
-	case 0x2:
-		props->active_mtu = props->max_mtu = IB_MTU_512;
-		break;
-	case 0x3:
-		props->active_mtu = props->max_mtu = IB_MTU_1024;
-		break;
-	case 0x4:
-		props->active_mtu = props->max_mtu = IB_MTU_2048;
-		break;
-	case 0x5:
-		props->active_mtu = props->max_mtu = IB_MTU_4096;
-		break;
-	default:
-		ehca_err(&shca->ib_device, "Unknown MTU size: %x.",
-			 rblock->max_mtu);
-		break;
-	}
-
+	props->active_mtu = props->max_mtu = map_mtu(shca, rblock->max_mtu);
 	props->port_cap_flags  = rblock->capability_mask;
 	props->gid_tbl_len     = rblock->gid_tbl_len;
-	props->max_msg_sz      = rblock->max_msg_sz;
+	if (rblock->max_msg_sz) {
+		props->max_msg_sz      = rblock->max_msg_sz;
+	} else {
+		props->max_msg_sz      = 0x1 << 31;
+	}
 	props->bad_pkey_cntr   = rblock->bad_pkey_cntr;
 	props->qkey_viol_cntr  = rblock->qkey_viol_cntr;
 	props->pkey_tbl_len    = rblock->pkey_tbl_len;
@@ -186,6 +217,7 @@ int ehca_query_port(struct ib_device *ibdev,
 	props->sm_sl           = rblock->sm_sl;
 	props->subnet_timeout  = rblock->subnet_timeout;
 	props->init_type_reply = rblock->init_type_reply;
+	props->max_vl_num      = map_number_of_vls(shca, rblock->vl_cap);
 
 	if (rblock->state && rblock->phys_width) {
 		props->phys_state      = rblock->phys_pstate;
-- 
1.5.2
