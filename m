Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMhHz19dzzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 00:16:31 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Simplify _PAGE_RO handling in page table dump
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170509141626.F30E767954@pc13941vm.idsi0.si.c-s.fr>
Date: Tue,  9 May 2017 16:16:26 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit fd893fe56a130 ("powerpc/mm: Fix missing page attributes in
page table dump") added support of _PAGE_RO attribute.

This patch makes it more simple

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index d659345a98d6..eeef51107cff 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -121,13 +121,8 @@ static const struct flag_info flag_array[] = {
 		.set	= "user",
 		.clear	= "    ",
 	}, {
-#if _PAGE_RO == 0
-		.mask	= _PAGE_RW,
+		.mask	= _PAGE_RW | _PAGE_RO,
 		.val	= _PAGE_RW,
-#else
-		.mask	= _PAGE_RO,
-		.val	= 0,
-#endif
 		.set	= "rw",
 		.clear	= "ro",
 	}, {
-- 
2.12.0
