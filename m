Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E32B8DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 01:24:51 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l9GFOlgW235352
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:24:47 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9GFOkSO1675508
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:24:46 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9GFOTKw003396
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:24:30 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 1/5] IB/ehca: Supply QP token for SRQ base QPs
Date: Tue, 16 Oct 2007 17:24:07 +0200
References: <200710161722.29144.fenkes@de.ibm.com>
In-Reply-To: <200710161722.29144.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710161724.08286.fenkes@de.ibm.com>
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

Because hardware reports the SRQ token in RWQEs of SRQ base QPs, supply the
base QP token as SRQ token, so we can properly find the SRQ base QP.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index e2bd62b..de18264 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -451,7 +451,6 @@ static struct ehca_qp *internal_create_qp(
 		has_srq = 1;
 		parms.ext_type = EQPT_SRQBASE;
 		parms.srq_qpn = my_srq->real_qp_num;
-		parms.srq_token = my_srq->token;
 	}
 
 	if (is_llqp && has_srq) {
@@ -583,6 +582,9 @@ static struct ehca_qp *internal_create_qp(
 		goto create_qp_exit1;
 	}
 
+	if (has_srq)
+		parms.srq_token = my_qp->token;
+
 	parms.servicetype = ibqptype2servicetype(qp_type);
 	if (parms.servicetype < 0) {
 		ret = -EINVAL;
-- 
1.5.2
