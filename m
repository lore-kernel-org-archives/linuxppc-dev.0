Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45019B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 06:44:19 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p23JWe90001109
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 12:32:40 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p23JiFao054182
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 12:44:15 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p23JiFPJ019846
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 12:44:15 -0700
Date: Thu, 3 Mar 2011 11:44:10 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: disable MSI using new interface if possible
Message-ID: <20110303194410.GD2782@us.ibm.com>
References: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
Cc: paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.03.2011 [11:39:23 -0800], Nishanth Aravamudan wrote:
> On upcoming hardware, we have a PCI adapter with two functions, one of
> which uses MSI and the other uses MSI-X. This adapter, when MSI is
> disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
> signals an MSI-X interrupt and triggers an EEH. We are working with the
> vendor to ensure that the hardware is not at fault, but if we use the
> "new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
> automatically disable MSI-X and the adapter does not appear to signal
> any stray MSI-X interrupt.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Cc: Milton Miller <miltonm@bga.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>

Sorry, I fudged my git-send-email config, apologies that the Cc's above
weren't actually used in the original!

> ---
> 
> This is effectively a PCI quirk, but I'm not sure how to do a
> architecture-specific quirk (looking through the code now). If anyone
> has any pointers, I'd appreciate it!

If this would be preferred, I think I see now how it would be done and
can work on a different patch that only makes this change for this
device.

Thanks,
Nish

>  arch/powerpc/platforms/pseries/msi.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 1164c34..9434576 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -93,8 +93,18 @@ static void rtas_disable_msi(struct pci_dev *pdev)
>  	if (!pdn)
>  		return;
> 
> -	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0)
> -		pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
> +	/*
> +	 * disabling MSI with the explicit interface also disables MSI-X
> +	 */
> +	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
> +		/* 
> +		 * may have failed due to lacking
> +		 * "ibm,change-msix-capable" property
> +		 */
> +		if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0) {
> +			pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
> +		}
> +	}
>  }
> 
>  static int rtas_query_irq_number(struct pci_dn *pdn, int offset)
> -- 
> 1.7.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
