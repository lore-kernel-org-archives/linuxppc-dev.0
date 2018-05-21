Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qMkd0tKwzF18k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 01:14:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LF8wol049752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:14:14 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j3wse1va0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:14:14 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 21 May 2018 16:14:12 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] selftests/powerpc: Move UCONTEXT_NIA() into utils.h
Date: Mon, 21 May 2018 20:43:56 +0530
In-Reply-To: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <27b2e81dfdb95182e99b7063f23539a23004203a.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

... so that it can be used by others.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/include/utils.h           | 8 ++++++++
 .../selftests/powerpc/primitives/load_unaligned_zeropad.c | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index 735815b3ad7f..b8f9cc6c9ff2 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -78,4 +78,12 @@ do {								\
 #define PPC_FEATURE2_ARCH_3_00 0x00800000
 #endif
 
+#if defined(__powerpc64__)
+#define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.gp_regs[PT_NIP]
+#elif defined(__powerpc__)
+#define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.uc_regs->gregs[PT_NIP]
+#else
+#error implement UCONTEXT_NIA
+#endif
+
 #endif /* _SELFTESTS_POWERPC_UTILS_H */
diff --git a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
index ed3239bbfae2..ee1e9ca22f0d 100644
--- a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
+++ b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
@@ -65,14 +65,6 @@ static int unprotect_region(void)
 extern char __start___ex_table[];
 extern char __stop___ex_table[];
 
-#if defined(__powerpc64__)
-#define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.gp_regs[PT_NIP]
-#elif defined(__powerpc__)
-#define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.uc_regs->gregs[PT_NIP]
-#else
-#error implement UCONTEXT_NIA
-#endif
-
 struct extbl_entry {
 	int insn;
 	int fixup;
-- 
2.17.0
