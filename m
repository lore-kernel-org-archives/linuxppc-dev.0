Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B7A3DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:51:18 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m7CCnmr8623766
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 12:49:48 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CCnmMR3334382
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:49:48 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CCnlTC018613
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:49:47 +0200
Date: Tue, 12 Aug 2008 14:49:46 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, lkml
	<linux-kernel@vger.kernel.org>, of-ewg <ewg@lists.openfabrics.org>,
	of-general <general@lists.openfabrics.org>, Roland Dreier
	<rolandd@cisco.com>
Subject: [PATCH 4/5] ib/ehca: check idr_find() return value
Message-ID: <20080812144946.5e2499f8@BL3D1974.boeblingen.de.ibm.com>
In-Reply-To: <20080812143542.0cbde755@BL3D1974.boeblingen.de.ibm.com>
References: <20080812143542.0cbde755@BL3D1974.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The idr_find() function may fail when trying to get the QP that is
associated with a CQE, e.g. when a QP has been destroyed between the
generation of a CQE and the poll request for it. In consequence, the
return value of idr_find() must be checked and the CQE must be
discarded when the QP cannot be found.

Signed-off-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- infiniband.git.orig/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ infiniband.git/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -680,8 +680,10 @@ repoll:
 
 	read_lock(&ehca_qp_idr_lock);
 	my_qp = idr_find(&ehca_qp_idr, cqe->qp_token);
-	wc->qp = &my_qp->ib_qp;
 	read_unlock(&ehca_qp_idr_lock);
+	if (!my_qp)
+		goto repoll;
+	wc->qp = &my_qp->ib_qp;
 
 	wc->byte_len = cqe->nr_bytes_transferred;
 	wc->pkey_index = cqe->pkey_index;
