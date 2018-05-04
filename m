Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cqHt1VywzDqjP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 21:18:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: kbuild test robot <lkp@intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: kbuild-all@01.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/nohash: remove hash related code from nohash
 headers.
In-Reply-To: <201804270438.utPklxgP%fengguang.wu@intel.com>
References: <02633d43f29e1ba01865cd334216dc8efb8b4b11.1524587425.git.christophe.leroy@c-s.fr>
 <201804270438.utPklxgP%fengguang.wu@intel.com>
Date: Fri, 04 May 2018 21:17:58 +1000
Message-ID: <878t8z8yah.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kbuild test robot <lkp@intel.com> writes:

> Hi Christophe,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.17-rc2 next-20180426]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc-nohash-remove-hash-related-code-from-nohash-headers/20180425-182026
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-ppc64e_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/powerpc/include/asm/nohash/pgtable.h:6:0,
>                     from arch/powerpc/include/asm/pgtable.h:19,
>                     from include/linux/memremap.h:8,
>                     from include/linux/mm.h:27,
>                     from include/linux/mman.h:5,
>                     from arch/powerpc/kernel/asm-offsets.c:22:
>    arch/powerpc/include/asm/nohash/64/pgtable.h: In function '__ptep_test_and_clear_young':
>>> arch/powerpc/include/asm/nohash/64/pgtable.h:214:6: error: implicit declaration of function 'pte_young'; did you mean 'pte_pud'? [-Werror=implicit-function-declaration]
>      if (pte_young(*ptep))
>          ^~~~~~~~~
>          pte_pud

Urk.

There's a circular dependency here.

I fixed it with the patch below, which seems to be the least worst
solution. Possibly we can clean things up further in future.

cheers

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 140f8e74b478..987a658b18e1 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -267,6 +267,11 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 	pte_update(ptep, clr, set);
 }
 
+static inline int pte_young(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_ACCESSED;
+}
+
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	((pte_val(A) ^ pte_val(B)) == 0)
 
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e8de7cb4d3fb..6ac8381f4c7a 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -204,6 +204,11 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	return old;
 }
 
+static inline int pte_young(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_ACCESSED;
+}
+
 static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 077472640b35..2160be2e4339 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -17,7 +17,6 @@ static inline int pte_write(pte_t pte)
 }
 static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
-static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
