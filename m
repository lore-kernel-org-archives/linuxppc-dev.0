Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m3F82G04zF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 15:40:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4G5dGm6091474
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 01:40:41 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j08fx4ay5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 01:40:41 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Wed, 16 May 2018 06:40:39 +0100
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, anton@samba.org, cyrilbur@gmail.com,
 matthew.brown.dev@gmail.com, sandipan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [RFC] powerpc/emulate_step: Fix kernel crash when VSX is not present
Date: Wed, 16 May 2018 11:10:21 +0530
Message-Id: <20180516054021.5328-1-ravi.bangoria@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

emulate_step() is not checking runtime VSX feature flag before
emulating an instruction. This can cause kernel oops when kernel
is compiled with CONFIG_VSX=y but running on machine where VSX is
not supported or disabled. Ex, while running emulate_step tests on
P6 machine:

  ...
  emulate_step_test: lvx            : PASS
  emulate_step_test: stvx           : PASS
  Oops: Exception in kernel mode, sig: 4 [#1]
  NIP [c000000000095c24] .load_vsrn+0x28/0x54
  LR [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
  Call Trace:
  [c0000000494c3770] [40fe240c7ae147ae] 0x40fe240c7ae147ae (unreliable)
  [c0000000494c37f0] [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
  [c0000000494c3900] [c000000000094f6c] .emulate_step+0x25c/0x5bc
  [c0000000494c39b0] [c000000000ec90dc] .test_lxvd2x_stxvd2x+0x64/0x154
  [c0000000494c3b90] [c000000000ec9204] .test_emulate_step+0x38/0x4c
  [c0000000494c3c00] [c00000000000de2c] .do_one_initcall+0x5c/0x2c0
  [c0000000494c3cd0] [c000000000eb4bf8] .kernel_init_freeable+0x314/0x4cc
  [c0000000494c3db0] [c00000000000e1e4] .kernel_init+0x24/0x160
  [c0000000494c3e30] [c00000000000bc24] .ret_from_kernel_thread+0x58/0xb4

With fix:
  ...
  emulate_step_test: stvx           : PASS
  emulate_step_test: lxvd2x         : FAIL
  emulate_step_test: stxvd2x        : FAIL

Fixes: https://github.com/linuxppc/linux/issues/148

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
Note: VSX was first introduced on P6. But there are many VSX instructions
      which were introduced in later versions. So ideally, analyse_instr()
      should check for ISA version along with opcode.

 arch/powerpc/lib/sstep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1b1b40..470942f9c567 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1173,6 +1173,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
 	long ival;
+	int type;
 
 	op->type = COMPUTE;
 
@@ -2544,6 +2545,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #endif /* __powerpc64__ */
 
 	}
+
+#ifdef CONFIG_VSX
+	type = op->type & INSTR_TYPE_MASK;
+	if ((type == LOAD_VSX || type == STORE_VSX) &&
+	    !cpu_has_feature(CPU_FTR_VSX)) {
+		return -1;
+	}
+#endif /* CONFIG_VSX */
+
 	return 0;
 
  logical_done:
-- 
2.16.2
