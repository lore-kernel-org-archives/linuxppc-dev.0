Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dNJ3zN5zF1h5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:17:36 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id k135-v6so5315894ite.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:17:36 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id
 m22-v6sm2048368iti.4.2018.03.20.22.17.32
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:17:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] powerpc/eeh: Remove eeh_handle_event()
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <d3d01073da02a5eb844cc8998fdac602b8121b62.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <52b1f55b-a711-5a46-d044-516a208cef8d@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:17:29 +1100
MIME-Version: 1.0
In-Reply-To: <d3d01073da02a5eb844cc8998fdac602b8121b62.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:46 pm, Sam Bobroff wrote:
> The function eeh_handle_event(pe) does nothing other than switching
> between calling eeh_handle_normal_event(pe) and
> eeh_handle_special_event(). However it is only called in two places,
> one where pe can't be NULL and the other where it must be NULL (see
> eeh_event_handler()) so it does nothing but obscure the flow of
> control.
> 
> So, remove it.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/include/asm/eeh_event.h |  3 ++-
>  arch/powerpc/kernel/eeh_driver.c     | 42 +++++++++++++-----------------------
>  arch/powerpc/kernel/eeh_event.c      |  4 ++--
>  3 files changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
> index 1e551a2d6f82..0a168038882d 100644
> --- a/arch/powerpc/include/asm/eeh_event.h
> +++ b/arch/powerpc/include/asm/eeh_event.h
> @@ -34,7 +34,8 @@ struct eeh_event {
>  int eeh_event_init(void);
>  int eeh_send_failure_event(struct eeh_pe *pe);
>  void eeh_remove_event(struct eeh_pe *pe, bool force);
> -void eeh_handle_event(struct eeh_pe *pe);
> +bool eeh_handle_normal_event(struct eeh_pe *pe);
> +void eeh_handle_special_event(void);
>  
>  #endif /* __KERNEL__ */
>  #endif /* ASM_POWERPC_EEH_EVENT_H */
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 0c0b66fc5bfb..51b21c97910f 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -738,9 +738,22 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>   * Attempts to recover the given PE.  If recovery fails or the PE has failed
>   * too many times, remove the PE.
>   *
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
> 


-- 
Alexey
