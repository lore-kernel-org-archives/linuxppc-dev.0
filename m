Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423ttn6Sn0zF37r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 01:20:01 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83FIpiF100233
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 11:19:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m96ntt4w8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 11:19:59 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Sep 2018 16:19:53 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH 3/6] powerpc sstep: Add cnttzw, cnttzd instruction emulation
Date: Mon,  3 Sep 2018 20:49:35 +0530
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
Message-Id: <f989c31bcf4bd8a80a50fa6899bcd239ed1bec69.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation support for the following integer instructions:
  * Count Trailing Zeros Word (cnttzw[.])
  * Count Trailing Zeros Doubleword (cnttzd[.])

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 18ac0a26c4fc..d57cb4e28621 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1816,6 +1816,20 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 506:	/* popcntd */
 			do_popcnt(regs, op, regs->gpr[rd], 64);
 			goto logical_done_nocc;
+#endif
+		case 538:	/* cnttzw */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			val = (unsigned int) regs->gpr[rd];
+			op->val = ( val ? __builtin_ctz(val) : 32 );
+			goto logical_done;
+#ifdef __powerpc64__
+		case 570:	/* cnttzd */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			val = regs->gpr[rd];
+			op->val = ( val ? __builtin_ctzl(val) : 64 );
+			goto logical_done;
 #endif
 		case 922:	/* extsh */
 			op->val = (signed short) regs->gpr[rd];
-- 
2.14.4
