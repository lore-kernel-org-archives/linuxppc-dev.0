Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 903F0DDF22
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 02:23:54 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3NGNn3Y122770
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 16:23:49 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3NGNnS93965022
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 18:23:49 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3NGNmMr007372
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 18:23:49 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH] eHCA: Add "Modify Port" verb
Date: Mon, 23 Apr 2007 18:23:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704231823.48723.fenkes@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add "Modify Port" verb support to eHCA driver.
ib_cm needs this to initialize properly.


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

 ehca_hca.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 hcp_if.c   |   24 ++++++++++++++++++++++++
 hcp_if.h   |    4 ++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff -urp a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
--- a/drivers/infiniband/hw/ehca/ehca_hca.c	2007-02-04 19:44:54.000000000 +0100
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c	2007-04-23 18:09:38.000000000 +0200
@@ -147,6 +147,7 @@ int ehca_query_port(struct ib_device *ib
 		break;
 	}
 
+	props->port_cap_flags  = rblock->capability_mask;
 	props->gid_tbl_len     = rblock->gid_tbl_len;
 	props->max_msg_sz      = rblock->max_msg_sz;
 	props->bad_pkey_cntr   = rblock->bad_pkey_cntr;
@@ -233,10 +234,53 @@ query_gid1:
 	return ret;
 }
 
+const u32 allowed_port_caps = (
+	IB_PORT_SM | IB_PORT_LED_INFO_SUP | IB_PORT_CM_SUP |
+	IB_PORT_SNMP_TUNNEL_SUP | IB_PORT_DEVICE_MGMT_SUP |
+	IB_PORT_VENDOR_CLASS_SUP);
+
 int ehca_modify_port(struct ib_device *ibdev,
 		     u8 port, int port_modify_mask,
 		     struct ib_port_modify *props)
 {
-	/* Not implemented yet */
-	return -EFAULT;
+	int ret = 0;
+	struct ehca_shca *shca = container_of(ibdev, struct ehca_shca, ib_device);
+	struct hipz_query_port *rblock;
+	u32 cap;
+	u64 hret;
+
+	if ((props->set_port_cap_mask | props->clr_port_cap_mask)
+	    & ~allowed_port_caps) {
+		ehca_err(&shca->ib_device, "Non-changeable bits set in masks  "
+			 "set=%x  clr=%x  allowed=%x", props->set_port_cap_mask,
+			 props->clr_port_cap_mask, allowed_port_caps);
+		return -EINVAL;
+	}
+
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
+	if (!rblock) {
+		ehca_err(&shca->ib_device,  "Can't allocate rblock memory.");
+		return -ENOMEM;
+	}
+
+	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_SUCCESS) {
+		ehca_err(&shca->ib_device, "Can't query port properties");
+		ret = -EINVAL;
+		goto modify_port1;
+	}
+
+	cap = (rblock->capability_mask | props->set_port_cap_mask)
+		& ~props->clr_port_cap_mask;
+
+	hret = hipz_h_modify_port(shca->ipz_hca_handle, port,
+				  cap, props->init_type, port_modify_mask);
+	if (hret != H_SUCCESS) {
+		ehca_err(&shca->ib_device, "Modify port failed  hret=%lx", hret);
+		ret = -EINVAL;
+	}
+
+modify_port1:
+	ehca_free_fw_ctrlblock(rblock);
+
+	return ret;
 }
diff -urp a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
--- a/drivers/infiniband/hw/ehca/hcp_if.c	2007-02-04 19:44:54.000000000 +0100
+++ b/drivers/infiniband/hw/ehca/hcp_if.c	2007-04-23 18:06:09.000000000 +0200
@@ -70,6 +70,10 @@
 #define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0, 31)
 #define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32, 63)
 
+#define H_MP_INIT_TYPE                  EHCA_BMASK_IBM(44, 47)
+#define H_MP_SHUTDOWN                   EHCA_BMASK_IBM(48, 48)
+#define H_MP_RESET_QKEY_CTR             EHCA_BMASK_IBM(49, 49)
+
 /* direct access qp controls */
 #define DAQP_CTRL_ENABLE    0x01
 #define DAQP_CTRL_SEND_COMP 0x20
@@ -364,6 +368,26 @@ u64 hipz_h_query_port(const struct ipz_a
 	return ret;
 }
 
+u64 hipz_h_modify_port(const struct ipz_adapter_handle adapter_handle,
+		       const u8 port_id, const u32 port_cap,
+		       const u8 init_type, const int modify_mask)
+{
+	u64 port_attributes = port_cap;
+
+	if (modify_mask & IB_PORT_SHUTDOWN)
+		port_attributes |= EHCA_BMASK_SET(H_MP_SHUTDOWN, 1);
+	if (modify_mask & IB_PORT_INIT_TYPE)
+		port_attributes |= EHCA_BMASK_SET(H_MP_INIT_TYPE, init_type);
+	if (modify_mask & IB_PORT_RESET_QKEY_CNTR)
+		port_attributes |= EHCA_BMASK_SET(H_MP_RESET_QKEY_CTR, 1);
+
+	return ehca_plpar_hcall_norets(H_MODIFY_PORT,
+				       adapter_handle.handle, /* r4 */
+				       port_id,               /* r5 */
+				       port_attributes,       /* r6 */
+				       0, 0, 0, 0);
+}
+
 u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
 		     struct hipz_query_hca *query_hca_rblock)
 {
diff -urp a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
--- a/drivers/infiniband/hw/ehca/hcp_if.h	2007-02-04 19:44:54.000000000 +0100
+++ b/drivers/infiniband/hw/ehca/hcp_if.h	2007-04-23 18:06:09.000000000 +0200
@@ -85,6 +85,10 @@ u64 hipz_h_query_port(const struct ipz_a
 		      const u8 port_id,
 		      struct hipz_query_port *query_port_response_block);
 
+u64 hipz_h_modify_port(const struct ipz_adapter_handle adapter_handle,
+		       const u8 port_id, const u32 port_cap,
+		       const u8 init_type, const int modify_mask);
+
 u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
 		     struct hipz_query_hca *query_hca_rblock);
 
