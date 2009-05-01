Return-Path: <dave@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76C2FDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 04:37:12 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n41IVPGu017720
	for <linuxppc-dev@ozlabs.org>; Fri, 1 May 2009 12:31:25 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n41Ib7aL090260
	for <linuxppc-dev@ozlabs.org>; Fri, 1 May 2009 12:37:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n41Ib6WW029627
	for <linuxppc-dev@ozlabs.org>; Fri, 1 May 2009 12:37:06 -0600
Subject: Should ppc32 use CONFIG_HIGHPTE or not?
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Content-Type: text/plain
Date: Fri, 01 May 2009 11:37:03 -0700
Message-Id: <1241203023.29485.218.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/pgtable_32.c has the following function:

pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
{
        struct page *ptepage;

#ifdef CONFIG_HIGHPTE
        gfp_t flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT | __GFP_ZERO;
#else
        gfp_t flags = GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO;
#endif
...

But there's no trace of CONFIG_HIGHPTE anywhere in arch/powerpc.  But,
the one and only definition on 32-bit of pte_offset_map() (in
arch/powerpc/include/asm/pgtable-ppc32.h) seems to have HIGHPTE
semantics:

#define pte_offset_map(dir, addr)               \
        ((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))
#define pte_offset_map_nested(dir, addr)        \
        ((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE1) + pte_index(addr))

So, it looks like ppc32 never actually allocates highmem pte pages, but
it *does* go to the trouble of at least trying to kmap_atomic() them.
Should we just give ppc32 unconditional direct-mapped ptes?  Or, should
we remove that #ifdef and let it allocate them in highmem when it can
since we also have the code to support that?

-- Dave
