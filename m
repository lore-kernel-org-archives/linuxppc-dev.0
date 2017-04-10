Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1kCN18dTzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 18:40:13 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so24942840pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 01:40:13 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20170410071153.21680-1-ruscur@russell.cc>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8113d48b-f7e4-b1fd-0c00-cb5835e6d15a@ozlabs.ru>
Date: Mon, 10 Apr 2017 18:40:07 +1000
MIME-Version: 1.0
In-Reply-To: <20170410071153.21680-1-ruscur@russell.cc>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/17 17:11, Russell Currey wrote:
> eeh_handle_special_event() is called when an EEH event is detected but
> can't be narrowed down to a specific PE.  This function looks through
> every PE to find one in an erroneous state, then calls the regular event
> handler eeh_handle_normal_event() once it knows which PE has an error.
> 
> However, if eeh_handle_normal_event() found that the PE cannot possibly
> be recovered, it will free it, rendering the passed PE stale.
> This leads to a use after free in eeh_handle_special_event() as it attempts to
> clear the "recovering" state on the PE after eeh_handle_normal_event() returns.
> 
> Thus, make sure the PE is valid when attempting to clear state in
> eeh_handle_special_event().
> 
> Cc: <stable@vger.kernel.org> #3.10+
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> V2: check a specific return path instead of looking at the PE itself
> ---
>  arch/powerpc/kernel/eeh_driver.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index b94887165a10..e510408e08e1 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -724,7 +724,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>   */
>  #define MAX_WAIT_FOR_RECOVERY 300
>  
> -static void eeh_handle_normal_event(struct eeh_pe *pe)
> +static int eeh_handle_normal_event(struct eeh_pe *pe)
>  {
>  	struct pci_bus *frozen_bus;
>  	struct eeh_dev *edev, *tmp;
> @@ -736,7 +736,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  	if (!frozen_bus) {
>  		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
>  			__func__, pe->phb->global_number, pe->addr);
> -		return;
> +		return -EIO;
>  	}
>  
>  	eeh_pe_update_time_stamp(pe);
> @@ -870,7 +870,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  	pr_info("EEH: Notify device driver to resume\n");
>  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
>  
> -	return;
> +	return rc;


eeh_handle_normal_event() uses "rc" to store return values from different
things:

- eeh_ops->wait_state() (which is pnv_eeh_wait_state) returns mask of
EEH_STATE_MMIO_ACTIVE/etc, errors would be EEH_STATE_UNAVAILABLE or
EEH_STATE_NOT_SUPPORT, both positive and the latter is used everywhere in
EEH code to report errors instead of negative linux errors.

- eeh_reset_device() returns usual linux negative errors, such as -EIO,
-ENODEV.

I'd suggest following one scheme or another here.


>  
>  excess_failures:
>  	/*
> @@ -915,8 +915,12 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  			pci_lock_rescan_remove();
>  			pci_hp_remove_devices(frozen_bus);
>  			pci_unlock_rescan_remove();
> +
> +			/* The passed PE should no longer be used */
> +			rc = -EFAULT;


I looked if eeh_handle_normal_event() could return -EFAULT in any other
branch. eeh_pci_enable() could return linux error if it failed in
pnv_eeh_set_option() which at least in theory can get -EFAULT from
unfreeze_pe(). Do we want to rely of the fact that unfreeze_pe() won't
return -EFAULT and we do not end up with non removed device?

May be instead of very popular EFAULT, eeh_handle_normal_event() is better
to return bool saying that pe is dead? Or move the whole
if(frozen_bus){
	...
	pci_hp_remove_devices()
	...
}

to a eeh_teardown_frozen_bus() helper, make eeh_handle_normal_event()
return frozen_bus if it needs to be frozen and pass that to
eeh_teardown_frozen_bus() if not NULL?


btw eeh_handle_normal_event() does not really need the excess_failures
label, that "excess_failures: pr_err()" could be moved to "goto
excess_failures" (which will become "goto perm_error") and then perm_error:
could go too :)


>  		}
>  	}
> +	return rc;
>  }
>  
>  static void eeh_handle_special_event(void)
> @@ -982,7 +986,14 @@ static void eeh_handle_special_event(void)
>  		 */
>  		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
>  		    rc == EEH_NEXT_ERR_FENCED_PHB) {
> -			eeh_handle_normal_event(pe);
> +			/*
> +			 * eeh_handle_normal_event() can make the PE stale if it
> +			 * determines that the PE cannot possibly be recovered.
> +			 * Don't modify the PE state if that's the case.
> +			 */
> +			if (eeh_handle_normal_event(pe) == -EFAULT)
> +				continue;
> +
>  			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>  		} else {
>  			pci_lock_rescan_remove();
> 


-- 
Alexey
