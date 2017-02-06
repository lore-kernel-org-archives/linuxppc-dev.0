Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vH3G80870zDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 21:13:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] selftests/powerpc: Refactor the AUXV routines
Date: Mon,  6 Feb 2017 21:13:27 +1100
Message-Id: <1486376008-2841-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactor the AUXV routines so they are more composable. In a future test
we want to look for many AUXV entries and we don't want to have to read
/proc/self/auxv each time.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/include/utils.h |  6 ++-
 tools/testing/selftests/powerpc/utils.c         | 53 +++++++++++++++++--------
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index 53405e8a52ab..735815b3ad7f 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -24,7 +24,11 @@ typedef uint8_t u8;
 
 void test_harness_set_timeout(uint64_t time);
 int test_harness(int (test_function)(void), char *name);
-extern void *get_auxv_entry(int type);
+
+int read_auxv(char *buf, ssize_t buf_size);
+void *find_auxv_entry(int type, char *auxv);
+void *get_auxv_entry(int type);
+
 int pick_online_cpu(void);
 
 static inline bool have_hwcap(unsigned long ftr)
diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
index dcf74184bfd0..d46916867a6f 100644
--- a/tools/testing/selftests/powerpc/utils.c
+++ b/tools/testing/selftests/powerpc/utils.c
@@ -19,45 +19,64 @@
 
 static char auxv[4096];
 
-void *get_auxv_entry(int type)
+int read_auxv(char *buf, ssize_t buf_size)
 {
-	ElfW(auxv_t) *p;
-	void *result;
 	ssize_t num;
-	int fd;
+	int rc, fd;
 
 	fd = open("/proc/self/auxv", O_RDONLY);
 	if (fd == -1) {
 		perror("open");
-		return NULL;
+		return -errno;
 	}
 
-	result = NULL;
-
-	num = read(fd, auxv, sizeof(auxv));
+	num = read(fd, buf, buf_size);
 	if (num < 0) {
 		perror("read");
+		rc = -EIO;
 		goto out;
 	}
 
-	if (num > sizeof(auxv)) {
-		printf("Overflowed auxv buffer\n");
+	if (num > buf_size) {
+		printf("overflowed auxv buffer\n");
+		rc = -EOVERFLOW;
 		goto out;
 	}
 
+	rc = 0;
+out:
+	close(fd);
+	return rc;
+}
+
+void *find_auxv_entry(int type, char *auxv)
+{
+	ElfW(auxv_t) *p;
+
 	p = (ElfW(auxv_t) *)auxv;
 
 	while (p->a_type != AT_NULL) {
-		if (p->a_type == type) {
-			result = (void *)p->a_un.a_val;
-			break;
-		}
+		if (p->a_type == type)
+			return p;
 
 		p++;
 	}
-out:
-	close(fd);
-	return result;
+
+	return NULL;
+}
+
+void *get_auxv_entry(int type)
+{
+	ElfW(auxv_t) *p;
+
+	if (read_auxv(auxv, sizeof(auxv)))
+		return NULL;
+
+	p = find_auxv_entry(type, auxv);
+	if (p)
+		return (void *)p->a_un.a_val;
+
+	return NULL;
 }
 
 int pick_online_cpu(void)
-- 
2.7.4
