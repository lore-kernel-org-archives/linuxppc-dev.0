Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwQmV2vLSzF0Wr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 16:48:10 +1100 (AEDT)
Message-ID: <1520315285.2077.14.camel@russell.cc>
Subject: Re: [PATCH 8/9] powerpc/eeh: Factor out common code eeh_reset_device()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 16:48:05 +1100
In-Reply-To: <fe5673642328c2e11fee269bfc7987095311f25c.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <fe5673642328c2e11fee269bfc7987095311f25c.1520294174.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-06 at 10:59 +1100, Sam Bobroff wrote:
> The caller will always pass NULL for 'rmv_data' when
> 'eeh_aware_driver' is true, so the first two calls to
> eeh_pe_dev_traverse() can be combined without changing behaviour as
> can the two arms of the final 'if' block.
> 
> This should not change behaviour.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>

minor nitpick below

>  arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++----------------
> --------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c
> b/arch/powerpc/kernel/eeh_driver.c
> index 1272f2c8cbd2..39d560e9f071 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -647,16 +647,12 @@ static int eeh_reset_device(bool
> eeh_aware_driver,
>  	 * into pci_hp_add_devices().
>  	 */
>  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
> -	if (!eeh_aware_driver) {
> -		if (pe->type & EEH_PE_VF) {
> -			eeh_pe_dev_traverse(pe, eeh_rmv_device,
> NULL);
> -		} else {
> -			pci_lock_rescan_remove();
> -			pci_hp_remove_devices(bus);
> -			pci_unlock_rescan_remove();
> -		}
> -	} else {
> +	if (eeh_aware_driver || (pe->type & EEH_PE_VF)) {
>  		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
> +	} else {
> +		pci_lock_rescan_remove();
> +		pci_hp_remove_devices(bus);
> +		pci_unlock_rescan_remove();
>  	}
>  
>  	/*
> @@ -691,8 +687,9 @@ static int eeh_reset_device(bool
> eeh_aware_driver,
>  	 * the device up before the scripts have taken it down,
>  	 * potentially weird things happen.
>  	 */
> -	if (!eeh_aware_driver) {
> -		pr_info("EEH: Sleep 5s ahead of complete
> hotplug\n");
> +	if (!eeh_aware_driver || rmv_data->removed) {
> +		pr_info("EEH: Sleep 5s ahead of %s hotplug\n",
> +			(eeh_aware_driver ? "partial" :
> "complete"));
>  		ssleep(5);
>  
>  		/*
> @@ -700,24 +697,15 @@ static int eeh_reset_device(bool
> eeh_aware_driver,
>  		 * PE. We should disconnect it so the binding can be
>  		 * rebuilt when adding PCI devices.
>  		 */
> -		edev = list_first_entry(&pe->edevs, struct eeh_dev,
> list);
> -		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
> -		if (pe->type & EEH_PE_VF) {
> -			eeh_add_virt_device(edev, NULL);
> -		} else {
> -			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
> -			pci_hp_add_devices(bus);
> -		}
> -	} else if (rmv_data->removed) {
> -		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
> -		ssleep(5);
> -
>  		edev = list_first_entry(&pe->edevs, struct eeh_dev,
> list);
>  		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
>  		if (pe->type & EEH_PE_VF)
>  			eeh_add_virt_device(edev, NULL);
> -		else
> +		else {

Put brackets around the if block now that the else block isn't a one
liner

> +			if (!eeh_aware_driver)
> +				eeh_pe_state_clear(pe,
> EEH_PE_PRI_BUS);
>  			pci_hp_add_devices(bus);
> +		}
>  	}
>  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>  
