Return-Path: <dja@axtens.net>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwKRT1DPmzF1BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 12:48:04 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id ay8-v6so10932490plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 17:48:04 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/9] powerpc/eeh: Manage EEH_PE_RECOVERING inside
 eeh_handle_normal_event()
In-Reply-To: <163b24ef504d753f4abf1510d9193962bbac32b7.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <163b24ef504d753f4abf1510d9193962bbac32b7.1520294174.git.sam.bobroff@au1.ibm.com>
Date: Tue, 06 Mar 2018 12:47:57 +1100
Message-ID: <87r2oyc6uq.fsf@linkitivity.dja.id.au>
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

> Currently the EEH_PE_RECOVERING flag for a PE is managed by both the
> caller and callee of eeh_handle_normal_event() (among other places not
> considered here). This is complicated by the fact that the PE may
> or may not have been invalidated by the call.
So, I applied this patch and looked at those places. They're now
restricted to eeh_driver.c and eeh.c.

The only other place it's marked is
eeh_driver.c::eeh_pe_reset_and_recover(), which is itself only called
from eeh.c::eeh_pe_change_owner(). That is only called from 2 places,
both in eeh.c - eeh_dev_open() and eeh_dev_release(). I have not yet
wrapped my head around the logic of that.

I suspect the entire logic can have some more simplifications, but this
is definitely a good step.

I also read through your patch and have no other comments, so:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel
>
> So move the callee's handling into eeh_handle_normal_event(), which
> clarifies it and allows the return type to be changed to void (because
> it no longer needs to indicate at the PE has been invalidated).
>
> This should not change behaviour except in eeh_event_handler() where
> it was previously possible to cause eeh_pe_state_clear() to be called
> on an invalid PE, which is now avoided.
>
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh_event.h |  2 +-
>  arch/powerpc/kernel/eeh_driver.c     | 29 +++++++++++------------------
>  arch/powerpc/kernel/eeh_event.c      |  2 --
>  3 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
> index 0a168038882d..9884e872686f 100644
> --- a/arch/powerpc/include/asm/eeh_event.h
> +++ b/arch/powerpc/include/asm/eeh_event.h
> @@ -34,7 +34,7 @@ struct eeh_event {
>  int eeh_event_init(void);
>  int eeh_send_failure_event(struct eeh_pe *pe);
>  void eeh_remove_event(struct eeh_pe *pe, bool force);
> -bool eeh_handle_normal_event(struct eeh_pe *pe);
> +void eeh_handle_normal_event(struct eeh_pe *pe);
>  void eeh_handle_special_event(void);
>  
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 51b21c97910f..5b7a5ed4db4d 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -733,7 +733,8 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  
>  /**
>   * eeh_handle_normal_event - Handle EEH events on a specific PE
> - * @pe: EEH PE
> + * @pe: EEH PE - which should not be used after we return, as it may
> + * have been invalidated.
>   *
>   * Attempts to recover the given PE.  If recovery fails or the PE has failed
>   * too many times, remove the PE.
> @@ -750,10 +751,8 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>   * & devices under this slot, and then finally restarting the device
>   * drivers (which cause a second set of hotplug events to go out to
>   * userspace).
> - *
> - * Returns true if @pe should no longer be used, else false.
>   */
> -bool eeh_handle_normal_event(struct eeh_pe *pe)
> +void eeh_handle_normal_event(struct eeh_pe *pe)
>  {
>  	struct pci_bus *frozen_bus;
>  	struct eeh_dev *edev, *tmp;
> @@ -765,9 +764,11 @@ bool eeh_handle_normal_event(struct eeh_pe *pe)
>  	if (!frozen_bus) {
>  		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
>  			__func__, pe->phb->global_number, pe->addr);
> -		return false;
> +		return;
>  	}
>  
> +	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
> +
>  	eeh_pe_update_time_stamp(pe);
>  	pe->freeze_count++;
>  	if (pe->freeze_count > eeh_max_freezes) {
> @@ -904,7 +905,7 @@ bool eeh_handle_normal_event(struct eeh_pe *pe)
>  	pr_info("EEH: Notify device driver to resume\n");
>  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
>  
> -	return false;
> +	goto final;
>  
>  hard_fail:
>  	/*
> @@ -940,12 +941,12 @@ bool eeh_handle_normal_event(struct eeh_pe *pe)
>  			pci_lock_rescan_remove();
>  			pci_hp_remove_devices(frozen_bus);
>  			pci_unlock_rescan_remove();
> -
>  			/* The passed PE should no longer be used */
> -			return true;
> +			return;
>  		}
>  	}
> -	return false;
> +final:
> +	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>  }
>  
>  /**
> @@ -1018,15 +1019,7 @@ void eeh_handle_special_event(void)
>  		 */
>  		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
>  		    rc == EEH_NEXT_ERR_FENCED_PHB) {
> -			/*
> -			 * eeh_handle_normal_event() can make the PE stale if it
> -			 * determines that the PE cannot possibly be recovered.
> -			 * Don't modify the PE state if that's the case.
> -			 */
> -			if (eeh_handle_normal_event(pe))
> -				continue;
> -
> -			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
> +			eeh_handle_normal_event(pe);
>  		} else {
>  			pci_lock_rescan_remove();
>  			list_for_each_entry(hose, &hose_list, list_node) {
> diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
> index 872bcfe8f90e..61c9356bf9c9 100644
> --- a/arch/powerpc/kernel/eeh_event.c
> +++ b/arch/powerpc/kernel/eeh_event.c
> @@ -73,7 +73,6 @@ static int eeh_event_handler(void * dummy)
>  		/* We might have event without binding PE */
>  		pe = event->pe;
>  		if (pe) {
> -			eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
>  			if (pe->type & EEH_PE_PHB)
>  				pr_info("EEH: Detected error on PHB#%x\n",
>  					 pe->phb->global_number);
> @@ -82,7 +81,6 @@ static int eeh_event_handler(void * dummy)
>  					"PHB#%x-PE#%x\n",
>  					pe->phb->global_number, pe->addr);
>  			eeh_handle_normal_event(pe);
> -			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>  		} else {
>  			eeh_handle_special_event();
>  		}
> -- 
> 2.16.1.74.g9b0b1f47b
