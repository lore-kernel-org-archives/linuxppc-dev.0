Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1AD6DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 19:29:08 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l799T29M022016
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 09:29:02 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l799T19N2195702
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 11:29:01 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l799Swpb021135
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 11:28:58 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH] IB/ehca: Properly report max #SRQs in query_device()
MIME-Version: 1.0
Date: Thu, 9 Aug 2007 11:28:46 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708091128.49165.fenkes@de.ibm.com>
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

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

This patch should apply cleanly on top of Stefan's recent patchset. Please
review and apply for 2.6.23. Thanks.

 drivers/infiniband/hw/ehca/ehca_hca.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index fc19ef9..cf22472 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -93,9 +93,13 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 	props->max_pd          = min_t(int, rblock->max_pd, INT_MAX);
 	props->max_ah          = min_t(int, rblock->max_ah, INT_MAX);
 	props->max_fmr         = min_t(int, rblock->max_mr, INT_MAX);
-	props->max_srq         = 0;
-	props->max_srq_wr      = 0;
-	props->max_srq_sge     = 0;
+
+	if (EHCA_BMASK_GET(HCA_CAP_SRQ, shca->hca_cap)) {
+		props->max_srq         = props->max_qp;
+		props->max_srq_wr      = props->max_qp_wr;
+		props->max_srq_sge     = 3;
+	}
+
 	props->max_pkeys       = 16;
 	props->local_ca_ack_delay
 		= rblock->local_ca_ack_delay;
-- 
1.5.2
