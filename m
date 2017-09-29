Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3L9F3dXWzDsVF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:44:33 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8T5iHSW102563
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:44:30 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d9dqgq297-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:44:30 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Fri, 29 Sep 2017 15:44:27 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8T5iPD048627824
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:44:25 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8T5iSET017100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:44:28 +1000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, anton@samba.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/lib/sstep: Fix fixed-point shift instructions
 that set CA32
Date: Fri, 29 Sep 2017 11:14:10 +0530
In-Reply-To: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
References: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20170929054410.12600-3-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the emulated behaviour of existing fixed-point shift right
algebraic instructions that are supposed to set both the CA and CA32
bits of XER when running on a system that is compliant with POWER ISA
v3.0 independent of whether the system is executing in 32-bit mode or
64-bit mode. The following instructions are affected:
  * Shift Right Algebraic Word Immediate (srawi[.])
  * Shift Right Algebraic Word (sraw[.])
  * Shift Right Algebraic Doubleword Immediate (sradi[.])
  * Shift Right Algebraic Doubleword (srad[.])

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 arch/powerpc/lib/sstep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index fe1910733e55..5118110c3983 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1804,6 +1804,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				op->xerval |= XER_CA;
 			else
 				op->xerval &= ~XER_CA;
+			set_ca32(op, op->xerval & XER_CA);
 			goto logical_done;
 
 		case 824:	/* srawi */
@@ -1816,6 +1817,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				op->xerval |= XER_CA;
 			else
 				op->xerval &= ~XER_CA;
+			set_ca32(op, op->xerval & XER_CA);
 			goto logical_done;
 
 #ifdef __powerpc64__
@@ -1845,6 +1847,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				op->xerval |= XER_CA;
 			else
 				op->xerval &= ~XER_CA;
+			set_ca32(op, op->xerval & XER_CA);
 			goto logical_done;
 
 		case 826:	/* sradi with sh_5 = 0 */
@@ -1858,6 +1861,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				op->xerval |= XER_CA;
 			else
 				op->xerval &= ~XER_CA;
+			set_ca32(op, op->xerval & XER_CA);
 			goto logical_done;
 #endif /* __powerpc64__ */
 
-- 
2.13.5
