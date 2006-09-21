Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 589E067BB1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 14:55:35 +1000 (EST)
Date: Thu, 21 Sep 2006 14:55:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] mark BUG() as noreturn
Message-Id: <20060921145522.366a3b03.sfr@canb.auug.org.au>
In-Reply-To: <1158798041.7062.4.camel@localhost.localdomain>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From an idea from Michael Ellerman.

We finish the BUG() macro with a call to a function marked with attribute
"noreturn" so that the compiler will know that BUG() and BUG_ON()
(with a constant, non-zero argument) will not return.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/bug.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/bug.h b/include/asm-powerpc/bug.h
index f44b529..cf5c460 100644
--- a/include/asm-powerpc/bug.h
+++ b/include/asm-powerpc/bug.h
@@ -31,6 +31,16 @@ #define BUG_WARNING_TRAP	0x1000000
 #ifdef CONFIG_BUG
 
 /*
+ * This is so that we can tell the compiler that BUG() and
+ * BUG_ON() with a constant non-zero argument does not return.
+ */
+static inline void __attribute__((noreturn)) __bug_does_not_return(void)
+{
+	while (1)
+		/* do nothing */;
+}
+
+/*
  * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
  * optimisations. However depending on the complexity of the condition
  * some compiler versions may not produce optimal results.
@@ -43,6 +53,7 @@ #define BUG() do {							 \
 		"\t"PPC_LONG"	1b,%0,%1,%2\n"				 \
 		".previous"						 \
 		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
+		__bug_does_not_return();				 \
 } while (0)
 
 #define BUG_ON(x) do {						\
-- 
1.4.2.1
