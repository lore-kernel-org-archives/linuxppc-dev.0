Date: Fri, 1 Feb 2002 00:51:01 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Nathan Scott <nathans@sgi.com>, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Extended attributes syscalls for powerpc
Message-ID: <20020201005101.U14742@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

Linus has merged the Extended attributes API from Andreas Gruenbacher
and Nathan Scott (SGI) into 2.5.3, and added the i386 syscalls.

By request of Nathan I have created the attached patch to add the
syscalls to the powerpc arch.

This patch allocates syscalls 208-219, if you have no problems with
this allocation could you merge this patch with the powerpc 2.5
kernel tree?  The sooner this can happen the better as Nathan is
working on getting the userspace utilities fixed to use the official
API and official syscall numbers, therefore we need the powerpc
syscall numbers reserved ASAP so the userspace utilities can support
the powerpc architecture.

TIA

This patch, and a version against the Linus 2.5.3 tree is also
available at:

http://penguinppc.org/~eb/files/ppc-xattr-syscalls-linus.diff (Linus tree)
http://penguinppc.org/~eb/files/ppc-xattr-syscalls.diff (linuxppc_2_5 tree)

diff -urN linux-2.5.3-ppc.orig/arch/ppc/kernel/misc.S linux-2.5.3-ppc/arch/ppc/kernel/misc.S
--- linux-2.5.3-ppc.orig/arch/ppc/kernel/misc.S	Thu Jan 31 21:06:20 2002
+++ linux-2.5.3-ppc/arch/ppc/kernel/misc.S	Fri Feb  1 00:03:59 2002
@@ -1230,6 +1230,18 @@
 	.long sys_madvise	/* 205 */
 	.long sys_mincore
 	.long sys_gettid
+	.long sys_setxattr
+	.long sys_lsetxattr
+	.long sys_fsetxattr	/* 210 */
+	.long sys_getxattr
+	.long sys_lgetxattr
+	.long sys_fgetxattr
+	.long sys_listxattr
+	.long sys_llistxattr	/* 215 */
+	.long sys_flistxattr
+	.long sys_removexattr
+	.long sys_lremovexattr
+	.long sys_fremovexattr
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -urN linux-2.5.3-ppc.orig/include/asm-ppc/unistd.h linux-2.5.3-ppc/include/asm-ppc/unistd.h
--- linux-2.5.3-ppc.orig/include/asm-ppc/unistd.h	Thu Jan 31 21:05:44 2002
+++ linux-2.5.3-ppc/include/asm-ppc/unistd.h	Fri Feb  1 00:05:11 2002
@@ -215,6 +215,18 @@
 #define __NR_madvise		205
 #define __NR_mincore		206
 #define __NR_gettid		207
+#define __NR_setxattr		208
+#define __NR_lsetxattr		209
+#define __NR_fsetxattr		210
+#define __NR_getxattr		211
+#define __NR_lgetxattr		212
+#define __NR_fgetxattr		213
+#define __NR_listxattr		214
+#define __NR_llistxattr		215
+#define __NR_flistxattr		216
+#define __NR_removexattr	217
+#define __NR_lremovexattr	218
+#define __NR_fremovexattr	219

 #define __NR(n)	#n



--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
