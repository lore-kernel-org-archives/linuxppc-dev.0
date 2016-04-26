Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qv7K02NZXzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 13:06:12 +1000 (AEST)
Received: by mail-pa0-x22b.google.com with SMTP id zm5so1155749pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 20:06:12 -0700 (PDT)
Subject: Re: [PATCH V2 54/68] powerpc/mm: Update pte filter for radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-55-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571EDB1E.1060005@gmail.com>
Date: Tue, 26 Apr 2016 13:06:06 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-55-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> ---
>  arch/powerpc/mm/pgtable.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 115a0a19d5a2..0a9658fbf8b9 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -82,6 +82,9 @@ static struct page *maybe_pte_to_page(pte_t pte)
>  
>  static pte_t set_pte_filter(pte_t pte)
>  {
> +	if (radix_enabled())
> +		return pte;
> +
>  	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
>  	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
>  				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
> 

Acked-by: Balbir Singh <bsingharora@gmail.com>
