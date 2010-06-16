Return-Path: <c.alfred@internode.on.net>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
	[150.101.137.143]) by ozlabs.org (Postfix) with ESMTP id 604BF1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 08:06:40 +1000 (EST)
Message-ID: <EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
From: "Chris Alfred" <c.alfred@internode.on.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
	<AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
Date: Thu, 17 Jun 2010 08:06:39 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Tue, Jun 15, 2010 at 4:19 PM, Chris Alfred
> <c.alfred@internode.on.net> wrote:
>> I am trying to port a DSA (Distributed Switch Architecture) driver
>> for the Micrel KS8995M managed switch connected to a MPC5200. There
>> is an SPI interface and MII interface managed by the DSA driver.
>>
>> I can't understand how probe gets called when the flatted device 
>> tree
>> (FDT) system is used, and how to bind such a driver using the FDT 
>> (if
>> you have to at all).
>>
>> The DSA driver is initialised via:
>>
>> // net/dsa/dsa.c
>>
>> static struct platform_driver dsa_driver = {
>> .probe = dsa_probe,
>> .remove = dsa_remove,
>> .shutdown = dsa_shutdown,
>> .driver = {
>> .name = "dsa",
>> .owner = THIS_MODULE,
>> },
>> };
>>
>> static int __init dsa_init_module(void)
>> {
>> return platform_driver_register(&dsa_driver);
>> }
>>
>> dsa_init_module is being called; but how do I get the system to 
>> call
>> .probe?
>
> To avoid writing new machine-specific code in 
> arch/powerpc/platforms,
> then I recommend that you add a node to your .dts file to describe 
> the
> DSA complex and write a very simple of_platform_driver that binds
> against it.  Then use the probe hook to extract data out of the 
> device
> tree node (if needed) and register the appropriate platform_device
> (don't forget to make the of_device the parent of the
> platform_device).  This can be considered a temporary solution, but 
> it
> will not break when I make the infrastructure changes, and then you
> can migrate over to the new method at your leisure.


Thanks for the great response.

I still have some learning to do. To start, I tried to get a simple 
of_platform_driver going.
In my .dts I added:

    / {
        ...
         dsa {
          compatible = "dsa-of";
          reg = <0 0>;   // TODO: might need config values e.g. number 
of phys, cpu port
         };
        ...
    };

I created net/dsa/dsa_of.c - the simple of_platform_driver that will 
bind to the DSA platform driver (in net/dsa/dsa.c):

    #include <linux/of.h>
    #include <linux/kernel.h>
    #include <linux/of_platform.h>

    static int __devinit dsa_of_probe(struct of_device *ofdev, const 
struct of_device_id *match)
    {
     printk("dsa_of_probe\n");
     return 0;
    }

    static int dsa_of_remove(struct of_device *ofdev)
    {
     printk("dsa_of_remove\n");
     return 0;
    }


    static const struct of_device_id dsa_of_match[] = {
     {
      .compatible = "dsa-of",
     },
     {}
    };

    static struct of_platform_driver dsa_of_driver = {
     .name = "dsa-of",
     .match_table = dsa_of_match,
     .probe = dsa_of_probe,
     .remove = dsa_of_remove,
    };

    static int __init dsa_of_init(void)
    {
     printk("dsa_of_init\n");

     if (of_register_platform_driver(&dsa_of_driver))
      printk(KERN_ERR "Unable to register DSA OF platform driver\n");

     return 0;
    }
    module_init(dsa_of_init);

    static void __exit dsa_of_cleanup(void)
    {
     printk("dsa_of_cleanup\n");

     of_unregister_platform_driver(&dsa_of_driver);
    }
    module_exit(dsa_of_cleanup);

    MODULE_DESCRIPTION("DSA OF platform driver");
    MODULE_AUTHOR("Chris Alfred <chris@greyfog.com.au");
    MODULE_LICENSE("GPL v2");

dsa_of_init is successfully called; but dsa_of_probe is not called.

Regards,
Chris 
