Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11F4368660
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 02:17:22 +1100 (EST)
Date: Tue, 1 Nov 2005 15:17:16 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20051101151716.GY7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc bug.h namespace pollution
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	DATA_TYPE is really not a good thing to put into header that
gets included all over the tree...
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/include/asm-powerpc/bug.h current/include/asm-powerpc/bug.h
--- RC14-base/include/asm-powerpc/bug.h	2005-11-01 02:39:50.000000000 -0500
+++ current/include/asm-powerpc/bug.h	2005-11-01 04:50:01.000000000 -0500
@@ -15,12 +15,12 @@
 #define BUG_TABLE_ENTRY(label, line, file, func) \
 	".llong " #label "\n .long " #line "\n .llong " #file ", " #func "\n"
 #define TRAP_OP(ra, rb) "1: tdnei " #ra ", " #rb "\n"
-#define DATA_TYPE long long
+#define BUG_DATA_TYPE long long
 #else 
 #define BUG_TABLE_ENTRY(label, line, file, func) \
 	".long " #label ", " #line ", " #file ", " #func "\n"
 #define TRAP_OP(ra, rb) "1: twnei " #ra ", " #rb "\n"
-#define DATA_TYPE int
+#define BUG_DATA_TYPE int
 #endif /* __powerpc64__ */
 
 struct bug_entry {
@@ -55,7 +55,7 @@
 		".section __bug_table,\"a\"\n\t"		\
 		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
 		".previous"					\
-		: : "r" ((DATA_TYPE)(x)), "i" (__LINE__),	\
+		: : "r" ((BUG_DATA_TYPE)(x)), "i" (__LINE__),	\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
@@ -65,7 +65,7 @@
 		".section __bug_table,\"a\"\n\t"		\
 		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
 		".previous"					\
-		: : "r" ((DATA_TYPE)(x)),			\
+		: : "r" ((BUG_DATA_TYPE)(x)),			\
 		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
