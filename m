Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlCjw61PTzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 15:56:52 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id ot11so27407676pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 22:56:52 -0700 (PDT)
Subject: Re: [PATCH v8 06/45] powerpc/powernv: Reorder fields in struct pnv_phb
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-7-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DDF9C.2040500@ozlabs.ru>
Date: Wed, 13 Apr 2016 15:56:44 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-7-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> This moves those fields in struct pnv_phb that are related to PE
> allocation around. No logical change.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/powernv/pci.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 78f035e..f2a1452 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -140,15 +140,14 @@ struct pnv_phb {
>   		unsigned int		io_segsize;
>   		unsigned int		io_pci_base;
>
> -		/* PE allocation bitmap */
> -		unsigned long		*pe_alloc;
> -		/* PE allocation mutex */
> +		/* PE allocation */
>   		struct mutex		pe_alloc_mutex;
> +		unsigned long		*pe_alloc;
> +		struct pnv_ioda_pe	*pe_array;
>
>   		/* M32 & IO segment maps */
>   		unsigned int		*m32_segmap;
>   		unsigned int		*io_segmap;
> -		struct pnv_ioda_pe	*pe_array;
>
>   		/* IRQ chip */
>   		int			irq_chip_init;
>


-- 
Alexey
