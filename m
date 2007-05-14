Return-Path: <stevewin@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41C95DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 00:07:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4EE44iL023786
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 10:04:04 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EE7aPr200752
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 08:07:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EE7aFH001920
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 08:07:36 -0600
Received: from d03nm125.boulder.ibm.com (d03nm125.boulder.ibm.com
	[9.17.195.151])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4EE7atg001916
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 May 2007 08:07:36 -0600
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: USB support for Bamboo/440EP (Yosemite/440EPx)
Message-ID: <OF5B339C18.B1F62CD6-ON85257371.003D3A0F-852572DB.004D9561@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Mon, 14 May 2007 10:07:34 -0400
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is there an intention to add the configuration for the USB host controller 
for Bamboo/Yosemite to the mainline kernel?  drivers/usb/host contains 
ohci-ppc-soc.c/h, but the Kconfig isn't updated to include it for 
440EP/EPx? 

I noticed it is configured in the Denx 4.1 2.6.19.2 kernel.  When I 
updated the 2.6.21 drivers/usb/host/Kconfig to include the controller 
support for 440EP for some reason I couldn't get the kernel to recognize 
the controller or devices when it boots - not sure if there is something 
else I am missing here?  One thing I noticed was that in the 2.6.19.2 
kernel CONFIG_USB_OHCI_BIG_ENDIAN gets defined - in 2.6.21 there is both 
CONFIG_USB_OHCI_BIG_ENDIAN_DESC and CONFIG_USB_OHCI_BIG_ENDIAN_MMIO - 
assume I want both defined?

Wondering also if anyone has much experience using the USB interface on 
Bamboo - and if any reliability issues have been observed?  I have a 
Bamboo system where we've added graphics card init capability to PIBS and 
are using the DENX 2.6.19.2 kernel and booting X (Xorg 7.1.1 - Debian 4.0 
system on hard disk) with a USB keyboard and mouse - and sometimes the 
mouse/keyboard are not detected properly by either the kernel on boot, or 
by X during its initialization (sometimes even after the kernel seems to 
detect everything fine).  I did play a bit with a memory stick on the 
interface and that seemed reliable for the little I did with it.

I am using an Apple keyboard plugged into the USB port on the board, with 
an IBM Scrollpoint USB mouse plugged into one of the ports on the 
keyboard.

An excerpt of the kernel boot when it finds everything OK:

...
IBM mouse - input driver mouse interface
hde: cache flushes supported
 hde: hde1 hde2 hde3
ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller
ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number 1
ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000
usb usb1: Product: USB Host Controller
usb usb1: Manufacturer: Linux 2.6.19.2 ohci_hcd
usb usb1: SerialNumber: PPC-SOC USB
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
usb 1-1: new full speed USB device using ppc-soc-ohci and address 2
usb 1-1: Product: Hub in Apple Extended USB Keyboard
usb 1-1: Manufacturer: Mitsumi Electric
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
eth0: link is up, 100 FDX, pause enabled
eth1: link is down
usb 1-1.1: new low speed USB device using ppc-soc-ohci and address 3
usb 1-1.1: configuration #1 chosen from 1 choice
input: HID 04b3:3100 as /class/input/input0
input: USB HID v1.00 Mouse [HID 04b3:3100] on usb-PPC-SOC USB-1.1
usb 1-1.3: new full speed USB device using ppc-soc-ohci and address 4
usb 1-1.3: Product: Apple Extended USB Keyboard
usb 1-1.3: Manufacturer: Mitsumi Electric
usb 1-1.3: configuration #1 chosen from 1 choice
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB 
Keyboard] on
usb-PPC-SOC USB-1.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] 
on us
b-PPC-SOC USB-1.3
Sending DHCP requests .,. OK
...
Sometimes though it does not find the mouse:
...
hde: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=65535/16/63
hde: cache flushes supported
 hde: hde1 hde2 hde3
ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller
ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number 1
ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000
usb usb1: Product: USB Host Controller
usb usb1: Manufacturer: Linux 2.6.19.2 ohci_hcd
usb usb1: SerialNumber: PPC-SOC USB
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usb 1-1: new full speed USB device using ppc-soc-ohci and address 2
usb 1-1: Product: Hub in Apple Extended USB Keyboard
usb 1-1: Manufacturer: Mitsumi Electric
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
usb 1-1.1: new low speed USB device using ppc-soc-ohci and address 3
usb 1-1.3: new full speed USB device using ppc-soc-ohci and address 4
usb 1-1.3: Product: Apple Extended USB Keyboard
usb 1-1.3: Manufacturer: Mitsumi Electric
usb 1-1.3: configuration #1 chosen from 1 choice
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input0
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB 
Keyboard] on
usb-PPC-SOC USB-1.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] 
on us
b-PPC-SOC USB-1.3
usbcore: registered new interface driver pegasus
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: link is up, 100 FDX, pause enabled
eth1: link is down
Sending DHCP requests .,. OK
...

And on rarer occasions it does not seem to fully discover the keyboard:
...
hde: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=65535/16/63
hde: cache flushes supported
 hde: hde1 hde2 hde3
ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller
ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number 1
ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000
usb usb1: Product: USB Host Controller
usb usb1: Manufacturer: Linux 2.6.19.2 ohci_hcd
usb usb1: SerialNumber: PPC-SOC USB
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
usb 1-1: new full speed USB device using ppc-soc-ohci and address 2
usb 1-1: Product: Hub in Apple Extended USB Keyboard
usb 1-1: Manufacturer: Mitsumi Electric
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
eth0: link is up, 100 FDX, pause enabled
eth1: link is down
usb 1-1.1: new low speed USB device using ppc-soc-ohci and address 3
usb 1-1.3: new full speed USB device using ppc-soc-ohci and address 4
Sending DHCP requests .,. OK
...

One typical fail scenario is that the keyboard/mouse seem to be detected 
fine by the kernel, but X doesn't start because it can't locate the mouse 
device (messages in /var/log/Xorg.0.log).

I did find the following power down sequence which does seem to result in 
reliable detection/operation whenever stopping/starting the system:

- Shutdown from X Desktop
- When Linux console 'power down' message appears, (with power still on) 
unplug then plug the keyboard from/into the USB port
- Power down the board
- Turn the power supply off/on

Thanks,

Steve
