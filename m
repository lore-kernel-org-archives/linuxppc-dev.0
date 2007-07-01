Return-Path: <blackfin.kang@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 342EDDDF94
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jul 2007 00:24:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so245458anc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 01 Jul 2007 07:24:16 -0700 (PDT)
Message-ID: <a7f827420707010724g7ebd9920weab2fc5af9c98899@mail.gmail.com>
Date: Sun, 1 Jul 2007 22:24:16 +0800
From: "kang shuo" <blackfin.kang@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: A question about man_page in linux-kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi:
    I had read some ppc code in linux-2.6.20. There is a question
about map_page function. map_page seems to implement the map between
virtual address and physical address. But I can not understand how the
tlb entry operation is done in the code in map_page. The map_page is
as the following:

int
map_page(unsigned long va, phys_addr_t pa, int flags)
{
       pmd_t *pd;
       pte_t *pg;
       int err = -ENOMEM;

       /* Use upper 10 bits of VA to index the first level map */
       pd = pmd_offset(pgd_offset_k(va), va);
       /* Use middle 10 bits of VA to index the second-level map */
       pg = pte_alloc_kernel(pd, va);
       if (pg != 0) {
               err = 0;
               set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
__pgprot(flags)));
               if (mem_init_done)
                       flush_HPTE(0, va, pmd_val(*pd));
       }
       return err;
}

       Could anyone give me some hints about where and when tlb entry
is setup according to map_page function. That is very appreciate.

-- Thanks
-- Michael.Kang
