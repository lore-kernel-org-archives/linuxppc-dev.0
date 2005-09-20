Return-Path: <galak@freescale.com>
Date: Tue, 20 Sep 2005 16:49:51 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509201649010.25116@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: merge include/asm-ppc*/statfs.h into
 include/asm-powerpc/statfs.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1288b50c0dd4747595c5e73dbff02088d8eeefcc
tree a721d4dbd9605cacb1bf0ab601515c3e57db7330
parent cb3e61d8491f6395a007687d9908bdb20fc9a0b5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 20 Sep 2005 16:48:42 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 20 Sep 2005 16:48:42 -0500

 include/asm-powerpc/statfs.h |   60 +++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/statfs.h     |    8 ------
 include/asm-ppc64/statfs.h   |   61 ------------------------------------------
 3 files changed, 60 insertions(+), 69 deletions(-)

diff --git a/include/asm-powerpc/statfs.h b/include/asm-powerpc/statfs.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/statfs.h
@@ -0,0 +1,60 @@
+#ifndef _ASM_POWERPC_STATFS_H
+#define _ASM_POWERPC_STATFS_H
+
+/* For ppc32 we just use the generic definitions, not so simple on ppc64 */
+
+#ifndef __powerpc64__
+#include <asm-generic/statfs.h>
+#else
+
+#ifndef __KERNEL_STRICT_NAMES
+#include <linux/types.h>
+typedef __kernel_fsid_t	fsid_t;
+#endif
+
+/*
+ * We're already 64-bit, so duplicate the definition
+ */
+struct statfs {
+	long f_type;
+	long f_bsize;
+	long f_blocks;
+	long f_bfree;
+	long f_bavail;
+	long f_files;
+	long f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_frsize;
+	long f_spare[5];
+};
+
+struct statfs64 {
+	long f_type;
+	long f_bsize;
+	long f_blocks;
+	long f_bfree;
+	long f_bavail;
+	long f_files;
+	long f_ffree;
+	__kernel_fsid_t f_fsid;
+	long f_namelen;
+	long f_frsize;
+	long f_spare[5];
+};
+
+struct compat_statfs64 {
+	__u32 f_type;
+	__u32 f_bsize;
+	__u64 f_blocks;
+	__u64 f_bfree;
+	__u64 f_bavail;
+	__u64 f_files;
+	__u64 f_ffree;
+	__kernel_fsid_t f_fsid;
+	__u32 f_namelen;
+	__u32 f_frsize;
+	__u32 f_spare[5];
+};
+#endif /* ! __powerpc64__ */
+#endif
diff --git a/include/asm-ppc/statfs.h b/include/asm-ppc/statfs.h
deleted file mode 100644
--- a/include/asm-ppc/statfs.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _PPC_STATFS_H
-#define _PPC_STATFS_H
-
-#include <asm-generic/statfs.h>
-#endif
-
-
-
diff --git a/include/asm-ppc64/statfs.h b/include/asm-ppc64/statfs.h
deleted file mode 100644
--- a/include/asm-ppc64/statfs.h
+++ /dev/null
@@ -1,61 +0,0 @@
-#ifndef _PPC64_STATFS_H
-#define _PPC64_STATFS_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef __KERNEL_STRICT_NAMES
-#include <linux/types.h>
-typedef __kernel_fsid_t	fsid_t;
-#endif
-
-/*
- * We're already 64-bit, so duplicate the definition
- */
-struct statfs {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_frsize;
-	long f_spare[5];
-};
-
-struct statfs64 {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_frsize;
-	long f_spare[5];
-};
-
-struct compat_statfs64 {
-	__u32 f_type;
-	__u32 f_bsize;
-	__u64 f_blocks;
-	__u64 f_bfree;
-	__u64 f_bavail;
-	__u64 f_files;
-	__u64 f_ffree;
-	__kernel_fsid_t f_fsid;
-	__u32 f_namelen;
-	__u32 f_frsize;
-	__u32 f_spare[5];
-};
-
-#endif  /* _PPC64_STATFS_H */
