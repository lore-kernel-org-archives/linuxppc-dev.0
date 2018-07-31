Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fkKH1rjyzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 14:41:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	andrew.donnellan@au1.ibm.com
Subject: [PATCH 2/2] selftests/powerpc: Add more version checks to
 alignment_handler test
Date: Tue, 31 Jul 2018 14:41:04 +1000
Message-Id: <20180731044104.13728-2-mpe@ellerman.id.au>
In-Reply-To: <20180731044104.13728-1-mpe@ellerman.id.au>
References: <20180731044104.13728-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alignment_handler is documented to only work on Power8/Power9, but
we can make it run on older CPUs by guarding more of the tests with
feature checks.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../powerpc/alignment/alignment_handler.c          | 76 +++++++++++++++++++---
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index 0eddd16af49f..bcecc44627af 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -49,6 +49,8 @@
 #include <setjmp.h>
 #include <signal.h>
 
+#include <asm/cputable.h>
+
 #include "utils.h"
 
 int bufsize;
@@ -289,6 +291,7 @@ int test_alignment_handler_vsx_206(void)
 	int rc = 0;
 
 	SKIP_IF(!can_open_fb0());
+	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
 
 	printf("VSX: 2.06B\n");
 	LOAD_VSX_XFORM_TEST(lxvd2x);
@@ -306,6 +309,7 @@ int test_alignment_handler_vsx_207(void)
 	int rc = 0;
 
 	SKIP_IF(!can_open_fb0());
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
 
 	printf("VSX: 2.07B\n");
 	LOAD_VSX_XFORM_TEST(lxsspx);
@@ -380,7 +384,6 @@ int test_alignment_handler_integer(void)
 	LOAD_DFORM_TEST(ldu);
 	LOAD_XFORM_TEST(ldx);
 	LOAD_XFORM_TEST(ldux);
-	LOAD_XFORM_TEST(ldbrx);
 	LOAD_DFORM_TEST(lmw);
 	STORE_DFORM_TEST(stb);
 	STORE_XFORM_TEST(stbx);
@@ -400,8 +403,28 @@ int test_alignment_handler_integer(void)
 	STORE_XFORM_TEST(stdx);
 	STORE_DFORM_TEST(stdu);
 	STORE_XFORM_TEST(stdux);
-	STORE_XFORM_TEST(stdbrx);
 	STORE_DFORM_TEST(stmw);
+
+	if (have_hwcap(PPC_FEATURE_ARCH_2_06)) {
+		LOAD_XFORM_TEST(ldbrx);
+		STORE_XFORM_TEST(stdbrx);
+	}
+
+	return rc;
+}
+
+int test_alignment_handler_integer_206(void)
+{
+	int rc = 0;
+
+	SKIP_IF(!can_open_fb0());
+	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
+
+	printf("Integer: 2.06\n");
+
+	LOAD_XFORM_TEST(ldbrx);
+	STORE_XFORM_TEST(stdbrx);
+
 	return rc;
 }
 
@@ -410,6 +433,7 @@ int test_alignment_handler_vmx(void)
 	int rc = 0;
 
 	SKIP_IF(!can_open_fb0());
+	SKIP_IF(!have_hwcap(PPC_FEATURE_HAS_ALTIVEC));
 
 	printf("VMX\n");
 	LOAD_VMX_XFORM_TEST(lvx);
@@ -441,20 +465,14 @@ int test_alignment_handler_fp(void)
 	printf("Floating point\n");
 	LOAD_FLOAT_DFORM_TEST(lfd);
 	LOAD_FLOAT_XFORM_TEST(lfdx);
-	LOAD_FLOAT_DFORM_TEST(lfdp);
-	LOAD_FLOAT_XFORM_TEST(lfdpx);
 	LOAD_FLOAT_DFORM_TEST(lfdu);
 	LOAD_FLOAT_XFORM_TEST(lfdux);
 	LOAD_FLOAT_DFORM_TEST(lfs);
 	LOAD_FLOAT_XFORM_TEST(lfsx);
 	LOAD_FLOAT_DFORM_TEST(lfsu);
 	LOAD_FLOAT_XFORM_TEST(lfsux);
-	LOAD_FLOAT_XFORM_TEST(lfiwzx);
-	LOAD_FLOAT_XFORM_TEST(lfiwax);
 	STORE_FLOAT_DFORM_TEST(stfd);
 	STORE_FLOAT_XFORM_TEST(stfdx);
-	STORE_FLOAT_DFORM_TEST(stfdp);
-	STORE_FLOAT_XFORM_TEST(stfdpx);
 	STORE_FLOAT_DFORM_TEST(stfdu);
 	STORE_FLOAT_XFORM_TEST(stfdux);
 	STORE_FLOAT_DFORM_TEST(stfs);
@@ -466,6 +484,42 @@ int test_alignment_handler_fp(void)
 	return rc;
 }
 
+int test_alignment_handler_fp_205(void)
+{
+	int rc = 0;
+
+	SKIP_IF(!can_open_fb0());
+	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_05));
+
+	printf("Floating point: 2.05\n");
+
+	LOAD_FLOAT_DFORM_TEST(lfdp);
+	LOAD_FLOAT_XFORM_TEST(lfdpx);
+	LOAD_FLOAT_XFORM_TEST(lfiwax);
+	STORE_FLOAT_DFORM_TEST(stfdp);
+	STORE_FLOAT_XFORM_TEST(stfdpx);
+
+	if (have_hwcap(PPC_FEATURE_ARCH_2_06)) {
+		LOAD_FLOAT_XFORM_TEST(lfiwzx);
+	}
+
+	return rc;
+}
+
+int test_alignment_handler_fp_206(void)
+{
+	int rc = 0;
+
+	SKIP_IF(!can_open_fb0());
+	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
+
+	printf("Floating point: 2.06\n");
+
+	LOAD_FLOAT_XFORM_TEST(lfiwzx);
+
+	return rc;
+}
+
 void usage(char *prog)
 {
 	printf("Usage: %s [options]\n", prog);
@@ -513,9 +567,15 @@ int main(int argc, char *argv[])
 			   "test_alignment_handler_vsx_300");
 	rc |= test_harness(test_alignment_handler_integer,
 			   "test_alignment_handler_integer");
+	rc |= test_harness(test_alignment_handler_integer_206,
+			   "test_alignment_handler_integer_206");
 	rc |= test_harness(test_alignment_handler_vmx,
 			   "test_alignment_handler_vmx");
 	rc |= test_harness(test_alignment_handler_fp,
 			   "test_alignment_handler_fp");
+	rc |= test_harness(test_alignment_handler_fp_205,
+			   "test_alignment_handler_fp_205");
+	rc |= test_harness(test_alignment_handler_fp_206,
+			   "test_alignment_handler_fp_206");
 	return rc;
 }
-- 
2.14.1
