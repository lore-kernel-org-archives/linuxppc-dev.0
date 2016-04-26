Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvChb14thzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 16:23:27 +1000 (AEST)
Received: by mail-pf0-x22a.google.com with SMTP id y69so2878637pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 23:23:27 -0700 (PDT)
Subject: Re: [PATCH V2 56/68] powerpc/radix: update mmu cache
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-57-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571F0958.40007@gmail.com>
Date: Tue, 26 Apr 2016 16:23:20 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-57-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> With radix there is no mmu cache. Hence we don't need to do much
> in update_mmu_cache.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/mem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index f980da6d7569..3164ce720b3e 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -499,6 +499,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  	 * called with either mm->page_table_lock held or ptl lock held
>  	 */
>  	unsigned long access = 0, trap;
> +	if (radix_enabled())
> +		return;
>  
>  	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
>  	if (!pte_young(*ptep) || address >= TASK_SIZE)
> 
Acked-by: Balbir Singh <bsingharora@gmail.com>
