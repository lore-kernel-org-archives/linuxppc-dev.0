Return-Path: <fenkes@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80333B7C2C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 21:55:49 +1000 (EST)
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.17.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB3E7DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 21:55:45 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.1/8.13.1) with ESMTP id n81BtbMs029315
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 11:55:37 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n81BtZOD2760890
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 13:55:37 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n81BtY3L005532
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 13:55:35 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, OF-EWG <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Fix CQE flags reporting
References: <200806061835.43802.fenkes@de.ibm.com> <48499C11.7030504@gmail.com>
In-Reply-To: <48499C11.7030504@gmail.com>
MIME-Version: 1.0
Date: Tue, 1 Sep 2009 13:55:33 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200909011355.34319.fenkes@de.ibm.com>
Cc: Alexander Schmidt <alexschm@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Was reporting CQE flags in the wrong bit positions, causing consumers to
miss incoming immediate data.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

Please review and queue for 2.6.32 if you think it's okay. Thanks!
  Joachim

 drivers/infiniband/hw/ehca/ehca_reqs.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index 5a3d96f..8fd88cd 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -786,7 +786,11 @@ repoll:
 	wc->slid = cqe->rlid;
 	wc->dlid_path_bits = cqe->dlid;
 	wc->src_qp = cqe->remote_qp_number;
-	wc->wc_flags = cqe->w_completion_flags;
+	/*
+	 * HW has "Immed data present" and "GRH present" in bits 6 and 5.
+	 * SW defines those in bits 1 and 0, so we can just shift and mask.
+	 */
+	wc->wc_flags = (cqe->w_completion_flags >> 5) & 3;
 	wc->ex.imm_data = cpu_to_be32(cqe->immediate_data);
 	wc->sl = cqe->service_level;
 
-- 
1.6.0.4
