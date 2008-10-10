Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9E066DE2D5
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 08:41:53 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] IB/ehca: Disallow creating UC QP with SRQ
References: <200810011306.31544.hnguyen@linux.vnet.ibm.com>
Date: Fri, 10 Oct 2008 14:41:39 -0700
In-Reply-To: <200810011306.31544.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Wed, 1 Oct 2008 13:06:31 +0200")
Message-ID: <adazllcku0c.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	general@lists.openfabrics.org, micfaath@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks, applied -- it didn't apply to the latest tree, because of the
flush CQE changes, so I merged it manually as below -- let me know if
this is wrong:

commit 0540bbbe455e123a1692d26205ad1a29983883b0
Author: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Date:   Fri Oct 10 14:40:39 2008 -0700

    IB/ehca: Don't allow creating UC QP with SRQ
    
    This patch prevents a UC QP to be created attached to an SRQ, since
    current firmware does not support this feature.
    
    Signed-off-by: Michael Faath <micfaath@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 4dbe287..40b578d 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -502,6 +502,12 @@ static struct ehca_qp *internal_create_qp(
 	if (init_attr->srq) {
 		my_srq = container_of(init_attr->srq, struct ehca_qp, ib_srq);
 
+		if (qp_type == IB_QPT_UC) {
+			ehca_err(pd->device, "UC with SRQ not supported");
+			atomic_dec(&shca->num_qps);
+			return ERR_PTR(-EINVAL);
+		}
+
 		has_srq = 1;
 		parms.ext_type = EQPT_SRQBASE;
 		parms.srq_qpn = my_srq->real_qp_num;
