Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C880B1A03C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 01:02:17 +1100 (AEDT)
Message-Id: <7d7a6f4881ef33d7621fdbf6602bd137c49753af.1446893433.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1446893426.git.christophe.leroy@c-s.fr>
References: <cover.1446893426.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 22/23] powerpc32: small optimisation in flush_icache_range()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Nov 2015 14:32:44 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Inlining of _dcache_range() functions has shown that the compiler
does the same thing a bit better with one insn less

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: new
v3: no change

 arch/powerpc/kernel/misc_32.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 1728f61..1597424 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -348,10 +348,9 @@ BEGIN_FTR_SECTION
 	PURGE_PREFETCHED_INS
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
-	li	r5,L1_CACHE_BYTES-1
-	andc	r3,r3,r5
+	rlwinm	r3,r3,0,0,31 - L1_CACHE_SHIFT
 	subf	r4,r3,r4
-	add	r4,r4,r5
+	addi	r4,r4,L1_CACHE_BYTES - 1
 	srwi.	r4,r4,L1_CACHE_SHIFT
 	beqlr
 	mtctr	r4
-- 
2.1.0
