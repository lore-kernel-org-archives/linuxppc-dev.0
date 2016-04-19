Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzGR5NxvzDqL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:49:35 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id c20so4795021pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:49:35 -0700 (PDT)
Subject: Re: [PATCH v8 33/45] powerpc/powernv: Simplify pnv_eeh_reset()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-34-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715F116.8090202@ozlabs.ru>
Date: Tue, 19 Apr 2016 18:49:26 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-34-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> This drops unnecessary nested if statements in pnv_eeh_reset() to
> improve the code readability. After the changes, the unused local
> variable "ret" is dropped as well. No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>



Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 67 +++++++++++++---------------
>   1 file changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 69e41ce..9226df1 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1009,8 +1009,9 @@ static int pnv_eeh_reset_vf_pe(struct eeh_pe *pe, int option)
>   static int pnv_eeh_reset(struct eeh_pe *pe, int option)
>   {
>   	struct pci_controller *hose = pe->phb;
> +	struct pnv_phb *phb;
>   	struct pci_bus *bus;
> -	int ret;
> +	int64_t rc;
>
>   	/*
>   	 * For PHB reset, we always have complete reset. For those PEs whose
> @@ -1026,45 +1027,39 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
>   	 * reset. The side effect is that EEH core has to clear the frozen
>   	 * state explicitly after BAR restore.
>   	 */
> -	if (pe->type & EEH_PE_PHB) {
> -		ret = pnv_eeh_phb_reset(hose, option);
> -	} else {
> -		struct pnv_phb *phb;
> -		s64 rc;
> +	if (pe->type & EEH_PE_PHB)
> +		return pnv_eeh_phb_reset(hose, option);
>
> -		/*
> -		 * The frozen PE might be caused by PAPR error injection
> -		 * registers, which are expected to be cleared after hitting
> -		 * frozen PE as stated in the hardware spec. Unfortunately,
> -		 * that's not true on P7IOC. So we have to clear it manually
> -		 * to avoid recursive EEH errors during recovery.
> -		 */
> -		phb = hose->private_data;
> -		if (phb->model == PNV_PHB_MODEL_P7IOC &&
> -		    (option == EEH_RESET_HOT ||
> -		    option == EEH_RESET_FUNDAMENTAL)) {
> -			rc = opal_pci_reset(phb->opal_id,
> -					    OPAL_RESET_PHB_ERROR,
> -					    OPAL_ASSERT_RESET);
> -			if (rc != OPAL_SUCCESS) {
> -				pr_warn("%s: Failure %lld clearing "
> -					"error injection registers\n",
> -					__func__, rc);
> -				return -EIO;
> -			}
> +	/*
> +	 * The frozen PE might be caused by PAPR error injection
> +	 * registers, which are expected to be cleared after hitting
> +	 * frozen PE as stated in the hardware spec. Unfortunately,
> +	 * that's not true on P7IOC. So we have to clear it manually
> +	 * to avoid recursive EEH errors during recovery.
> +	 */
> +	phb = hose->private_data;
> +	if (phb->model == PNV_PHB_MODEL_P7IOC &&
> +	    (option == EEH_RESET_HOT ||
> +	     option == EEH_RESET_FUNDAMENTAL)) {
> +		rc = opal_pci_reset(phb->opal_id,
> +				    OPAL_RESET_PHB_ERROR,
> +				    OPAL_ASSERT_RESET);
> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("%s: Failure %lld clearing error injection registers\n",
> +				__func__, rc);
> +			return -EIO;
>   		}
> -
> -		bus = eeh_pe_bus_get(pe);
> -		if (pe->type & EEH_PE_VF)
> -			ret = pnv_eeh_reset_vf_pe(pe, option);
> -		else if (pci_is_root_bus(bus) ||
> -			pci_is_root_bus(bus->parent))
> -			ret = pnv_eeh_root_reset(hose, option);
> -		else
> -			ret = pnv_eeh_bridge_reset(bus->self, option);
>   	}
>
> -	return ret;
> +	bus = eeh_pe_bus_get(pe);
> +	if (pe->type & EEH_PE_VF)
> +		return pnv_eeh_reset_vf_pe(pe, option);
> +
> +	if (pci_is_root_bus(bus) ||
> +	    pci_is_root_bus(bus->parent))
> +		return pnv_eeh_root_reset(hose, option);
> +
> +	return pnv_eeh_bridge_reset(bus->self, option);
>   }
>
>   /**
>


-- 
Alexey
