Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E76DDDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 14:49:06 +1000 (EST)
Date: Tue, 8 May 2007 23:51:15 -0500
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/4] powerpc: EEH: log error only after driver
	notification.
Message-ID: <20070509045115.GA1771@lixom.net>
References: <20070508230952.GN4452@austin.ibm.com>
	<20070508233329.GP4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508233329.GP4452@austin.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, May 08, 2007 at 06:33:29PM -0500, Linas Vepstas wrote:

> Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c
> ===================================================================
> --- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-08 17:55:43.000000000 -0500
> +++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-08 17:56:42.000000000 -0500
> @@ -361,7 +361,6 @@ struct pci_dn * handle_eeh_events (struc
>  		goto hard_fail;
>  	}
>  
> -	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
>  	printk(KERN_WARNING
>  	   "EEH: This PCI device has failed %d times since last reboot: "
>  		"location=%s driver=%s pci addr=%s\n",
> @@ -375,6 +374,11 @@ struct pci_dn * handle_eeh_events (struc
>  	 */
>  	pci_walk_bus(frozen_bus, eeh_report_error, &result);
>  
> +	/* Since rtas may enable MMIO when posting the error log,
> +	 * don't post the error log until after all dev drivers
> +	 * have been informed. */
> +	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);

I know you only moved it, but if you have to document what '1' means,
you really should add a symbolic define/enum instead. Not saying it should
stop this from going in, but it could be a good separate improvement.

(Also, the comment style: */ should be on it's own line.)


-Olof
