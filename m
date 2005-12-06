Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.36])
	by ozlabs.org (Postfix) with ESMTP id 70FEB68866
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 02:09:26 +1100 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 542C928003F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 16:09:22 +0100 (CET)
Message-ID: <4395AA59.5030209@cpe.fr>
Date: Tue, 06 Dec 2005 16:12:25 +0100
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20051206125102.1FC7F68888@ozlabs.org>
In-Reply-To: <20051206125102.1FC7F68888@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: no IRQ from USB on MPC8248
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

As I said previously I started a backport of the hcd driver from 
sourceforge (http://cpm2usb.sourceforge.net/) to linux 2.6.9 for an 
actis board (VSBC6848) based on a MPC8248 (MPC8272 family)
I have a running 2.6.9 kernel for this board, and no other, that's why 
I'm doing a backport of the driver. (for those who might wonder)

I managed to have the core up:

---> insmod usbcore.ko
Using usbcore.ko
usbcore: registered new driver usbfs
usbcore: registered new driver hub
---> mount /proc/bus/usb
---> insmod m82xx-hcd.ko
Using m82xx-hcd.ko
=> driver mpc82xx-hcd, 0.02
mpc82xx-hcd mpc82xx-hcd3: PQ2 intergrated USB controller v0.1
mpc82xx-hcd mpc82xx-hcd3: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
PQ2USB: debug file creation
---> Done
~ #

so this is OK

then, when plugging a device, I got this:
usb 1-1: new full speed USB device using address 2
usb 1-1: control timeout on ep0out
mpc82xx-hcd mpc82xx-hcd3: Unlink after no-IRQ? Different ACPI or APIC 
settings may help.
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 2, error -110
usb 1-1: new full speed USB device using address 3
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 3, error -110

which means the hub detects a device, and tries to configure it.
On the device (MP3player) I have an LCD display, and the text switches 
to "USB-C" and comes back, which means something has been received. 
Let's consider the device is working fine, I have then two possibilities:

first: the device receives incoherent stuff, and does not dare 
responding, but I got no way to check on the device. (I consider the 
usbcore tries to send cohenrent stuff!)

second: the device is happy to see a request and replies correctly.... 
but there's no interrupt fired, whether using SUI_INT_USB (==11) or the 
SCC3 interrupt (==42)


I've been looking for many things allready, but did not find a clue of 
what might happen... If you have some, I'll be pleased to hear about them.

I also had a look at the debug file:

~ # cat /proc/driver/m8xxhci_privateh
===> Misc stats:
sof = 0 isrs = 0 cpm_irqs = 0 overrun = 0
rxb = 0 txb = 0 bsy = 0 sof = 0
txe[0] = 0 txe[1] = 0 txe[2] = 0 txe[3] = 0
nak[0] = 0 nak[1] = 0 nak[2] = 0 nak[3] = 0
to[0] = 0 to[1] = 0 to[2] = 0 to[3] = 0
stall[0] = 0 stall[1] = 0 stall[2] = 0 stall[3] = 0
tx_err = 0 tx_nak = 0 tx_stal = 0 tx_to = 0 tx_un = 0
enqs[ISO] = 0 enqs[INTR] = 0 enqs[CTRL] = 4 enqs[BULK] = 0
cpls[ISO] = 0 cpls[INTR] = 0 cpls[CTRL] = 4 cpls[BULK] = 0
===> Periodic schedule:
~ #

but as I do not know what might be expected, I do not know what to think 
about it.

The sof, isrs, and cpm_irqs counters confirm that there have been no 
irqs ...

please, help me if you can.
and anyway, have fun :) :)
