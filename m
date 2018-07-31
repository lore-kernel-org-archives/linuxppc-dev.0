Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fkKH0FKxzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 14:41:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	andrew.donnellan@au1.ibm.com
Subject: [PATCH 1/2] selftests/powerpc: Skip earlier in alignment_handler test
Date: Tue, 31 Jul 2018 14:41:03 +1000
Message-Id: <20180731044104.13728-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the alignment_handler test prints "Can't open /dev/fb0"
about 80 times per run, which is a little annoying.

Refactor it to check earlier if it can open /dev/fb0 and skip if not,
this results in each test printing something like:

  test: test_alignment_handler_vsx_206
  tags: git_version:v4.18-rc3-134-gfb21a48904aa
  [SKIP] Test skipped on line 291
  skip: test_alignment_handler_vsx_206

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../powerpc/alignment/alignment_handler.c          | 40 +++++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index 0f2698f9fd6d..0eddd16af49f 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -40,6 +40,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -191,7 +192,7 @@ int test_memcmp(void *s1, void *s2, int n, int offset, char *test_name)
  */
 int do_test(char *test_name, void (*test_func)(char *, char *))
 {
-	int offset, width, fd, rc = 0, r;
+	int offset, width, fd, rc, r;
 	void *mem0, *mem1, *ci0, *ci1;
 
 	printf("\tDoing %s:\t", test_name);
@@ -199,8 +200,8 @@ int do_test(char *test_name, void (*test_func)(char *, char *))
 	fd = open("/dev/fb0", O_RDWR);
 	if (fd < 0) {
 		printf("\n");
-		perror("Can't open /dev/fb0");
-		SKIP_IF(1);
+		perror("Can't open /dev/fb0 now?");
+		return 1;
 	}
 
 	ci0 = mmap(NULL, bufsize, PROT_WRITE, MAP_SHARED,
@@ -226,6 +227,7 @@ int do_test(char *test_name, void (*test_func)(char *, char *))
 		return rc;
 	}
 
+	rc = 0;
 	/* offset = 0 no alignment fault, so skip */
 	for (offset = 1; offset < 16; offset++) {
 		width = 16; /* vsx == 16 bytes */
@@ -244,32 +246,50 @@ int do_test(char *test_name, void (*test_func)(char *, char *))
 		r |= test_memcpy(mem1, mem0, width, offset, test_func);
 		if (r && !debug) {
 			printf("FAILED: Got signal");
+			rc = 1;
 			break;
 		}
 
 		r |= test_memcmp(mem1, ci1, width, offset, test_name);
-		rc |= r;
 		if (r && !debug) {
 			printf("FAILED: Wrong Data");
+			rc = 1;
 			break;
 		}
 	}
-	if (!r)
+
+	if (rc == 0)
 		printf("PASSED");
+
 	printf("\n");
 
 	munmap(ci0, bufsize);
 	munmap(ci1, bufsize);
 	free(mem0);
 	free(mem1);
+	close(fd);
 
 	return rc;
 }
 
+static bool can_open_fb0(void)
+{
+	int fd;
+
+	fd = open("/dev/fb0", O_RDWR);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
+}
+
 int test_alignment_handler_vsx_206(void)
 {
 	int rc = 0;
 
+	SKIP_IF(!can_open_fb0());
+
 	printf("VSX: 2.06B\n");
 	LOAD_VSX_XFORM_TEST(lxvd2x);
 	LOAD_VSX_XFORM_TEST(lxvw4x);
@@ -285,6 +305,8 @@ int test_alignment_handler_vsx_207(void)
 {
 	int rc = 0;
 
+	SKIP_IF(!can_open_fb0());
+
 	printf("VSX: 2.07B\n");
 	LOAD_VSX_XFORM_TEST(lxsspx);
 	LOAD_VSX_XFORM_TEST(lxsiwax);
@@ -298,6 +320,8 @@ int test_alignment_handler_vsx_300(void)
 {
 	int rc = 0;
 
+	SKIP_IF(!can_open_fb0());
+
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
 	printf("VSX: 3.00B\n");
 	LOAD_VMX_DFORM_TEST(lxsd);
@@ -328,6 +352,8 @@ int test_alignment_handler_integer(void)
 {
 	int rc = 0;
 
+	SKIP_IF(!can_open_fb0());
+
 	printf("Integer\n");
 	LOAD_DFORM_TEST(lbz);
 	LOAD_DFORM_TEST(lbzu);
@@ -383,6 +409,8 @@ int test_alignment_handler_vmx(void)
 {
 	int rc = 0;
 
+	SKIP_IF(!can_open_fb0());
+
 	printf("VMX\n");
 	LOAD_VMX_XFORM_TEST(lvx);
 
@@ -408,6 +436,8 @@ int test_alignment_handler_fp(void)
 {
 	int rc = 0;
 
+	SKIP_IF(!can_open_fb0());
+
 	printf("Floating point\n");
 	LOAD_FLOAT_DFORM_TEST(lfd);
 	LOAD_FLOAT_XFORM_TEST(lfdx);
-- 
2.14.1
