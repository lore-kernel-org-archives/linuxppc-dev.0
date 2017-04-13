Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3gQL60LczDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 22:41:30 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix missing page attributes in page table dump
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Rashmica Gupta <rashmicy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170413124126.301CF6E664@localhost.localdomain>
Date: Thu, 13 Apr 2017 14:41:26 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some targets, _PAGE_RW is 0 and this is _PAGE_RO which is used.
There is also _PAGE_SHARED that is missing

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 05109d7fa027..22d2433333f5 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -119,8 +119,13 @@ static const struct flag_info flag_array[] = {
 		.set	= "user",
 		.clear	= "    ",
 	}, {
+#if _PAGE_RO == 0
 		.mask	= _PAGE_RW,
 		.val	= _PAGE_RW,
+#else
+		.mask	= _PAGE_RO,
+		.val	= 0,
+#endif
 		.set	= "rw",
 		.clear	= "ro",
 	}, {
@@ -207,6 +212,10 @@ static const struct flag_info flag_array[] = {
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
 		.set	= "special",
+	}, {
+		.mask	= _PAGE_SHARED,
+		.val	= _PAGE_SHARED,
+		.set	= "shared",
 	}
 };
 
-- 
2.12.0
