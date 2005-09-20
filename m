Return-Path: <galak@freescale.com>
Date: Tue, 20 Sep 2005 16:33:54 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509201633190.24999@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: merge include/asm-ppc*/spinlock_types.h into
 include/asm-powerpc/spinlock_types.h[PATCH]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit cb3e61d8491f6395a007687d9908bdb20fc9a0b5
tree da0514335c8f2ed2a795d4bbc7db06cfa6f728d5
parent 40ec2534f42b5d38123c41858a3c85bc2eae272b
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 20 Sep 2005 16:27:51 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 20 Sep 2005 16:27:51 -0500

 include/asm-powerpc/spinlock_types.h |   20 ++++++++++++++++++++
 include/asm-ppc/spinlock_types.h     |   20 --------------------
 include/asm-ppc64/spinlock_types.h   |   20 --------------------
 3 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/include/asm-powerpc/spinlock_types.h b/include/asm-powerpc/spinlock_types.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/spinlock_types.h
@@ -0,0 +1,20 @@
+#ifndef _ASM_POWERPC_SPINLOCK_TYPES_H
+#define _ASM_POWERPC_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile signed int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff --git a/include/asm-ppc/spinlock_types.h b/include/asm-ppc/spinlock_types.h
deleted file mode 100644
--- a/include/asm-ppc/spinlock_types.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef __ASM_SPINLOCK_TYPES_H
-#define __ASM_SPINLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_H
-# error "please don't include this file directly"
-#endif
-
-typedef struct {
-	volatile unsigned long lock;
-} raw_spinlock_t;
-
-#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
-
-typedef struct {
-	volatile signed int lock;
-} raw_rwlock_t;
-
-#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif
diff --git a/include/asm-ppc64/spinlock_types.h b/include/asm-ppc64/spinlock_types.h
deleted file mode 100644
--- a/include/asm-ppc64/spinlock_types.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef __ASM_SPINLOCK_TYPES_H
-#define __ASM_SPINLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_H
-# error "please don't include this file directly"
-#endif
-
-typedef struct {
-	volatile unsigned int slock;
-} raw_spinlock_t;
-
-#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
-
-typedef struct {
-	volatile signed int lock;
-} raw_rwlock_t;
-
-#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif
