Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 2DE1CDDE42
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 14:03:21 +1000 (EST)
Message-ID: <393088111.08518@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Nicholas Mc Guire <der.herr@hofr.at>, linux-embedded@opentech.lzu.edu.cn,
	Miguel Masmano <mimastel@doctor.upv.es>
Subject: ppc manual paging question
Date: Mon, 22 Oct 2007 12:03:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710221203.24157.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi,

  I've got some qeustion about ppc(ppc44x) paging:=20

how can I manually map a virtual address to a physical address through a=20
specific pgd? How does ppc translate virt address to physical one? I think=
=20
besides from tlb, the CPU will search the page table entries via the pgd, c=
an=20
I alter the pgd value to change the memory translation? under i386, it's ve=
ry=20
simple, we can just rewrite %%cr3, it even could invalidate all tlb entries=
=20
automatically, how can I do this under ppc? I've tried rewrite=20
current->mm->pgd and current->thread.pgdir, but sounds like it still not=20
insufficiant, am I missing something vital?=20

Any hint will be greatly approciated.

  Regards,
Wang

P.S:

here is the code:

#define save_pd(pd)     ((pd) =3D (unsigned long)(current->mm->pgd))
#define load_pd(pd)     (current->mm->pgd =3D (pd))

=2E..

static inline pgd_t* __pgd_offset(unsigned long pgd_base, unsigned long va)
{
        return (pgd_t*)((pgd_t*)pgd_base + pgd_index(va));
}

static inline pte_t* pte_offset(pmd_t* pte_base, unsigned long va)
{
        return (pte_t*)((pte_t*)pte_base + pte_index(va));
}

static inline unsigned long get_free_pages_atomic(int order)
{
        return __get_free_pages(GFP_ATOMIC, order);
}

=2E..

unsigned long create_page_directory (unsigned long (*alloc_page) (void)) {
  unsigned long pd, c_pd;
  unsigned long idx;

  save_pd(c_pd);

  pd =3D get_free_pages_atomic(PGD_ORDER);
  if(!pd)       return 0;

  memset((void*)pd, 0, PGD_ORDER << PAGE_SHIFT);

  /*
   * copy kernel page directies
   */
  idx =3D pgd_index(PAGE_OFFSET);
  memcpy((pgd_t*)pd + idx, (pgd_t*)c_pd + idx, (PTRS_PER_PGD - idx) *=20
sizeof(pgd_t));

  printk(KERN_EMERG"create_page_directory return: 0x%lx, c_pd: 0x%lx\n", pd=
,=20
c_pd);

  return pd;
}

/*
 * allocate a user page at @vaddress if possible
 * TODO: add tlb/slb/bat for fast page/block address translation
 */
unsigned long allocate_user_page (unsigned long pd,
                unsigned long vaddress,
                unsigned long (*alloc_page) (void)) {
        pgd_t* pgd;
        pud_t* pud;
        pmd_t* pmd;
        pte_t* pte;
        unsigned long page =3D 0;

#define mm_debug        printk
        mm_debug("allocate_user_page(0x%lx, 0x%lx, 0x%lx)\n", pd, vaddress,=
=20
alloc_page);

        pgd =3D __pgd_offset(pd, vaddress);
        if(!pgd_present(*pgd) || !(*pgd)){
                pud_t* pud_entry =3D (pud_t*)get_free_pages_atomic(PUD_ORDE=
R);
                if(!pud_entry)  return 0;
                *pgd =3D __pa(pud_entry) & PAGE_MASK;
                mm_debug("!pgd_present, pgd: 0x%lx, *pgd: 0x%lx\n", pgd,=20
*pgd);
        }

        pud =3D pud_offset(pgd, vaddress);
        if(!pud_present(*pud) || !(*pud)){
                pmd_t* pmd_entry =3D (pmd_t*)get_free_pages_atomic(PMD_ORDE=
R);
                if(!pmd_entry)  return 0;
                *pud =3D __pa(pmd_entry) & PAGE_MASK;
                mm_debug("!pud_present, pud: 0x%lx, *pud: 0x%lx\n", pud,=20
*pud);
        }

        pmd =3D pmd_offset(pud, vaddress);
        if(!pmd_present(*pmd) || !(*pmd)){
                pte_t* pte_entry =3D (pte_t*)get_free_pages_atomic(PTE_ORDE=
R);
                if(!pte_entry)  return 0;
                *pmd =3D __pa(pte_entry) & PAGE_MASK;
                *pmd |=3D _PMD_PRESENT;
                mm_debug("!pmd_present, pmd: 0x%lx, *pmd: 0x%lx\n", pmd,=20
*pmd);
        }

        pte =3D pte_offset(pmd, vaddress);
        if(!pte_present(*pte) || !(*pte) || pte_none(*pte)){
                unsigned long pfn;

                page =3D get_free_pages_atomic(PAGE_ORDER);
                mm_debug("page: 0x%lx\n", page);
                pfn =3D __pa(page) & PAGE_MASK;
                mm_debug("pfn: 0x%lx\n", pfn);
                set_pte_at(current->mm, page, pte, pfn_pte(pfn >> PAGE_SHIF=
T,=20
__pgprot(PAGE_SHARED_X)));
                mm_debug("pte_present now?: %lld\n", pte_present(*pte));
                mm_debug("!pte_present, pte: 0x%lx\n", pte);
        }

        mm_debug("allocate_user_page: return 0x%lx\n", page);

#undef  mm_debug
        return page;
}

=2D-=20
Wang, Baojun =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0Lanzhou University
Distributed & Embedded System Lab =A0 =A0 =A0 =A0 =A0 =A0 =A0http://dslab.l=
zu.edu.cn
School of Information Science and Engeneering =A0 =A0 =A0 =A0wangbj@lzu.edu=
=2Ecn
Tianshui South Road 222. Lanzhou 730000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 .P.R.China
Tel:+86-931-8912025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Fax:+86-931-8912022
