Date: Mon, 11 Feb 2002 05:01:14 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Nathan Scott <nathans@sgi.com>, linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Extended attributes syscalls for powerpc (updated, re-send)
Message-ID: <20020211050114.G20789@plato.local.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/Zw+/jwnNHcBRYYu"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

This is a re-send of an updated patch for extended attributes syscall
allocation for powerpc, Linus has added a syscall (tkill) to the
powerpc arch in 2.5.4 so my patch had to be adjusted and the
allocation has changed.  Since Linus appears to randomly keep powerpc
syscalls in sync with other architectures I believe it is imperative
that this patch be sent along to him ASAP so we don't have to keep
reallocating these syscalls and thus breaking userspace along the way.

Linus has merged the Extended attributes API from Andreas Gruenbacher
and Nathan Scott (SGI) into 2.5.3, and added the i386 syscalls.

By request of Nathan I have created the attached patch to add the
syscalls to the powerpc arch.

This patch allocates syscalls 209-220, if you have no problems with
this allocation could you merge this patch with the powerpc 2.5
kernel tree?  The sooner this can happen the better as Nathan is
working on getting the userspace utilities fixed to use the official
API and official syscall numbers, therefore we need the powerpc
syscall numbers reserved ASAP so the userspace utilities can support
the powerpc architecture.

TIA

This patch, and a version against the Linus 2.5.4 tree is also
available at:

http://penguinppc.org/~eb/files/ppc-xattr-syscalls-linus.diff (Linus tree (2.5.4))
http://penguinppc.org/~eb/files/ppc-xattr-syscalls.diff (linuxppc_2_5 tree (2.5.4-pre2))

--
Ethan Benson
http://www.alaska.net/~erbenson/

--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc-xattr-syscalls.diff"

diff -urN linux-2.5.4-ppc.orig/arch/ppc/kernel/misc.S linux-2.5.4-ppc/arch/ppc/kernel/misc.S
--- linux-2.5.4-ppc.orig/arch/ppc/kernel/misc.S	Thu Feb  7 09:09:17 2002
+++ linux-2.5.4-ppc/arch/ppc/kernel/misc.S	Mon Feb 11 04:48:01 2002
@@ -1231,6 +1231,18 @@
 	.long sys_mincore
 	.long sys_gettid
 	.long sys_tkill
+	.long sys_setxattr
+	.long sys_lsetxattr	/* 210 */
+	.long sys_fsetxattr
+	.long sys_getxattr
+	.long sys_lgetxattr
+	.long sys_fgetxattr
+	.long sys_listxattr	/* 215 */
+	.long sys_llistxattr
+	.long sys_flistxattr
+	.long sys_removexattr
+	.long sys_lremovexattr
+	.long sys_fremovexattr	/* 220 */
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -urN linux-2.5.4-ppc.orig/include/asm-ppc/unistd.h linux-2.5.4-ppc/include/asm-ppc/unistd.h
--- linux-2.5.4-ppc.orig/include/asm-ppc/unistd.h	Thu Feb  7 09:08:40 2002
+++ linux-2.5.4-ppc/include/asm-ppc/unistd.h	Mon Feb 11 04:48:01 2002
@@ -216,6 +216,18 @@
 #define __NR_mincore		206
 #define __NR_gettid		207
 #define __NR_tkill		208
+#define __NR_setxattr		209
+#define __NR_lsetxattr		210
+#define __NR_fsetxattr		211
+#define __NR_getxattr		212
+#define __NR_lgetxattr		213
+#define __NR_fgetxattr		214
+#define __NR_listxattr		215
+#define __NR_llistxattr		216
+#define __NR_flistxattr		217
+#define __NR_removexattr	218
+#define __NR_lremovexattr	219
+#define __NR_fremovexattr	220

 #define __NR(n)	#n


--/Zw+/jwnNHcBRYYu--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
