Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 5D5C5100A3D
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:47 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 5/8] Share ppc64 and ppc32 code where possible
Message-ID: <20091127223345.GE21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* runtime/copy.c: Can use ppc64's code.
* runtime/regs.h: Ditto.
* runtime/string.h: Ditto.
* tapset/context.stp: Ditto.
* tapset/errno.stp: Ditto.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/copy.c     |    2 +-
 runtime/regs.h     |    2 +-
 runtime/string.h   |    6 +++---
 tapset/context.stp |    2 +-
 tapset/errno.stp   |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/runtime/copy.c b/runtime/copy.c
index 4fb8725..40f1511 100644
--- a/runtime/copy.c
+++ b/runtime/copy.c
@@ -105,7 +105,7 @@ do {									   \
 		: "i"(-EFAULT), "0"(count), "1"(count), "3"(src), "4"(dst) \
 		: "memory");						   \
 } while (0)
-#elif defined (__powerpc64__) || defined (__ia64__) || defined (__arm__)
+#elif defined (__powerpc__) || defined (__ia64__) || defined (__arm__)
 #define __stp_strncpy_from_user(dst,src,count,res) \
 	do { res = __strncpy_from_user(dst, src, count); } while(0)
 
diff --git a/runtime/regs.h b/runtime/regs.h
index dc6b50a..08449aa 100644
--- a/runtime/regs.h
+++ b/runtime/regs.h
@@ -36,7 +36,7 @@
   (((regs)->cr_iip = (x) & ~3UL), (ia64_psr(regs)->ri = (x) & 3UL))
 
 
-#elif defined (__powerpc64__)
+#elif defined (__powerpc__)
 
 #define REG_IP(regs) regs->nip
 #define REG_SP(regs) regs->gpr[1]
diff --git a/runtime/string.h b/runtime/string.h
index f4d4cc0..b08304e 100644
--- a/runtime/string.h
+++ b/runtime/string.h
@@ -19,14 +19,14 @@ static void _stp_text_str(char *out, char *in, int len, int quoted, int user);
  * is provided without the paranoid check. Use it if available, fall back
  * to __get_user() if not. Other archs can use __get_user() as is
  */
-#ifdef __powerpc64__
+#if defined(__powerpc__)
 #ifdef __get_user_inatomic
 #define __stp_get_user(x, ptr) __get_user_inatomic(x, ptr)
 #else /* __get_user_inatomic */
 #define __stp_get_user(x, ptr) __get_user(x, ptr)
 #endif /* __get_user_inatomic */
-#else /* __powerpc64__ */
+#else /* defined(__powerpc__) */
 #define __stp_get_user(x, ptr) __get_user(x, ptr)
-#endif /* __powerpc64__ */
+#endif /* defined(__powerpc__) */
 
 #endif /* _STRING_H_ */
diff --git a/tapset/context.stp b/tapset/context.stp
index 36701e6..b30f7dc 100644
--- a/tapset/context.stp
+++ b/tapset/context.stp
@@ -15,7 +15,7 @@
 %{
 #include <asm/processor.h>
 
-#if defined(__powerpc64__)
+#if defined(__powerpc__)
 #if !defined(task_pt_regs)
 #define task_pt_regs(tsk)       ((struct pt_regs *)(tsk)->thread.regs)
 #endif
diff --git a/tapset/errno.stp b/tapset/errno.stp
index 011ff7e..d4d571b 100644
--- a/tapset/errno.stp
+++ b/tapset/errno.stp
@@ -369,7 +369,7 @@ static long _stp_returnval(struct pt_regs *regs) {
 #elif defined (__x86_64__)
 		// TODO: Handle -m32 apps.
 		return regs->rax;
-#elif defined (__powerpc64__)
+#elif defined (__powerpc__)
 		return regs->gpr[3];
 #elif defined (__ia64__)
 		return regs->r8;
-- 
1.6.3.3
