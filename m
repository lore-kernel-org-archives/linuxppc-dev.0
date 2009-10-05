Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF7CAB7B86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 01:46:26 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n95EjElr026858
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Oct 2009 08:45:14 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n95Ek9TX181206
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Oct 2009 08:46:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n95Ek98H030174
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Oct 2009 08:46:09 -0600
Date: Mon, 5 Oct 2009 10:46:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2] powerpc/booke: Fix xmon single step on PowerPC Book-E
Message-ID: <20091005144605.GS14261@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prior to the arch/ppc -> arch/powerpc transition, xmon had support for single
stepping on 4xx boards.  The functionality was lost when arch/ppc was removed.
This patch restores single step support for 44x boards, and Book-E in general.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c6f0a71..bdbe96c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -517,6 +517,15 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	in_xmon = 0;
 #endif
 
+#ifdef CONFIG_BOOKE
+	if (regs->msr & MSR_DE) {
+		bp = at_breakpoint(regs->nip);
+		if (bp != NULL) {
+			regs->nip = (unsigned long) &bp->instr[0];
+			atomic_inc(&bp->ref_count);
+		}
+	}
+#else
 	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF)) {
 		bp = at_breakpoint(regs->nip);
 		if (bp != NULL) {
@@ -530,7 +539,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 			}
 		}
 	}
-
+#endif
 	insert_cpu_bpts();
 
 	local_irq_restore(flags);
@@ -894,6 +903,14 @@ cmds(struct pt_regs *excp)
 	}
 }
 
+#ifdef CONFIG_BOOKE
+static int do_step(struct pt_regs *regs)
+{
+	regs->msr |= MSR_DE;
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+	return 1;
+}
+#else
 /*
  * Step a single instruction.
  * Some instructions we emulate, others we execute with MSR_SE set.
@@ -924,6 +941,7 @@ static int do_step(struct pt_regs *regs)
 	regs->msr |= MSR_SE;
 	return 1;
 }
+#endif
 
 static void bootcmds(void)
 {
-- 
1.5.5.6
