Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 737F5DDF55
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 02:36:55 +1000 (EST)
Message-ID: <46AE146D.8010504@mvista.com>
Date: Mon, 30 Jul 2007 09:40:13 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707291606.21612.arnd@arndb.de>
In-Reply-To: <200707291606.21612.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 27 July 2007, Dave Jiang wrote:
>> +static struct of_device_id mpc85xx_pci_err_of_match[] = {
>> +       {
>> +        .type = "pci",
>> +        .compatible = "fsl,mpc8540-pci",
>> +        },
>> +       {},
>> +};
>> +
>> +static struct of_platform_driver mpc85xx_pci_err_driver = {
>> +       .owner = THIS_MODULE,
>> +       .name = "mpc85xx_pci_err",
>> +       .match_table = mpc85xx_pci_err_of_match,
>> +       .probe = mpc85xx_pci_err_probe,
>> +       .remove = mpc85xx_pci_err_remove,
>> +       .driver = {
>> +                  .name = "mpc85xx_pci_err",
>> +                  .owner = THIS_MODULE,
>> +                  },
>> +};
> 
> This is  a little problematic, if we want to make the PCI bus implementation
> use the PCI code from arch/powerpc/kernel/of_platform.c in the future.
> Right now this is not possible, because that code is still 64-bit only,
> but that may change in the future. Since only one driver can bind
> to the pci host bridge device, the mpc85xx_pci_err driver would conflict
> with the PCI driver itself, which you probably don't intend.
> 
> I'd suggest either to integrate EDAC into the 85xx specific PCI code,
> or to have an extra device in the device tree for this.

How about I create a platform device just for EDAC and leave the PCI of_device
to the 85xx PCI code? That would be a lot less modification than adding a
device for every PCI hose per DTS file.... Just a thought....

>> +       res = of_register_platform_driver(&mpc85xx_mc_err_driver) ? : res;
>> +
>> +       res = of_register_platform_driver(&mpc85xx_l2_err_driver) ? : res;
>> +
>> +#ifdef CONFIG_PCI
>> +       res = of_register_platform_driver(&mpc85xx_pci_err_driver) ? : res;
>> +#endif
>> +
>> +       /*
>> +        * need to clear HID1[RFXE] to disable machine check int
>> +        * so we can catch it
>> +        */
>> +       if (edac_op_state == EDAC_OPSTATE_INT) {
>> +               orig_hid1 = mfspr(SPRN_HID1);
>> +
>> +               mtspr(SPRN_HID1, (orig_hid1 & ~0x20000));
>> +       }
>> +
>> +       return res;
>> +}
> 
> The error handling could use some improvement here. In particular, you should
> unregister the buses in the failure path, maybe you need to clean up other
> parts as well.

I think I want individual "devices" work even some may fail or be missing. For
example, even if L2 fails to register, I still want to be able to get the
memory controller to report errors. So I really don't want to unregister
everything that initialized properly even though some failures exists. Maybe I
need to clean it up a little bit.

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
