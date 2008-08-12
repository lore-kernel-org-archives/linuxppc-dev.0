Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4809EDE113
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 23:46:43 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7CDkNG1097282
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:46:23 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CDkNUU2232514
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:46:23 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CDkMr7030911
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:46:23 +0100
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "of-ewg" <ewg@lists.openfabrics.org>,
	"of-general" <general@lists.openfabrics.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5 try2] ib/ehca: repoll on invalid opcode
Date: Tue, 12 Aug 2008 15:46:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808121546.20787.alexs@linux.vnet.ibm.com>
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

When the ehca driver detects an invalid opcode in a CQE, it currently passes
the CQE to the application and returns with success. This patch changes the
CQE handling to discard CQEs with invalid opcodes and to continue reading the
next CQE from the CQ.

Signed-off-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- infiniband.git.orig/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ infiniband.git/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -667,7 +667,7 @@ repoll:
 		ehca_dmp(cqe, 64, "ehca_cq=%p cq_num=%x",
 			 my_cq, my_cq->cq_number);
 		/* update also queue adder to throw away this entry!!! */
-		goto poll_cq_one_exit0;
+		goto repoll;
 	}
 
 	/* eval ib_wc_status */
