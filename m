Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AB28DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 09:20:08 +1100 (EST)
In-Reply-To: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
References: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3B008FD0-DF55-492B-A60A-EF0F9F8F75AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [MPC8349ITX] USB Init with PPC arch
Date: Mon, 22 Jan 2007 16:19:06 -0600
To: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jan 22, 2007, at 11:10 AM, Benjamin Zores wrote:

>
> Hi,
>
> This question is mainly intended to Freescale's MPC8349ITX board  
> maintainer
> but the issue/resolution is probably the same for other boards.
>
> I'm trying to boot the MPC8349ITX card with Linux 2.6.19 using old PPC
> architecture (and not the new PowerPC one).
> I've ported patches from Freescale's BSP from 2.6.13 to 2.6.19 and
> it works pretty well but USB doesn't init properly.
>
> Switching to PowerPC arch of course works fine and USB is well inited
> but due to other feature i use that only exist on PPC right now, I  
> can't
> make use of it.

What are these features?

> So I've added the attached patched to my PPC kernel in order to  
> initialize
> the USB controller the same way it is done in DTS file for PowerPC  
> arch.
> The goal is of course to use the regular EHCI-FSL driver.
>
> I've noticed that PowerPC arch starts by initing the DR controller  
> than MPH one.
> On PPC it's the opposite way. Although I have to not initialize the  
> DR one, which
> seems to completely hang the card at USB controller probe.
>
> Initializing the MPH controller seems to work fine but then
> USB stack has a lot of errors which seem to come from bad EHCI-FSL  
> init.
> (see below)
>
> fsl-ehci fsl-ehci.1: No platform data for fsl-ehci.1.
> fsl-ehci fsl-ehci.2: Freescale On-Chip EHCI Host Controller
> fsl-ehci fsl-ehci.2: new USB bus registered, assigned bus number 1
> fsl-ehci fsl-ehci.2: irq 39, io base 0xe0022000
> fsl-ehci fsl-ehci.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: Product: Freescale On-Chip EHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.19.2-fsl ehci_hcd
> usb usb1: SerialNumber: fsl-ehci.2
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> USB Universal Host Controller Interface driver v3.0
> Initializing USB Mass Storage driver...
> usb 1-1: new high speed USB device using fsl-ehci and address 2
> usb 1-1: device descriptor read/64, error -32
> usb 1-1: device descriptor read/64, error -32
> usb 1-1: new high speed USB device using fsl-ehci and address 3
> usb 1-1: device descriptor read/64, error -32
> usb 1-1: device descriptor read/64, error -32
> usb 1-1: new high speed USB device using fsl-ehci and address 4
> usb 1-1: device not accepting address 4, error -32
> usb 1-1: new high speed USB device using fsl-ehci and address 5
> usb 1-1: device not accepting address 5, error -32
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
>
> Of course, the USB controller isn't working afterwards
> and no USB device can be used.
>
> Does anyone has an idea where the problem might come from and how  
> to solve it
> (once again, switching to PowerPC arch is ok but i don't want to).

If you are forward porting the Freescale patches and not using the in  
kernel driver that would explain the issue.  There are bugs in the  
Freescale driver that have been fixed in the driver that is in the  
kernel.

- kumar
