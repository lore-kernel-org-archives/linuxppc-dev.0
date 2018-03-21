Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dPr2QpWzF1dw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:18:56 +1100 (AEDT)
Received: by mail-io0-x244.google.com with SMTP id b20so5137406iof.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:18:56 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id e193sm2110776ioe.35.2018.03.20.22.18.52
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:18:53 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] powerpc/eeh: Factor out common code
 eeh_reset_device()
To: linuxppc-dev@lists.ozlabs.org
References: <168a19fad005f7f3dffe700978db75e7e976b946.1521523452.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a2d18307-15ab-7b08-36ce-d6d52a4f25ea@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:18:50 +1100
MIME-Version: 1.0
In-Reply-To: <168a19fad005f7f3dffe700978db75e7e976b946.1521523452.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/3/18 1:06 pm, Sam Bobroff wrote:
> The caller will always pass NULL for 'rmv_data' when
> 'eeh_aware_driver' is true, so the first two calls to
> eeh_pe_dev_traverse() can be combined without changing behaviour as
> can the two arms of the final 'if' block.
> 
> This should not change behaviour.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
> ====== v2 -> v3: ======
> Corrected two missed cases of eeh_aware_driver -> driver_eeh_aware.
> 
>  arch/powerpc/kernel/eeh_driver.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 93fc22e791fa..43ceb6263cd8 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -647,16 +647,12 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  	 * into pci_hp_add_devices().
>  	 */
>  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
> -	if (!driver_eeh_aware) {
> -		if (pe->type & EEH_PE_VF) {
> -			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
> -		} else {
> -			pci_lock_rescan_remove();
> -			pci_hp_remove_devices(bus);
> -			pci_unlock_rescan_remove();
> -		}
> -	} else {
> +	if (driver_eeh_aware || (pe->type & EEH_PE_VF)) {
>  		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
> +	} else {
> +		pci_lock_rescan_remove();
> +		pci_hp_remove_devices(bus);
> +		pci_unlock_rescan_remove();
>  	}
>  
>  	/*
> @@ -691,8 +687,9 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  	 * the device up before the scripts have taken it down,
>  	 * potentially weird things happen.
>  	 */
> -	if (!driver_eeh_aware) {
> -		pr_info("EEH: Sleep 5s ahead of complete hotplug\n");
> +	if (!driver_eeh_aware || rmv_data->removed) {
> +		pr_info("EEH: Sleep 5s ahead of %s hotplug\n",
> +			(driver_eeh_aware ? "partial" : "complete"));
>  		ssleep(5);
>  
>  		/*
> @@ -705,19 +702,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  		if (pe->type & EEH_PE_VF) {
>  			eeh_add_virt_device(edev, NULL);
>  		} else {
> -			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
> +			if (!driver_eeh_aware)
> +				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
>  			pci_hp_add_devices(bus);
>  		}
> -	} else if (rmv_data->removed) {
> -		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
> -		ssleep(5);
> -
> -		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
> -		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
> -		if (pe->type & EEH_PE_VF)
> -			eeh_add_virt_device(edev, NULL);
> -		else
> -			pci_hp_add_devices(bus);
>  	}
>  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>  
> 


-- 
Alexey
