Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14BEADE0A8
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:34:42 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDYaah464848
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:34:36 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDYarC2199608
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:34:36 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDYaI6020118
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:34:36 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 11/12] IB/ehca: Serialize MR alloc and MR free hvCalls
References: <200709111518.26276.fenkes@de.ibm.com>
In-Reply-To: <200709111518.26276.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 15:34:35 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111534.35916.fenkes@de.ibm.com>
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

Some firmware levels exhibit a race condition between H_ALLOC_RESOURCE(MR)
and H_FREE_RESOURCE(MR). Work around this problem by locking these hvCalls
against each other.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/hcp_if.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index a70a5ed..d3d1ef2 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -120,15 +120,28 @@ static long ehca_plpar_hcall_norets(unsigned long opcode,
 				    unsigned long arg7)
 {
 	long ret;
-	int i, sleep_msecs;
+	int i, sleep_msecs, do_lock;
+	unsigned long flags;
 
 	ehca_gen_dbg("opcode=%lx " HCALL7_REGS_FORMAT,
 		     opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 
+	/* lock H_FREE_RESOURCE(MR) against itself and H_ALLOC_RESOURCE(MR) */
+	if ((opcode == H_FREE_RESOURCE) && (arg7 == 5)) {
+		arg7 = 0; /* better not upset firmware */
+		do_lock = 1;
+	}
+
 	for (i = 0; i < 5; i++) {
+		if (do_lock)
+			spin_lock_irqsave(&hcall_lock, flags);
+
 		ret = plpar_hcall_norets(opcode, arg1, arg2, arg3, arg4,
 					 arg5, arg6, arg7);
 
+		if (do_lock)
+			spin_unlock_irqrestore(&hcall_lock, flags);
+
 		if (H_IS_LONG_BUSY(ret)) {
 			sleep_msecs = get_longbusy_msecs(ret);
 			msleep_interruptible(sleep_msecs);
@@ -161,23 +174,24 @@ static long ehca_plpar_hcall9(unsigned long opcode,
 			      unsigned long arg9)
 {
 	long ret;
-	int i, sleep_msecs, lock_is_set = 0;
+	int i, sleep_msecs, do_lock;
 	unsigned long flags = 0;
 
 	ehca_gen_dbg("INPUT -- opcode=%lx " HCALL9_REGS_FORMAT, opcode,
 		     arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
 
+	/* lock H_ALLOC_RESOURCE(MR) against itself and H_FREE_RESOURCE(MR) */
+	do_lock = ((opcode == H_ALLOC_RESOURCE) && (arg2 == 5));
+
 	for (i = 0; i < 5; i++) {
-		if ((opcode == H_ALLOC_RESOURCE) && (arg2 == 5)) {
+		if (do_lock)
 			spin_lock_irqsave(&hcall_lock, flags);
-			lock_is_set = 1;
-		}
 
 		ret = plpar_hcall9(opcode, outs,
 				   arg1, arg2, arg3, arg4, arg5,
 				   arg6, arg7, arg8, arg9);
 
-		if (lock_is_set)
+		if (do_lock)
 			spin_unlock_irqrestore(&hcall_lock, flags);
 
 		if (H_IS_LONG_BUSY(ret)) {
@@ -807,7 +821,7 @@ u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle adapter_handle,
 	return ehca_plpar_hcall_norets(H_FREE_RESOURCE,
 				       adapter_handle.handle,    /* r4 */
 				       mr->ipz_mr_handle.handle, /* r5 */
-				       0, 0, 0, 0, 0);
+				       0, 0, 0, 0, 5);
 }
 
 u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
-- 
1.5.2
