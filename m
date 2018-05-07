Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fqc96d7mzF1fm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 03:39:05 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w47HZAWw000846
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 13:39:03 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2htqcpu0fa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 13:39:02 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 7 May 2018 18:39:01 +0100
Subject: Re: [PATCH v2 4/7] ocxl: Rename pnv_ocxl_spa_remove_pe to clarify
 it's action
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 19:38:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <80b45171-3708-d252-8f57-310f23eb18cd@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The function removes the process element from NPU cache.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   arch/powerpc/include/asm/pnv-ocxl.h   | 2 +-
>   arch/powerpc/platforms/powernv/ocxl.c | 4 ++--
>   drivers/misc/ocxl/link.c              | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index f6945d3bc971..208b5503f4ed 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -28,7 +28,7 @@ extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
>   extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
>   			void **platform_data);
>   extern void pnv_ocxl_spa_release(void *platform_data);
> -extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
> +extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
> 
>   extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>   extern void pnv_ocxl_free_xive_irq(u32 irq);
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index fa9b53af3c7b..8c65aacda9c8 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -475,7 +475,7 @@ void pnv_ocxl_spa_release(void *platform_data)
>   }
>   EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
> 
> -int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
> +int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>   {
>   	struct spa_data *data = (struct spa_data *) platform_data;
>   	int rc;
> @@ -483,7 +483,7 @@ int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
>   	rc = opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
>   	return rc;
>   }
> -EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe);
> +EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe_from_cache);
> 
>   int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr)
>   {
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index f30790582dc0..656e8610eec2 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -599,7 +599,7 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
>   	 * On powerpc, the entry needs to be cleared from the context
>   	 * cache of the NPU.
>   	 */
> -	rc = pnv_ocxl_spa_remove_pe(link->platform_data, pe_handle);
> +	rc = pnv_ocxl_spa_remove_pe_from_cache(link->platform_data, pe_handle);
>   	WARN_ON(rc);
> 
>   	pe_data = radix_tree_delete(&spa->pe_tree, pe_handle);
> 
