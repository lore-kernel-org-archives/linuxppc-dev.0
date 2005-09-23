Return-Path: <jdl@jdl.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Fri, 23 Sep 2005 08:05:03 -0500
Message-Id: <E1EInEd-00023v-MX@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc Merge asm-ppc*/seccomp.h, drop TIF_32BIT check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merge asm-ppc*/seccomp.h. Drop TIF_32BIT check.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---


 include/asm-powerpc/seccomp.h |   16 ++++++++++++++++
 include/asm-ppc/seccomp.h     |   10 ----------
 include/asm-ppc64/seccomp.h   |   21 ---------------------
 3 files changed, 16 insertions(+), 31 deletions(-)


diff --git a/include/asm-powerpc/seccomp.h b/include/asm-powerpc/seccomp.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/seccomp.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_POWERPC_SECCOMP_H
+
+#include <linux/thread_info.h>
+#include <linux/unistd.h>
+
+#define __NR_seccomp_read __NR_read
+#define __NR_seccomp_write __NR_write
+#define __NR_seccomp_exit __NR_exit
+#define __NR_seccomp_sigreturn __NR_rt_sigreturn
+
+#define __NR_seccomp_read_32 __NR_read
+#define __NR_seccomp_write_32 __NR_write
+#define __NR_seccomp_exit_32 __NR_exit
+#define __NR_seccomp_sigreturn_32 __NR_sigreturn
+
+#endif	/* _ASM_POWERPC_SECCOMP_H */
diff --git a/include/asm-ppc/seccomp.h b/include/asm-ppc/seccomp.h
deleted file mode 100644
--- a/include/asm-ppc/seccomp.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _ASM_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#endif /* _ASM_SECCOMP_H */
diff --git a/include/asm-ppc64/seccomp.h b/include/asm-ppc64/seccomp.h
deleted file mode 100644
--- a/include/asm-ppc64/seccomp.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef _ASM_SECCOMP_H
-
-#include <linux/thread_info.h> /* already defines TIF_32BIT */
-
-#ifndef TIF_32BIT
-#error "unexpected TIF_32BIT on ppc64"
-#endif
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_sigreturn
-
-#endif /* _ASM_SECCOMP_H */
