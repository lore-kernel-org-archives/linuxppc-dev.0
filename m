Date: Wed, 23 Oct 2002 17:24:16 -0500 (CDT)
Message-Id: <200210232224.g9NMO5n04849@postal.somerset.sps.mot.com>
From: Ed Swarthout <Ed.Swarthout@Motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: syscall register clobber list
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


asm-ppc/unistd.h is sloppy with the register clobber list for some of
the _syscallX macros.  gcc with this fix:

   http://gcc.gnu.org/ml/gcc/2002-09/msg00741.html

will issue a bunch of error messages like this:

  include/asm/unistd.h:439: error:
  asm-specifier for variable `__sc_4' conflicts with asm clobber list

Here's a patch:

Index: unistd.h
===================================================================
RCS file: /cvsroot/linuxppc/linuxppc_2_4_devel/include/asm-ppc/unistd.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 unistd.h
--- unistd.h	2002/09/14 05:22:43	1.1.1.2
+++ unistd.h	2002/10/23 21:56:45
@@ -249,8 +249,16 @@
 	return (__sc_err & 0x10000000 ? errno = __sc_ret, __sc_ret = -1 : 0), \
 	       (type) __sc_ret

-#define __syscall_clobbers \
+#define __syscall_clobbers_4_12 \
 	"r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12"
+#define __syscall_clobbers_5_12 \
+	"r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12"
+#define __syscall_clobbers_6_12 \
+	"r6", "r7", "r8", "r9", "r10", "r11", "r12"
+#define __syscall_clobbers_7_12 \
+	"r7", "r8", "r9", "r10", "r11", "r12"
+#define __syscall_clobbers_8_12 \
+	"r8", "r9", "r10", "r11", "r12"

 #define _syscall0(type,name)						\
 type name(void)								\
@@ -266,7 +274,7 @@
 			 "mfcr %1      "				\
 			: "=&r" (__sc_3), "=&r" (__sc_0)		\
 			: "0"   (__sc_3), "1"   (__sc_0)		\
-			: __syscall_clobbers);				\
+			: __syscall_clobbers_4_12);		       	\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
@@ -288,7 +296,7 @@
 			 "mfcr %1      "				\
 			: "=&r" (__sc_3), "=&r" (__sc_0)		\
 			: "0"   (__sc_3), "1"   (__sc_0)		\
-			: __syscall_clobbers);				\
+			: __syscall_clobbers_4_12);			\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
@@ -313,7 +321,7 @@
 			: "=&r" (__sc_3), "=&r" (__sc_0)		\
 			: "0"   (__sc_3), "1"   (__sc_0),		\
 			  "r"   (__sc_4)				\
-			: __syscall_clobbers);				\
+			: __syscall_clobbers_5_12);			\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
@@ -341,7 +349,7 @@
 			: "0"   (__sc_3), "1"   (__sc_0),		\
 			  "r"   (__sc_4),				\
 			  "r"   (__sc_5)				\
-			: __syscall_clobbers);				\
+			: __syscall_clobbers_6_12);			\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
@@ -372,7 +380,7 @@
 			  "r"   (__sc_4),				\
 			  "r"   (__sc_5),				\
 			  "r"   (__sc_6)				\
-			: __syscall_clobbers);				\
+			: __syscall_clobbers_7_12);			\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
@@ -406,7 +414,7 @@
 			  "r"   (__sc_5),				\
 			  "r"   (__sc_6),				\
 			  "r"   (__sc_7)				\
-			: __syscall_clobbers);				\
+			: __syscall_clobbers_8_12);			\
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
