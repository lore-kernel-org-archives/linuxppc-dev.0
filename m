Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GF12006@kryten>
Message-Id: <20090222115332.289241697@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:02 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 05/10] powerpc: More stack randomisation for 64bit binaries
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At the moment we randomise the stack by 8MB on 32bit and 64bit tasks. Since we
have a lot more address space to play with on 64bit, lets do what x86 does and
increase that randomisation to 1GB:

before:
# for i in seq `1 10` ; do sleep 1 & cat /proc/${!}/maps | grep stack; done
fffffebc000-fffffed1000 rw-p ffffffeb000 00:00 0       [stack]           
ffffff5a000-ffffff6f000 rw-p ffffffeb000 00:00 0       [stack]           
fffffdb2000-fffffdc7000 rw-p ffffffeb000 00:00 0       [stack]           
fffffd3e000-fffffd53000 rw-p ffffffeb000 00:00 0       [stack]           
fffffad9000-fffffaee000 rw-p ffffffeb000 00:00 0       [stack]           

after:
# for i in seq `1 10` ; do sleep 1 & cat /proc/${!}/maps | grep stack; done
ffff5c27000-ffff5c3c000 rw-p ffffffeb000 00:00 0       [stack]
fffebe5e000-fffebe73000 rw-p ffffffeb000 00:00 0       [stack]
fffcb298000-fffcb2ad000 rw-p ffffffeb000 00:00 0       [stack]
fffc719d000-fffc71b2000 rw-p ffffffeb000 00:00 0       [stack]
fffe01af000-fffe01c4000 rw-p ffffffeb000 00:00 0       [stack]

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/elf.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/elf.h	2009-02-20 13:39:05.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/elf.h	2009-02-20 13:51:20.000000000 +1100
@@ -270,6 +270,11 @@
 				       int uses_interp);
 #define VDSO_AUX_ENT(a,b) NEW_AUX_ENT(a,b);
 
+/* 1GB for 64bit, 8MB for 32bit */
+#define STACK_RND_MASK (is_32bit_task() ? \
+	(0x7ff >> (PAGE_SHIFT - 12)) : \
+	(0x3ffff >> (PAGE_SHIFT - 12)))
+
 #endif /* __KERNEL__ */
 
 /*

-- 
