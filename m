Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98BD567A70
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 13:05:05 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
In-Reply-To: <16924.59237.581247.498382@alkaid.it.uu.se>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 13:04:48 +1100
Message-Id: <1109210688.15027.2.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -Memory: 255872k available (1788k kernel code, 976k data, 144k init, 0k highmem)
> +Memory: 255872k available (1776k kernel code, 0k data, 144k init, 0k highmem)

That is weird... (0k data)

> AGP special page: 0xcffff000
>  Calibrating delay loop... 830.66 BogoMIPS (lpj=4153344)
>  Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> @@ -132,13 +132,7 @@
>  VFS: Mounted root (ext3 filesystem) readonly.
>  Freeing unused kernel memory: 144k init 4k chrp 8k prep
>  usb 3-2: new full speed USB device using ohci_hcd and address 2
> -hub 3-2:1.0: USB hub found
> -hub 3-2:1.0: 3 ports detected
> -usb 3-2.1: new low speed USB device using ohci_hcd and address 3
> -input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:1b.0-2.1
> -usb 3-2.3: new full speed USB device using ohci_hcd and address 4
> -input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
> -input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
> +usb 3-2: can't connect bus-powered hub to this port
>  EXT3 FS on hda5, internal journal
>  Adding 1048568k swap on /dev/hda3.  Priority:-1 extents:1
>  SCSI subsystem initialized
> 
> Note: "Memory: ... 0k data ..." !? Surely that can't be correct.

Not sure what's up, but it's probably something beeing miscompiled. Can
you check if the udelay/medlay loops are correct ?

Ben.
