Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BCF91A126E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 16:28:54 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 21 Nov 2014 15:28:53 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5F900357805E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 16:28:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAL5UcHC30343188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 16:30:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAL5SjBi013790
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 16:28:46 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
In-Reply-To: <1416478790-27522-4-git-send-email-mgorman@suse.de>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
 <1416478790-27522-4-git-send-email-mgorman@suse.de>
Date: Fri, 21 Nov 2014 10:58:34 +0530
Message-ID: <87lhn56s1p.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>,
 Dave Jones <davej@redhat.com>, LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mel Gorman <mgorman@suse.de> writes:

> Convert existing users of pte_numa and friends to the new helper. Note
> that the kernel is broken after this patch is applied until the other
> page table modifiers are also altered. This patch layout is to make
> review easier.
>

.....

> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index c90e602..b5d58d3 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -173,7 +173,13 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  		pte_t pte)
>  {
>  #ifdef CONFIG_DEBUG_VM
> -	WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
> +	/*
> +	 * When handling numa faults, we already have the pte marked
> +	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
> +	 * Hence we can use set_pte_at for them.
> +	 */
> +	WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
> +		(_PAGE_PRESENT | _PAGE_USER));
>  #endif


This can be VM_WARN_ON with #ifdef removed.

>  	/* Note: mm->context.id might not yet have been assigned as
>  	 * this context might not have been activated yet when this
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c

-aneesh
