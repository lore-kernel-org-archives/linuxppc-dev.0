Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb02w2KtyzDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 16:44:56 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD5hlWO112886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 00:44:54 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e6wqwgggu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 00:44:54 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 12 Nov 2017 22:44:53 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] selftest/mm: Add test for checking mmap across 128TB boundary
Date: Mon, 13 Nov 2017 11:14:40 +0530
Message-Id: <20171113054440.11279-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/Makefile         |   1 +
 tools/testing/selftests/vm/run_vmtests      |  11 ++
 tools/testing/selftests/vm/va_128TBswitch.c | 152 ++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/vm/va_128TBswitch.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index cbb29e41ef2b..b1fb3cd7cf52 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -17,6 +17,7 @@ TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += virtual_address_range
+TEST_GEN_FILES += va_128TBswitch
 
 TEST_PROGS := run_vmtests
 
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 07548a1fa901..b367f7801b67 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -176,4 +176,15 @@ else
 	echo "[PASS]"
 fi
 
+echo "-----------------------------"
+echo "running virtual address 128TB switch test" 
+echo "-----------------------------"
+./va_128TBswitch
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 exit $exitcode
diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/vm/va_128TBswitch.c
new file mode 100644
index 000000000000..ee1842c342ba
--- /dev/null
+++ b/tools/testing/selftests/vm/va_128TBswitch.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright IBM Corporation, 2017
+ * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+
+#ifdef DEBUG
+#define pr_debug(fmt, ...)  printf(fmt, ##__VA_ARGS__)
+#else
+#define pr_debug(fmt, ...)
+#endif
+
+#define VA_128TB (1UL << 47)
+
+#ifdef __powerpc64__
+#define MAP_SIZE  64*1024
+#else
+#define MAP_SIZE  4*1024
+#endif
+
+
+void report_failure(long in_addr, unsigned long flags)
+{
+	printf("Failed to map 0x%lx with flags 0x%lx\n", in_addr, flags);
+	exit(1);
+}
+
+int *__map_addr(long in_addr, int size, unsigned long flags, int unmap)
+{
+	int *addr;
+
+	addr = (int *)mmap((void *)in_addr, size, PROT_READ | PROT_WRITE,
+			   MAP_ANONYMOUS | MAP_PRIVATE | flags, -1, 0);
+	if (addr == MAP_FAILED)
+		report_failure(in_addr, flags);
+	pr_debug("Mapped addr 0x%lx-0x%lx for request 0x%lx with flag 0x%lx\n",
+		 (unsigned long)addr, ((unsigned long)addr + size), in_addr, flags);
+	/*
+	 * Try to access to catch errors in fault handling/slb miss handling
+	 */
+	*addr = 10;
+	if (unmap)
+		munmap(addr, size);
+	return addr;
+}
+
+int *map_addr(long in_addr, unsigned long flags, int unmap)
+{
+	return __map_addr(in_addr, MAP_SIZE, flags, unmap);
+}
+
+void boundary_check(void)
+{
+	int *a;
+
+	/*
+	 * If stack is moved, we could possibly allocate
+	 * this at the requested address.
+	 */
+	a = map_addr((VA_128TB - MAP_SIZE), 0, 1);
+	if ((unsigned long)a > VA_128TB - MAP_SIZE)
+		report_failure(VA_128TB - MAP_SIZE, 0);
+
+	/*
+	 * We should never allocate at the requested address or above it
+	 * The len cross the 128TB boundary. Without MAP_FIXED
+	 * we will always search in the lower address space.
+	 */
+	a = __map_addr((VA_128TB - MAP_SIZE), 2*MAP_SIZE, 0, 1);
+	if ((unsigned long)a >= VA_128TB - MAP_SIZE)
+		report_failure(VA_128TB - MAP_SIZE, 0);
+	/*
+	 * Exact mapping at 128TB, the area is free we should get that
+	 * even without MAP_FIXED. Don't unmap. We check fixed in the
+	 * same range later.
+	 */
+	a = map_addr(VA_128TB, 0, 0);
+	if ((unsigned long)a != VA_128TB)
+		report_failure(VA_128TB, 0);
+
+	a = map_addr(VA_128TB + MAP_SIZE, 0, 1);
+	if ((unsigned long)a < VA_128TB)
+		report_failure(VA_128TB, 0);
+
+#if 0
+	/*
+	 * Enable this with stack mapped MAP_SIZE below 128TB
+	 */
+	a = map_addr((VA_128TB - MAP_SIZE), MAP_FIXED, 1);
+	if ((unsigned long)a != VA_128TB - MAP_SIZE)
+		report_failure(VA_128TB - MAP_SIZE, 0);
+	a = __map_addr((VA_128TB - MAP_SIZE), 2*MAP_SIZE, MAP_FIXED, 1);
+	if ((unsigned long)a != VA_128TB - MAP_SIZE)
+		report_failure(VA_128TB - MAP_SIZE, MAP_FIXED);
+
+#endif
+	a = map_addr(VA_128TB, MAP_FIXED, 1);
+	if ((unsigned long)a != VA_128TB)
+		report_failure(VA_128TB, MAP_FIXED);
+}
+
+
+int main(int argc, char *argv[])
+{
+	int *a;
+	/*
+	 * check the 128TB boundary before we update addr_limit
+	 */
+	boundary_check();
+
+	a = map_addr(0, 0, 1);
+	if ((unsigned long)a > VA_128TB)
+		report_failure(0, 0);
+
+	a = map_addr(-1, 0, 1);
+	if ((unsigned long)a < VA_128TB)
+		report_failure(-1, 0);
+
+	/* don't unmap this one */
+	a = map_addr((1UL << 48), 0, 0);
+	if ((unsigned long)a != 1UL << 48)
+		report_failure((1UL << 48), 0);
+
+	a = map_addr((1UL << 48), 0, 1);
+	if ((unsigned long)a < VA_128TB)
+		report_failure((1UL << 48), 0);
+
+	a = map_addr(0, 0, 1);
+	if ((unsigned long)a > VA_128TB)
+		report_failure(0, 0);
+
+	a = map_addr(-1, 0, 1);
+	if ((unsigned long)a < VA_128TB)
+		report_failure(-1, 0);
+	/*
+	 * Try boundary conditions again after we allocated something above 128TB
+	 * and updated addr_limit.
+	 */
+	boundary_check();
+}
-- 
2.13.6
