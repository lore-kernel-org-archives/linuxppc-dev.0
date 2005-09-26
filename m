Return-Path: <bgill@freescale.com>
Date: Mon, 26 Sep 2005 11:21:18 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509261119370.14971@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc: merge ipcbuf.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Merge ipcbuf.h

Merged ipcbuf.h into include/asm-powerpc.  The type of a couple of
__unused fields in the ipc64_perm struct has been changed to long long
so we get a 64-bit quantity on both 32/64 ppcs.  The pad field is now
called __pad1 on both platforms.  The "seq" structure member is now an int,
so we get 32-bits on both platforms as well (previously, it was a long
on ppc32).  The size of the structure on both platforms is the same as
it always was.  Also, updated include/asm-ppc64/compat.h to match the
new structure definition.

Builds cleanly on several different 32/64-bit platforms with no new
warnings.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 62cba170a9d2629791c9e9ceebb9c679f81fb3fb
tree 848d43a4a62930af1ed7181088d2b428d4b40b2d
parent 76b1ba19ac14976b8cd288180bb939f429a70820
author Becky Bruce <becky.bruce@freescale.com> Mon, 26 Sep 2005 11:17:55 -0500
committer Becky Bruce <becky.bruce@freescale.com> Mon, 26 Sep 2005 11:17:55 -0500

 include/asm-powerpc/ipcbuf.h |   28 ++++++++++++++++++++++++++++
 include/asm-ppc/ipcbuf.h     |   29 -----------------------------
 include/asm-ppc64/compat.h   |    6 +++---
 include/asm-ppc64/ipcbuf.h   |   28 ----------------------------
 4 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/include/asm-powerpc/ipcbuf.h b/include/asm-powerpc/ipcbuf.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/ipcbuf.h
@@ -0,0 +1,28 @@
+#ifndef _ASM_POWERPC_IPCBUF_H
+#define _ASM_POWERPC_IPCBUF_H
+
+/*
+ * The ipc64_perm structure for the PPC is identical to kern_ipc_perm
+ * as we have always had 32-bit UIDs and GIDs in the kernel.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid_t		uid;
+	__kernel_gid_t		gid;
+	__kernel_uid_t		cuid;
+	__kernel_gid_t		cgid;
+	__kernel_mode_t		mode;
+	unsigned int		seq;
+	unsigned int		__pad1;
+	unsigned long long	__unused1;
+	unsigned long long	__unused2;
+};
+
+#endif /* _ASM_POWERPC_IPCBUF_H */
diff --git a/include/asm-ppc/ipcbuf.h b/include/asm-ppc/ipcbuf.h
deleted file mode 100644
--- a/include/asm-ppc/ipcbuf.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __PPC_IPCBUF_H__
-#define __PPC_IPCBUF_H__
-
-/*
- * The ipc64_perm structure for PPC architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 1 32-bit value to fill up for 8-byte alignment
- * - 2 miscellaneous 64-bit values (so that this structure matches
- *                                  PPC64 ipc64_perm)
- */
-
-struct ipc64_perm
-{
-	__kernel_key_t		key;
-	__kernel_uid_t		uid;
-	__kernel_gid_t		gid;
-	__kernel_uid_t		cuid;
-	__kernel_gid_t		cgid;
-	__kernel_mode_t		mode;
-	unsigned long		seq;
-	unsigned int		__pad2;
-	unsigned long long	__unused1;
-	unsigned long long	__unused2;
-};
-
-#endif /* __PPC_IPCBUF_H__ */
diff --git a/include/asm-ppc64/compat.h b/include/asm-ppc64/compat.h
--- a/include/asm-ppc64/compat.h
+++ b/include/asm-ppc64/compat.h
@@ -152,9 +152,9 @@ struct compat_ipc64_perm {
 	__compat_gid_t cgid;
 	compat_mode_t mode;
 	unsigned int seq;
-	unsigned int __pad2;
-	unsigned long __unused1;	/* yes they really are 64bit pads */
-	unsigned long __unused2;
+	unsigned int __pad1;
+	unsigned long long __unused1;	/* yes they really are 64bit pads */
+	unsigned long long __unused2;
 };
 
 struct compat_semid64_ds {
diff --git a/include/asm-ppc64/ipcbuf.h b/include/asm-ppc64/ipcbuf.h
deleted file mode 100644
--- a/include/asm-ppc64/ipcbuf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#ifndef __PPC64_IPCBUF_H__
-#define __PPC64_IPCBUF_H__
-
-/*
- * The ipc64_perm structure for the PPC is identical to kern_ipc_perm
- * as we have always had 32-bit UIDs and GIDs in the kernel.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-struct ipc64_perm
-{
-	__kernel_key_t	key;
-	__kernel_uid_t	uid;
-	__kernel_gid_t	gid;
-	__kernel_uid_t	cuid;
-	__kernel_gid_t	cgid;
-	__kernel_mode_t	mode;
-	unsigned int	seq;
-	unsigned int	__pad1;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* __PPC64_IPCBUF_H__ */
