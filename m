Return-Path: <anton@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CBFCCB7092
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 17:00:47 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95D94DDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 17:00:47 +1000 (EST)
Message-Id: <20090714065425.301516312@samba.org>
References: <20090714065350.659537380@samba.org>
Date: Tue, 14 Jul 2009 16:53:51 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [patch 1/3] powerpc: Move 64bit VDSO to improve context switch
	performance
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64bit applications the VDSO is the only thing in segment 0. Since the VDSO
is position independent we can remove the hint and let get_unmapped_area pick
an area. This will mean the vdso will be near other mmaps and will share
an SLB entry:

10000000-10001000 r-xp 00000000 08:06 5778459        /root/context_switch_64
10010000-10011000 r--p 00000000 08:06 5778459        /root/context_switch_64
10011000-10012000 rw-p 00001000 08:06 5778459        /root/context_switch_64
fffa92ae000-fffa92b0000 rw-p 00000000 00:00 0 
fffa92b0000-fffa9453000 r-xp 00000000 08:06 4334051  /lib64/power6/libc-2.9.so
fffa9453000-fffa9462000 ---p 001a3000 08:06 4334051  /lib64/power6/libc-2.9.so
fffa9462000-fffa9466000 r--p 001a2000 08:06 4334051  /lib64/power6/libc-2.9.so
fffa9466000-fffa947c000 rw-p 001a6000 08:06 4334051  /lib64/power6/libc-2.9.so
fffa947c000-fffa9480000 rw-p 00000000 00:00 0 
fffa9480000-fffa94a8000 r-xp 00000000 08:06 4333852  /lib64/ld-2.9.so
fffa94b3000-fffa94b4000 rw-p 00000000 00:00 0 

fffa94b4000-fffa94b7000 r-xp 00000000 00:00 0        [vdso] <----- here I am

fffa94b7000-fffa94b8000 r--p 00027000 08:06 4333852  /lib64/ld-2.9.so
fffa94b8000-fffa94bb000 rw-p 00028000 08:06 4333852  /lib64/ld-2.9.so
fffa94bb000-fffa94bc000 rw-p 00000000 00:00 0 
fffe4c10000-fffe4c25000 rw-p 00000000 00:00 0        [stack]

On a microbenchmark that bounces a token between two 64bit processes over pipes
and calls gettimeofday each iteration (to access the VDSO), our context switch
rate goes from 268k to 277k ctx switches/sec (tested on a 4GHz POWER6).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/include/asm/vdso.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/vdso.h	2009-07-14 11:41:52.000000000 +1000
+++ linux.trees.git/arch/powerpc/include/asm/vdso.h	2009-07-14 11:42:59.000000000 +1000
@@ -7,9 +7,8 @@
 #define VDSO32_LBASE	0x100000
 #define VDSO64_LBASE	0x100000
 
-/* Default map addresses */
+/* Default map addresses for 32bit vDSO */
 #define VDSO32_MBASE	VDSO32_LBASE
-#define VDSO64_MBASE	VDSO64_LBASE
 
 #define VDSO_VERSION_STRING	LINUX_2.6.15
 
Index: linux.trees.git/arch/powerpc/kernel/vdso.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/vdso.c	2009-07-14 11:41:46.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/vdso.c	2009-07-14 12:03:13.000000000 +1000
@@ -203,7 +203,12 @@
 	} else {
 		vdso_pagelist = vdso64_pagelist;
 		vdso_pages = vdso64_pages;
-		vdso_base = VDSO64_MBASE;
+		/*
+		 * On 64bit we don't have a preferred map address. This
+		 * allows get_unmapped_area to find an area near other mmaps
+		 * and most likely share a SLB entry.
+		 */
+		vdso_base = 0;
 	}
 #else
 	vdso_pagelist = vdso32_pagelist;

-- 
