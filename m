Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3L982zRBzDsTF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:44:28 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8T5iI5u097285
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:44:26 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d9eqym9db-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:44:26 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Fri, 29 Sep 2017 15:44:23 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8T5iLlF35651694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:44:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8T5iNTb017052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:44:24 +1000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, anton@samba.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/lib/sstep: Fix fixed-point arithmetic
 instructions that set CA32
Date: Fri, 29 Sep 2017 11:14:09 +0530
In-Reply-To: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
References: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20170929054410.12600-2-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are existing fixed-point arithmetic instructions that always set the
CA bit of XER to reflect the carry out of bit 0 in 64-bit mode and out of
bit 32 in 32-bit mode. In ISA v3.0, these instructions also always set the
CA32 bit of XER to reflect the carry out of bit 32.

This fixes the emulated behaviour of such instructions when running on a
system that is compliant with POWER ISA v3.0. The following instructions
are affected:
  * Add Immediate Carrying (addic)
  * Add Immediate Carrying and Record (addic.)
  * Subtract From Immediate Carrying (subfic)
  * Add Carrying (addc[.])
  * Subtract From Carrying (subfc[.])
  * Add Extended (adde[.])
  * Subtract From Extended (subfe[.])
  * Add to Minus One Extended (addme[.])
  * Subtract From Minus One Extended (subfme[.])
  * Add to Zero Extended (addze[.])
  * Subtract From Zero Extended (subfze[.])

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 arch/powerpc/lib/sstep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 16814bfc01da..fe1910733e55 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -964,6 +964,16 @@ static nokprobe_inline void set_cr0(const struct pt_regs *regs,
 		op->ccval |= 0x20000000;
 }
 
+static nokprobe_inline void set_ca32(struct instruction_op *op, bool val)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (val)
+			op->xerval |= XER_CA32;
+		else
+			op->xerval &= ~XER_CA32;
+	}
+}
+
 static nokprobe_inline void add_with_carry(const struct pt_regs *regs,
 				     struct instruction_op *op, int rd,
 				     unsigned long val1, unsigned long val2,
@@ -987,6 +997,9 @@ static nokprobe_inline void add_with_carry(const struct pt_regs *regs,
 		op->xerval |= XER_CA;
 	else
 		op->xerval &= ~XER_CA;
+
+	set_ca32(op, (unsigned int)val < (unsigned int)val1 ||
+			(carry_in && (unsigned int)val == (unsigned int)val1));
 }
 
 static nokprobe_inline void do_cmp_signed(const struct pt_regs *regs,
-- 
2.13.5
