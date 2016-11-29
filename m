Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tShLs6N3hzDvvn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 22:35:49 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id e9so16142075pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 03:35:49 -0800 (PST)
Subject: Re: [PATCH v7 2/7] powerpc/mm/hugetlb: Handle hugepage size supported
 by hash config
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161128061704.4914-3-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4dac81ab-b4cc-c2ea-d406-ef6045ea31c8@gmail.com>
Date: Tue, 29 Nov 2016 22:35:40 +1100
MIME-Version: 1.0
In-Reply-To: <20161128061704.4914-3-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/11/16 17:16, Aneesh Kumar K.V wrote:
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

Could we reorder this

We check for 2M, 1G, 16M and 16G. The likely sizes are
2M and 16M. Can we have those upfront so that the order of checks
is 2M, 16M, 1G and 16G

Balbir
