Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GH12006@kryten>
Message-Id: <20090222115332.546296226@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:04 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 07/10] powerpc: Randomise the brk region
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randomize the heap.

before:
tundro2:~ # sleep 1 & cat /proc/${!}/maps | grep heap
10017000-10118000 rw-p 10017000 00:00 0                                  [heap]
10017000-10118000 rw-p 10017000 00:00 0                                  [heap]
10017000-10118000 rw-p 10017000 00:00 0                                  [heap]
10017000-10118000 rw-p 10017000 00:00 0                                  [heap]
10017000-10118000 rw-p 10017000 00:00 0                                  [heap]


after
tundro2:~ # sleep 1 & cat /proc/${!}/maps | grep heap
19419000-1951a000 rw-p 19419000 00:00 0                                  [heap]
325ff000-32700000 rw-p 325ff000 00:00 0                                  [heap]
1a97c000-1aa7d000 rw-p 1a97c000 00:00 0                                  [heap]
1cc60000-1cd61000 rw-p 1cc60000 00:00 0                                  [heap]
1afa9000-1b0aa000 rw-p 1afa9000 00:00 0                                  [heap]

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/elf.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/elf.h	2009-02-20 16:06:32.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/elf.h	2009-02-22 11:58:02.000000000 +1100
@@ -275,6 +275,9 @@
 	(0x7ff >> (PAGE_SHIFT - 12)) : \
 	(0x3ffff >> (PAGE_SHIFT - 12)))
 
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+#define arch_randomize_brk arch_randomize_brk
+
 #endif /* __KERNEL__ */
 
 /*
Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2009-02-20 16:06:32.000000000 +1100
+++ linux-2.6/arch/powerpc/kernel/process.c	2009-02-22 11:58:02.000000000 +1100
@@ -1131,3 +1131,26 @@
 		sp -= get_random_int() & ~PAGE_MASK;
 	return sp & ~0xf;
 }
+
+static inline unsigned long brk_rnd(void)
+{
+        unsigned long rnd = 0;
+
+	/* 8MB for 32bit, 1GB for 64bit */
+	if (is_32bit_task())
+		rnd = (long)(get_random_int() % (1<<(23-PAGE_SHIFT)));
+	else
+		rnd = (long)(get_random_int() % (1<<(30-PAGE_SHIFT)));
+
+	return rnd << PAGE_SHIFT;
+}
+
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+	unsigned long ret = PAGE_ALIGN(mm->brk + brk_rnd());
+
+	if (ret < mm->brk)
+		return mm->brk;
+
+	return ret;
+}

-- 
