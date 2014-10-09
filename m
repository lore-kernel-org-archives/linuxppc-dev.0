Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 727B11A19CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 02:05:21 +1100 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 92D6A1400BB
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2014 02:05:20 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 9 Oct 2014 20:35:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH v4 05/16] powerpc/mm: Export mmu_kernel_ssize and
 mmu_linear_psize
In-Reply-To: <1412758505-23495-6-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
 <1412758505-23495-6-git-send-email-mikey@neuling.org>
Date: Thu, 09 Oct 2014 20:35:02 +0530
Message-ID: <871tqh2sip.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 imunsie@au1.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> Export mmu_kernel_ssize and mmu_linear_psize.  These are needed by the cxl
> driver which has it's own MMU.  To setup the MMU cxl needs access to these.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 5c0738d..bbdb054 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -98,6 +98,7 @@ unsigned long htab_size_bytes;
>  unsigned long htab_hash_mask;
>  EXPORT_SYMBOL_GPL(htab_hash_mask);
>  int mmu_linear_psize = MMU_PAGE_4K;
> +EXPORT_SYMBOL_GPL(mmu_linear_psize);
>  int mmu_virtual_psize = MMU_PAGE_4K;
>  int mmu_vmalloc_psize = MMU_PAGE_4K;
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> @@ -105,6 +106,7 @@ int mmu_vmemmap_psize = MMU_PAGE_4K;
>  #endif
>  int mmu_io_psize = MMU_PAGE_4K;
>  int mmu_kernel_ssize = MMU_SEGSIZE_256M;
> +EXPORT_SYMBOL_GPL(mmu_kernel_ssize);
>  int mmu_highuser_ssize = MMU_SEGSIZE_256M;
>  u16 mmu_slb_size = 64;
>  EXPORT_SYMBOL_GPL(mmu_slb_size);
> -- 
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
