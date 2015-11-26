Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60A911A033E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:33:57 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 23:33:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 707C72BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:33:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAQDXhAl65929312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:33:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAQDXITc017820
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:33:18 +1100
Message-ID: <56570A0B.6040209@linux.vnet.ibm.com>
Date: Thu, 26 Nov 2015 19:02:59 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 26/31] powerpc/mm: Remove the dependency on pte bit
 position in asm code
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> We should not expect pte bit position in asm code. Simply
> by moving part of that to C

There is a full stop missing in the second sentence. The commit
message here does not tell about why we would want to process the
page access flags or other PTE flags in the C code. Was it needed
at this stage of this series during PTE change or its just an
improvement which could have segregated out before.

> 
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 16 +++-------------
>  arch/powerpc/mm/hash_utils_64.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 0a0399c2af11..34920f11dbdd 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1556,28 +1556,18 @@ do_hash_page:
>  	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
>  	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
>  	bne	77f			/* then don't call hash_page now */
> -	/*
> -	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
> -	 * accessing a userspace segment (even from the kernel). We assume
> -	 * kernel addresses always have the high bit set.
> -	 */
> -	rlwinm	r4,r4,32-25+9,31-9,31-9	/* DSISR_STORE -> _PAGE_RW */
> -	rotldi	r0,r3,15		/* Move high bit into MSR_PR posn */
> -	orc	r0,r12,r0		/* MSR_PR | ~high_bit */
> -	rlwimi	r4,r0,32-13,30,30	/* becomes _PAGE_USER access bit */
> -	ori	r4,r4,1			/* add _PAGE_PRESENT */
> -	rlwimi	r4,r5,22+2,31-2,31-2	/* Set _PAGE_EXEC if trap is 0x400 */
>  
>  	/*
>  	 * r3 contains the faulting address
> -	 * r4 contains the required access permissions
> +	 * r4 msr
>  	 * r5 contains the trap number
>  	 * r6 contains dsisr
>  	 *
>  	 * at return r3 = 0 for success, 1 for page fault, negative for error
>  	 */
> +        mr 	r4,r12
>  	ld      r6,_DSISR(r1)
> -	bl	hash_page		/* build HPTE if possible */
> +	bl	__hash_page		/* build HPTE if possible */

>  	cmpdi	r3,0			/* see if hash_page succeeded */

The comment needs to change to __hash_page ^^^^^^^^^^^^^^^^^^^^^^^^.

>  
>  	/* Success */
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index db35e7d83088..04d549527eaa 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1162,6 +1162,35 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
>  }
>  EXPORT_SYMBOL_GPL(hash_page);

So we are still keeping hash_page as an exported symbol here as
there are consumers for it ?
 
>  
> +int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
> +		unsigned long dsisr)
> +{
> +	unsigned long access = _PAGE_PRESENT;
> +	unsigned long flags = 0;
> +	struct mm_struct *mm = current->mm;
> +
> +	if (REGION_ID(ea) == VMALLOC_REGION_ID)
> +		mm = &init_mm;
> +
> +	if (dsisr & DSISR_NOHPTE)
> +		flags |= HPTE_NOHPTE_UPDATE;
> +
> +	if (dsisr & DSISR_ISSTORE)
> +		access |= _PAGE_RW;
> +	/*
> +	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
> +	 * accessing a userspace segment (even from the kernel). We assume
> +	 * kernel addresses always have the high bit set.
> +	 */
> +	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
> +		access |= _PAGE_USER;
> +
> +	if (trap == 0x400)
> +		access |= _PAGE_EXEC;
> +
> +	return hash_page_mm(mm, ea, access, trap, flags);
> +}

There are some code similarity between hash_page and __hash_page
above. Cant we consolidate some part of it ?
