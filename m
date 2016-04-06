Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg1Mg6XMtzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 19:56:30 +1000 (AEST)
Received: by mail-wm0-f65.google.com with SMTP id o129so2169155wmo.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Apr 2016 02:56:30 -0700 (PDT)
Date: Wed, 6 Apr 2016 11:56:24 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 James Dykman <jdykman@us.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()
Message-ID: <20160406095623.GA24283@dhcp22.suse.cz>
References: <20160405190547.GA12673@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160405190547.GA12673@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 05-04-16 12:05:47, Sukadev Bhattiprolu wrote:
[...]
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index d991b9e..081f679 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -81,6 +81,13 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>  	if (! new)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Make sure other cpus find the hugepd set only after a
> +	 * properly initialized page table is visible to them.
> +	 * For more details look for comment in __pte_alloc().
> +	 */
> +	smp_wmb();
> +

what is the pairing memory barrier?

>  	spin_lock(&mm->page_table_lock);
>  #ifdef CONFIG_PPC_FSL_BOOK3E
>  	/*
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
