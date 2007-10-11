Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 63880DE09C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 03:09:20 +1000 (EST)
Resent-Message-ID: <20071011171441.GA11218@lixom.net>
Date: Thu, 11 Oct 2007 12:12:11 -0500
From: Olof Johansson <olof@lixom.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bug.h: Introduce HAVE_ARCH_WARN
Message-ID: <20071011171211.GB10877@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org, lethal@linux-sh.org, grundler@parisc-linux.org,
	kyle@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

HAVE_ARCH_WARN is used to determine if an arch already has a __WARN()
macro, or if a generic one is needed.

With this, some of the arch-specific WARN_ON() implementations can be
made common instead (see follow-up patch for powerpc).

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index d56fedb..c6b8386 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -31,14 +31,19 @@ struct bug_entry {
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while(0)
 #endif
 
+#ifndef HAVE_ARCH_WARN
+#define __WARN() do {							\
+	printk("WARNING: at %s:%d %s()\n", __FILE__,			\
+		__LINE__, __FUNCTION__);				\
+	dump_stack();							\
+} while (0)
+#endif
+
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on)) {					\
-		printk("WARNING: at %s:%d %s()\n", __FILE__,		\
-			__LINE__, __FUNCTION__);			\
-		dump_stack();						\
-	}								\
+	if (unlikely(__ret_warn_on))					\
+		__WARN();						\
 	unlikely(__ret_warn_on);					\
 })
 #endif
diff --git a/include/asm-parisc/bug.h b/include/asm-parisc/bug.h
index 8cfc553..3f68100 100644
--- a/include/asm-parisc/bug.h
+++ b/include/asm-parisc/bug.h
@@ -8,6 +8,7 @@
 
 #ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
+#define HAVE_ARCH_WARN
 #define HAVE_ARCH_WARN_ON
 
 /* the break instruction is used as BUG() marker.  */
diff --git a/include/asm-powerpc/bug.h b/include/asm-powerpc/bug.h
index e55d1f6..02e171c 100644
--- a/include/asm-powerpc/bug.h
+++ b/include/asm-powerpc/bug.h
@@ -110,6 +110,7 @@
 })
 
 #define HAVE_ARCH_BUG
+#define HAVE_ARCH_WARN
 #define HAVE_ARCH_BUG_ON
 #define HAVE_ARCH_WARN_ON
 #endif /* __ASSEMBLY __ */
diff --git a/include/asm-sh/bug.h b/include/asm-sh/bug.h
index a78d482..4ea415b 100644
--- a/include/asm-sh/bug.h
+++ b/include/asm-sh/bug.h
@@ -5,6 +5,7 @@
 
 #ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
+#define HAVE_ARCH_WARN
 #define HAVE_ARCH_WARN_ON
 
 /**
