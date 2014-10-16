Return-Path: <steve.capper@linaro.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E4D11A0290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 20:25:41 +1100 (AEDT)
Received: by mail-wg0-f46.google.com with SMTP id l18so3240396wgh.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 02:25:37 -0700 (PDT)
Date: Thu, 16 Oct 2014 10:25:30 +0100
From: Steve Capper <steve.capper@linaro.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm: Update generic gup implementation to handle
 hugepage directory
Message-ID: <20141016092529.GA1524@linaro.org>
References: <1413390888-4934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413390888-4934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux@arm.linux.org.uk, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2014 at 10:04:47PM +0530, Aneesh Kumar K.V wrote:
> Update generic gup implementation with powerpc specific details.
> On powerpc at pmd level we can have hugepte, normal pmd pointer
> or a pointer to the hugepage directory.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Hi,
This patch causes compiler errors on arm and arm64 due to pgd_huge
being undefined. I've attached a fixup below, this fixup will require
that #define pgd_huge(pgd) 0 be added back into:
arch/powerpc/include/asm/page.h
For the second patch in this series.

Another avenue would be to do something like:
#ifndef pgd_huge
#define pgd_huge(pgd)	(0)
#endif

Then no changes would be required to arm and arm64 (or other
architectures).

To help with bisectability, could we please have a suitable fix applied
to the two patches in the -mm tree:
http://ozlabs.org/~akpm/mmots/broken-out/mm-update-generic-gup-implementation-to-handle-hugepage-directory.patch
http://ozlabs.org/~akpm/mmots/broken-out/arch-powerpc-switch-to-generic-rcu-get_user_pages_fast.patch

rather than applied afterwards?

With pgd_huge(x) defined, this patch passes my futex test on arm
(Arndale platform) and arm64(Juno).

Cheers,
-- 
Steve



>From 2fb7b0308f0aca94c50611257ba82d656abb0768 Mon Sep 17 00:00:00 2001
From: Steve Capper <steve.capper@linaro.org>
Date: Thu, 16 Oct 2014 09:09:48 +0100
Subject: [PATCH] Fixup for Update generic gup implementation

The patch:
mm: Update generic gup implementation to handle hugepage directory

will not compile for arm or arm64 due to pgd_huge being undefined.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable.h   | 2 ++
 arch/arm64/include/asm/pgtable.h | 2 ++
 include/linux/hugetlb.h          | 1 -
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 90aa4583..46f81fb 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -181,6 +181,8 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
+#define pgd_huge(pgd)		(0)
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 464c5ce..d4462ca 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -462,6 +462,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
+#define pgd_huge(pgd)		(0)
+
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65e12a2..6e6d338 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -138,7 +138,6 @@ static inline void hugetlb_show_meminfo(void)
 #define prepare_hugepage_range(file, addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
 #define pud_huge(x)	0
-#define pgd_huge(x)	0
 #define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
 #define hugetlb_fault(mm, vma, addr, flags)	({ BUG(); 0; })
-- 
1.9.3
