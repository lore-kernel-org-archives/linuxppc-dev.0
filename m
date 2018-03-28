Return-Path: <srs0=kr7c=gs=ozlabs.ru=aik@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409qpc2rYXzF2D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:21:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 409qpc0vySz8syw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:21:28 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 409qpb2rBkz9ryk
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2018 12:21:26 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id u86so349480pfd.2
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2018 18:21:26 -0700 (PDT)
Subject: Re: [PATCH] powerpc/powernv: Fix sparse data type warnings in
 pci-ioda.c
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
References: <20180328004442.GA29865@fergus.ozlabs.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b39932f7-1486-7106-6920-8795ae694c7d@ozlabs.ru>
Date: Wed, 28 Mar 2018 12:21:19 +1100
MIME-Version: 1.0
In-Reply-To: <20180328004442.GA29865@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/3/18 11:44 am, Paul Mackerras wrote:
> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> The value passed to __raw_rm_writeq() and __raw_writeq() should be "u64"
> and "unsigned long". This fixes warning reported by sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/pci-ioda.o
>   arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
>   warning: incorrect type in argument 1 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
>   expected unsigned long long [unsigned] [usertype] val
>   arch/powerpc/platforms/powernv/pci-ioda.c:1794:41: \
>   got restricted __be64 [usertype] <noident>
>   arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
>   warning: incorrect type in argument 1 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
>   expected unsigned long [unsigned] v
>   arch/powerpc/platforms/powernv/pci-ioda.c:1796:38: \
>   got restricted __be64 [usertype] <noident>
> 
> This also fixes another warning reported by sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/pci-ioda.o
>         :
>   arch/powerpc/platforms/powernv/pci-ioda.c:2647:45: \
>   warning: cast to restricted __be64
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index a6c92c7..71de087 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1976,9 +1976,11 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
>          mb(); /* Ensure above stores are visible */
>          while (start <= end) {
>  		if (rm)
> -			__raw_rm_writeq(cpu_to_be64(start), invalidate);
> +			__raw_rm_writeq((__force u64)cpu_to_be64(start),
> +					invalidate);
>  		else
> -			__raw_writeq(cpu_to_be64(start), invalidate);
> +			__raw_writeq((__force unsigned long)cpu_to_be64(start),
> +				     invalidate);
>                  start += inc;
>          }
>  
> @@ -2055,9 +2057,10 @@ static void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
>  
>  	mb(); /* Ensure previous TCE table stores are visible */
>  	if (rm)
> -		__raw_rm_writeq(cpu_to_be64(val), invalidate);
> +		__raw_rm_writeq((__force u64)cpu_to_be64(val), invalidate);
>  	else
> -		__raw_writeq(cpu_to_be64(val), invalidate);
> +		__raw_writeq((__force unsigned long)cpu_to_be64(val),
> +			     invalidate);
>  }
>  
>  static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
> @@ -2067,7 +2070,7 @@ static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
>  	unsigned long val = PHB3_TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
>  
>  	mb(); /* Ensure above stores are visible */
> -	__raw_writeq(cpu_to_be64(val), invalidate);
> +	__raw_writeq((__force unsigned long)cpu_to_be64(val), invalidate);
>  }
>  
>  static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
> @@ -2090,9 +2093,11 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
>  
>  	while (start <= end) {
>  		if (rm)
> -			__raw_rm_writeq(cpu_to_be64(start), invalidate);
> +			__raw_rm_writeq((__force u64)cpu_to_be64(start),
> +					invalidate);
>  		else
> -			__raw_writeq(cpu_to_be64(start), invalidate);
> +			__raw_writeq((__force unsigned long)cpu_to_be64(start),
> +				     invalidate);
>  		start += inc;
>  	}
>  }
> @@ -2864,7 +2869,8 @@ static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>  		u64 *tmp = (u64 *) addr_ul;
>  
>  		for (i = 0; i < size; ++i) {
> -			unsigned long hpa = be64_to_cpu(tmp[i]);
> +			unsigned long hpa =
> +				be64_to_cpu((__force __be64)(tmp[i]));
>  
>  			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
>  				continue;
> 


-- 
Alexey
