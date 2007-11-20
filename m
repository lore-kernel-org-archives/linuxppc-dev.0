Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A5ACDDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:09:55 +1100 (EST)
Date: Tue, 20 Nov 2007 06:09:50 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [patch] powerpc: hash lock use lock bitops
Message-ID: <20071120050950.GB18332@wotan.suse.de>
References: <20071120050826.GA18332@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071120050826.GA18332@wotan.suse.de>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This isn't a bugfix, but may help performance slightly...

--
powerpc 64-bit hash pte lock bit is an actual lock, so it can take advantage
of lock bitops for slightly more optimal memory barriers (can avoid an lwsync
in the trylock).

Signed-off-by: Nick Piggin <npiggin@suse.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Index: linux-2.6/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/hash_native_64.c
+++ linux-2.6/arch/powerpc/mm/hash_native_64.c
@@ -113,7 +113,7 @@ static inline void native_lock_hpte(stru
 	unsigned long *word = &hptep->v;
 
 	while (1) {
-		if (!test_and_set_bit(HPTE_LOCK_BIT, word))
+		if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
 			break;
 		while(test_bit(HPTE_LOCK_BIT, word))
 			cpu_relax();
@@ -124,8 +124,7 @@ static inline void native_unlock_hpte(st
 {
 	unsigned long *word = &hptep->v;
 
-	asm volatile("lwsync":::"memory");
-	clear_bit(HPTE_LOCK_BIT, word);
+	clear_bit_unlock(HPTE_LOCK_BIT, word);
 }
 
 static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
