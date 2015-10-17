Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A68C1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:15:31 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 22:15:30 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 077632CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:15:27 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HCFI5R59900136
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:15:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HCErxi020249
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:14:54 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
Cc: criu@openvz.org
Subject: Re: [PATCH 2/3] mm: clear_soft_dirty_pmd requires THP
In-Reply-To: <c56e0cee475c34bda846ffbf1cc0e541ccb6b9b4.1444995096.git.ldufour@linux.vnet.ibm.com>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
 <c56e0cee475c34bda846ffbf1cc0e541ccb6b9b4.1444995096.git.ldufour@linux.vnet.ibm.com>
Date: Sat, 17 Oct 2015 17:44:33 +0530
Message-ID: <87d1wditee.fsf@linux.vnet.ibm.com>
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

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> Don't build clear_soft_dirty_pmd() if the transparent huge pages are
> not enabled.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  fs/proc/task_mmu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c9454ee39b28..fa847a982a9f 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -762,7 +762,14 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
>  	}
>  }
> +#else
> +static inline void clear_soft_dirty(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *pte)
> +{
> +}
> +#endif
>
> +#if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmdp)
>  {
> @@ -776,14 +783,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>
>  	set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>  }
> -
>  #else
> -
> -static inline void clear_soft_dirty(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *pte)
> -{
> -}
> -
>  static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmdp)
>  {
> -- 
> 1.9.1
