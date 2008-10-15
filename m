Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id C9FADDE004
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 01:59:38 +1100 (EST)
Message-ID: <48F60493.8050708@hypersurf.com>
Date: Wed, 15 Oct 2008 07:56:19 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linux-usb@vger.kernel.org
Subject: Re: gigE 2.6.27 USB
References: <48F32451.7020303@hypersurf.com>	 <48F479ED.1030500@hypersurf.com>
	<1224045959.8157.424.camel@pasglop>
In-Reply-To: <1224045959.8157.424.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-10-14 at 03:52 -0700, Kevin Diggs wrote:
> 
>>Kevin Diggs wrote:
>>
>>>Hi,
>>>
>>>    I managed to wrestle my gigE to the ground and get it to boot
>>>2.6.27. I have, however, noticed that some messages are showing up in
>>>dmesg. There are alot of them. They are continuous. They appear to come
>>>from drivers/usb/core/hub.c:2916. It looks like they come in pairs (this
>>>beast has two ports (root hubs)). I plugged in a USB CF reader. It
>>>appears to work. The keyboard and mouse (a Logitech wireless receiver)
>>>seems to work. 2.6.24 did not do this.
>>>
>>>kevin
>>>
>>
>>	For what it is worth, I tricked a laptop into booting 2.6.27. It
>>does not appear to generate these messages. The PowerMac is running
>>Yellow Dog 4.
> 
> 
> It would be a lot more useful if you included informations in your
> report such as :
> 
>  - The actual error output
>  - The full dmesg log
>  - Informations about the adapter including output of lsusb -v
>  - How do you actually trigger the problem
> 
> It would be even more useful if you CC'ed some relevant list such
> as the linux-usb one too :-)
> 
> Cheers,
> Ben.
> 
> 
> 
I cut a deal with my 8600 to get it to boot 2.6.27. It does not seem
to work right either.

The error message that shows up in dmesg is (the messages that show
up for the gigE appear to be for two different busses (hubs?):

hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000

lsusb does not work on this system:

Unknown line at line 4969
    .
    .
    .
Unknown line at line 5004

lspci shows:

01:0d.0 USB Controller: Lucent Microelectronics USS-312 USB Controller (rev 10)

The relevant lines from the dmesg (before they get overwritten are):

ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:01:0d.0: enabling device (0004 -> 0006)
ohci_hcd 0000:01:0d.0: OHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:01:0d.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:0d.0: created debug files
ohci_hcd 0000:01:0d.0: irq 25, io mem 0x80800000
ohci_hcd 0000:01:0d.0: OHCI controller state
ohci_hcd 0000:01:0d.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:01:0d.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:01:0d.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:01:0d.0: intrstatus 0x00000004 SF
ohci_hcd 0000:01:0d.0: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:01:0d.0: hcca frame #001f
ohci_hcd 0000:01:0d.0: roothub.a 10000202 POTPGT=16 NPS NDP=2(2)
ohci_hcd 0000:01:0d.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:01:0d.0: roothub.status 00008000 DRWE
ohci_hcd 0000:01:0d.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:01:0d.0: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 32ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: trying to enable port power on non-switchable hub
drivers/usb/core/inode.c: creating file '001'
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.27-pll-hrt ohci_hcd
usb usb1: SerialNumber: 0000:01:0d.0
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usbcore: registered new interface driver libusual


This is a PowerMac8600 with an OrangeLink USB Firewire card. The
GigE starts spewing them immediately with no triggering event
(though one should keep in mind that it uses a USB keyboard).
The 8600 was fine until a gigaware USB 2 hub was plugged in (i.e.
first thing plugged in). A CF reader seems to be working.

The 8600 was running 2.6.26 before the upgrade to 2.6.27. I don't think
it did this under 2.6.26.

lsusb did work on the gigE.

Thanks for the reply, Ben.

kevin
