Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZR5wPyzDrq3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:51 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85Ngwq4049626
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:49 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259dq4826s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:49 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2DD152BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:44 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjiVe44826704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:44 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjhlN031873
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:44 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 09/20] selftests/powerpc: Move VMX stack frame macros to
 header file
Date: Tue,  6 Sep 2016 09:44:37 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-10-cyrilbur@gmail.com>
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
 tools/testing/selftests/powerpc/math/vmx_asm.S | 85 +---------------------
 tools/testing/selftests/powerpc/vmx_asm.h      | 98 ++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/vmx_asm.h

diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testing/selftests/powerpc/math/vmx_asm.S
index 1b8c248..fd74da4 100644
--- a/tools/testing/selftests/powerpc/math/vmx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
@@ -8,90 +8,7 @@
  */
 
 #include "../basic_asm.h"
-
-# POS MUST BE 16 ALIGNED!
-#define PUSH_VMX(pos,reg) \
-	li	reg,pos; \
-	stvx	v20,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v21,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v22,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v23,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v24,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v25,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v26,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v27,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v28,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v29,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v30,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v31,reg,sp;
-
-# POS MUST BE 16 ALIGNED!
-#define POP_VMX(pos,reg) \
-	li	reg,pos; \
-	lvx	v20,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v21,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v22,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v23,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v24,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v25,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v26,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v27,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v28,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v29,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v30,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v31,reg,sp;
-
-# Carefull this will 'clobber' vmx (by design)
-# Don't call this from C
-FUNC_START(load_vmx)
-	li	r5,0
-	lvx	v20,r5,r3
-	addi	r5,r5,16
-	lvx	v21,r5,r3
-	addi	r5,r5,16
-	lvx	v22,r5,r3
-	addi	r5,r5,16
-	lvx	v23,r5,r3
-	addi	r5,r5,16
-	lvx	v24,r5,r3
-	addi	r5,r5,16
-	lvx	v25,r5,r3
-	addi	r5,r5,16
-	lvx	v26,r5,r3
-	addi	r5,r5,16
-	lvx	v27,r5,r3
-	addi	r5,r5,16
-	lvx	v28,r5,r3
-	addi	r5,r5,16
-	lvx	v29,r5,r3
-	addi	r5,r5,16
-	lvx	v30,r5,r3
-	addi	r5,r5,16
-	lvx	v31,r5,r3
-	blr
-FUNC_END(load_vmx)
+#include "../vmx_asm.h"
 
 # Should be safe from C, only touches r4, r5 and v0,v1,v2
 FUNC_START(check_vmx)
diff --git a/tools/testing/selftests/powerpc/vmx_asm.h b/tools/testing/selftests/powerpc/vmx_asm.h
new file mode 100644
index 0000000..461845dd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vmx_asm.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "basic_asm.h"
+
+/* POS MUST BE 16 ALIGNED! */
+#define PUSH_VMX(pos,reg) \
+	li	reg,pos; \
+	stvx	v20,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v21,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v22,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v23,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v24,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v25,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v26,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v27,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v28,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v29,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v30,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v31,reg,%r1;
+
+/* POS MUST BE 16 ALIGNED! */
+#define POP_VMX(pos,reg) \
+	li	reg,pos; \
+	lvx	v20,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v21,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v22,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v23,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v24,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v25,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v26,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v27,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v28,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v29,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v30,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v31,reg,%r1;
+
+/*
+ * Careful this will 'clobber' vmx (by design)
+ * Don't call this from C
+ */
+FUNC_START(load_vmx)
+	li	r5,0
+	lvx	v20,r5,r3
+	addi	r5,r5,16
+	lvx	v21,r5,r3
+	addi	r5,r5,16
+	lvx	v22,r5,r3
+	addi	r5,r5,16
+	lvx	v23,r5,r3
+	addi	r5,r5,16
+	lvx	v24,r5,r3
+	addi	r5,r5,16
+	lvx	v25,r5,r3
+	addi	r5,r5,16
+	lvx	v26,r5,r3
+	addi	r5,r5,16
+	lvx	v27,r5,r3
+	addi	r5,r5,16
+	lvx	v28,r5,r3
+	addi	r5,r5,16
+	lvx	v29,r5,r3
+	addi	r5,r5,16
+	lvx	v30,r5,r3
+	addi	r5,r5,16
+	lvx	v31,r5,r3
+	blr
+FUNC_END(load_vmx)
+
+
-- 
2.9.3
