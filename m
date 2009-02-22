Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GI12006@kryten>
Message-Id: <20090222115332.669493518@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:05 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 08/10] powerpc: Ensure random space between stack and mmaps
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

get_random_int() returns the same value within a 1 jiffy interval. This means
that the mmap and stack regions will almost always end up the same distance
apart, making a relative offset based attack possible.

To fix this, shift the randomness we use for the mmap region by 1 bit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/mmap.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/mmap.c	2009-02-22 11:58:54.000000000 +1100
+++ linux-2.6/arch/powerpc/mm/mmap.c	2009-02-22 12:05:01.000000000 +1100
@@ -46,6 +46,14 @@
 	return sysctl_legacy_va_layout;
 }
 
+/*
+ * Since get_random_int() returns the same value within a 1 jiffy window,
+ * we will almost always get the same randomisation for the stack and mmap
+ * region. This will mean the relative distance between stack and mmap will
+ * be the same.
+ *
+ * To avoid this we can shift the randomness by 1 bit.
+ */
 static unsigned long mmap_rnd(void)
 {
 	unsigned long rnd = 0;
@@ -53,11 +61,11 @@
 	if (current->flags & PF_RANDOMIZE) {
 		/* 8MB for 32bit, 1GB for 64bit */
 		if (is_32bit_task())
-			rnd = (long)(get_random_int() % (1<<(23-PAGE_SHIFT)));
+			rnd = (long)(get_random_int() % (1<<(22-PAGE_SHIFT)));
 		else
-			rnd = (long)(get_random_int() % (1<<(30-PAGE_SHIFT)));
+			rnd = (long)(get_random_int() % (1<<(29-PAGE_SHIFT)));
 	}
-	return rnd << PAGE_SHIFT;
+	return (rnd << PAGE_SHIFT) * 2;
 }
 
 static inline unsigned long mmap_base(void)

-- 
