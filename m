Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21655DDEFB
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 05:07:54 +1000 (EST)
Date: Thu, 10 May 2007 14:03:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [RFC/PATCH] Fixup WARNINGs related to COMMON symbol
Message-ID: <Pine.LNX.4.64.0705101359370.23551@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We now get the following warnings:

WARNING: "ee_restarts" [arch/powerpc/kernel/built-in] is COMMON symbol
WARNING: "fee_restarts" [arch/powerpc/kernel/built-in] is COMMON symbol
WARNING: "htab_hash_searches" [arch/powerpc/mm/built-in] is COMMON symbol
WARNING: "next_slot" [arch/powerpc/mm/built-in] is COMMON symbol
WARNING: "mmu_hash_lock" [arch/powerpc/mm/built-in] is COMMON symbol
WARNING: "primary_pteg_full" [arch/powerpc/mm/built-in] is COMMON symbol

because these symbols are defined as .comm.  It is not clear if there is
any reason for these sybmols to be .comm.  Only mmu_hash_lock is global
and needed outside of the file scope its defined in.

If this patch looks good, I'll spin a version for arch/ppc and repost.

- k

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index c29d165..c7082d0 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -596,7 +596,11 @@ fast_exception_return:
 	mr	r12,r4		/* restart at exc_exit_restart */
 	b	2b

-	.comm	fee_restarts,4
+	.section .bss
+	.align	2
+fee_restarts:
+	.space	4
+	.text

 /* aargh, a nonrecoverable interrupt, panic */
 /* aargh, we don't know which trap this is */
@@ -851,7 +855,11 @@ load_dbcr0:
 	mtspr	SPRN_DBSR,r11	/* clear all pending debug events */
 	blr

-	.comm	global_dbcr0,8
+	.section .bss
+	.align	4
+global_dbcr0:
+	.space	8
+	.text
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

 do_work:			/* r10 contains MSR_KERNEL here */
@@ -926,7 +934,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	/* shouldn't return */
 	b	4b

-	.comm	ee_restarts,4
+	.section .bss
+	.align	2
+ee_restarts:
+	.space	4
+	.text

 /*
  * PROM code for specific machines follows.  Put it
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index ddceefc..8e1c059 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -30,7 +30,11 @@
 #include <asm/asm-offsets.h>

 #ifdef CONFIG_SMP
-	.comm	mmu_hash_lock,4
+	.section .bss
+	.align	2
+	.globl mmu_hash_lock
+mmu_hash_lock:
+	.space	4
 #endif /* CONFIG_SMP */

 /*
@@ -455,9 +459,15 @@ found_slot:
 	sync		/* make sure pte updates get to memory */
 	blr

-	.comm	next_slot,4
-	.comm	primary_pteg_full,4
-	.comm	htab_hash_searches,4
+	.section .bss
+	.align	2
+next_slot:
+	.space	4
+primary_pteg_full:
+	.space	4
+htab_hash_searches:
+	.space	4
+	.text

 /*
  * Flush the entry for a particular page from the hash table.
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
