Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDD41DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 07:35:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6ELbrEg002936
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 17:37:53 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6ELZN0e234376
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 17:35:23 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6ELZMpK020423
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 17:35:23 -0400
Message-ID: <487BC68E.2080303@linux.vnet.ibm.com>
Date: Mon, 14 Jul 2008 16:35:10 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/16 v3] powerpc: Do not probe PCI buses or eBus devices
	if CMO is enabled
References: <20080704125418.GK1310@linux.vnet.ibm.com>
In-Reply-To: <20080704125418.GK1310@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Please drop this patch from the series. After further discussion, this patch
is not required and has actually been causing problems.

Thanks,

Brian

Robert Jennings wrote:
> From: Brian King <brking@linux.vnet.ibm.com>
> 
> The Cooperative Memory Overcommit (CMO) on System p does not currently
> support native PCI devices or eBus devices when enabled. Prevent
> PCI bus probe and eBus device probe if the feature is enabled.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> 
> ---
> 
>  arch/powerpc/kernel/ibmebus.c          |    6 ++++++
>  arch/powerpc/platforms/pseries/setup.c |    4 ++++
>  2 files changed, 10 insertions(+)
> 
> Index: b/arch/powerpc/kernel/ibmebus.c
> ===================================================================
> --- a/arch/powerpc/kernel/ibmebus.c
> +++ b/arch/powerpc/kernel/ibmebus.c
> @@ -45,6 +45,7 @@
>  #include <linux/of_platform.h>
>  #include <asm/ibmebus.h>
>  #include <asm/abs_addr.h>
> +#include <asm/firmware.h>
> 
>  static struct device ibmebus_bus_device = { /* fake "parent" device */
>  	.bus_id = "ibmebus",
> @@ -332,6 +333,11 @@ static int __init ibmebus_bus_init(void)
>  {
>  	int err;
> 
> +	if (firmware_has_feature(FW_FEATURE_CMO)) {
> +		printk(KERN_WARNING "Not probing eBus since CMO is enabled\n");
> +		return 0;
> +	}
> +
>  	printk(KERN_INFO "IBM eBus Device Driver\n");
> 
>  	err = of_bus_type_init(&ibmebus_bus_type, "ibmebus");
> Index: b/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -539,6 +539,10 @@ static void pseries_shared_idle_sleep(vo
> 
>  static int pSeries_pci_probe_mode(struct pci_bus *bus)
>  {
> +	if (firmware_has_feature(FW_FEATURE_CMO)) {
> +		dev_warn(&bus->dev, "Not probing PCI bus since CMO is enabled\n");
> +		return PCI_PROBE_NONE;
> +	}
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
>  		return PCI_PROBE_DEVTREE;
>  	return PCI_PROBE_NORMAL;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
