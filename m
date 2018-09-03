Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423tth23dpzF37r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 01:19:53 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83FJ7ln137404
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 11:19:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m964fkj29-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 11:19:51 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Sep 2018 16:19:49 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH 2/6] powerpc sstep: Add darn instruction emulation
Date: Mon,  3 Sep 2018 20:49:34 +0530
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
Message-Id: <40fccd3f879a447d32d0fa26e773674a19cb5a87.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation support for the following integer instructions:
  * Deliver A Random Number (darn)

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index b40ec18515bd..18ac0a26c4fc 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1728,6 +1728,25 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				(int) regs->gpr[rb];
 			goto arith_done;
 
+		case 755:	/* darn */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			switch (ra & 0x3) {
+			case 0:
+				asm("darn %0,0" : "=r" (op->val));
+				goto compute_done;
+
+			case 1:
+				asm("darn %0,1" : "=r" (op->val));
+				goto compute_done;
+
+			case 2:
+				asm("darn %0,2" : "=r" (op->val));
+				goto compute_done;
+			}
+
+			return -1;
+
 
 /*
  * Logical instructions
-- 
2.14.4
