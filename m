Return-Path: <dja@axtens.net>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwL2L1tbwzF1Kj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 13:14:49 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id r26so7687779pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:14:49 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/9] powerpc/eeh: Remove misleading test in
 eeh_handle_normal_event()
In-Reply-To: <52c15c0414d248981e251386384ed2a716315003.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <52c15c0414d248981e251386384ed2a716315003.1520294174.git.sam.bobroff@au1.ibm.com>
Date: Tue, 06 Mar 2018 13:14:43 +1100
Message-ID: <87o9k2c5m4.fsf@linkitivity.dja.id.au>
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

Sam Bobroff <sam.bobroff@au1.ibm.com> writes:

> Remove a test that checks if "frozen_bus" is NULL, because it cannot
> have changed since it was tested at the start of the function and so
> must be true here.

As far as I can tell this was added back in 2012 in 9b3c76f08122f. As
far as I can tell it couldn't be NULL back then either. Weird.

LGTM, but I'm not super comfortable chnging something I don't understand
so I will leave the formal review for now.

Regards,
Daniel
>
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
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
> -- 
> 2.16.1.74.g9b0b1f47b
