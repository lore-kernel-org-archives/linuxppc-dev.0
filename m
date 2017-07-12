Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vmp3WSPzDqk2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:08:58 +1000 (AEST)
Message-Id: <a699b909ef4902cedb6707c9b3c1640dc37aa88f.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/7] powerpc/8xx: Do not allow Pinned TLBs with
 STRICT_KERNEL_RWX or DEBUG_PAGEALLOC
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:53 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pinning TLBs bypasses STRICT_KERNEL_RWX or DEBUG_PAGEALLOC protections
so it should only be allowed when those are not selected

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d09b259d3621..28608275d7c0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1165,7 +1165,8 @@ config CONSISTENT_SIZE
 
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
-	depends on ADVANCED_OPTIONS && 8xx
+	depends on ADVANCED_OPTIONS && PPC_8xx && \
+		   !DEBUG_PAGEALLOC && !STRICT_KERNEL_RWX
 
 config PIN_TLB_DATA
 	bool "Pinned TLB for DATA"
-- 
2.12.0
