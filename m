Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id E90791A1D46
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:32 +1000 (AEST)
Message-Id: <6dafdde33fcfebd99bb310500deed56c8c4b32a1.1439382637.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 18/20] powerpc32: Remove useless/wrong MMU:setio progress
 message
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:29 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 771168494719 ("[POWERPC] Remove unused machine call outs")
removed the call to setup_io_mappings(), so remove the associated
progress line message

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/init_32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 1a18e4b..4eb1b8f 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -178,10 +178,6 @@ void __init MMU_init(void)
 	/* Initialize early top-down ioremap allocator */
 	ioremap_bot = IOREMAP_TOP;
 
-	/* Map in I/O resources */
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:setio", 0x302);
-
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:exit", 0x211);
 
-- 
2.1.0
