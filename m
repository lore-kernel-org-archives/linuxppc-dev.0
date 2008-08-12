Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D486DE159
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 23:48:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m7CDkCMu498146
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:46:12 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CDkCTf3551256
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 15:46:12 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CDkCUA030999
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 15:46:12 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "of-ewg" <ewg@lists.openfabrics.org>,
	"of-general" <general@lists.openfabrics.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/5 try2] ib/ehca: rename goto label
Date: Tue, 12 Aug 2008 15:46:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808121546.13860.alexs@linux.vnet.ibm.com>
Cc: Joachim Fenkes <fenkes@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the "poll_cq_one_read_cqe" goto label to what it actually does,
"repoll".

Signed-off-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- infiniband.git.orig/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ infiniband.git/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -589,7 +589,7 @@ static inline int ehca_poll_cq_one(struc
 	struct ehca_qp *my_qp;
 	int cqe_count = 0, is_error;
 
-poll_cq_one_read_cqe:
+repoll:
 	cqe = (struct ehca_cqe *)
 		ipz_qeit_get_inc_valid(&my_cq->ipz_queue);
 	if (!cqe) {
@@ -617,7 +617,7 @@ poll_cq_one_read_cqe:
 			ehca_dmp(cqe, 64, "cq_num=%x qp_num=%x",
 				 my_cq->cq_number, cqe->local_qp_number);
 			/* ignore this purged cqe */
-			goto poll_cq_one_read_cqe;
+			goto repoll;
 		}
 		spin_lock_irqsave(&qp->spinlock_s, flags);
 		purgeflag = qp->sqerr_purgeflag;
@@ -636,7 +636,7 @@ poll_cq_one_read_cqe:
 			 * that caused sqe and turn off purge flag
 			 */
 			qp->sqerr_purgeflag = 0;
-			goto poll_cq_one_read_cqe;
+			goto repoll;
 		}
 	}
 
