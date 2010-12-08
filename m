Return-Path: <JOFT@gmx.de>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 3FC04B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 06:26:47 +1100 (EST)
Message-ID: <4CFFDA61.9090803@gmx.de>
Date: Wed, 08 Dec 2010 20:20:01 +0100
From: =?ISO-8859-1?Q?Joachim_F=F6rster?= <JOFT@gmx.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>	<201012061544.40124.dargaud@lpsc.in2p3.fr>	<1291770234.2041.102.camel@concordia>	<201012081118.13977.dargaud@lpsc.in2p3.fr>
	<1291815910.12093.15.camel@concordia>
In-Reply-To: <1291815910.12093.15.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guillaume,

Michael Ellerman wrote:
> On Wed, 2010-12-08 at 11:18 +0100, Guillaume Dargaud wrote:
>> ///////////////////////////////////////////////////////////////////////////////
>> // Called on insmod
>> static int __init xad_init(void) {
>>   int rc=0;
>>   printk(KERN_INFO SD "Module %s: loading...\n" FL, NAME);
>>   

Are you sure that you want to have the chrdev registration here (the
following code)?

Such stuff typically goes into the probe() function. The modules's
init() just registers the driver. Furthermore your global variables
prohibit having more than one device instance using the driver.

>>   // Deal with the device
>>   first = MKDEV (my_major, my_minor);
>>   register_chrdev_region(first, count, DEVNAME);
>>   my_cdev = cdev_alloc ();
>>   if (NULL==my_cdev) goto Err;
>>   
>>   cdev_init(my_cdev, &fops);
>>   cdev_add (my_cdev, first, count);
>>
>>   printk(KERN_INFO SD "Module %s: Major=%d, Minor=%d, Count=%d\n" FL, NAME, 
>> my_major, my_minor, count);
>>
>>   // Driver
>>   rc = platform_driver_register(&xad_driver);
> 
> Should be of_register_platform_driver()
> 
>> //  rc = platform_driver_probe(&xad_driver, xad_driver_probe);
>>   if (rc) goto err_plat;
>>

I think the following function call to platform_device_register_simple()
and if() does not belong here.

As was said before, "devices" are registered by the (platform) bus. Your
driver module, needs to just register, well, the "driver". You are doing
this above - and that's it: (of_)platform_driver_register().

>>   // Device
>>   pdev=platform_device_register_simple("xps-acqui-data", -1, NULL, 0);
>>   if (IS_ERR(pdev)) {
>>           rc = PTR_ERR(pdev);
>>           platform_driver_unregister(&xad_driver);
>>           goto err_plat;
>>   }
>>
>>
>>   return 0;
>>
>> err_plat:
>>   unregister_chrdev_region(first, count);
>> Err:
>>   printk(KERN_ERR SD "Module %s: Failed loading rc=%d\n" FL, NAME, rc);
>>   return rc;
>> }

 Joachim
