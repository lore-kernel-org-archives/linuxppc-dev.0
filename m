Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5FT6MYzzF0fW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:21:33 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L4J4DS047965
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j3jqk7e23-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:31 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Mon, 21 May 2018 05:21:29 +0100
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
 cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 2/3] powerpc/sstep: Fix kernel crash if VSX is not present
Date: Mon, 21 May 2018 09:51:07 +0530
In-Reply-To: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
References: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
Message-Id: <20180521042108.8318-3-ravi.bangoria@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

emulate_step() is not checking runtime VSX feature flag before
emulating an instruction. This is causing kernel crash when kernel
is compiled with CONFIG_VSX=y but running on a machine where VSX
is not supported or disabled. Ex, while running emulate_step tests
on P6 machine:

  Oops: Exception in kernel mode, sig: 4 [#1]
  NIP [c000000000095c24] .load_vsrn+0x28/0x54
  LR [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
  Call Trace:
    0x40fe240c7ae147ae (unreliable)
    .emulate_loadstore+0x167c/0x17b0
    .emulate_step+0x25c/0x5bc
    .test_lxvd2x_stxvd2x+0x64/0x154
    .test_emulate_step+0x38/0x4c
    .do_one_initcall+0x5c/0x2c0
    .kernel_init_freeable+0x314/0x4cc
    .kernel_init+0x24/0x160
    .ret_from_kernel_thread+0x58/0xb4

With fix:
  emulate_step_test: lxvd2x         : FAIL
  emulate_step_test: stxvd2x        : FAIL

Fixes: https://github.com/linuxppc/linux/issues/148

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index db6bba259d91..23b7ddf04521 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2544,6 +2544,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #endif /* __powerpc64__ */
 
 	}
+
+#ifdef CONFIG_VSX
+	if ((GETTYPE(op->type) == LOAD_VSX ||
+	     GETTYPE(op->type) == STORE_VSX) &&
+	    !cpu_has_feature(CPU_FTR_VSX)) {
+		return -1;
+	}
+#endif /* CONFIG_VSX */
+
 	return 0;
 
  logical_done:
-- 
2.16.2
