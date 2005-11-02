Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE0CB68670
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 14:10:47 +1100 (EST)
Date: Wed, 2 Nov 2005 03:10:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051102031043.GB7992@ftp.linux.org.uk>
References: <20051101151716.GY7992@ftp.linux.org.uk>
	<17256.10342.228209.745529@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17256.10342.228209.745529@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc bug.h namespace pollution
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 02, 2005 at 01:45:58PM +1100, Paul Mackerras wrote:
> Al Viro writes:
> 
> > 	DATA_TYPE is really not a good thing to put into header that
> > gets included all over the tree...
> 
> Very true.  However, I don't see any reason why the cast shouldn't
> just be (long) on both 32-bit and 64-bit, so we can get rid of that
> define altogether.

Should be OK...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/include/asm-powerpc/bug.h current/include/asm-powerpc/bug.h
--- RC14-base/include/asm-powerpc/bug.h	2005-11-01 22:08:35.000000000 -0500
+++ current/include/asm-powerpc/bug.h	2005-11-01 22:09:28.000000000 -0500
@@ -15,12 +15,10 @@
 #define BUG_TABLE_ENTRY(label, line, file, func) \
 	".llong " #label "\n .long " #line "\n .llong " #file ", " #func "\n"
 #define TRAP_OP(ra, rb) "1: tdnei " #ra ", " #rb "\n"
-#define DATA_TYPE long long
 #else 
 #define BUG_TABLE_ENTRY(label, line, file, func) \
 	".long " #label ", " #line ", " #file ", " #func "\n"
 #define TRAP_OP(ra, rb) "1: twnei " #ra ", " #rb "\n"
-#define DATA_TYPE int
 #endif /* __powerpc64__ */
 
 struct bug_entry {
@@ -55,7 +53,7 @@
 		".section __bug_table,\"a\"\n\t"		\
 		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
 		".previous"					\
-		: : "r" ((DATA_TYPE)(x)), "i" (__LINE__),	\
+		: : "r" ((long)(x)), "i" (__LINE__),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
@@ -65,7 +63,7 @@
 		".section __bug_table,\"a\"\n\t"		\
 		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
 		".previous"					\
-		: : "r" ((DATA_TYPE)(x)),			\
+		: : "r" ((long)(x)),				\
 		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
