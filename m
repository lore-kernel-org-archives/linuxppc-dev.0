Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP41j5Dy9zDw7M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:08:25 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id e9so1188489pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:08:25 -0800 (PST)
Subject: Re: [PATCH v5 3/7] powerpc/mm/hugetlb: Handle hugepage size supported
 by hash config
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161123111003.459-3-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <11917d34-3bb8-1d79-2753-ead02ebe7ce3@gmail.com>
Date: Thu, 24 Nov 2016 01:08:31 +1100
MIME-Version: 1.0
In-Reply-To: <20161123111003.459-3-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/11/16 22:09, Aneesh Kumar K.V wrote:
> W.r.t hash page table config, we support 16MB and 16GB as the hugepage
> size. Update the hstate_get_psize to handle 16M and 16G.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 499268045306..d9c283f95e05 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -21,6 +21,10 @@ static inline int hstate_get_psize(struct hstate *hstate)
>  		return MMU_PAGE_2M;
>  	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
>  		return MMU_PAGE_1G;
> +	else if (shift == mmu_psize_defs[MMU_PAGE_16M].shift)
> +		return MMU_PAGE_16M;
> +	else if (shift == mmu_psize_defs[MMU_PAGE_16G].shift)
> +		return MMU_PAGE_16G;
>  	else {
>  		WARN(1, "Wrong huge page shift\n");
>  		return mmu_virtual_psize;
> 

Is this related to this patch series? Radix can't do these sizes

Balbir
