Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MT33nQnzDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:56:39 +1000 (AEST)
Message-Id: <ca402117164de975e3836a2899c648f50430e789.1492606298.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492606297.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/5] powerpc/mm: The 8xx doesn't call do_page_fault() for
 breakpoints
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 14:56:32 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx has a dedicated exception for breakpoints, that directly
calls do_break()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8d1639eee3af..400f2d0d42f8 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -251,7 +251,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || \
-			     defined(CONFIG_PPC_BOOK3S_64))
+      defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_8xx))
   	if (error_code & DSISR_DABRMATCH) {
 		/* breakpoint match */
 		do_break(regs, address, error_code);
-- 
2.12.0
