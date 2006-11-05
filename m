Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 05A7567C82
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 22:37:27 +1100 (EST)
Message-ID: <454DCCE8.4020402@s5r6.in-berlin.de>
Date: Sun, 05 Nov 2006 12:37:12 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe	cycle]
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
In-Reply-To: <454DC985.2020203@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Gioele Barabucci <dev@gioelebarabucci.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:
> Benjamin Herrenschmidt wrote:
>> The machine check means basically that the chip didn't respond on the
>> PCI bus. The most probable cause is that something is wrong with the
>> platform code that switches the chip clock on/off or with the PCI D
>> state change.
>>
>> One thing you can check is wether that's always called properly,
>> especially when starting the chip.
[...]
> How about this patch:
> 
> --- linux.orig/drivers/ieee1394/ohci1394.c	2006-11-02 22:35:16.000000000 +0100
> +++ linux/drivers/ieee1394/ohci1394.c	2006-11-05 12:19:52.000000000 +0100
> @@ -3215,6 +3215,18 @@ static int __devinit ohci1394_pci_probe(
>  	struct ti_ohci *ohci;	/* shortcut to currently handled device */
>  	resource_size_t ohci_base;
> 
> +#ifdef CONFIG_PPC_PMAC
> +	/* Necessary if ohci1394 was loaded and unloaded before */
> +	if (machine_is(powermac)) {
> +		struct device_node *of_node = pci_device_to_OF_node(dev);
> +
> +		if (of_node)
> +			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node,
> +					  0, 1);
> +			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 1);
> +	}
> +#endif /* CONFIG_PPC_PMAC */
> +
>          if (pci_enable_device(dev))
>  		FAIL(-ENXIO, "Failed to enable OHCI hardware");
>          pci_set_master(dev);
[...]

Hm. There is the following comment in ohci1394_pci_remove():

	/* On UniNorth, power down the cable and turn off the chip
	 * clock when the module is removed to save power on
	 * laptops. Turning it back ON is done by the arch code when
	 * pci_enable_device() is called */

Is this true or wrong in current kernels?
-- 
Stefan Richter
-=====-=-==- =-== --=-=
http://arcgraph.de/sr/
