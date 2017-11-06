Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVrKJ3XBYzDrKq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 22:42:59 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id a8so7553776pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 03:42:59 -0800 (PST)
Date: Mon, 6 Nov 2017 22:42:46 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 4/5] powerpc/64s/radix: Fix 128TB-512TB virtual address
 boundary case allocation
Message-ID: <20171106224246.05f234c5@roar.ozlabs.ibm.com>
In-Reply-To: <87po8vslp3.fsf@linux.vnet.ibm.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-5-npiggin@gmail.com>
 <87po8vslp3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 06 Nov 2017 16:44:48 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Radix VA space allocations test addresses against mm->task_size which is
> > 512TB, even in cases where the intention is to limit allocation to below
> > 128TB.
> >
> > This results in mmap with a hint address below 128TB but address + length
> > above 128TB succeeding when it should fail (as hash does after the
> > previous patch).
> >
> > Set the high address limit to be considered up front, and base subsequent
> > allocation checks on that consistently.  
> 
> Doesn't setting info.high_limit take care of that ? I would expect
> vm_unmapped_area to fail based on info.high_limit.

No, it is the hint address case. info.high_limit only gets involved if
the hint area was unavailable.

I prefer the behaviour without this fix because I disagree that the explicit
address request should fail, but this is what you asked for.

Actually now I come to look again, it seems that generic code does *not*
fail in this case either! Any explicit hint will succeed if it partially
or completely crosses 128TB. This is much better behaviour, so I think
powerpc has it wrong.

> Is this with MAP_FIXED?

With MAP_FIXED, it remains as succeeding as expected (like generic code
and hash). I did not change that case.

> 
> 
> >
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/hugetlbpage-radix.c | 13 +++++++------
> >  arch/powerpc/mm/mmap.c              | 27 ++++++++++++++-------------
> >  2 files changed, 21 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
> > index a12e86395025..9c6a411e9c85 100644
> > --- a/arch/powerpc/mm/hugetlbpage-radix.c
> > +++ b/arch/powerpc/mm/hugetlbpage-radix.c
> > @@ -48,14 +48,18 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma;
> >  	struct hstate *h = hstate_file(file);
> > +	unsigned long high_limit = DEFAULT_MAP_WINDOW;
> >  	struct vm_unmapped_area_info info;
> >
> >  	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
> >  		mm->context.addr_limit = TASK_SIZE;
> >
> > +	if (addr > high_limit)
> > +		high_limit = TASK_SIZE;
> > +
> >  	if (len & ~huge_page_mask(h))
> >  		return -EINVAL;
> > -	if (len > mm->task_size)
> > +	if (len > high_limit)
> >  		return -ENOMEM;
> >
> >  	if (flags & MAP_FIXED) {
> > @@ -67,7 +71,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >  	if (addr) {
> >  		addr = ALIGN(addr, huge_page_size(h));
> >  		vma = find_vma(mm, addr);
> > -		if (mm->task_size - len >= addr &&
> > +		if (high_limit - len >= addr &&
> >  		    (!vma || addr + len <= vm_start_gap(vma)))
> >  			return addr;
> >  	}
> > @@ -78,12 +82,9 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> >  	info.length = len;
> >  	info.low_limit = PAGE_SIZE;
> > -	info.high_limit = current->mm->mmap_base;
> > +	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
> >  	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
> >  	info.align_offset = 0;
> >
> > -	if (addr > DEFAULT_MAP_WINDOW)
> > -		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
> > -
> >  	return vm_unmapped_area(&info);
> >  }
> > diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> > index 5d78b193fec4..e6cb3b3f7e93 100644
> > --- a/arch/powerpc/mm/mmap.c
> > +++ b/arch/powerpc/mm/mmap.c
> > @@ -106,13 +106,17 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma;
> > +	unsigned long high_limit = DEFAULT_MAP_WINDOW;
> >  	struct vm_unmapped_area_info info;
> >
> >  	if (unlikely(addr > mm->context.addr_limit &&
> >  		     mm->context.addr_limit != TASK_SIZE))
> >  		mm->context.addr_limit = TASK_SIZE;
> >
> > -	if (len > mm->task_size - mmap_min_addr)
> > +	if (addr > high_limit)
> > +		high_limit = TASK_SIZE;
> > +
> > +	if (len > high_limit - mmap_min_addr)
> >  		return -ENOMEM;
> >
> >  	if (flags & MAP_FIXED)
> > @@ -121,7 +125,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
> >  	if (addr) {
> >  		addr = PAGE_ALIGN(addr);
> >  		vma = find_vma(mm, addr);
> > -		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
> > +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
> >  		    (!vma || addr + len <= vm_start_gap(vma)))
> >  			return addr;
> >  	}
> > @@ -129,13 +133,9 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
> >  	info.flags = 0;
> >  	info.length = len;
> >  	info.low_limit = mm->mmap_base;
> > +	info.high_limit = high_limit;
> >  	info.align_mask = 0;
> >
> > -	if (unlikely(addr > DEFAULT_MAP_WINDOW))
> > -		info.high_limit = mm->context.addr_limit;
> > -	else
> > -		info.high_limit = DEFAULT_MAP_WINDOW;
> > -
> >  	return vm_unmapped_area(&info);
> >  }
> >
> > @@ -149,14 +149,18 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
> >  	struct vm_area_struct *vma;
> >  	struct mm_struct *mm = current->mm;
> >  	unsigned long addr = addr0;
> > +	unsigned long high_limit = DEFAULT_MAP_WINDOW;
> >  	struct vm_unmapped_area_info info;
> >
> >  	if (unlikely(addr > mm->context.addr_limit &&
> >  		     mm->context.addr_limit != TASK_SIZE))
> >  		mm->context.addr_limit = TASK_SIZE;
> >
> > +	if (addr > high_limit)
> > +		high_limit = TASK_SIZE;
> > +
> >  	/* requested length too big for entire address space */
> > -	if (len > mm->task_size - mmap_min_addr)
> > +	if (len > high_limit - mmap_min_addr)
> >  		return -ENOMEM;
> >
> >  	if (flags & MAP_FIXED)
> > @@ -166,7 +170,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
> >  	if (addr) {
> >  		addr = PAGE_ALIGN(addr);
> >  		vma = find_vma(mm, addr);
> > -		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
> > +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
> >  				(!vma || addr + len <= vm_start_gap(vma)))
> >  			return addr;
> >  	}
> > @@ -174,12 +178,9 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
> >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> >  	info.length = len;
> >  	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
> > -	info.high_limit = mm->mmap_base;
> > +	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
> >  	info.align_mask = 0;
> >
> > -	if (addr > DEFAULT_MAP_WINDOW)
> > -		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
> > -
> >  	addr = vm_unmapped_area(&info);
> >  	if (!(addr & ~PAGE_MASK))
> >  		return addr;
> > -- 
> > 2.15.0  
> 
