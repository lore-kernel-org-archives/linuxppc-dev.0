Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76C8C2C0320
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:35:09 +1000 (EST)
Message-ID: <1342150499.15597.13.camel@pasglop>
Subject: Re: [PATCH] powerpc/eeh: check handle_eeh_events() return value
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
Date: Fri, 13 Jul 2012 13:34:59 +1000
In-Reply-To: <1342149276-18435-1-git-send-email-klebers@linux.vnet.ibm.com>
References: <1342149276-18435-1-git-send-email-klebers@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-07-13 at 00:14 -0300, Kleber Sacilotto de Souza wrote:
> Function eeh_event_handler() dereferences the pointer returned by
> handle_eeh_events() without checking, causing a crash if NULL was
> returned, which is expected in some situations.
> 
> This patch fixes this bug by checking for the value returned by
> handle_eeh_events() before dereferencing it.

Thanks,
Ben.

> Signed-off-by: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh_event.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
> index 4cb375c..fb50631 100644
> --- a/arch/powerpc/platforms/pseries/eeh_event.c
> +++ b/arch/powerpc/platforms/pseries/eeh_event.c
> @@ -85,8 +85,10 @@ static int eeh_event_handler(void * dummy)
>  	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
>  	edev = handle_eeh_events(event);
>  
> -	eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
> -	pci_dev_put(edev->pdev);
> +	if (edev) {
> +		eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
> +		pci_dev_put(edev->pdev);
> +	}
>  
>  	kfree(event);
>  	mutex_unlock(&eeh_event_mutex);
