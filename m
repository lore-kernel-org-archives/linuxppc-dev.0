Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9678DDF22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Nov 2008 01:51:18 +1100 (EST)
Message-ID: <49199BDB.8050700@freescale.com>
Date: Tue, 11 Nov 2008 08:51:07 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OFD9F4E831.43139485-ON882574FD.00772E9C-882574FD.007963C9@selinc.com>
In-Reply-To: <OFD9F4E831.43139485-ON882574FD.00772E9C-882574FD.007963C9@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:
> linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 11/09/2008 
> 04:09:51 PM:
> 
>>> The Elo device driver is an async DMA back-end driver.  That is, you
>>> don't communicate with that driver directly, you communicate with the
>>> async library (which is new - so you won't find it in LDD3).
>>>
>> Okay, has anyone actually _used_ the Elo driver?  I can't get the probe 
>> function to run.  I get into of_fsl_dma_init(), but of_fsl_dma_probe() 
>> never executes.  I have CONFIG_DMADEVICES and CONFIG_FSL_DMA set in my 
> 
> It would help if I was sure _when_the probe function was supposed to be 
> called. 

Normally, your driver's OF probe function will be called when the driver calls
of_register_platform_driver().

> I traced of_fsl_dma_init() all the way down into 
> bus_for_each_dev(), but the call to the passed in function 
> (__driver_attach() in this case) never gets called. 

I believe this because the kernel never scanned the DMA entries in the device
tree.  This is why I said you need of_platform_bus_probe() with the compatible
field of the parent of the DMA controller node.  Send me your device tree.

> Also, my NAND driver init function is 
> wrapped in module_init() whereas the Elo driver init function is wrapped 
> in subsys_initcall(). 

When compiled as a module, subsys_initcall() becomes module_init().  When
compiled in-kernel, subsys_initcall() guarantees the DMA driver is initialized
before other (normal) drivers are.

-- 
Timur Tabi
Linux kernel developer at Freescale
