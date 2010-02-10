Return-Path: <anton@ozlabs.org>
Date: Wed, 10 Feb 2010 22:03:06 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 3/6] powerpc: Convert open coded native hashtable bit lock
Message-ID: <20100210110306.GC3399@kryten>
References: <20100210105728.GA3399@kryten>
 <20100210110236.GB3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210110236.GB3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Now we have real bit locks use them instead of open coding it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 056d23a..9e1aa4f 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -122,7 +122,7 @@ static inline void native_lock_hpte(struct hash_pte *hptep)
 	unsigned long *word = &hptep->v;
 
 	while (1) {
-		if (!test_and_set_bit(HPTE_LOCK_BIT, word))
+		if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
 			break;
 		while(test_bit(HPTE_LOCK_BIT, word))
 			cpu_relax();
@@ -133,8 +133,7 @@ static inline void native_unlock_hpte(struct hash_pte *hptep)
 {
 	unsigned long *word = &hptep->v;
 
-	asm volatile("lwsync":::"memory");
-	clear_bit(HPTE_LOCK_BIT, word);
+	clear_bit_unlock(HPTE_LOCK_BIT, word);
 }
 
 static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
