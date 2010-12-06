Return-Path: <mikey@neuling.org>
Message-Id: <20101206234050.385929597@neuling.org>
Date: Tue, 07 Dec 2010 10:40:47 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 4/7] powerpc: Change fast_exception_return to restore r0,
	r7. r8, and CTR
References: <20101206234043.083045003@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we don't restore r0, r7, r8 and CTR in
fast_exception_return. This changes fast_exception_return to restore
these, which were saved anyway on exception entry.

This seems like a bug waiting to happen, plus we do it in hash_page
for 32bit anyway.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/entry_32.S |    4 ++++
 arch/powerpc/mm/hash_low_32.S  |    7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

Index: linux-lazy/arch/powerpc/kernel/entry_32.S
===================================================================
--- linux-lazy.orig/arch/powerpc/kernel/entry_32.S
+++ linux-lazy/arch/powerpc/kernel/entry_32.S
@@ -720,6 +720,10 @@
 #endif
 
 2:	REST_4GPRS(3, r11)
+	REST_2GPRS(7, r11)
+	REST_GPR(0, r11)
+ 	lwz	r10,_CTR(r11)
+ 	mtctr	r10
 	lwz	r10,_CCR(r11)
 	REST_GPR(1, r11)
 	mtcr	r10
Index: linux-lazy/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-lazy.orig/arch/powerpc/mm/hash_low_32.S
+++ linux-lazy/arch/powerpc/mm/hash_low_32.S
@@ -146,13 +146,6 @@
 	li	r0,0
 	stw	r0,mmu_hash_lock@l(r8)
 #endif
-
-	/* Return from the exception */
-	lwz	r5,_CTR(r11)
-	mtctr	r5
-	lwz	r0,GPR0(r11)
-	lwz	r7,GPR7(r11)
-	lwz	r8,GPR8(r11)
 	b	fast_exception_return
 
 #ifdef CONFIG_SMP
