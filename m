Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dPQ1c87zF1d5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:18:34 +1100 (AEDT)
Received: by mail-io0-x244.google.com with SMTP id r18so5136975ioa.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:18:33 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id j28sm1282442iod.84.2018.03.20.22.18.30
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:18:31 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] powerpc/eeh: Clarify arguments to
 eeh_reset_device()
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <17133177f6095a830824e54a6dcd3354ae0d04e7.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <84b36142-bfa4-bcc6-46b3-0c81df6176b4@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:18:28 +1100
MIME-Version: 1.0
In-Reply-To: <17133177f6095a830824e54a6dcd3354ae0d04e7.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:48 pm, Sam Bobroff wrote:
> It is currently difficult to understand the behaviour of
> eeh_reset_device() due to the way it's parameters are used. In
> particular, when 'bus' is NULL, it's value is still necessary so the
> same value is looked up again locally under a different name
> ('frozen_bus') but behaviour is changed.
> 
> To clarify this, add a new parameter 'driver_eeh_aware', and have the
> caller set it when it would have passed NULL for 'bus' and always pass
> a value for 'bus'. Then change any test that was on 'bus' to one on
> '!driver_eeh_aware' and replace uses of 'frozen_bus' with 'bus'.
> 
> Also update the function's comment.
> 
> This should not change behaviour.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>



Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/kernel/eeh_driver.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index cb584d72b0a5..07437d765434 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -619,17 +619,19 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>  
>  /**
>   * eeh_reset_device - Perform actual reset of a pci slot
> + * @driver_eeh_aware: Does the device's driver provide EEH support?
>   * @pe: EEH PE
>   * @bus: PCI bus corresponding to the isolcated slot
> + * @rmv_data: Optional, list to record removed devices
>   *
>   * This routine must be called to do reset on the indicated PE.
>   * During the reset, udev might be invoked because those affected
>   * PCI devices will be removed and then added.
>   */
>  static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
> -				struct eeh_rmv_data *rmv_data)
> +			    struct eeh_rmv_data *rmv_data,
> +			    bool driver_eeh_aware)
>  {
> -	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
>  	time64_t tstamp;
>  	int cnt, rc;
>  	struct eeh_dev *edev;
> @@ -645,7 +647,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  	 * into pci_hp_add_devices().
>  	 */
>  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
> -	if (bus) {
> +	if (!driver_eeh_aware) {
>  		if (pe->type & EEH_PE_VF) {
>  			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
>  		} else {
> @@ -653,7 +655,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  			pci_hp_remove_devices(bus);
>  			pci_unlock_rescan_remove();
>  		}
> -	} else if (frozen_bus) {
> +	} else if (bus) {
>  		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
>  	}
>  
> @@ -689,7 +691,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  	 * the device up before the scripts have taken it down,
>  	 * potentially weird things happen.
>  	 */
> -	if (bus) {
> +	if (!driver_eeh_aware) {
>  		pr_info("EEH: Sleep 5s ahead of complete hotplug\n");
>  		ssleep(5);
>  
> @@ -706,7 +708,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
>  			pci_hp_add_devices(bus);
>  		}
> -	} else if (frozen_bus && rmv_data->removed) {
> +	} else if (bus && rmv_data->removed) {
>  		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
>  		ssleep(5);
>  
> @@ -715,7 +717,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  		if (pe->type & EEH_PE_VF)
>  			eeh_add_virt_device(edev, NULL);
>  		else
> -			pci_hp_add_devices(frozen_bus);
> +			pci_hp_add_devices(bus);
>  	}
>  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>  
> @@ -820,7 +822,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
>  	 */
>  	if (result == PCI_ERS_RESULT_NONE) {
>  		pr_info("EEH: Reset with hotplug activity\n");
> -		rc = eeh_reset_device(pe, bus, NULL);
> +		rc = eeh_reset_device(pe, bus, NULL, false);
>  		if (rc) {
>  			pr_warn("%s: Unable to reset, err=%d\n",
>  				__func__, rc);
> @@ -872,7 +874,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
>  	/* If any device called out for a reset, then reset the slot */
>  	if (result == PCI_ERS_RESULT_NEED_RESET) {
>  		pr_info("EEH: Reset without hotplug activity\n");
> -		rc = eeh_reset_device(pe, NULL, &rmv_data);
> +		rc = eeh_reset_device(pe, bus, &rmv_data, true);
>  		if (rc) {
>  			pr_warn("%s: Cannot reset, err=%d\n",
>  				__func__, rc);
> 


-- 
Alexey
