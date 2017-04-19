Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MSz3pB0zDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:56:35 +1000 (AEST)
Message-Id: <938b8a2050fb08b92a609d78e8a213e2f4146f6d.1492606298.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492606297.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/5] powerpc/mm: remove a redundant test in do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 14:56:28 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The result of (trap == 0x400) is already in is_exec.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 9d21e5fd383d..b56bf472db6d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -213,7 +213,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * bits we are interested in.  But there are some bits which
 	 * indicate errors in DSISR but can validly be set in SRR1.
 	 */
-	if (trap == 0x400)
+	if (is_exec)
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & DSISR_ISSTORE;
-- 
2.12.0
