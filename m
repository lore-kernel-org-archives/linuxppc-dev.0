Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8EE7DDF5E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 21:48:33 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l49BmIR0186882
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 11:48:18 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l49BmITL3432632
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 13:48:18 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l49Bm7Zp004865
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 13:48:08 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 2/6] IB/ehca: correctly set GRH mask bit in ehca_modify_qp()
MIME-Version: 1.0
Date: Wed, 9 May 2007 13:48:01 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705091348.02396.fenkes@de.ibm.com>
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

The driver needs to always supply the "GRH present" flag to the hypervisor,
whether it's true or false. Not supplying it (i.e. not setting the
corresponding mask bit) amounts to a "perhaps", which we don't want.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index df0516f..e21d796 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -968,17 +968,21 @@ static int internal_modify_qp(struct ib_
 			((ehca_mult - 1) / ah_mult) : 0;
 		else
 			mqpcb->max_static_rate = 0;
-
 		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_MAX_STATIC_RATE, 1);
 
 		/*
+		 * Always supply the GRH flag, even if it's zero, to give the
+		 * hypervisor a clear "yes" or "no" instead of a "perhaps"
+		 */
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SEND_GRH_FLAG, 1);
+
+		/*
 		 * only if GRH is TRUE we might consider SOURCE_GID_IDX
 		 * and DEST_GID otherwise phype will return H_ATTR_PARM!!!
 		 */
 		if (attr->ah_attr.ah_flags == IB_AH_GRH) {
-			mqpcb->send_grh_flag = 1 << 31;
-			update_mask |=
-				EHCA_BMASK_SET(MQPCB_MASK_SEND_GRH_FLAG, 1);
+			mqpcb->send_grh_flag = 1;
+
 			mqpcb->source_gid_idx = attr->ah_attr.grh.sgid_index;
 			update_mask |=
 				EHCA_BMASK_SET(MQPCB_MASK_SOURCE_GID_IDX, 1);
-- 
1.4.2.1
