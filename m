Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcr7218sxzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:54:37 +1000 (AEST)
Message-Id: <698522e0a3638bfe26a9cdc3944943ae139de576.1503277387.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1503277387.git.christophe.leroy@c-s.fr>
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/4] powerpc: fix location of two EXPORT_SYMBOL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 23 Aug 2017 16:54:34 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9445aa1a3062a ("ppc: move exports to definitions")
added EXPORT_SYMBOL() for memset() and flush_hash_pages() in
the middle of the functions.

This patch moves them at the end of the two functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S    | 2 +-
 arch/powerpc/mm/hash_low_32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index a14d4df2ebc9..a3ffeac69eca 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -104,7 +104,6 @@ _GLOBAL(memset)
 	subf	r6,r0,r6
 	cmplwi	0,r4,0
 	bne	2f	/* Use normal procedure if r4 is not zero */
-EXPORT_SYMBOL(memset)
 _GLOBAL(memset_nocache_branch)
 	b	2f	/* Skip optimised bloc until cache is enabled */
 
@@ -140,6 +139,7 @@ _GLOBAL(memset_nocache_branch)
 8:	stbu	r4,1(r6)
 	bdnz	8b
 	blr
+EXPORT_SYMBOL(memset)
 
 /*
  * This version uses dcbz on the complete cache lines in the
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 6f962e5cb5e1..ffbd7c0bda96 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -575,7 +575,6 @@ _GLOBAL(flush_hash_pages)
 	rlwinm	r8,r8,0,31,29		/* clear HASHPTE bit */
 	stwcx.	r8,0,r5			/* update the pte */
 	bne-	33b
-EXPORT_SYMBOL(flush_hash_pages)
 
 	/* Get the address of the primary PTE group in the hash table (r3) */
 _GLOBAL(flush_hash_patch_A)
@@ -634,6 +633,7 @@ _GLOBAL(flush_hash_patch_B)
 	SYNC_601
 	isync
 	blr
+EXPORT_SYMBOL(flush_hash_pages)
 
 /*
  * Flush an entry from the TLB
-- 
2.13.3
