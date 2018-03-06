Return-Path: <dja@axtens.net>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwJYt2N1RzF0j2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 12:08:33 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id 61-v6so10881180plf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 17:08:33 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/9] powerpc/eeh: Remove eeh_handle_event()
In-Reply-To: <d3d01073da02a5eb844cc8998fdac602b8121b62.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <d3d01073da02a5eb844cc8998fdac602b8121b62.1520294174.git.sam.bobroff@au1.ibm.com>
Date: Tue, 06 Mar 2018 12:08:26 +1100
Message-ID: <87tvtuc8ol.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sam,

> The function eeh_handle_event(pe) does nothing other than switching
> between calling eeh_handle_normal_event(pe) and
> eeh_handle_special_event(). However it is only called in two places,
> one where pe can't be NULL and the other where it must be NULL (see
> eeh_event_handler()) so it does nothing but obscure the flow of
> control.
I've verified this.

>
> So, remove it.
Sounds good.


> + * While PHB detects address or data parity errors on particular PCI
> + * slot, the associated PE will be frozen. Besides, DMA's occurring
> + * to wild addresses (which usually happen due to bugs in device
> + * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
> + * #PERR or other misc PCI-related errors also can trigger EEH errors.
> + *
> + * Recovery process consists of unplugging the device driver (which
> + * generated hotplug events to userspace), then issuing a PCI #RST to
> + * the device, then reconfiguring the PCI config space for all bridges
> + * & devices under this slot, and then finally restarting the device
> + * drivers (which cause a second set of hotplug events to go out to
> + * userspace).
> + *
So this is the comment from eeh_handle_event. This seems as good a place
as any to put it. (At some point someone should check if it lines up
well with Documentation/powerpc/eeh-pci-error-recovery.txt but it can wait.)


In conclusion:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Thanks Sam!

Regards,
Daniel
>   * Returns true if @pe should no longer be used, else false.
>   */
> -static bool eeh_handle_normal_event(struct eeh_pe *pe)
> +bool eeh_handle_normal_event(struct eeh_pe *pe)
>  {
>  	struct pci_bus *frozen_bus;
>  	struct eeh_dev *edev, *tmp;
> @@ -942,7 +955,7 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
>   * specific PE.  Iterates through possible failures and handles them as
>   * necessary.
>   */
> -static void eeh_handle_special_event(void)
> +void eeh_handle_special_event(void)
>  {
>  	struct eeh_pe *pe, *phb_pe;
>  	struct pci_bus *bus;
> @@ -1049,28 +1062,3 @@ static void eeh_handle_special_event(void)
>  			break;
>  	} while (rc != EEH_NEXT_ERR_NONE);
>  }
> -
> -/**
> - * eeh_handle_event - Reset a PCI device after hard lockup.
> - * @pe: EEH PE
> - *
> - * While PHB detects address or data parity errors on particular PCI
> - * slot, the associated PE will be frozen. Besides, DMA's occurring
> - * to wild addresses (which usually happen due to bugs in device
> - * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
> - * #PERR or other misc PCI-related errors also can trigger EEH errors.
> - *
> - * Recovery process consists of unplugging the device driver (which
> - * generated hotplug events to userspace), then issuing a PCI #RST to
> - * the device, then reconfiguring the PCI config space for all bridges
> - * & devices under this slot, and then finally restarting the device
> - * drivers (which cause a second set of hotplug events to go out to
> - * userspace).
> - */
> -void eeh_handle_event(struct eeh_pe *pe)
> -{
> -	if (pe)
> -		eeh_handle_normal_event(pe);
> -	else
> -		eeh_handle_special_event();
> -}
> diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
> index accbf8b5fd46..872bcfe8f90e 100644
> --- a/arch/powerpc/kernel/eeh_event.c
> +++ b/arch/powerpc/kernel/eeh_event.c
> @@ -81,10 +81,10 @@ static int eeh_event_handler(void * dummy)
>  				pr_info("EEH: Detected PCI bus error on "
>  					"PHB#%x-PE#%x\n",
>  					pe->phb->global_number, pe->addr);
> -			eeh_handle_event(pe);
> +			eeh_handle_normal_event(pe);
>  			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>  		} else {
> -			eeh_handle_event(NULL);
> +			eeh_handle_special_event();
>  		}
>  
>  		kfree(event);
> -- 
> 2.16.1.74.g9b0b1f47b
