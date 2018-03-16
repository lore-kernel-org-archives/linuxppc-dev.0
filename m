Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH33DrwzDrJK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:55 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id a20so2234372wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:55 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 09/19] ppc64: change %016lx into %p
Date: Fri, 16 Mar 2018 12:02:14 +0100
Message-Id: <20180316110224.12260-10-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
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

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘show_pte’:
../arch/powerpc/xmon/xmon.c:3016:24: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘pgd_t * {aka struct <anonymous> *}’ [-Werror=format=]
  printf("pgd  @ 0x%016lx\n", pgdir);
                        ^
../arch/powerpc/xmon/xmon.c:3022:24: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘pgd_t * {aka struct <anonymous> *}’ [-Werror=format=]
  printf("pgdp @ 0x%016lx = 0x%016lx\n", pgdp, pgd_val(*pgdp));
                        ^
../arch/powerpc/xmon/xmon.c:3036:24: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘pud_t * {aka struct <anonymous> *}’ [-Werror=format=]
  printf("pudp @ 0x%016lx = 0x%016lx\n", pudp, pud_val(*pudp));
                        ^
../arch/powerpc/xmon/xmon.c:3049:24: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘pmd_t * {aka struct <anonymous> *}’ [-Werror=format=]
  printf("pmdp @ 0x%016lx = 0x%016lx\n", pmdp, pmd_val(*pmdp));
                        ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0e4dcdf12f9e..69152f00d3fc 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3010,13 +3010,13 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	printf("pgd  @ 0x%016lx\n", pgdir);
+	printf("pgd  @ 0x%p\n", pgdir);
 
 	if (pgd_huge(*pgdp)) {
 		format_pte(pgdp, pgd_val(*pgdp));
 		return;
 	}
-	printf("pgdp @ 0x%016lx = 0x%016lx\n", pgdp, pgd_val(*pgdp));
+	printf("pgdp @ 0x%p = 0x%016lx\n", pgdp, pgd_val(*pgdp));
 
 	pudp = pud_offset(pgdp, addr);
 
@@ -3030,7 +3030,7 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	printf("pudp @ 0x%016lx = 0x%016lx\n", pudp, pud_val(*pudp));
+	printf("pudp @ 0x%p = 0x%016lx\n", pudp, pud_val(*pudp));
 
 	pmdp = pmd_offset(pudp, addr);
 
@@ -3043,7 +3043,7 @@ static void show_pte(unsigned long addr)
 		format_pte(pmdp, pmd_val(*pmdp));
 		return;
 	}
-	printf("pmdp @ 0x%016lx = 0x%016lx\n", pmdp, pmd_val(*pmdp));
+	printf("pmdp @ 0x%p = 0x%016lx\n", pmdp, pmd_val(*pmdp));
 
 	ptep = pte_offset_map(pmdp, addr);
 	if (pte_none(*ptep)) {
-- 
2.11.0
