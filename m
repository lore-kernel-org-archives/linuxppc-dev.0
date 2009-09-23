Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5D69B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 23:53:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8NDk8dP021792
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:46:08 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8NDq0Fe148426
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:52:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8NDpxiK029263
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:51:59 -0400
Received: from zod.rchland.ibm.com ([9.49.202.222])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n8NDpuDX029182
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:51:58 -0400
Date: Wed, 23 Sep 2009 09:51:56 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/44x: Fix xmon single step on PowerPC 44x
Message-ID: <20090923135156.GH14261@zod.rchland.ibm.com>
References: <20090923134844.GF14261@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090923134844.GF14261@zod.rchland.ibm.com>
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
This patch restores single step support for 44x boards.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c6f0a71..fe2ad71 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -517,6 +517,15 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	in_xmon = 0;
 #endif
 
+#ifdef CONFIG_4xx
+	if ((regs->msr & (MSR_DE)) == (MSR_DE)) {
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
 
+#ifdef CONFIG_44x
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
