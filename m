Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423ttl4WpQzF37r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 01:19:59 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83FIqmo071467
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 11:19:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m96v41mrv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 11:19:57 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Sep 2018 16:19:55 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH 4/6] powerpc sstep: Add extswsli instruction emulation
Date: Mon,  3 Sep 2018 20:49:36 +0530
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
Message-Id: <f6708f9faa4027a9ebfaee35d14d5631d9e472f1.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation support for the following integer instructions:
  * Extend-Sign Word and Shift Left Immediate (extswsli[.])

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d57cb4e28621..828677df47b2 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1932,6 +1932,20 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				op->xerval &= ~XER_CA;
 			set_ca32(op, op->xerval & XER_CA);
 			goto logical_done;
+
+		case 890:	/* extswsli with sh_5 = 0 */
+		case 891:	/* extswsli with sh_5 = 1 */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			op->type = COMPUTE + SETREG;
+			sh = rb | ((instr & 2) << 4);
+			val = (signed int) regs->gpr[rd];
+			if (sh)
+				op->val = ROTATE(val, sh) & MASK64(0, 63 - sh);
+			else
+				op->val = val;
+			goto logical_done;
+
 #endif /* __powerpc64__ */
 
 /*
-- 
2.14.4
