Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7043A2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:20:57 +1000 (EST)
Message-ID: <1370060330.3766.5.camel@pasglop>
Subject: Re: [PATCH 08/23] powerpc/eeh: Refactor eeh_reset_pe_once()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:18:50 +1000
In-Reply-To: <1369902245-5886-9-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-9-git-send-email-shangw@linux.vnet.ibm.com>
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

On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
> The patch changes the criteria used to judge if the PE has been
> resetted successfully. We needn't the PE status is exactly equal
> to the combo: (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE).

The comment above doesn't mean anything :-)

I assume you meant to write "we shouldn't check that the
returned PE status is exactly equal to the two flags X and Y,
but instead only check that they are both set".

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
> index 39d2ea6..ffe34c4 100644
> --- a/arch/powerpc/platforms/pseries/eeh.c
> +++ b/arch/powerpc/platforms/pseries/eeh.c
> @@ -527,7 +527,6 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
>  	 * Partitionable Endpoint trumps hot-reset.
>    	 */
>  	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
> -

Unrelated churn

>  	if (freset)
>  		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
>  	else
> @@ -565,6 +564,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
>   */
>  int eeh_reset_pe(struct eeh_pe *pe)
>  {
> +	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>  	int i, rc;
>  
>  	/* Take three shots at resetting the bus */
> @@ -572,7 +572,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
>  		eeh_reset_pe_once(pe);
>  
>  		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
> -		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
> +		if ((rc & flags) == flags)
>  			return 0;
>  
>  		if (rc < 0) {
