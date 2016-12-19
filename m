Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thvyZ4lthzDt0P
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 20:00:38 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ8xQ6I100182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 04:00:36 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27eaarvxqs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 04:00:35 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 02:00:35 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 2/5] powerpc/mm: refactor {create,
 remove}_section_mapping()
In-Reply-To: <1481831443-22761-3-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-3-git-send-email-arbab@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 14:30:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737hkuwcz.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> Change {create,remove}_section_mapping() to be wrappers around functions
> prefixed with "hash__".
>
> This is preparation for the addition of their "radix__" variants. No
> functional change.
>

I think this can go upstream now ? To fixup broken hotplug with radix ?

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h |  5 +++++
>  arch/powerpc/mm/hash_utils_64.c           |  4 ++--
>  arch/powerpc/mm/pgtable-book3s64.c        | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index f61cad3..dd90574 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -201,6 +201,11 @@ extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
>  					      unsigned long phys);
>  extern void hash__vmemmap_remove_mapping(unsigned long start,
>  				     unsigned long page_size);
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int hash__create_section_mapping(unsigned long start, unsigned long end);
> +int hash__remove_section_mapping(unsigned long start, unsigned long end);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index b9a062f..96a4fb7 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -743,7 +743,7 @@ static unsigned long __init htab_get_table_size(void)
>  }
>
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -int create_section_mapping(unsigned long start, unsigned long end)
> +int hash__create_section_mapping(unsigned long start, unsigned long end)
>  {
>  	int rc = htab_bolt_mapping(start, end, __pa(start),
>  				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
> @@ -757,7 +757,7 @@ int create_section_mapping(unsigned long start, unsigned long end)
>  	return rc;
>  }
>
> -int remove_section_mapping(unsigned long start, unsigned long end)
> +int hash__remove_section_mapping(unsigned long start, unsigned long end)
>  {
>  	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
>  				     mmu_kernel_ssize);
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index ebf9782..653ff6c 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -126,3 +126,21 @@ void mmu_cleanup_all(void)
>  	else if (mmu_hash_ops.hpte_clear_all)
>  		mmu_hash_ops.hpte_clear_all();
>  }
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int create_section_mapping(unsigned long start, unsigned long end)
> +{
> +	if (radix_enabled())
> +		return -ENODEV;
> +
> +	return hash__create_section_mapping(start, end);
> +}
> +
> +int remove_section_mapping(unsigned long start, unsigned long end)
> +{
> +	if (radix_enabled())
> +		return -ENODEV;
> +
> +	return hash__remove_section_mapping(start, end);
> +}
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> -- 
> 1.8.3.1
