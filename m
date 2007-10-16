Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31FD2DDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 01:26:59 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l9GFQtue438026
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:26:55 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9GFQtLe1937590
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 17:26:55 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9GFQsL2006434
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 17:26:55 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 3/5] IB/ehca: Fix ehca_encode_hwpage_size() and alloc_fmr()
References: <200710161722.29144.fenkes@de.ibm.com>
In-Reply-To: <200710161722.29144.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 16 Oct 2007 17:26:54 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710161726.54648.fenkes@de.ibm.com>
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

Simplify ehca_encode_hwpage_size(), fixing an infinite loop for pgsize == 0
in the process. Fix the bug in alloc_fmr() that triggered the loop.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_mrmw.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 16c9efd..b9a788c 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -72,17 +72,9 @@ enum ehca_mr_pgsize {
 
 static u32 ehca_encode_hwpage_size(u32 pgsize)
 {
-	u32 idx = 0;
-	pgsize >>= 12;
-	/*
-	 * map mr page size into hw code:
-	 * 0, 1, 2, 3 for 4K, 64K, 1M, 64M
-	 */
-	while (!(pgsize & 1)) {
-		idx++;
-		pgsize >>= 4;
-	}
-	return idx;
+	int log = ilog2(pgsize);
+	WARN_ON(log < 12 || log > 24 || log & 3);
+	return (log - 12) / 4;
 }
 
 static u64 ehca_get_max_hwpage_size(struct ehca_shca *shca)
@@ -826,6 +818,7 @@ struct ib_fmr *ehca_alloc_fmr(struct ib_pd *pd,
 
 	/* register MR on HCA */
 	memset(&pginfo, 0, sizeof(pginfo));
+	pginfo.hwpage_size = hw_pgsize;
 	/*
 	 * pginfo.num_hwpages==0, ie register_rpages() will not be called
 	 * but deferred to map_phys_fmr()
-- 
1.5.2
