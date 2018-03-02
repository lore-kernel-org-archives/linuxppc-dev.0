Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsswW36yQzF1Ft
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 13:01:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v2] selftests/powerpc: Skip the subpage_prot tests if the
 syscall is unavailable
Date: Fri,  2 Mar 2018 13:01:08 +1100
Message-Id: <20180302020108.22174-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The subpage_prot syscall is only functional when the system is using
the Hash MMU. Since commit 5b2b80714796 ("powerpc/mm: Invalidate
subpage_prot() system call on radix platforms") it returns ENOENT when
the Radix MMU is active. Currently this just makes the test fail.

Additionally the syscall is not available if the kernel is built with
4K pages, or if CONFIG_PPC_SUBPAGE_PROT=n, in which case it returns
ENOSYS because the syscall is missing entirely.

So check explicitly for ENOENT and ENOSYS and skip if we see either of
those.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/subpage_prot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
index 35ade7406dcd..3ae77ba93208 100644
--- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
+++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
@@ -135,6 +135,16 @@ static int run_test(void *addr, unsigned long size)
 	return 0;
 }
 
+static int syscall_available(void)
+{
+	int rc;
+
+	errno = 0;
+	rc = syscall(__NR_subpage_prot, 0, 0, 0);
+
+	return rc == 0 || (errno != ENOENT && errno != ENOSYS);
+}
+
 int test_anon(void)
 {
 	unsigned long align;
@@ -145,6 +155,8 @@ int test_anon(void)
 	void *mallocblock;
 	unsigned long mallocsize;
 
+	SKIP_IF(!syscall_available());
+
 	if (getpagesize() != 0x10000) {
 		fprintf(stderr, "Kernel page size must be 64K!\n");
 		return 1;
@@ -180,6 +192,8 @@ int test_file(void)
 	off_t filesize;
 	int fd;
 
+	SKIP_IF(!syscall_available());
+
 	fd = open(file_name, O_RDWR);
 	if (fd == -1) {
 		perror("failed to open file");
-- 
2.14.1
