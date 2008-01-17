Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BB6BDDE39
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:04:41 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m0HE4bIf415964
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 14:04:37 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m0HE4b462588758
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 14:04:37 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m0HE4X5h025312
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 14:04:34 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 2/4] IB/ehca: Define array to store SMI/GSI QPs
References: <200801171502.34287.fenkes@de.ibm.com>
In-Reply-To: <200801171502.34287.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Thu, 17 Jan 2008 15:04:32 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801171504.33426.fenkes@de.ibm.com>
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

From: Hoang-Nam Nguyen <hnguyen at de.ibm.com>

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    2 +-
 drivers/infiniband/hw/ehca/ehca_main.c    |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 74d2b72..936580d 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -94,7 +94,7 @@ struct ehca_sma_attr {
 
 struct ehca_sport {
 	struct ib_cq *ibcq_aqp1;
-	struct ib_qp *ibqp_aqp1;
+	struct ib_qp *ibqp_sqp[2];
 	enum ib_port_state port_state;
 	struct ehca_sma_attr saved_attr;
 };
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 6a56d86..cde486c 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -511,7 +511,7 @@ static int ehca_create_aqp1(struct ehca_shca *shca, u32 port)
 	}
 	sport->ibcq_aqp1 = ibcq;
 
-	if (sport->ibqp_aqp1) {
+	if (sport->ibqp_sqp[IB_QPT_GSI]) {
 		ehca_err(&shca->ib_device, "AQP1 QP is already created.");
 		ret = -EPERM;
 		goto create_aqp1;
@@ -537,7 +537,7 @@ static int ehca_create_aqp1(struct ehca_shca *shca, u32 port)
 		ret = PTR_ERR(ibqp);
 		goto create_aqp1;
 	}
-	sport->ibqp_aqp1 = ibqp;
+	sport->ibqp_sqp[IB_QPT_GSI] = ibqp;
 
 	return 0;
 
@@ -550,7 +550,7 @@ static int ehca_destroy_aqp1(struct ehca_sport *sport)
 {
 	int ret;
 
-	ret = ib_destroy_qp(sport->ibqp_aqp1);
+	ret = ib_destroy_qp(sport->ibqp_sqp[IB_QPT_GSI]);
 	if (ret) {
 		ehca_gen_err("Cannot destroy AQP1 QP. ret=%i", ret);
 		return ret;
-- 
1.5.2
