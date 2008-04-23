Return-Path: <henka@henka.dyndns.org>
Received: from proxy1.bredband.net (proxy1.bredband.net [195.54.101.71])
	by ozlabs.org (Postfix) with ESMTP id 6C69DDE10A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 02:02:41 +1000 (EST)
Received: from ironport.bredband.com (195.54.101.120) by proxy1.bredband.net
	(7.3.127) id 47E10B8B00AC23DD for linuxppc-embedded@ozlabs.org;
	Wed, 23 Apr 2008 17:41:51 +0200
Date: Wed, 23 Apr 2008 17:41:50 +0200 (CEST)
From: Henrik Larson <henka@henka.dyndns.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: SecretLab 2.6.24 with USB
In-Reply-To: <87iqy8haf8.fsf@macbook.be.48ers.dk>
Message-ID: <Pine.LNX.4.62.0804231741110.20567@henka.dyndns.org>
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
	<480E4EBD.3010202@zin-tech.com>
	<fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
	<480F4E8E.4010506@zin-tech.com> <87iqy8haf8.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Cc: Aaron Sells <aaron.sells@zin-tech.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Allt som har med skatter är per definition inte logiskt!



On Wed, 23 Apr 2008, Peter Korsgaard wrote:

>>>>>> "Aaron" == Aaron Sells <aaron.sells@zin-tech.com> writes:
>
> Hi,
>
> Aaron> root@xilinx-ml403:/# dmesg | grep -i usb
> Aaron> [    0.175963] usbcore: registered new interface driver usbfs
> Aaron> [    0.178207] usbcore: registered new interface driver hub
> Aaron> [    0.179810] usbcore: registered new device driver usb
> Aaron> [    3.426016] usbcore: registered new interface driver ub
> Aaron> [    4.156086] usbmon: debugfs is not available
> Aaron> [    4.209160] Initializing USB Mass Storage driver...
> Aaron> [    4.268302] usbcore: registered new interface driver usb-storage
> Aaron> [    4.336109] USB Mass Storage support registered.
> Aaron> [    4.958294] usbcore: registered new interface driver usbhid
> Aaron> [    5.020120] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
>
> Yes, the USB core and drivers gets loaded, but because you haven't
> provided a struct platform_device the c67x00 driver doesn't get
> probed.
>
> Aaron> It still doesn't look like the ML403 Cypress host device is being
> Aaron> recognized.  No messages appear upon insertion and removal of USB
> Aaron> devices.
>
> Aaron> Regards,
> Aaron> Aaron Sells
> Aaron> diff linux-2.6-xlnx_arch-ppc-syslib-virtex_devices.c secretlab_arch-ppc-syslib-virtex_devices.c
> Aaron> 77,92d76
> Aaron> <  * ML300/ML403 Video Device: shortcut macro for single instance
>
> Please use diff -u.
>
> I don't see anything with platform devices for the c67x00 driver. You
> need something like:
>
> #include <linux/usb/c67x00.h>
>
> static struct resource c67x00_resources[] = {
> 	[0] = {
> 		.start	= 0x84000000,
> 		.end	= 0x8400000f,
> 		.flags	= IORESOURCE_MEM,
> 	},
> 	[1] = {
> 		.start	= 3,
> 		.end	= 3,
> 		.flags	= IORESOURCE_IRQ,
> 	},
> };
>
> static struct c67x00_platform_data thinlite_c67x00_data = {
> 	.sie_config		= C67X00_SIE1_HOST | C67X00_SIE2_PERIPHERAL_B,
> 	.hpi_regstep		= 0x02, /* A0 not connected on 16bit bus */
> };
>
> static struct platform_device thinlite_c67x00 = {
> 	.name			= "c67x00",
> 	.id			= 0,
> 	.num_resources		= ARRAY_SIZE(c67x00_resources),
> 	.resource		= c67x00_resources,
> 	.dev.platform_data	= &thinlite_c67x00_data,
> };
>
> Which you then register with the platform bus with
> platform_add_devices or similar. Either you do this by hand or you
> create XPAR_* macros which take the needed info out of xparameter.h
> (sorry, I don't have an xparameters.h with those defines at hand).
>
> Aaron> diff -Naur c67x00.old/c67x00-drv.c c67x00/c67x00-drv.c
> Aaron> --- c67x00.old/c67x00-drv.c	2008-04-23 10:36:16.000000000 -0400
> Aaron> +++ c67x00/c67x00-drv.c	2008-04-23 10:39:20.000000000 -0400
> Aaron> @@ -57,8 +57,7 @@
> Aaron>  		c67x00_hcd_probe(sie);
> Aaron>  		break;
>
> Aaron> -	case C67X00_SIE_PERIPHERAL_A:
> Aaron> -	case C67X00_SIE_PERIPHERAL_B:
> Aaron> +	case C67X00_SIE_PERIPHERAL:
>
> This seems to be from an earlier version of my driver.
>
> -- 
> Bye, Peter Korsgaard
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
