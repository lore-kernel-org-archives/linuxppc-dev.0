Return-Path: <c.alfred@internode.on.net>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
	[150.101.137.131]) by ozlabs.org (Postfix) with ESMTP id 22C2F1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 21:11:49 +1000 (EST)
Message-ID: <6EAB45775B71486B8E72844E797E1D0F@kos>
From: "Chris Alfred" <c.alfred@internode.on.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
	<AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
	<EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
	<AANLkTinBJgwL9qcw0Ouzuvc55C1Gs2KtIoY2NbBy34V2@mail.gmail.com>
	<162C87D14617439384076F797228B1EF@kos>
	<AANLkTim8kD9PH7BqOIV0GvElIfOgUDMw1VfWcOJhj-8r@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
Date: Thu, 17 Jun 2010 21:11:47 +1000
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

> virtual-devices {
>         compatible = "simple-bus";
>         dsa {
>               compatible = "<vendor>,jkc5200n8-dsa";
>         };
> };

Ok, after correcting the names, the basic OF driver is probed.

Now to try and use probe to register the DSA platform driver with the 
OF driver as its parent.


=======

For those interested in how to get a very basic OF (uses FDT) driver 
going, the steps I did are below.

'myvendor' is your company name, and 'mydevice' is the name of the 
device - use better names in real code.

(1) The .dts file - this is the Flattened Device Tree (FDT) 
descriptor:

    / {
        ...

         virtual-device {
          compatible = "simple-bus";
          mydevice0 {
           compatible = "myvendor,mydevice";
          };
         };

        ...
    };

    For my board "simple-bus" is an already defined bus in the .dts. 
In my case the .dts had:

    / {
        ...

        localbus {
          compatible = 
"fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";

          ...
         };

        ...
    };

(2) Create the OF driver:

    #include <linux/of.h>
    #include <linux/kernel.h>
    #include <linux/of_platform.h>

    static int __devinit mydevice_probe(struct of_device *ofdev, const 
struct of_device_id *match)
    {
     printk("mydevice_probe\n");
     return 0;
    }

    static int mydevice_remove(struct of_device *ofdev)
    {
     printk("mydevice_remove\n");
     return 0;
    }


    static const struct of_device_id mydevice_match[] = {
     {
      .compatible = "myvendor,mydevice",
     },
     {}
    };

    static struct of_platform_driver mydevice_driver = {
     .name = "mydevice-driver",
     .match_table = mydevice_match,
     .probe = mydevice_probe,
     .remove = mydevice_remove,
    };

    static int __init mydevice_driver_init(void)
    {
     printk("mydevice_drver_init\n");

     if (of_register_platform_driver(&mydevice_driver))
      printk(KERN_ERR "Unable to register platform driver\n");

     return 0;
    }
    module_init(mydevice_driver_init);

    static void __exit mydevice_driver_cleanup(void)
    {
     printk("mydevice_driver_cleanup\n");

     of_unregister_platform_driver(&mydevice_driver);
    }
    module_exit(mydevice_driver_cleanup);

    MODULE_DESCRIPTION("mydevice driver");
    MODULE_AUTHOR("name <email>");
    MODULE_LICENSE("GPL v2");
    MODULE_ALIAS("platform:mydevice-driver");

(3) Change the appropriate Makefile and Kconfig to compile the OF 
driver.

During kernel boot you should see the lines:

    mydevice_driver_init
    mydevice_probe

If not, you probably have one of the strings (text in " ") incorrect.

In /sys/bus/of_platform/drivers, you should have a directory named 
'mydevice-driver'.

In /sys/bus/of_platform/drivers/mydevice-driver you should have a 
directory named 'mydevice0.1'. The name 'mydevice0' comes from the 
.dts above.

==========

Brief explaination of how I think this is all tied together:

(1) The Flattened Device Tree is included with the compiled kernel 
image.

(2) The module_init(...) macro is like declaring a 'main' for drivers. 
The kernel calls all of the functions declared in the module_init(...) 
macros during startup.

(3) When a device driver is registered via 
of_register_platform_driver(), this invokes a scan of the FDT to find 
matches with strings in the .match_table. If a match is found, the 
.probe is called for the created device instance.

Chris
