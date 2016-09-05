Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZS70XlzDrtm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:52 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85NgwIb128619
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:51 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259dpc0565-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:51 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F7682BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjjIu56492126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjjNc026502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:45 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 10/20] selftests/powerpc: Introduce GPR asm helper header
 file
Date: Tue,  6 Sep 2016 09:44:38 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-11-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/gpr_asm.h | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/gpr_asm.h

diff --git a/tools/testing/selftests/powerpc/gpr_asm.h b/tools/testing/selftests/powerpc/gpr_asm.h
new file mode 100644
index 0000000..f6f3885
--- /dev/null
+++ b/tools/testing/selftests/powerpc/gpr_asm.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _SELFTESTS_POWERPC_GPR_ASM_H
+#define _SELFTESTS_POWERPC_GPR_ASM_H
+
+#include "basic_asm.h"
+
+#define __PUSH_NVREGS(top_pos); \
+	std r31,(top_pos)(%r1); \
+	std r30,(top_pos - 8)(%r1); \
+	std r29,(top_pos - 16)(%r1); \
+	std r28,(top_pos - 24)(%r1); \
+	std r27,(top_pos - 32)(%r1); \
+	std r26,(top_pos - 40)(%r1); \
+	std r25,(top_pos - 48)(%r1); \
+	std r24,(top_pos - 56)(%r1); \
+	std r23,(top_pos - 64)(%r1); \
+	std r22,(top_pos - 72)(%r1); \
+	std r21,(top_pos - 80)(%r1); \
+	std r20,(top_pos - 88)(%r1); \
+	std r19,(top_pos - 96)(%r1); \
+	std r18,(top_pos - 104)(%r1); \
+	std r17,(top_pos - 112)(%r1); \
+	std r16,(top_pos - 120)(%r1); \
+	std r15,(top_pos - 128)(%r1); \
+	std r14,(top_pos - 136)(%r1)
+
+#define __POP_NVREGS(top_pos); \
+	ld r31,(top_pos)(%r1); \
+	ld r30,(top_pos - 8)(%r1); \
+	ld r29,(top_pos - 16)(%r1); \
+	ld r28,(top_pos - 24)(%r1); \
+	ld r27,(top_pos - 32)(%r1); \
+	ld r26,(top_pos - 40)(%r1); \
+	ld r25,(top_pos - 48)(%r1); \
+	ld r24,(top_pos - 56)(%r1); \
+	ld r23,(top_pos - 64)(%r1); \
+	ld r22,(top_pos - 72)(%r1); \
+	ld r21,(top_pos - 80)(%r1); \
+	ld r20,(top_pos - 88)(%r1); \
+	ld r19,(top_pos - 96)(%r1); \
+	ld r18,(top_pos - 104)(%r1); \
+	ld r17,(top_pos - 112)(%r1); \
+	ld r16,(top_pos - 120)(%r1); \
+	ld r15,(top_pos - 128)(%r1); \
+	ld r14,(top_pos - 136)(%r1)
+
+#define PUSH_NVREGS(stack_size) \
+	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
+
+/* 18 NV FPU REGS */
+#define PUSH_NVREGS_BELOW_FPU(stack_size) \
+	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
+
+#define POP_NVREGS(stack_size) \
+	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
+
+/* 18 NV FPU REGS */
+#define POP_NVREGS_BELOW_FPU(stack_size) \
+	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
+
+/*
+ * Careful calling this, it will 'clobber' NVGPRs (by design)
+ * Don't call this from C
+ */
+FUNC_START(load_gpr)
+	ld	r14,0(r3)
+	ld	r15,8(r3)
+	ld	r16,16(r3)
+	ld	r17,24(r3)
+	ld	r18,32(r3)
+	ld	r19,40(r3)
+	ld	r20,48(r3)
+	ld	r21,56(r3)
+	ld	r22,64(r3)
+	ld	r23,72(r3)
+	ld	r24,80(r3)
+	ld	r25,88(r3)
+	ld	r26,96(r3)
+	ld	r27,104(r3)
+	ld	r28,112(r3)
+	ld	r29,120(r3)
+	ld	r30,128(r3)
+	ld	r31,136(r3)
+	blr
+FUNC_END(load_gpr)
+
+
+#endif /* _SELFTESTS_POWERPC_GPR_ASM_H */
-- 
2.9.3
