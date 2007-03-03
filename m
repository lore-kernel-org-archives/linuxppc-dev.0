Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8A5ADDF81
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 11:16:45 +1100 (EST)
In-Reply-To: <45E84D32.8040405@gmail.com>
References: <45E5ED35.7090207@gmail.com>
	<0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
	<45E61161.9040900@gmail.com>
	<eaa8f5754d3e1544ce91df01acf2054d@kernel.crashing.org>
	<45E69CDF.20608@gmail.com>
	<3a8c70b34f2ef98fb696c371b4d2c2d2@kernel.crashing.org>
	<45E84D32.8040405@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <507a41eebf447d7ce7c18b007a971b9e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
Date: Sat, 3 Mar 2007 01:16:31 +0100
To: Luotao Fu <devtty0@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> 8000 is device 16, not 10

> I took the number 10 out of the sysfs bus entry. As they are printed as
> %x there.

Oh okay.

> The 10 is a 0x10 = 16. Hence 8000 seemed to be OK then. How is
> this actually supposed to be calculated? (As you can see, I know only
> little about pci stuffs) As I wrote in the last mail. The addr is
> calculated by the parser with
> laddr[0] = (pdev->bus->number << 16) | (pdev->devfn << 8)
> Since we have only one pci bus here, I suppose the bus number should be
> 0. However I'm wondering about what does this devfn stands for?

bus-dev-fn-offset is a 24-bit number; the high 8 bits are
bus number, then 5 bits device number, 3 bits function
number, and 8 bits offset.  devfn is simply device and
function number combined; so your 0x8000 is bus 0, device
16, function 0 (and offset 0).

> I now finally made some processes. I made a really stupid failure and
> put the pci bus in 66 MhZ, the USB controller doesn't like it at all 
> and
> went dow the hill.... Now I run the pci bus with 33MhZ and the USB
> controller is working all fine now.

Progress, good :-)

> However I still get troubles with
> the intel gd82551t ethernet controller. I connected it to the network
> and generated some activities, I even saw the phy blinking. The 
> watchdog
> also works properly and reports link status. However the controller 
> just
> won't generate or receive any interrupts. Both the Becker Driver and 
> the
> intel driver just won't work.

Something is wrong with either the interrupts in your
device tree, or with the board wiring then.

> I noticed that the L1 information are different for the ethernet and 
> usb
> controllers according to /proc/interrupts.

I have no idea what L1 is?

> for eth1 it says Main and for
> usb it says IRQ[0-3], might this be the reason of my problem?

Yeah, since...

>  64:          0  MPC52xx Main Edge      eth1
>  65:          2   MPC52xx IRQ[0-3]  Edge      ehci_hcd:usb1,
> ohci_hcd:usb2, ohci_hcd:usb3


> The interrupt pin of the ethernet controller is connected to irq0 pin 
> of
> the MPC5200B while the interrupt pin of the usb controller is connected
> to irq1 of the MPC5200B.

...you say that the ethernet controller is on IRQ0, which
would be Linux IRQ 65 as well.

> Since the usb has 65 and is working, I suppose
> strongly that 64 for the ethernet controller should also be correct.

Sounds like both should be 65 to me?  Maybe someone
who has experience with 5200 can chime in, I have
never used it.

> The pci node of my the device tree now looks like this:
>
> pci@0d00 {

> 	interrupt-map-mask = <f800 0 0 7>;
> 	interrupt-map = <8000 0 0 1 500 1 0 3 // e100, 10.0

That says: device 16.0, PIRQA, goes to phandle 500
IRQ 1 (so far so good), priority 0?  I believe priority
should be one from 1..3 (but I could very well
be mistaken).

That doesn't explain why Linux throws your interrupt
at 64 instead of 65 though.

> 	interrupt-parent = <500>;

Oh and if you have an interrupt-map, you shouldn't
have an interrupt-parent.  Not that that causes
your problem though.

> Like I mentioned before. I quite did not get the idea of all the open
> firmware things. I'd be very appreciate if you could take a near look 
> on
> this and tell me if you see anything wrong with this node.

It looks pretty much sane.

Enable DEBUG in arch/powerpc/kernel/prom_parse.c ,
maybe it'll tell you a bit more.  Oh and read the
5200 datasheet again, make double sure which interrupt
on the interrupt controller the four PCI interrupts
connect to.

Good luck and have fun,


Segher
