Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GD12006@kryten>
Message-Id: <20090222115332.041708631@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:00 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 03/10] powerpc: Rearrange mmap.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rearrange mmap.c to better match the x86 version.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/mmap.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/mmap.c	2009-02-20 13:40:26.000000000 +1100
+++ linux-2.6/arch/powerpc/mm/mmap.c	2009-02-20 13:41:06.000000000 +1100
@@ -34,6 +34,17 @@
 #define MIN_GAP (128*1024*1024)
 #define MAX_GAP (TASK_SIZE/6*5)
 
+static inline int mmap_is_legacy(void)
+{
+	if (current->personality & ADDR_COMPAT_LAYOUT)
+		return 1;
+
+	if (current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY)
+		return 1;
+
+	return sysctl_legacy_va_layout;
+}
+
 static inline unsigned long mmap_base(void)
 {
 	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
@@ -46,17 +57,6 @@
 	return TASK_SIZE - (gap & PAGE_MASK);
 }
 
-static inline int mmap_is_legacy(void)
-{
-	if (current->personality & ADDR_COMPAT_LAYOUT)
-		return 1;
-
-	if (current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY)
-		return 1;
-
-	return sysctl_legacy_va_layout;
-}
-
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:

-- 
