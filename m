Return-Path: <hughd@google.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJMlc2KdPzDqPF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 02:39:24 +1000 (AEST)
Received: by mail-pf0-x22b.google.com with SMTP id f144so53237664pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:39:24 -0700 (PDT)
Date: Mon, 30 May 2016 09:39:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Hugh Dickins <hughd@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Fix the reference bit update when
 handling hash fault
In-Reply-To: <201605270629.u4R6OCLx014831@mx0a-001b2d01.pphosted.com>
Message-ID: <alpine.LSU.2.11.1605300903270.1076@eggly.anvils>
References: <201605270629.u4R6OCLx014831@mx0a-001b2d01.pphosted.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 27 May 2016, Aneesh Kumar K.V wrote:

> When we converted the asm routines to C functions, we missed updating
> HPTE_R_R based on _PAGE_ACCESSED. ASM code used to copy over the lower
> bits from pte via.
> 
> andi.	r3,r30,0x1fe		/* Get basic set of flags */
> 
> Fixes: 'commit 89ff725051d1 ("powerpc/mm: Convert __hash_page_64K to C")'
> 
> We also don't set C bit always with this patch. This was added by
> 'commit c5cf0e30bf3d8 ("[PATCH] powerpc: Fix buglet with MMU hash management")'
> 
> With hash64, we need to make sure that hardware doesn't do a pte update
> directly. This is because we do end up with entries in TLB with no hash
> page table entry. This happens because when we find hash bucket full,
> we "evict" a more/less random entry from it. When we do that we don't
> invalidate the TLB (hpte_remove) because we assume the old translation
> is still technically "valid". For more info look at
> 'commit 0608d692463(" powerpc/mm: Always invalidate tlb on hpte invalidate and
> update")'. Now that implies that hardware should never do a writeback to
> update 'R' or 'C' hpte bits.
> 
> Commitc 5cf0e30bf3d8 did that for 'C' bit by enabling 'C' bit always.
> We don't really need to do that because we never map a RW pte entry
> without setting 'C' bit. on READ fault on a RW pte entry, we still map
> it READ only, hence a store update in the page will still cause a hash
> pte fault.
> 
> This patch reverts the 'C' update part of the c5cf0e30bf3d8
> ("[PATCH] powerpc: Fix buglet with MMU hash management") and retain
> the updatepp part.
> - If we hit the updatepp path on native, the old code without that
>   commit, would fail to set C bcause native_hpte_updatepp()
>   was implemented to filter the same bits as H_PROTECT and not let C
>   through thus we would "upgrade" a RO HPTE to RW without setting C
>   thus causing the bug. So the real fix in that commit was the change
>   to native_hpte_updatepp
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 9c594ea99149..76fa5f3eb450 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -159,6 +159,19 @@ static struct mmu_psize_def mmu_psize_defaults_gp[] = {
>  	},
>  };
>  
> +/*
> + * 'R' and 'C' update notes:
> + *  - Under pHyp or KVM, the updatepp path will not set C, thus it *will*
> + *     create writeable HPTEs without C set, because the hcall H_PROTECT
> + *     that we use in that case will not update C
> + *  - The above is however not a problem, because we also don't do that
> + *     fancy "no flush" variant of eviction and we use H_REMOVE which will
> + *     do the right thing and thus we don't have the race I described earlier
> + *
> + *    - Under bare metal,  we do have the race, so we need R and C set
> + *    - We make sure R is always set and never lost
> + *    - C is _PAGE_DIRTY, and *should* always be set for a writeable mapping
> + */
>  unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  {
>  	unsigned long rflags = 0;
> @@ -186,9 +199,14 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  			rflags |= 0x1;
>  	}
>  	/*
> -	 * Always add "C" bit for perf. Memory coherence is always enabled
> +	 * We can't allow hardware to update hpte bits. Hence always
> +	 * set 'R' bit and set 'C' if it is a write fault
> +	 * Memory coherence is always enabled
>  	 */
> -	rflags |=  HPTE_R_C | HPTE_R_M;
> +	rflags |=  HPTE_R_R | HPTE_R_M;
> +
> +	if (pteflags & _PAGE_DIRTY)
> +		rflags |= HPTE_R_C;
>  	/*
>  	 * Add in WIG bits
>  	 */
> -- 
> 2.7.4

Thanks a lot for the patch: I'm just starting to try it out.

I had hoped to try it on 4.7-rc1, but found yesterday that rc1 has at
least two issues (not specific to powerpc) with OOMing and leaking
memory, that I've no chance of sustaining my swapping load on it.
I'll hope at least one of them gets fixed by rc2 and try again then.

So I've applied your patch to v4.5 and v4.6, and set v4.6 going for now.
But if all goes well, I won't be able to report back with confidence for
a couple of days.

I don't mean to be churlish, and subtract from your triumph in tracking
this down (assuming you have), but that commit log... okay, it's intended
for powerpc mmu experts, not me, but if it hasn't already gone into git,
then a rewrite could be very helpful.

I gather that C is a bit as well as a language :) and there is a code
comment which helped me by mentioning "C is _PAGE_DIRTY, and *should*
always be set for a writeable mapping" (though I wonder what imposes
that "should" - certainly not core mm); which was the first mention
of "dirty" or "modified" in the whole thing.

And it needs a Cc to stable.  And the patch title: "Fix the reference
bit update"?  But this is about dirty bit, not referenced bit, isn't it?
If it's just about referenced bit, then I don't see how we would have
corruption before the fix (but again, I'm ignorant of powerpc mmu).

Many thanks, I hope, for the fix: I shall report back.

Hugh
