Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dP83rJ2zF1Vw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:18:20 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id e79so5115298ioi.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:18:20 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id d128sm2068273iod.19.2018.03.20.22.18.13
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:18:14 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] powerpc/eeh: Remove misleading test in
 eeh_handle_normal_event()
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <52c15c0414d248981e251386384ed2a716315003.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <521099dd-f637-104e-6495-8d8b5eb70b72@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:18:11 +1100
MIME-Version: 1.0
In-Reply-To: <52c15c0414d248981e251386384ed2a716315003.1521427331.git.sam.bobroff@au1.ibm.com>
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
> Remove a test that checks if "frozen_bus" is NULL, because it cannot
> have changed since it was tested at the start of the function and so
> must be true here.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/kernel/eeh_driver.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 5b7a5ed4db4d..04a5d9db5499 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -930,20 +930,18 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
>  	 * all removed devices correctly to avoid access
>  	 * the their PCI config any more.
>  	 */
> -	if (frozen_bus) {
> -		if (pe->type & EEH_PE_VF) {
> -			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
> -			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
> -		} else {
> -			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
> -			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
> +	if (pe->type & EEH_PE_VF) {
> +		eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
> +		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
> +	} else {
> +		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
> +		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>  
> -			pci_lock_rescan_remove();
> -			pci_hp_remove_devices(frozen_bus);
> -			pci_unlock_rescan_remove();
> -			/* The passed PE should no longer be used */
> -			return;
> -		}
> +		pci_lock_rescan_remove();
> +		pci_hp_remove_devices(frozen_bus);
> +		pci_unlock_rescan_remove();
> +		/* The passed PE should no longer be used */
> +		return;
>  	}
>  final:
>  	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
> 


-- 
Alexey
