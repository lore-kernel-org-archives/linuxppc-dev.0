Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb5nr2VzbzDsbD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:02:39 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND] powerpc: fix usage of _PAGE_RO in hugepage
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160916070227.DC69C1A2463@localhost.localdomain>
Date: Fri, 16 Sep 2016 08:34:15 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some CPUs like the 8xx, _PAGE_RW hence _PAGE_WRITE is defined
as 0 and _PAGE_RO has to be set when a page is not writable

_PAGE_RO is defined by default in pte-common.h, however BOOK3S/64
doesn't include that file so _PAGE_RO has to be defined explicitly
in book3s/64/pgtable.h

fixes: a7b9f671f2d14 ("powerpc32: adds handling of _PAGE_RO")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
This patch was initially part of the v1 serie of patchs for providing
hugepage support to the 8xx. As suggested by Aneesh, that serie has
been splited to focus only on hugepage implementation for 8xx.
This patch is a fix and is independant of 8xx hugepage implementation,
allthough it is required to have hugepage support working properly on
the 8xx.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 ++
 arch/powerpc/mm/hugetlbpage.c                | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8ec8be9..9fd77f8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -6,6 +6,8 @@
  */
 #define _PAGE_BIT_SWAP_TYPE	0
 
+#define _PAGE_RO		0
+
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
 #define _PAGE_READ		0x00004	/* read access allowed */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7372ee1..8a512b1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -1021,6 +1021,8 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	mask = _PAGE_PRESENT | _PAGE_READ;
 	if (write)
 		mask |= _PAGE_WRITE;
+	else
+		mask |= _PAGE_RO;
 
 	if ((pte_val(pte) & mask) != mask)
 		return 0;
-- 
2.1.0
