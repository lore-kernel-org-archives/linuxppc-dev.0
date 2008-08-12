Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6272CDE118
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 23:46:39 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7CDkRwQ149504
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:46:27 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CDkQhe4268216
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:46:26 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CDkQKv021784
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:46:26 +0100
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "of-ewg" <ewg@lists.openfabrics.org>,
	"of-general" <general@lists.openfabrics.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5 try2] ib/ehca: check idr_find() return value
Date: Tue, 12 Aug 2008 15:46:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808121546.27705.alexs@linux.vnet.ibm.com>
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

The idr_find() function may fail when trying to get the QP that is associated
with a CQE, e.g. when a QP has been destroyed between the generation of a CQE
and the poll request for it. In consequence, the return value of idr_find()
must be checked and the CQE must be discarded when the QP cannot be found.

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
