Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w467h4MFvzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 15:45:20 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/mm: Fix missing page attributes in page table dump
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Rashmica Gupta <rashmicy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170414054516.757356014A@localhost.localdomain>
Date: Fri, 14 Apr 2017 07:45:16 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some targets, _PAGE_RW is 0 and this is _PAGE_RO which is used.
There is also _PAGE_SHARED that is missing.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Unlike the 3 other pgtable.h, arch/powerpc/include/asm/book3s/64/pgtable.h
 doesn't include pte-common.h . Therefore, _PAGE_SHARED has to be defined
 explicitly there, just like _PAGE_RO is. (build issue reported by kbuild robot)

 arch/powerpc/include/asm/book3s/64/pgtable.h | 1 +
 arch/powerpc/mm/dump_linuxpagetables.c       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index fb72ff6b98e6..fc9dc57a787b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -13,6 +13,7 @@
 #define _PAGE_BIT_SWAP_TYPE	0
 
 #define _PAGE_RO		0
+#define _PAGE_SHARED		0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
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
