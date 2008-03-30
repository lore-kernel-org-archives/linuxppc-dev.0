Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2E1CDDEE2
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 07:50:04 +1000 (EST)
Subject: [PATCH] powerpc: Fix deadlock with mmu_hash_lock in hash_page_sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gaash-ppclnx@gaashh.com
In-Reply-To: <90380.16819.qm@web39603.mail.mud.yahoo.com>
References: <90380.16819.qm@web39603.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 08:49:27 +1100
Message-Id: <1206913767.10388.129.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Gilad Ben-Yossef <gilad@codefidence.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hash_page_sync() takes and releases the low level mmu hash
lock in order to sync with other processors disposing of page
tables. Because that lock can be needed to service hash misses
triggered by interrupt handler, taking it must be done with
interrupts off. However, hash_page_sync() appear to be called
with interrupts enabled, thus causing occasional deadlocks.

We fix it by making sure hash_page_sync() masks interrupts while
holding the lock.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Please test and report asap thought it's probably too late for
2.6.25, it can still go into stable later on.

Index: linux-work/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_32.S	2008-03-31 08:42:56.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_low_32.S	2008-03-31 08:45:05.000000000 +1100
@@ -44,6 +44,9 @@ mmu_hash_lock:
 #ifdef CONFIG_SMP
 	.text
 _GLOBAL(hash_page_sync)
+	mfmsr   r10
+	rlwinm  r0,r10,0,17,15          /* clear bit 16 (MSR_EE) */
+	mtmsr   r0
 	lis	r8,mmu_hash_lock@h
 	ori	r8,r8,mmu_hash_lock@l
 	lis	r0,0x0fff
@@ -60,8 +63,9 @@ _GLOBAL(hash_page_sync)
 	eieio
 	li	r0,0
 	stw	r0,0(r8)
-	blr	
-#endif
+	mtmsr	r10
+	blr
+#endif /* CONFIG_SMP */
 
 /*
  * Load a PTE into the hash table, if possible.
