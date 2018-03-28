Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409pbP5rrXzF2Gb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 11:26:41 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Joe Perches <joe@perches.com>, "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH v2 2/5] powerpc: mm: Use memblock API for PPC32 page_is_ram
Date: Wed, 28 Mar 2018 02:25:41 +0200
Message-Id: <20180328002544.18526-3-j.neuschaefer@gmx.net>
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support accurate checking for different blocks of memory on PPC32,
use the same memblock-based approach that's already used on PPC64 also
on PPC32.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2: no changes
---
 arch/powerpc/mm/mem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index da4e1555d61d..a42b86e2a34c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -82,11 +82,7 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
 
 int page_is_ram(unsigned long pfn)
 {
-#ifndef CONFIG_PPC64	/* XXX for now */
-	return pfn < max_pfn;
-#else
 	return memblock_is_memory(__pfn_to_phys(pfn));
-#endif
 }
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
2.16.2
