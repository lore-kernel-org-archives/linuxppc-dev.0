Return-Path: <jdl@jdl.com>
From: linuxppc@jdl.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Mon, 19 Sep 2005 09:01:13 -0500
Message-Id: <E1EHMCn-0001mg-KT@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc: Merge asm-ppc*/posix_types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merge asm-ppc/posix_types.h and asm-ppc64/posix_types.h.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---

 include/asm-powerpc/posix_types.h |  129 +++++++++++++++++++++++++++++++++++++
 include/asm-ppc/posix_types.h     |  111 --------------------------------
 include/asm-ppc64/posix_types.h   |  119 ----------------------------------
 3 files changed, 129 insertions(+), 230 deletions(-)


diff --git a/include/asm-powerpc/posix_types.h b/include/asm-powerpc/posix_types.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/posix_types.h
@@ -0,0 +1,129 @@
+#ifndef _ASM_POWERPC_POSIX_TYPES_H
+#define _ASM_POWERPC_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef unsigned long	__kernel_ino_t;
+typedef unsigned int	__kernel_mode_t;
+typedef long		__kernel_off_t;
+typedef int		__kernel_pid_t;
+typedef unsigned int	__kernel_uid_t;
+typedef unsigned int	__kernel_gid_t;
+typedef long		__kernel_ptrdiff_t;
+typedef long		__kernel_time_t;
+typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
+typedef long		__kernel_suseconds_t;
+typedef int		__kernel_daddr_t;
+typedef char *		__kernel_caddr_t;
+typedef unsigned short	__kernel_uid16_t;
+typedef unsigned short	__kernel_gid16_t;
+typedef unsigned int	__kernel_uid32_t;
+typedef unsigned int	__kernel_gid32_t;
+typedef unsigned int	__kernel_old_uid_t;
+typedef unsigned int	__kernel_old_gid_t;
+
+#ifdef __powerpc64__
+typedef unsigned long  	__kernel_nlink_t;
+typedef int             __kernel_ipc_pid_t;
+typedef unsigned long	__kernel_size_t;
+typedef long		__kernel_ssize_t;
+typedef unsigned long	__kernel_old_dev_t;
+#else
+typedef unsigned short	__kernel_nlink_t;
+typedef short		__kernel_ipc_pid_t;
+typedef unsigned int	__kernel_size_t;
+typedef int		__kernel_ssize_t;
+typedef unsigned int	__kernel_old_dev_t;
+#endif
+
+#ifdef __powerpc64__
+typedef long long	__kernel_loff_t;
+#else
+#ifdef __GNUC__
+typedef long long	__kernel_loff_t;
+#endif
+#endif
+
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+
+#ifndef __GNUC__
+
+#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
+#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
+#define	__FD_ISSET(d, set)	(((set)->fds_bits[__FDELT(d)] & __FDMASK(d)) != 0)
+#define	__FD_ZERO(set)	\
+  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
+
+#else /* __GNUC__ */
+
+#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) \
+    || (__GLIBC__ == 2 && __GLIBC_MINOR__ == 0)
+/* With GNU C, use inline functions instead so args are evaluated only once: */
+
+#undef __FD_SET
+static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
+}
+
+#undef __FD_CLR
+static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
+}
+
+#undef __FD_ISSET
+static __inline__ int __FD_ISSET(unsigned long fd, __kernel_fd_set *p)
+{ 
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
+}
+
+/*
+ * This will unroll the loop for the normal constant case (8 ints,
+ * for a 256-bit fd_set)
+ */
+#undef __FD_ZERO
+static __inline__ void __FD_ZERO(__kernel_fd_set *p)
+{
+	unsigned long *tmp = (unsigned long *)p->fds_bits;
+	int i;
+
+	if (__builtin_constant_p(__FDSET_LONGS)) {
+		switch (__FDSET_LONGS) {
+		      case 16:
+			tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+
+		      case 8:
+			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+
+		      case 4:
+			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			return;
+		}
+	}
+	i = __FDSET_LONGS;
+	while (i) {
+		i--;
+		*tmp = 0;
+		tmp++;
+	}
+}
+
+#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
+#endif /* __GNUC__ */
+#endif /* _ASM_POWERPC_POSIX_TYPES_H */
diff --git a/include/asm-ppc/posix_types.h b/include/asm-ppc/posix_types.h
deleted file mode 100644
--- a/include/asm-ppc/posix_types.h
+++ /dev/null
@@ -1,111 +0,0 @@
-#ifndef _PPC_POSIX_TYPES_H
-#define _PPC_POSIX_TYPES_H
-
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
-typedef unsigned long	__kernel_ino_t;
-typedef unsigned int	__kernel_mode_t;
-typedef unsigned short	__kernel_nlink_t;
-typedef long		__kernel_off_t;
-typedef int		__kernel_pid_t;
-typedef unsigned int	__kernel_uid_t;
-typedef unsigned int	__kernel_gid_t;
-typedef unsigned int	__kernel_size_t;
-typedef int		__kernel_ssize_t;
-typedef long		__kernel_ptrdiff_t;
-typedef long		__kernel_time_t;
-typedef long		__kernel_suseconds_t;
-typedef long		__kernel_clock_t;
-typedef int		__kernel_timer_t;
-typedef int		__kernel_clockid_t;
-typedef int		__kernel_daddr_t;
-typedef char *		__kernel_caddr_t;
-typedef short             __kernel_ipc_pid_t;
-typedef unsigned short	__kernel_uid16_t;
-typedef unsigned short	__kernel_gid16_t;
-typedef unsigned int	__kernel_uid32_t;
-typedef unsigned int	__kernel_gid32_t;
-
-typedef unsigned int	__kernel_old_uid_t;
-typedef unsigned int	__kernel_old_gid_t;
-typedef unsigned int	__kernel_old_dev_t;
-
-#ifdef __GNUC__
-typedef long long	__kernel_loff_t;
-#endif
-
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
-#ifndef __GNUC__
-
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-#define	__FD_ISSET(d, set)	((set)->fds_bits[__FDELT(d)] & __FDMASK(d))
-#define	__FD_ZERO(set)	\
-  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
-
-#else /* __GNUC__ */
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) \
-    || (__GLIBC__ == 2 && __GLIBC_MINOR__ == 0)
-/* With GNU C, use inline functions instead so args are evaluated only once: */
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __kernel_fd_set *p)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned int *tmp = (unsigned int *)p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 8:
-				tmp[0] = 0; tmp[1] = 0; tmp[2] = 0; tmp[3] = 0;
-				tmp[4] = 0; tmp[5] = 0; tmp[6] = 0; tmp[7] = 0;
-				return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-#endif /* __GNUC__ */
-#endif /* _PPC_POSIX_TYPES_H */
diff --git a/include/asm-ppc64/posix_types.h b/include/asm-ppc64/posix_types.h
deleted file mode 100644
--- a/include/asm-ppc64/posix_types.h
+++ /dev/null
@@ -1,119 +0,0 @@
-#ifndef _PPC64_POSIX_TYPES_H
-#define _PPC64_POSIX_TYPES_H
-
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-typedef unsigned long	__kernel_ino_t;
-typedef unsigned long  	__kernel_nlink_t;
-typedef unsigned int	__kernel_mode_t;
-typedef long		__kernel_off_t;
-typedef long long	__kernel_loff_t;
-typedef int		__kernel_pid_t;
-typedef int             __kernel_ipc_pid_t;
-typedef unsigned int	__kernel_uid_t;
-typedef unsigned int	__kernel_gid_t;
-typedef unsigned long	__kernel_size_t;
-typedef long		__kernel_ssize_t;
-typedef long		__kernel_ptrdiff_t;
-typedef long		__kernel_time_t;
-typedef int		__kernel_timer_t;
-typedef int		__kernel_clockid_t;
-typedef long		__kernel_suseconds_t;
-typedef long		__kernel_clock_t;
-typedef int		__kernel_daddr_t;
-typedef char *		__kernel_caddr_t;
-typedef unsigned short	__kernel_uid16_t;
-typedef unsigned short	__kernel_gid16_t;
-typedef unsigned int	__kernel_uid32_t;
-typedef unsigned int	__kernel_gid32_t;
-
-typedef unsigned int	__kernel_old_uid_t;
-typedef unsigned int	__kernel_old_gid_t;
-typedef unsigned long	__kernel_old_dev_t;
-
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
-#ifndef __GNUC__
-
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-#define	__FD_ISSET(d, set)	(((set)->fds_bits[__FDELT(d)] & __FDMASK(d)) != 0)
-#define	__FD_ZERO(set)	\
-  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
-
-#else /* __GNUC__ */
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) \
-    || (__GLIBC__ == 2 && __GLIBC_MINOR__ == 0)
-/* With GNU C, use inline functions instead so args are evaluated only once: */
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = (unsigned long *)p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		      case 16:
-			tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-
-		      case 8:
-			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-
-		      case 4:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-#endif /* __GNUC__ */
-#endif /* _PPC64_POSIX_TYPES_H */
