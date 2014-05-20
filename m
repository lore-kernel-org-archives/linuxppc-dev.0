Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 384BD1A0883
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 21:25:16 +1000 (EST)
Message-ID: <537B3B97.3020100@suse.de>
Date: Tue, 20 May 2014 13:25:11 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.05.14 10:30, Gavin Shan wrote:
> If we detects frozen state on PE that has been passed to guest, we
> needn't handle it. Instead, we rely on the guest to detect and recover
> it. The patch avoid EEH event on the frozen passed PE so that the guest
> can have chance to handle that.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

How does the guest learn about this failure? We'd need to inject an 
error into it, no?

I think what you want is an irqfd that the in-kernel eeh code notifies 
when it sees a failure. When such an fd exists, the kernel skips its own 
error handling.


Alex

> ---
>   arch/powerpc/kernel/eeh.c                 | 8 ++++++++
>   arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 9c6b899..6543f05 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -400,6 +400,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>   	if (ret > 0)
>   		return ret;
>   
> +	/*
> +	 * If the PE has been passed to guest, we won't check the
> +	 * state. Instead, let the guest handle it if the PE has
> +	 * been frozen.
> +	 */
> +	if (eeh_pe_passed(pe))
> +		return 0;
> +
>   	/* If we already have a pending isolation event for this
>   	 * slot, we know it's bad already, we don't need to check.
>   	 * Do this checking under a lock; as multiple PCI devices
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index 1b5982f..03a3ed2 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -890,7 +890,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>   				opal_pci_eeh_freeze_clear(phb->opal_id, frozen_pe_no,
>   					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>   				ret = EEH_NEXT_ERR_NONE;
> -			} else if ((*pe)->state & EEH_PE_ISOLATED) {
> +			} else if ((*pe)->state & EEH_PE_ISOLATED ||
> +				   eeh_pe_passed(*pe)) {
>   				ret = EEH_NEXT_ERR_NONE;
>   			} else {
>   				pr_err("EEH: Frozen PHB#%x-PE#%x (%s) detected\n",
