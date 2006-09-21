Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 21 Sep 2006 16:48:40 +1000
Subject: [PATCH] Use __builtin_trap() to indicate that BUG() never returns
Message-Id: <20060921064840.9F31367BB8@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

By using __builtin_trap() in BUG() we tell the compiler that we
don't expect the code below to be executed, and in certain circumstances
this allows the compiler to elide that code altogether.

In fact it works so well that we have to put the bug section stuff
before the __builtin_trap() or else it isn't generated at all.

Tested on P5 LPAR, line numbers etc. all OK.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/bug.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: to-merge/include/asm-powerpc/bug.h
===================================================================
--- to-merge.orig/include/asm-powerpc/bug.h
+++ to-merge/include/asm-powerpc/bug.h
@@ -37,12 +37,13 @@ struct bug_entry *find_bug(unsigned long
  */
 
 #define BUG() do {							 \
-	__asm__ __volatile__(						 \
-		"1:	twi 31,0,0\n"					 \
+       __asm__ __volatile__(                                            \
 		".section __bug_table,\"a\"\n"				 \
-		"\t"PPC_LONG"	1b,%0,%1,%2\n"				 \
-		".previous"						 \
+		"\t"PPC_LONG"	1f,%0,%1,%2\n"				 \
+		".previous\n"						 \
+                "1:     "                                           \
 		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
+       __builtin_trap();                                                \
 } while (0)
 
 #define BUG_ON(x) do {						\
