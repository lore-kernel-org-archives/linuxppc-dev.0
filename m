Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C37BDDF35
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Nov 2008 09:07:38 +1100 (EST)
In-Reply-To: <OFA76D8B60.24A9D6A0-ON882574FC.0082F8AB-882574FD.0000DE16@selinc.com>
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OFD9F4E831.43139485-ON882574FD.00772E9C-882574FD.007963C9@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 10 Nov 2008 14:06:17 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: Timur Tabi <timur@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 11/09/2008 
04:09:51 PM:

> > 
> > The Elo device driver is an async DMA back-end driver.  That is, you
> > don't communicate with that driver directly, you communicate with the
> > async library (which is new - so you won't find it in LDD3).
> > 
> 
> Okay, has anyone actually _used_ the Elo driver?  I can't get the probe 
> function to run.  I get into of_fsl_dma_init(), but of_fsl_dma_probe() 
> never executes.  I have CONFIG_DMADEVICES and CONFIG_FSL_DMA set in my 

It would help if I was sure _when_the probe function was supposed to be 
called.  I traced of_fsl_dma_init() all the way down into 
bus_for_each_dev(), but the call to the passed in function 
(__driver_attach() in this case) never gets called.  This may not be a bad 
thing in and of itself, the USB core registers two interface drivers 
(usbfs and hub) and a device driver (usb) just prior this that also don't 
call into the function passed into bus_for_each_dev().

The only thing I'm used to yet, being so new to this level of detail, is 
installing device drivers where the probe function is called right way. 
For example, in my NAND driver when the init funtion runs and calls 
pci_register_driver() I land in my probe function.  That doesn't happen 
when of_fsl_dma_init() calls of_register_platform_driver().  There are 
some obvious differences in the code.  For one thing, my NAND driver is 
described with a device driver structure (i.e., struct pci_device), 
whereas the Elo DMA driver is descibed with a platform driver structure 
(i.e., struct of_platform_driver).  Also, my NAND driver init function is 
wrapped in module_init() whereas the Elo driver init function is wrapped 
in subsys_initcall().  I'm not sure what (if any) these differences mean, 
but I'm stummped.  I have no idea how to attach to the Elo DMA driver.

It seems to me that the probe function should be called as soon as the 
kernel calls the init function, but it doesn't happen.  Any guidence on 
how to make this thing work is really appreciated.  Thanks.

Bruce
