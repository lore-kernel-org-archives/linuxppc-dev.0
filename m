Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 237FC2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 05:43:56 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 13:43:53 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 22B0338C8027
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 13:43:51 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s15IhoYY7864604
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 18:43:50 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s15Ihoet004448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 13:43:50 -0500
Date: Wed, 5 Feb 2014 10:43:38 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/eeh: drop taken reference to driver on
 eeh_rmv_device
Message-ID: <20140205184338.GA5433@linux.vnet.ibm.com>
References: <1391624445-9095-1-git-send-email-cascardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391624445-9095-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.02.2014 [16:20:45 -0200], Thadeu Lima de Souza Cascardo wrote:
> Commit f5c57710dd62dd06f176934a8b4b8accbf00f9f8 ("powerpc/eeh: Use
> partial hotplug for EEH unaware drivers") introduces eeh_rmv_device,
> which may grab a reference to a driver, but not release it.
> 
> That prevents a driver from being removed after it has gone through EEH
> recovery.
> 
> This patch drops the reference if it was taken.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 7bb30dc..fdc679d 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -362,9 +362,13 @@ static void *eeh_rmv_device(void *data, void *userdata)
>  	 */
>  	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
>  		return NULL;
> +

This appears to be unnecessary whitespace change?

-Nish

>  	driver = eeh_pcid_get(dev);
> -	if (driver && driver->err_handler)
> -		return NULL;
> +	if (driver) {
> +		eeh_pcid_put(dev);
> +		if (driver->err_handler)
> +			return NULL;
> +	}
> 
>  	/* Remove it from PCI subsystem */
>  	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
> -- 
> 1.7.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
