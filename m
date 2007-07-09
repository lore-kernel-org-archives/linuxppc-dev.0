Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D8BBDE0DC
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:34:03 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l69DXw2T039906
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:33:58 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69DXsNf573676
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 14:33:55 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69DXrgh005777
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 14:33:54 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 13/13] IB/ehca: Improve latency by unlocking the SQ/RQ after
	triggering the hardware
References: <200707091502.22407.fenkes@de.ibm.com>
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 9 Jul 2007 15:33:52 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091533.53383.fenkes@de.ibm.com>
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

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index fd3ba22..61da65e 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -407,10 +407,9 @@ int ehca_post_send(struct ib_qp *qp,
 	} /* eof for cur_send_wr */
 
 post_send_exit0:
-	/* UNLOCK the QUEUE */
-	spin_unlock_irqrestore(&my_qp->spinlock_s, flags);
 	iosync(); /* serialize GAL register access */
 	hipz_update_sqa(my_qp, wqe_cnt);
+	spin_unlock_irqrestore(&my_qp->spinlock_s, flags);
 	return ret;
 }
 
@@ -473,9 +472,9 @@ static int internal_post_recv(struct ehca_qp *my_qp,
 	} /* eof for cur_recv_wr */
 
 post_recv_exit0:
-	spin_unlock_irqrestore(&my_qp->spinlock_r, flags);
 	iosync(); /* serialize GAL register access */
 	hipz_update_rqa(my_qp, wqe_cnt);
+	spin_unlock_irqrestore(&my_qp->spinlock_r, flags);
 	return ret;
 }
 
-- 
1.5.2
