Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAE141A0C96
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:04:51 +1100 (AEDT)
Message-ID: <1452665080.2403.21.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org
Date: Wed, 13 Jan 2016 17:04:40 +1100
In-Reply-To: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-01-10 at 01:08 -0200, Guilherme G. Piccoli wrote:weust changes the way the arch checking is done in function
> 
> This patch jeeh_add_device_early(): we use no more eeh_enabled(), but instead we check therunning architecture by using the macro machine_is(). If we are running on
> pSeries or PowerNV, the EEH mechanism can be enabled; otherwise, we bail out
> the function. This way, we don't enable EEH on Cell and we don't hit the oops
> on DLPAR either.

Can't we just check for eeh_ops being NULL ?

Cheers,
Ben.

> Fixes: 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 40e4d4a..81e2d3e 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1072,7 +1072,13 @@ void eeh_add_device_early(struct pci_dn *pdn)
>  	struct pci_controller *phb;
>  	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>  
> -	if (!edev || !eeh_enabled())
> +	if (!edev)
> +		return;
> +
> +	/* Some platforms (like Cell) don't have EEH capabilities, so we
> +	 * need to abort here. In case of pseries or powernv, we have EEH
> +	 * so we can continue. */
> +	if (!machine_is(pseries) && !machine_is(powernv))
>  		return;
>  
>  	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
