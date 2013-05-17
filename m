Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16D672C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 18:36:46 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 17 May 2013 14:02:52 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BF3A0E0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 14:09:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4H8aVUa63176756
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 14:06:32 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4H8aaSI012844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 18:36:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: Re: [PATCH 2/2] powerpc: split hugepage when using subpage protection
In-Reply-To: <1368778503-23230-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1368778503-23230-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1368778503-23230-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 17 May 2013 14:06:36 +0530
Message-ID: <8761yiuhnv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> We find all the overlapping vma and mark them such that we don't allocate
> hugepage in that range. Also we split existing huge page so that the
> normal page hash can be invalidated and new page faulted in with new
> protection bits.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/subpage-prot.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index 7c415dd..33fd329 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -130,6 +130,14 @@ static void subpage_prot_clear(unsigned long addr, unsigned long len)
>  	up_write(&mm->mmap_sem);
>  }
>
> +static int subpage_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->private;
> +	split_huge_page_pmd(vma, addr, pmd);
> +	return 0;
> +}
> +
>  /*
>   * Copy in a subpage protection map for an address range.
>   * The map has 2 bits per 4k subpage, so 32 bits per 64k page.
> @@ -149,6 +157,12 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
>  	size_t nw;
>  	unsigned long next, limit;
>  	int err;
> +	struct vm_area_struct *vma;
> +
> +	struct mm_walk subpage_proto_walk = {
> +		.mm = mm,
> +		.pmd_entry = subpage_walk_pmd_entry,
> +	};
>
>  	/* Check parameters */
>  	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
> @@ -168,6 +182,19 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
>  		return -EFAULT;
>
>  	down_write(&mm->mmap_sem);
> +
> +	/*
> +	 * We don't try too hard, we just mark all the vma in that range
> +	 * VM_NOHUGEPAGE and split them.
> +	 */
> +	for (vma = find_vma(mm, addr);
> +	     (vma && vma->vm_end < (addr + len)); vma = vma->vm_next) {

should be, Missed commit -amend 

	     (vma && vma->vm_start < (addr + len)); vma = vma->vm_next) {

> +		vma->vm_flags |= VM_NOHUGEPAGE;
> +		subpage_proto_walk.private = vma;
> +		walk_page_range(vma->vm_start, vma->vm_end,
> +				&subpage_proto_walk);
> +	}
>  	for (limit = addr + len; addr < limit; addr = next) {
>  		next = pmd_addr_end(addr, limit);
>  		err = -ENOMEM;

-aneesh
