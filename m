Return-Path: <benh@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5747567A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:14:36 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.6/8.13.6) with ESMTP id k4U4HjhB6094960
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:17:45 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4U4HsrX166260
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:17:54 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4U4EXdA003928
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:14:33 +1000
Subject: [PATCH] powerpc: Fix buglet with MMU hash management
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:14:19 +1000
Message-Id: <1148962460.15722.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our MMU hash management code would not set the "C" bit (changed bit) in
the hardware PTE when updating a RO PTE into a RW PTE. That would cause
the hardware to possibly to a write back to the hash table to set it on
the first store access, which in addition to being a performance issue,
might also hit a bug when running with native hash management (non-HV)
as our code is specifically optimized for the case where no write back
happens.

Thus there is a very small therocial window were a hash PTE can become
corrupted if that HPTE has just been upgraded to read write, a store
access happens on it, and that races with another processor evicting
that same slot. Since eviction (caused by an almost full hash) is
extremely rare, the bug is very unlikely to happen fortunately.

This fixes by allowing the updating of the protection bits in the native
hash handling to also set (but not clear) the "C" bit, and, in order to
also improve performances in the general case, by always setting that
bit on newly inserted hash PTE so that writeback really never happens.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/mm/hash_low_64.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_64.S	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_low_64.S	2006-05-30 14:00:53.000000000 +1000
@@ -136,6 +136,7 @@ _GLOBAL(__hash_page_4K)
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
 	andc	r0,r30,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
+	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
 
 	/* We eventually do the icache sync here (maybe inline that
 	 * code rather than call a C function...) 
@@ -400,6 +401,7 @@ _GLOBAL(__hash_page_4K)
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
 	andc	r0,r30,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
+	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
 
 	/* We eventually do the icache sync here (maybe inline that
 	 * code rather than call a C function...)
@@ -671,6 +673,7 @@ _GLOBAL(__hash_page_64K)
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
 	andc	r0,r30,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
+	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
 
 	/* We eventually do the icache sync here (maybe inline that
 	 * code rather than call a C function...)
Index: linux-work/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_native_64.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_native_64.c	2006-05-30 13:54:12.000000000 +1000
@@ -238,7 +238,7 @@ static long native_hpte_updatepp(unsigne
 		DBG_LOW(" -> hit\n");
 		/* Update the HPTE */
 		hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
-			(newpp & (HPTE_R_PP | HPTE_R_N));
+			(newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C));
 		native_unlock_hpte(hptep);
 	}
 
Index: linux-work/include/asm-powerpc/mmu.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mmu.h	2006-05-30 13:40:21.000000000 +1000
+++ linux-work/include/asm-powerpc/mmu.h	2006-05-30 13:53:18.000000000 +1000
@@ -96,6 +96,8 @@ extern char initial_stab[];
 #define HPTE_R_FLAGS		ASM_CONST(0x00000000000003ff)
 #define HPTE_R_PP		ASM_CONST(0x0000000000000003)
 #define HPTE_R_N		ASM_CONST(0x0000000000000004)
+#define HPTE_R_C		ASM_CONST(0x0000000000000080)
+#define HPTE_R_R		ASM_CONST(0x0000000000000100)
 
 /* Values for PP (assumes Ks=0, Kp=1) */
 /* pp0 will always be 0 for linux     */
