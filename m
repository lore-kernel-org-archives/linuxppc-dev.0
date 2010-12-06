Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2465B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 20:58:44 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB69wbSv001043
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Dec 2010 10:58:38 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Mon, 6 Dec 2010 10:58:37 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012031558.35557.dargaud@lpsc.in2p3.fr>
	<1291613340.11896.216.camel@concordia>
In-Reply-To: <1291613340.11896.216.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012061058.37612.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you for the detailed answer. I'm trying to digest it...

> > What's a good source, besides grepping the kernel to no end ?
> 
> Nothing really I'm afraid.
8-|

> So you have a device, it appears in your device tree, and you want to
> write a driver for it.
That's the idea. Communication between usermode and the driver is limited to 
simple ioctl calls and the driver receives an interrupt when certain data has 
been placed in memory blocks by the hardware (like a DMA). Then the user prog 
figures out where that latest data buffer is (mmap) and saves it. 

> The first issue is that someone needs to create a device for your node,
> it doesn't necessarily happen by default. For many platforms this will
> all happen "automagically" as long as the device node that describes
> your device appears in the right place, but I'll describe it in full
> anyway.

I'm on a minimalist embedded system (buildroot+busybox+uclibc), so I'm pretty 
sure I have to do the whole thing. No udev/HAL here.

> In most cases your device will appear below a node that represents a
> bus, eg:
> 
> 	foobus@xyz {
> 		compatible = "vendor,foobus-v1.m.n", "simple-bus";
> 		...
> 		yournode@abc {
> 			...
> 		}
> 	}
> 
> If that isn't the case you need to arrange for it somehow [1].

Commenting on your [1] here. So should I just add "simple-bus" or does the 
VHDL needs to be modified so as to generate this additional bus info ?
I indeed have:

/dts-v1/;
/ {
	#address-cells = <1>;
	#size-cells = <1>;
	compatible = "xlnx,virtex405", "xlnx,virtex";
	model = "testing";
	...
	plb: plb@0 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "xlnx,plb-v46-1.05.a", "xlnx,plb-v46-1.00.a", "simple-
bus";
		ranges ;
		...
		xps_acqui_data_0: xps-acqui-data@c9800000 {
			compatible = "xlnx,xps-acqui-data-3.00.a";
			...
		}
		...
	}
	...
}

> Somewhere there needs to be code to probe that bus and create devices on
> it. That is usually done in platform code with of_platform_bus_probe().

Isn't the of_* code outdated (just been told that on a previous message) ?
Or was it just for of_register_platform_driver ?

> If you don't know what platform you're on, you can look at a boot log
> for a line saying "Using <blah> machine description", it will be very
> early in the log. "blah" is then the name of the platform you're on, and
> you should be able to grep for it in arch/powerpc/platforms.

"Using Xilinx Virtex machine description"
 
> Once you've found the .c file for your platform, there should be a call
> somewhere to of_platform_bus_probe(), with a list of ids, and one of
> those ids should match the compatible property of your bus node. In a
> lot of cases that is just "simple-bus".

That'd be:
arch/powerpc/platforms/40x/virtex.c:51: .name = "Xilinx Virtex",
and
arch/powerpc/platforms/40x/virtex.c:21: { .compatible = "simple-bus", },

No match for simple-bus of acqui-data in dmesg.

> To check a device is being created for your device node, you can look
> in /sys/devices. The device names don't match 100% with what's in the
> device tree, but the name should be there, so in your case:
> 
> # find /sys/devices -name '*xps-acqui-data*'

Indeed: 
# ll /sys/devices/plb.0/c9800000.xps-acqui-data
-r--r--r--    1 root     root        4.0K Dec  6 09:47 devspec
-r--r--r--    1 root     root        4.0K Dec  6 09:47 modalias
-r--r--r--    1 root     root        4.0K Dec  6 09:47 name
lrwxrwxrwx    1 root     root           0 Dec  6 09:47 subsystem -> 
../../../bus/of_platform/
-rw-r--r--    1 root     root        4.0K Dec  6 09:47 uevent

So that's created on boot, right ?

> [...code snipped...]

I still need a platform_device_register() after your sample init, right ?
I'll get on to adapting your sample code now. Thanks a lot.
-- 
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
