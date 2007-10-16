Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0890ADDEC2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 01:26:22 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l9GFQIFD090828
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:26:18 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9GFQIGx2388196
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:26:18 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9GFQ1lf010676
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:26:02 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 2/5] IB/ehca: Fix masking error in {,re}reg_phys_mr()
References: <200710161722.29144.fenkes@de.ibm.com>
In-Reply-To: <200710161722.29144.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 16 Oct 2007 17:25:50 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710161725.50371.fenkes@de.ibm.com>
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
 drivers/infiniband/hw/ehca/ehca_mrmw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index da88738..16c9efd 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -259,7 +259,7 @@ struct ib_mr *ehca_reg_phys_mr(struct ib_pd *pd,
 		pginfo.u.phy.num_phys_buf = num_phys_buf;
 		pginfo.u.phy.phys_buf_array = phys_buf_array;
 		pginfo.next_hwpage =
-			((u64)iova_start & ~(hw_pgsize - 1)) / hw_pgsize;
+			((u64)iova_start & ~PAGE_MASK) / hw_pgsize;
 
 		ret = ehca_reg_mr(shca, e_mr, iova_start, size, mr_access_flags,
 				  e_pd, &pginfo, &e_mr->ib.ib_mr.lkey,
@@ -547,7 +547,7 @@ int ehca_rereg_phys_mr(struct ib_mr *mr,
 		pginfo.u.phy.num_phys_buf = num_phys_buf;
 		pginfo.u.phy.phys_buf_array = phys_buf_array;
 		pginfo.next_hwpage =
-			((u64)iova_start & ~(hw_pgsize - 1)) / hw_pgsize;
+			((u64)iova_start & ~PAGE_MASK) / hw_pgsize;
 	}
 	if (mr_rereg_mask & IB_MR_REREG_ACCESS)
 		new_acl = mr_access_flags;
-- 
1.5.2
