Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A722ADDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 10:52:47 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m0PKITCF077762
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 20:18:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m0PKITsL1061014
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 21:18:29 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m0PKIS7Y002747
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 21:18:28 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 2/2] IB/ehca: Add PMA support
References: <200801252111.11915.fenkes@de.ibm.com>
In-Reply-To: <200801252111.11915.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Fri, 25 Jan 2008 21:18:27 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801252118.28122.fenkes@de.ibm.com>
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

This patch enables ehca to redirect any PMA queries to the
actual PMA QP.

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Reviewed-by: Joachim Fenkes <fenkes@de.ibm.com>
Reviewed-by: Christoph Raisch <raisch@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    1 +
 drivers/infiniband/hw/ehca/ehca_iverbs.h  |    5 ++
 drivers/infiniband/hw/ehca/ehca_main.c    |    2 +-
 drivers/infiniband/hw/ehca/ehca_sqp.c     |   91 +++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index f281d16..92cce8a 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -101,6 +101,7 @@ struct ehca_sport {
 	spinlock_t mod_sqp_lock;
 	enum ib_port_state port_state;
 	struct ehca_sma_attr saved_attr;
+	u32 pma_qp_nr;
 };
 
 #define HCA_CAP_MR_PGSIZE_4K  0x80000000
diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
index c469bfd..a8a2ea5 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -187,6 +187,11 @@ int ehca_dealloc_ucontext(struct ib_ucontext *context);
 
 int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
+int ehca_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
+		     struct ib_wc *in_wc, struct ib_grh *in_grh,
+		     struct ib_mad *in_mad,
+		     struct ib_mad *out_mad);
+
 void ehca_poll_eqs(unsigned long data);
 
 int ehca_calc_ipd(struct ehca_shca *shca, int port,
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 0fe0c84..33b5bac 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -472,7 +472,7 @@ int ehca_init_device(struct ehca_shca *shca)
 	shca->ib_device.dealloc_fmr	    = ehca_dealloc_fmr;
 	shca->ib_device.attach_mcast	    = ehca_attach_mcast;
 	shca->ib_device.detach_mcast	    = ehca_detach_mcast;
-	/* shca->ib_device.process_mad	    = ehca_process_mad;	    */
+	shca->ib_device.process_mad	    = ehca_process_mad;
 	shca->ib_device.mmap		    = ehca_mmap;
 
 	if (EHCA_BMASK_GET(HCA_CAP_SRQ, shca->hca_cap)) {
diff --git a/drivers/infiniband/hw/ehca/ehca_sqp.c b/drivers/infiniband/hw/ehca/ehca_sqp.c
index 79e72b2..706d97a 100644
--- a/drivers/infiniband/hw/ehca/ehca_sqp.c
+++ b/drivers/infiniband/hw/ehca/ehca_sqp.c
@@ -39,12 +39,18 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <rdma/ib_mad.h>
 
 #include "ehca_classes.h"
 #include "ehca_tools.h"
 #include "ehca_iverbs.h"
 #include "hcp_if.h"
 
+#define IB_MAD_STATUS_REDIRECT		__constant_htons(0x0002)
+#define IB_MAD_STATUS_UNSUP_VERSION	__constant_htons(0x0004)
+#define IB_MAD_STATUS_UNSUP_METHOD	__constant_htons(0x0008)
+
+#define IB_PMA_CLASS_PORT_INFO		__constant_htons(0x0001)
 
 /**
  * ehca_define_sqp - Defines special queue pair 1 (GSI QP). When special queue
@@ -83,6 +89,9 @@ u64 ehca_define_sqp(struct ehca_shca *shca,
 				 port, ret);
 			return ret;
 		}
+		shca->sport[port - 1].pma_qp_nr = pma_qp_nr;
+		ehca_dbg(&shca->ib_device, "port=%x pma_qp_nr=%x",
+			 port, pma_qp_nr);
 		break;
 	default:
 		ehca_err(&shca->ib_device, "invalid qp_type=%x",
@@ -109,3 +118,85 @@ u64 ehca_define_sqp(struct ehca_shca *shca,
 
 	return H_SUCCESS;
 }
+
+struct ib_perf {
+	struct ib_mad_hdr mad_hdr;
+	u8 reserved[40];
+	u8 data[192];
+} __attribute__ ((packed));
+
+
+static int ehca_process_perf(struct ib_device *ibdev, u8 port_num,
+			     struct ib_mad *in_mad, struct ib_mad *out_mad)
+{
+	struct ib_perf *in_perf = (struct ib_perf *)in_mad;
+	struct ib_perf *out_perf = (struct ib_perf *)out_mad;
+	struct ib_class_port_info *poi =
+		(struct ib_class_port_info *)out_perf->data;
+	struct ehca_shca *shca =
+		container_of(ibdev, struct ehca_shca, ib_device);
+	struct ehca_sport *sport = &shca->sport[port_num - 1];
+
+	ehca_dbg(ibdev, "method=%x", in_perf->mad_hdr.method);
+
+	*out_mad = *in_mad;
+
+	if (in_perf->mad_hdr.class_version != 1) {
+		ehca_warn(ibdev, "Unsupported class_version=%x",
+			  in_perf->mad_hdr.class_version);
+		out_perf->mad_hdr.status = IB_MAD_STATUS_UNSUP_VERSION;
+		goto perf_reply;
+	}
+
+	switch (in_perf->mad_hdr.method) {
+	case IB_MGMT_METHOD_GET:
+	case IB_MGMT_METHOD_SET:
+		/* set class port info for redirection */
+		out_perf->mad_hdr.attr_id = IB_PMA_CLASS_PORT_INFO;
+		out_perf->mad_hdr.status = IB_MAD_STATUS_REDIRECT;
+		memset(poi, 0, sizeof(*poi));
+		poi->base_version = 1;
+		poi->class_version = 1;
+		poi->resp_time_value = 18;
+		poi->redirect_lid = sport->saved_attr.lid;
+		poi->redirect_qp = sport->pma_qp_nr;
+		poi->redirect_qkey = IB_QP1_QKEY;
+		poi->redirect_pkey = IB_DEFAULT_PKEY_FULL;
+
+		ehca_dbg(ibdev, "ehca_pma_lid=%x ehca_pma_qp=%x",
+			 sport->saved_attr.lid, sport->pma_qp_nr);
+		break;
+
+	case IB_MGMT_METHOD_GET_RESP:
+		return IB_MAD_RESULT_FAILURE;
+
+	default:
+		out_perf->mad_hdr.status = IB_MAD_STATUS_UNSUP_METHOD;
+		break;
+	}
+
+perf_reply:
+	out_perf->mad_hdr.method = IB_MGMT_METHOD_GET_RESP;
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
+
+int ehca_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
+		     struct ib_wc *in_wc, struct ib_grh *in_grh,
+		     struct ib_mad *in_mad,
+		     struct ib_mad *out_mad)
+{
+	int ret;
+
+	if (!port_num || port_num > ibdev->phys_port_cnt)
+		return IB_MAD_RESULT_FAILURE;
+
+	/* accept only pma request */
+	if (in_mad->mad_hdr.mgmt_class != IB_MGMT_CLASS_PERF_MGMT)
+		return IB_MAD_RESULT_SUCCESS;
+
+	ehca_dbg(ibdev, "port_num=%x src_qp=%x", port_num, in_wc->src_qp);
+	ret = ehca_process_perf(ibdev, port_num, in_mad, out_mad);
+
+	return ret;
+}
-- 
1.5.2
