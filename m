Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68DC6DDDF0
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2008 00:07:21 +1100 (EST)
Date: Sat, 1 Nov 2008 14:07:15 +0100
From: Nick Piggin <npiggin@suse.de>
To: paulus@samba.org, benh@kernel.crashing.org,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
Subject: [rfc][patch] powerpc: replace isync with lwsync
Message-ID: <20081101130715.GC32055@wotan.suse.de>
References: <20081101123339.GA32055@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081101123339.GA32055@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

This is an interesting one for me. AFAIKS it is possible to use lwsync for
a full barrier after a successful ll/sc operation, right? (or stop me here
if I'm wrong).

Anyway, I was interested in exploring this. Unfortunately my G5 might not
be very indicative of more modern, and future developments in high end
powerpc CPUs... it would be interesting to get opinion and verification
from insiders.

OK, on my G5, using lwsync instead of isync in spinlocks is a bit faster
in really stupid userspace microbenchmark (4 threads, looping, locking,
incrementing shared variable, unlocking). This prompted me to look at bit
further.

So I converted a significant number of isyncs in the kernel to lwsync.
The resulting kernel (on 2 core, 2 socket system) ran tbench consistently
about 1.75% faster than unpatched (avg ~934MB/s vs ~918MB/s) (Tbench was
just the first benchmark I picked that could run really quickly and
give relatively stable numbers). This seems pretty significant. More
than I was expecting.

I've attached the patch I used (I've not thoroughly audited the code
for all users of isync, only replaced some main ones)

Now I'd like to know why this is faster, whether it makes sense to to,
whether it helps with more useful workloads and modern systems.

isync followed by a branch I guess does something like puts a bubble
into the pipeline until the branch retires? So it is probably always
going to cost some cycles.

lwsync on the other hand, I suppose has to do a bit more when it comes
to the store queue. Maybe flush it or insert a barrier or something
into it. Also has some ordering of loads, but effectively no more than
isync AFAIKS.

Thanks,
Nick
---

Index: linux-2.6/arch/powerpc/include/asm/atomic.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/atomic.h	2008-11-01 20:36:12.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/atomic.h	2008-11-01 20:36:33.000000000 +1100
@@ -55,7 +55,7 @@
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -91,7 +91,7 @@
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -125,7 +125,7 @@
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
@@ -169,7 +169,7 @@
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
@@ -202,7 +202,7 @@
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%1 \n\
 	bne-	1b \n"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 "	subf	%0,%2,%0 \n\
 2:"
 	: "=&r" (t)
@@ -235,7 +235,7 @@
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	"\n\
 2:"	: "=&b" (t)
 	: "r" (&v->counter)
@@ -293,7 +293,7 @@
 	add	%0,%1,%0\n\
 	stdcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -327,7 +327,7 @@
 	subf	%0,%1,%0\n\
 	stdcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -359,7 +359,7 @@
 	addic	%0,%0,1\n\
 	stdcx.	%0,0,%1 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
@@ -401,7 +401,7 @@
 	addic	%0,%0,-1\n\
 	stdcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
@@ -427,7 +427,7 @@
 	blt-	2f\n\
 	stdcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	"\n\
 2:"	: "=&r" (t)
 	: "r" (&v->counter)
@@ -460,7 +460,7 @@
 	add	%0,%2,%0 \n"
 "	stdcx.	%0,0,%1 \n\
 	bne-	1b \n"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 "	subf	%0,%2,%0 \n\
 2:"
 	: "=&r" (t)
Index: linux-2.6/arch/powerpc/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/bitops.h	2008-11-01 20:36:12.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/bitops.h	2008-11-01 20:36:40.000000000 +1100
@@ -139,7 +139,7 @@
 	PPC405_ERR77(0,%3)
 	PPC_STLCX "%1,0,%3 \n"
 	"bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (old), "=&r" (t)
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
@@ -160,7 +160,7 @@
 	PPC405_ERR77(0,%3)
 	PPC_STLCX "%1,0,%3 \n"
 	"bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (old), "=&r" (t)
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
@@ -182,7 +182,7 @@
 	PPC405_ERR77(0,%3)
 	PPC_STLCX "%1,0,%3 \n"
 	"bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (old), "=&r" (t)
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
@@ -204,7 +204,7 @@
 	PPC405_ERR77(0,%3)
 	PPC_STLCX "%1,0,%3 \n"
 	"bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (old), "=&r" (t)
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
Index: linux-2.6/arch/powerpc/include/asm/futex.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/futex.h	2008-11-01 20:36:12.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/futex.h	2008-11-01 20:36:45.000000000 +1100
@@ -97,7 +97,7 @@
         PPC405_ERR77(0,%2)
 "2:     stwcx.  %4,0,%2\n\
         bne-    1b\n"
-        ISYNC_ON_SMP
+        LWSYNC_ON_SMP
 "3:	.section .fixup,\"ax\"\n\
 4:	li	%0,%5\n\
 	b	3b\n\
Index: linux-2.6/arch/powerpc/include/asm/spinlock.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/spinlock.h	2008-11-01 20:34:45.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/spinlock.h	2008-11-01 20:35:27.000000000 +1100
@@ -65,7 +65,7 @@
 	bne-		2f\n\
 	stwcx.		%1,0,%2\n\
 	bne-		1b\n\
-	isync\n\
+	lwsync\n\
 2:"	: "=&r" (tmp)
 	: "r" (token), "r" (&lock->slock)
 	: "cr0", "memory");
@@ -193,7 +193,7 @@
 	PPC405_ERR77(0,%1)
 "	stwcx.		%0,0,%1\n\
 	bne-		1b\n\
-	isync\n\
+	lwsync\n\
 2:"	: "=&r" (tmp)
 	: "r" (&rw->lock)
 	: "cr0", "xer", "memory");
@@ -217,7 +217,7 @@
 	PPC405_ERR77(0,%1)
 "	stwcx.		%1,0,%2\n\
 	bne-		1b\n\
-	isync\n\
+	lwsync\n\
 2:"	: "=&r" (tmp)
 	: "r" (token), "r" (&rw->lock)
 	: "cr0", "memory");
Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-01 20:34:45.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-01 20:36:54.000000000 +1100
@@ -235,7 +235,7 @@
 	PPC405_ERR77(0,%2)
 "	stwcx.	%3,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -278,7 +278,7 @@
 	PPC405_ERR77(0,%2)
 "	stdcx.	%3,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -371,7 +371,7 @@
 	PPC405_ERR77(0,%2)
 "	stwcx.	%4,0,%2\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	"\n\
 2:"
 	: "=&r" (prev), "+m" (*p)
@@ -416,7 +416,7 @@
 	bne-	2f\n\
 	stdcx.	%4,0,%2\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	LWSYNC_ON_SMP
 	"\n\
 2:"
 	: "=&r" (prev), "+m" (*p)
Index: linux-2.6/arch/powerpc/include/asm/synch.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/synch.h	2008-11-01 20:34:45.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/synch.h	2008-11-01 20:39:42.000000000 +1100
@@ -34,7 +34,7 @@
 
 #ifdef CONFIG_SMP
 #define ISYNC_ON_SMP	"\n\tisync\n"
-#define LWSYNC_ON_SMP	stringify_in_c(LWSYNC) "\n"
+#define LWSYNC_ON_SMP	"\n\t" stringify_in_c(LWSYNC) "\n"
 #else
 #define ISYNC_ON_SMP
 #define LWSYNC_ON_SMP
