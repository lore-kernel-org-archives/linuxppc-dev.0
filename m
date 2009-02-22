Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GE12006@kryten>
Message-Id: <20090222115332.173898755@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:01 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 04/10] powerpc: Randomise mmap start address
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randomise mmap start address - 8MB on 32bit and 1GB on 64bit tasks.
Until ppc32 uses the mmap.c functionality, this is ppc64 specific.

Before:

# ./test & cat /proc/${!}/maps|tail -2|head -1
f75fe000-f7fff000 rw-p f75fe000 00:00 0
f75fe000-f7fff000 rw-p f75fe000 00:00 0
f75fe000-f7fff000 rw-p f75fe000 00:00 0
f75fe000-f7fff000 rw-p f75fe000 00:00 0
f75fe000-f7fff000 rw-p f75fe000 00:00 0

After:
# ./test & cat /proc/${!}/maps|tail -2|head -1
f718b000-f7b8c000 rw-p f718b000 00:00 0
f7551000-f7f52000 rw-p f7551000 00:00 0
f6ee7000-f78e8000 rw-p f6ee7000 00:00 0
f74d4000-f7ed5000 rw-p f74d4000 00:00 0
f6e9d000-f789e000 rw-p f6e9d000 00:00 0

Similar for 64bit, but with 1GB of scatter:
# ./test & cat /proc/${!}/maps|tail -2|head -1
fffb97b5000-fffb97b6000 rw-p fffb97b5000 00:00 0
fffce9a3000-fffce9a4000 rw-p fffce9a3000 00:00 0
fffeaaf2000-fffeaaf3000 rw-p fffeaaf2000 00:00 0
fffd88ac000-fffd88ad000 rw-p fffd88ac000 00:00 0
fffbc62e000-fffbc62f000 rw-p fffbc62e000 00:00 0

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/mmap.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/mmap.c	2009-02-20 13:46:35.000000000 +1100
+++ linux-2.6/arch/powerpc/mm/mmap.c	2009-02-20 13:47:23.000000000 +1100
@@ -24,6 +24,7 @@
 
 #include <linux/personality.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 
 /*
@@ -45,6 +46,20 @@
 	return sysctl_legacy_va_layout;
 }
 
+static unsigned long mmap_rnd(void)
+{
+	unsigned long rnd = 0;
+
+	if (current->flags & PF_RANDOMIZE) {
+		/* 8MB for 32bit, 1GB for 64bit */
+		if (is_32bit_task())
+			rnd = (long)(get_random_int() % (1<<(23-PAGE_SHIFT)));
+		else
+			rnd = (long)(get_random_int() % (1<<(30-PAGE_SHIFT)));
+	}
+	return rnd << PAGE_SHIFT;
+}
+
 static inline unsigned long mmap_base(void)
 {
 	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
@@ -54,7 +69,7 @@
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
 }
 
 /*

-- 
