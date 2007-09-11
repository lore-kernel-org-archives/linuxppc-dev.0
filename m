Return-Path: <fenkes@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE8C4DDEFC
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:32:08 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDW3KW542758
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:32:03 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDW2E62912320
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 14:32:02 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDVusY027228
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 14:31:56 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 05/12] IB/ehca: Refactor hvcall tracing
References: <200709111518.26276.fenkes@de.ibm.com>
In-Reply-To: <200709111518.26276.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 15:31:49 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111531.50039.fenkes@de.ibm.com>
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

Change hvcall trace output towards better readability: reg numbers instead
of argument numbers, return code as signed decimal instead of unsigned hex.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/hcp_if.c |   57 ++++++++++++++--------------------
 1 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 8534061..32f465b 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -84,6 +84,10 @@
 #define H_MP_SHUTDOWN                   EHCA_BMASK_IBM(48, 48)
 #define H_MP_RESET_QKEY_CTR             EHCA_BMASK_IBM(49, 49)
 
+#define HCALL4_REGS_FORMAT "r4=%lx r5=%lx r6=%lx r7=%lx"
+#define HCALL7_REGS_FORMAT HCALL4_REGS_FORMAT " r8=%lx r9=%lx r10=%lx"
+#define HCALL9_REGS_FORMAT HCALL7_REGS_FORMAT " r11=%lx r12=%lx"
+
 static DEFINE_SPINLOCK(hcall_lock);
 
 static u32 get_longbusy_msecs(int longbusy_rc)
@@ -118,8 +122,7 @@ static long ehca_plpar_hcall_norets(unsigned long opcode,
 	long ret;
 	int i, sleep_msecs;
 
-	ehca_gen_dbg("opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
-		     "arg5=%lx arg6=%lx arg7=%lx",
+	ehca_gen_dbg("opcode=%lx " HCALL7_REGS_FORMAT,
 		     opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 
 	for (i = 0; i < 5; i++) {
@@ -133,16 +136,13 @@ static long ehca_plpar_hcall_norets(unsigned long opcode,
 		}
 
 		if (ret < H_SUCCESS)
-			ehca_gen_err("opcode=%lx ret=%lx"
-				     " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
-				     " arg5=%lx arg6=%lx arg7=%lx ",
-				     opcode, ret,
-				     arg1, arg2, arg3, arg4, arg5,
-				     arg6, arg7);
-
-		ehca_gen_dbg("opcode=%lx ret=%lx", opcode, ret);
-		return ret;
+			ehca_gen_err("opcode=%lx ret=%li " HCALL7_REGS_FORMAT,
+				     opcode, ret, arg1, arg2, arg3,
+				     arg4, arg5, arg6, arg7);
+		else
+			ehca_gen_dbg("opcode=%lx ret=%li", opcode, ret);
 
+		return ret;
 	}
 
 	return H_BUSY;
@@ -164,10 +164,8 @@ static long ehca_plpar_hcall9(unsigned long opcode,
 	int i, sleep_msecs, lock_is_set = 0;
 	unsigned long flags = 0;
 
-	ehca_gen_dbg("opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
-		     "arg5=%lx arg6=%lx arg7=%lx arg8=%lx arg9=%lx",
-		     opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
-		     arg8, arg9);
+	ehca_gen_dbg("INPUT -- opcode=%lx " HCALL9_REGS_FORMAT, opcode,
+		     arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
 
 	for (i = 0; i < 5; i++) {
 		if ((opcode == H_ALLOC_RESOURCE) && (arg2 == 5)) {
@@ -188,26 +186,19 @@ static long ehca_plpar_hcall9(unsigned long opcode,
 			continue;
 		}
 
-		if (ret < H_SUCCESS)
-			ehca_gen_err("opcode=%lx ret=%lx"
-				     " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
-				     " arg5=%lx arg6=%lx arg7=%lx arg8=%lx"
-				     " arg9=%lx"
-				     " out1=%lx out2=%lx out3=%lx out4=%lx"
-				     " out5=%lx out6=%lx out7=%lx out8=%lx"
-				     " out9=%lx",
-				     opcode, ret,
-				     arg1, arg2, arg3, arg4, arg5,
-				     arg6, arg7, arg8, arg9,
-				     outs[0], outs[1], outs[2], outs[3],
+		if (ret < H_SUCCESS) {
+			ehca_gen_err("INPUT -- opcode=%lx " HCALL9_REGS_FORMAT,
+				     opcode, arg1, arg2, arg3, arg4, arg5,
+				     arg6, arg7, arg8, arg9);
+			ehca_gen_err("OUTPUT -- ret=%li " HCALL9_REGS_FORMAT,
+				     ret, outs[0], outs[1], outs[2], outs[3],
+				     outs[4], outs[5], outs[6], outs[7],
+				     outs[8]);
+		} else
+			ehca_gen_dbg("OUTPUT -- ret=%li " HCALL9_REGS_FORMAT,
+				     ret, outs[0], outs[1], outs[2], outs[3],
 				     outs[4], outs[5], outs[6], outs[7],
 				     outs[8]);
-
-		ehca_gen_dbg("opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx "
-			     "out4=%lx out5=%lx out6=%lx out7=%lx out8=%lx "
-			     "out9=%lx",
-			     opcode, ret, outs[0], outs[1], outs[2], outs[3],
-			     outs[4], outs[5], outs[6], outs[7], outs[8]);
 		return ret;
 	}
 
-- 
1.5.2
