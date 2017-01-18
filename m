Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v38NQ1B84zDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 12:22:46 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 19so6517513pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:22:46 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 18 Jan 2017 06:52:36 +0530
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 3/4] powerpc/mm: add radix__remove_section_mapping()
Message-ID: <20170118012236.GB10798@localhost.localdomain>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-4-git-send-email-arbab@linux.vnet.ibm.com>
 <20170117072251.GD8963@dhcp-9-109-223-248.in.ibm.com>
 <20170117183620.y4kkxacuo6p7r5lb@arbab-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117183620.y4kkxacuo6p7r5lb@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 17, 2017 at 12:36:21PM -0600, Reza Arbab wrote:
> On Tue, Jan 17, 2017 at 12:52:51PM +0530, Balbir Singh wrote:
> > Shouldn't most of these functions have __meminit?
> 
> I don't think so. The mapping functions are __meminit, but the unmapping
> functions are completely within #ifdef CONFIG_MEMORY_HOTPLUG already.
> 
> > On Mon, Jan 16, 2017 at 01:07:45PM -0600, Reza Arbab wrote:
> > >  #ifdef CONFIG_MEMORY_HOTPLUG
> > > +static void free_pte_table(pte_t *pte_start, pmd_t *pmd)
> > > +{
> > > +	pte_t *pte;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < PTRS_PER_PTE; i++) {
> > > +		pte = pte_start + i;
> > > +		if (!pte_none(*pte))
> > > +			return;
> > 
> > If !pte_none() we fail the hotplug? Or silently
> > leave the allocated pte's around. I guess this is
> > the same as x86
> 
> The latter--it's not a failure. If you provided remove_pagetable() an
> unaligned address range, there could be a pte left unremoved at either end.
>

OK.
 
> > > +static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
> > > +			     unsigned long end)
> > > +{
> > > +	unsigned long next;
> > > +	pte_t *pte_base;
> > > +	pmd_t *pmd;
> > > +
> > > +	pmd = pmd_start + pmd_index(addr);
> > > +	for (; addr < end; addr = next, pmd++) {
> > > +		next = pmd_addr_end(addr, end);
> > > +
> > > +		if (!pmd_present(*pmd))
> > > +			continue;
> > > +
> > > +		if (pmd_huge(*pmd)) {
> > > +			pte_clear(&init_mm, addr, (pte_t *)pmd);
> > 
> > pmd_clear()?
> 
> I used pte_clear() to mirror what happens in radix__map_kernel_page():
> 
> 		if (map_page_size == PMD_SIZE) {
> 			ptep = (pte_t *)pmdp;
> 			goto set_the_pte;
> 		}
> 
> 		[...]
> 
> 	set_the_pte:
> 		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
> 
> Would pmd_clear() be equivalent, since the pointer got set like a pte?

But we are still setting a pmdp. pmd_clear() will set the pmd to 0,
pte_clear() will go through the pte_update() mechanism which is expensive
IMHO and we may not need to do it.

> 
> > > +static void remove_pagetable(unsigned long start, unsigned long end)
> > > +{
> > > +	unsigned long addr, next;
> > > +	pud_t *pud_base;
> > > +	pgd_t *pgd;
> > > +
> > > +	spin_lock(&init_mm.page_table_lock);
> > > +
> > 
> > x86 does more granular lock acquisition only during
> > clearing the relevant entries. I suppose we don't have
> > to worry about it since its not fast path and frequent.
> 
> Yep. Ben thought the locking in remove_pte_table() was actually too
> granular, and Aneesh questioned what was being protected in the first place.
> So I left one lock/unlock in the outermost function for now.
>

Fair enough

Balbir Singh. 
