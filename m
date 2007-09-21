Return-Path: <tyrlik@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 918E3DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 01:26:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8LFQ8Ir019648
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 11:26:08 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8LFQ8Q1498528
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 09:26:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8LFQ7T2024175
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 09:26:07 -0600
Received: from d03nm126.boulder.ibm.com (d03nm126.boulder.ibm.com
	[9.17.195.152])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l8LFQ7DL024158
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 09:26:07 -0600
Subject: DTC Patch for Cygwin
To: linuxppc-dev@ozlabs.org
Message-ID: <OF485FF693.8CDC7B13-ON8525735D.00541A51-8525735D.0054C8B8@us.ibm.com>
From: Matt Tyrlik <tyrlik@us.ibm.com>
Date: Fri, 21 Sep 2007 11:26:04 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0ABBF9CEDFC79CC18f9e8a93df938690918c0ABBF9CEDFC79CC1"
Cc: dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=0ABBF9CEDFC79CC18f9e8a93df938690918c0ABBF9CEDFC79CC1
Content-type: text/plain; charset=US-ASCII


Changes required to compile DTC under Cygwin

===================================================================
--- dtc-org.orig/tests/supernode_atdepth_offset.c
+++ dtc-org/tests/supernode_atdepth_offset.c
@@ -63,8 +63,11 @@ int path_prefix(const char *path, int de
                return 1;

        p = path;
-       for (i = 0; i < depth; i++)
-               p = strchrnul(p+1, '/');
+       for (i = 0; i < depth; i++) {
+               p = strchr(p+1, '/');
+               if (!p)
+                       p = path + strlen(path);
+       }

        return p - path;
 }
Index: dtc-org/tests/testutils.c
===================================================================
--- dtc-org.orig/tests/testutils.c
+++ dtc-org/tests/testutils.c
@@ -52,10 +52,9 @@ static void sigint_handler(int signum, s
 void test_init(int argc, char *argv[])
 {
        int err;
-       struct sigaction sa_int = {
-               .sa_sigaction = sigint_handler,
-       };
+       struct sigaction sa_int;

+       sa_int.sa_sigaction = sigint_handler,
        test_name = argv[0];

        err = sigaction(SIGINT, &sa_int, NULL);
Index: dtc-org/tests/trees.S
===================================================================
--- dtc-org.orig/tests/trees.S
+++ dtc-org/tests/trees.S
@@ -17,10 +17,16 @@
        .byte   ((val) >> 8) & 0xff ; \
        .byte   (val) & 0xff

+#ifdef __CYGWIN__
+#define TREE_SYMBOL(tree)      __##tree
+#else
+#define TREE_SYMBOL(tree)      _##tree
+#endif
+
 #define TREE_HDR(tree) \
        .balign 4               ; \
-       .globl  _##tree         ; \
-_##tree:       \
+       .globl TREE_SYMBOL(tree); \
+TREE_SYMBOL(tree):     \
 tree:  \
        FDTLONG(FDT_MAGIC)      ; \
        FDTLONG(tree##_end - tree) ; \
Index: dtc-org/tests/tests.h
===================================================================
--- dtc-org.orig/tests/tests.h
+++ dtc-org/tests/tests.h
@@ -130,4 +130,15 @@ const void *check_getprop(void *fdt, int
 void *load_blob_arg(int argc, char *argv[]);
 void save_blob(const char *filename, void *blob);

+#ifndef GLIBC
+#define strndupa(my_str, my_len) \
+       ({ \
+               char *new_str=alloca((my_len) + 1); \
+               strncpy(new_str, my_str, my_len); \
+               new_str[my_len]='\0'; \
+               new_str; \
+       })
+
+#endif
+
 #endif /* _TESTS_H */


Matt Tyrlik
--0__=0ABBF9CEDFC79CC18f9e8a93df938690918c0ABBF9CEDFC79CC1
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>Changes required to compile DTC under Cygwin<br>
<br>
<tt>===================================================================</tt><br>
<tt>--- dtc-org.orig/tests/supernode_atdepth_offset.c</tt><br>
<tt>+++ dtc-org/tests/supernode_atdepth_offset.c</tt><br>
<tt>@@ -63,8 +63,11 @@ int path_prefix(const char *path, int de</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 1;</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; p = path;</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; for (i = 0; i &lt; depth; i++)</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p = strchrnul(p+1, '/');</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; for (i = 0; i &lt; depth; i++) {</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p = strchr(p+1, '/');</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!p)</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p = path + strlen(path);</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; }</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; return p - path;</tt><br>
<tt>&nbsp;}</tt><br>
<tt>Index: dtc-org/tests/testutils.c</tt><br>
<tt>===================================================================</tt><br>
<tt>--- dtc-org.orig/tests/testutils.c</tt><br>
<tt>+++ dtc-org/tests/testutils.c</tt><br>
<tt>@@ -52,10 +52,9 @@ static void sigint_handler(int signum, s</tt><br>
<tt>&nbsp;void test_init(int argc, char *argv[])</tt><br>
<tt>&nbsp;{</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; int err;</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; struct sigaction sa_int = {</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .sa_sigaction = sigint_handler,</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; };</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; struct sigaction sa_int;</tt><br>
<br>
<tt>+ &nbsp; &nbsp; &nbsp; sa_int.sa_sigaction = sigint_handler,</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; test_name = argv[0];</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; err = sigaction(SIGINT, &amp;sa_int, NULL);</tt><br>
<tt>Index: dtc-org/tests/trees.S</tt><br>
<tt>===================================================================</tt><br>
<tt>--- dtc-org.orig/tests/trees.S</tt><br>
<tt>+++ dtc-org/tests/trees.S</tt><br>
<tt>@@ -17,10 +17,16 @@</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; .byte &nbsp; ((val) &gt;&gt; 8) &amp; 0xff ; \</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; .byte &nbsp; (val) &amp; 0xff</tt><br>
<br>
<tt>+#ifdef __CYGWIN__</tt><br>
<tt>+#define TREE_SYMBOL(tree) &nbsp; &nbsp; &nbsp;__##tree</tt><br>
<tt>+#else</tt><br>
<tt>+#define TREE_SYMBOL(tree) &nbsp; &nbsp; &nbsp;_##tree</tt><br>
<tt>+#endif</tt><br>
<tt>+</tt><br>
<tt>&nbsp;#define TREE_HDR(tree) \</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; .balign 4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ; \</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; .globl &nbsp;_##tree &nbsp; &nbsp; &nbsp; &nbsp; ; \</tt><br>
<tt>-_##tree: &nbsp; &nbsp; &nbsp; \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; .globl TREE_SYMBOL(tree); \</tt><br>
<tt>+TREE_SYMBOL(tree): &nbsp; &nbsp; \</tt><br>
<tt>&nbsp;tree: &nbsp;\</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; FDTLONG(FDT_MAGIC) &nbsp; &nbsp; &nbsp;; \</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; FDTLONG(tree##_end - tree) ; \</tt><br>
<tt>Index: dtc-org/tests/tests.h</tt><br>
<tt>===================================================================</tt><br>
<tt>--- dtc-org.orig/tests/tests.h</tt><br>
<tt>+++ dtc-org/tests/tests.h</tt><br>
<tt>@@ -130,4 +130,15 @@ const void *check_getprop(void *fdt, int</tt><br>
<tt>&nbsp;void *load_blob_arg(int argc, char *argv[]);</tt><br>
<tt>&nbsp;void save_blob(const char *filename, void *blob);</tt><br>
<br>
<tt>+#ifndef GLIBC</tt><br>
<tt>+#define strndupa(my_str, my_len) \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; ({ \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char *new_str=alloca((my_len) + 1); \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; strncpy(new_str, my_str, my_len); \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new_str[my_len]='\0'; \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new_str; \</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; })</tt><br>
<tt>+</tt><br>
<tt>+#endif</tt><br>
<tt>+</tt><br>
<tt>&nbsp;#endif /* _TESTS_H */</tt><br>
<br>
<br>
Matt Tyrlik </body></html>
--0__=0ABBF9CEDFC79CC18f9e8a93df938690918c0ABBF9CEDFC79CC1--
