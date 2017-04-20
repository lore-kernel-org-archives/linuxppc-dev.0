Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7g1966kKzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:37:01 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K0XhtS001495
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:36:56 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29xb7v96ga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:36:55 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 20 Apr 2017 10:36:53 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3K0afFX7733546
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:36:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3K0aGMq013492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:36:16 +1000
Subject: Re: [PATCH v3 1/2] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20170419074136.8401F13603C@b03ledav002.gho.boulder.ibm.com>
Cc: aik@ozlabs.ru
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 20 Apr 2017 10:35:52 +1000
MIME-Version: 1.0
In-Reply-To: <20170419074136.8401F13603C@b03ledav002.gho.boulder.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2c7f75a7-e468-2e4c-9662-6ba3b864122a@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/04/17 17:39, Russell Currey wrote:
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

Per our conversation about this yesterday:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> V2: check a specific return path instead of looking at the PE itself
> V3: use a bool instead of a non-specific int return
> ---
>  arch/powerpc/kernel/eeh_driver.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index b94887165a10..e50d1470714f 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -724,7 +724,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>   */
>  #define MAX_WAIT_FOR_RECOVERY 300
>
> -static void eeh_handle_normal_event(struct eeh_pe *pe)
> +static bool eeh_handle_normal_event(struct eeh_pe *pe)
>  {
>  	struct pci_bus *frozen_bus;
>  	struct eeh_dev *edev, *tmp;
> @@ -736,7 +736,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  	if (!frozen_bus) {
>  		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
>  			__func__, pe->phb->global_number, pe->addr);
> -		return;
> +		return false;
>  	}
>
>  	eeh_pe_update_time_stamp(pe);
> @@ -870,7 +870,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  	pr_info("EEH: Notify device driver to resume\n");
>  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
>
> -	return;
> +	return false;
>
>  excess_failures:
>  	/*
> @@ -915,8 +915,12 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  			pci_lock_rescan_remove();
>  			pci_hp_remove_devices(frozen_bus);
>  			pci_unlock_rescan_remove();
> +
> +			/* The passed PE should no longer be used */
> +			return true;
>  		}
>  	}
> +	return false;
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
> +			if (eeh_handle_normal_event(pe))
> +				continue;
> +
>  			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>  		} else {
>  			pci_lock_rescan_remove();
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
