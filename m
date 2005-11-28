Return-Path: <alancarbr@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id B727068816
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 02:27:30 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i11so2179917wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 07:27:29 -0800 (PST)
Message-ID: <dc70db7d0511280727k314faa27g5fc09c074bc28630@mail.gmail.com>
Date: Mon, 28 Nov 2005 13:27:29 -0200
From: Alan Carvalho <alancarbr@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2315_17437247.1133191649045"
Subject: Joystick and Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2315_17437247.1133191649045
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
I am trying use Logitech WingMan Strike Force 3D on Lite5200 board. I am
using linux-2.6.14 Denx's tree, just selecting this options:

CONFIG_INPUT=3Dy
CONFIG_INPUT_JOYDEV=3Dy
CONFIG_INPUT_EVDEV=3Dy
CONFIG_INPUT_EVBUG=3Dy

and

CONFIG_USB_HID=3Dy
CONFIG_USB_HIDINPUT=3Dy
CONFIG_HID_FF=3Dy
CONFIG_LOGITECH_FF=3Dy

As my device ID is not listed in hid-ff.c and hid-lgff.c, then I mapped it:

drivers/usb/input/hid-ff.c :
{0x46d, 0xc285, hid_lgff_init}, // Logitech Wingman Strike Force 3d

drivers/usb/input/hid-lgff.c
{0x046d, 0xc285, ff_joystick},
(I need do it in the PC to force feedback work fine too)

But the problem is the driver is not working correctly, if I try open
/dev/input/event0 it return "No such device", but as you can see below
evbug.c show correctly all joystick events.

Suggestions?

Best regard,

Alan

/ # dmesg
...
usbmon: debugfs is not available
2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PPC SOC)
block sizes: ed 64 td 64
initializing PPC-SOC USB Controller
ppc-soc-ohci ppc-soc-ohci: USB Host Controller
ppc-soc-ohci ppc-soc-ohci: new USB bus registered, assigned bus number 1
ppc-soc-ohci ppc-soc-ohci: irq 44, io mem 0xf0001000
ppc-soc-ohci ppc-soc-ohci: resetting from state 'reset', control =3D 0x0
ppc-soc-ohci ppc-soc-ohci: OHCI controller state
ppc-soc-ohci ppc-soc-ohci: OHCI 1.0, NO legacy support registers
ppc-soc-ohci ppc-soc-ohci: control 0x083 HCFS=3Doperational CBSR=3D3
ppc-soc-ohci ppc-soc-ohci: cmdstatus 0x00000 SOC=3D0
ppc-soc-ohci ppc-soc-ohci: intrstatus 0x00000044 RHSC SF
ppc-soc-ohci ppc-soc-ohci: intrenable 0x8000001a MIE UE RD WDH
ppc-soc-ohci ppc-soc-ohci: hcca frame #0005
ppc-soc-ohci ppc-soc-ohci: roothub.a 02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2=
)
ppc-soc-ohci ppc-soc-ohci: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ppc-soc-ohci ppc-soc-ohci: roothub.status 00008000 DRWE
ppc-soc-ohci ppc-soc-ohci: roothub.portstatus [0] 0x00000100 PPS
ppc-soc-ohci ppc-soc-ohci: roothub.portstatus [1] 0x00000100 PPS
ppc-soc-ohci ppc-soc-ohci: created debug files
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: USB Host Controller
usb usb1: Manufacturer: Linux 2.6.14 ohci_hcd
usb usb1: SerialNumber: PPC-SOC USB
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0000
Serial: MPC52xx PSC driver
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 64 RAM disks of 4096K size 1024 blocksize
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
Generic platform RAM MTD, (c) 2004 Simtec Electronics
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem) readonly.
Freeing unused kernel memory: 108k init
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
ppc-soc-ohci ppc-soc-ohci: GetStatus roothub.portstatus [0] =3D 0x00010301 =
CSC
LSDA PPS CCS
hub 1-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
ppc-soc-ohci ppc-soc-ohci: GetStatus roothub.portstatus [0] =3D 0x00100303
PRSC LSDA PPS PES CCS
usb 1-1: new low speed USB device using ppc-soc-ohci and address 2
ppc-soc-ohci ppc-soc-ohci: GetStatus roothub.portstatus [0] =3D 0x00100303
PRSC LSDA PPS PES CCS
usb 1-1: skipped 1 descriptor after interface
usb 1-1: default language 0x0409
usb 1-1: new device strings: Mfr=3D4, Product=3D32, SerialNumber=3D0
usb 1-1: Product: WingMan Strike Force 3D
usb 1-1: Manufacturer: Logitech Inc.
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usbhid 1-1:1.0: usb_probe_interface
usbhid 1-1:1.0: usb_probe_interface - got id
drivers/usb/input/hid-core.c: timeout initializing reports

Force feedback for Logitech force feedback devices by Johann Deneux <
johann.deneux@it.uu.se>
input: Logitech Inc. WingMan Strike Force 3D//class/input as input0
evbug.c: Connected device: "Logitech Inc. WingMan Strike Force 3D",
usb-PPC-SOC USB-1/input0
input<7>evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0,
Value: 620
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 1, Value: 536
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 5, Value: 140
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 6, Value: 126
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0
: USB HID v1.00 Joystick [Logitech Inc. WingMan Strike Force 3D] on
usb-PPC-SOC USB-1
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 619
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 5, Value: 141
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 618
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 624
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 618
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0
/ # cat /dev/input/event2
cat: /dev/input/event2: No such device

------=_Part_2315_17437247.1133191649045
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br>
I am trying use Logitech WingMan Strike Force 3D on Lite5200 board. I
am using linux-2.6.14 Denx's tree, just selecting this options:<br>
<br>
CONFIG_INPUT=3Dy<br>
CONFIG_INPUT_JOYDEV=3Dy<br>
CONFIG_INPUT_EVDEV=3Dy<br>
CONFIG_INPUT_EVBUG=3Dy<br>
<br>
and<br>
<br>
CONFIG_USB_HID=3Dy<br>
CONFIG_USB_HIDINPUT=3Dy<br>
CONFIG_HID_FF=3Dy<br>
CONFIG_LOGITECH_FF=3Dy<br>
<br>
As my device ID is not listed in hid-ff.c and hid-lgff.c, then I mapped it:=
<br>
<p>drivers/usb/input/hid-ff.c :<br>
{0x46d, 0xc285, hid_lgff_init}, // Logitech Wingman Strike Force 3d</p>

=09
<p>drivers/usb/input/hid-lgff.c<br>
{0x046d, 0xc285, ff_joystick},</p>
(I need do it in the PC to force feedback work fine too)<br>
<br>
But the problem is the driver is not working correctly, if I try open
/dev/input/event0 it return &quot;No such device&quot;, but as you can see =
below
evbug.c show correctly all joystick events.<br>
<br>
Suggestions?<br>
<br>
Best regard,<br>
<br>
Alan<br>
<br>
/ # dmesg<br>
...<br>
usbmon: debugfs is not available<br>
2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PPC SOC)<br>
block sizes: ed 64 td 64<br>
initializing PPC-SOC USB Controller<br>
ppc-soc-ohci ppc-soc-ohci: USB Host Controller<br>
ppc-soc-ohci ppc-soc-ohci: new USB bus registered, assigned bus number 1<br=
>
ppc-soc-ohci ppc-soc-ohci: irq 44, io mem 0xf0001000<br>
ppc-soc-ohci ppc-soc-ohci: resetting from state 'reset', control =3D 0x0<br=
>
ppc-soc-ohci ppc-soc-ohci: OHCI controller state<br>
ppc-soc-ohci ppc-soc-ohci: OHCI 1.0, NO legacy support registers<br>
ppc-soc-ohci ppc-soc-ohci: control 0x083 HCFS=3Doperational CBSR=3D3<br>
ppc-soc-ohci ppc-soc-ohci: cmdstatus 0x00000 SOC=3D0<br>
ppc-soc-ohci ppc-soc-ohci: intrstatus 0x00000044 RHSC SF<br>
ppc-soc-ohci ppc-soc-ohci: intrenable 0x8000001a MIE UE RD WDH<br>
ppc-soc-ohci ppc-soc-ohci: hcca frame #0005<br>
ppc-soc-ohci ppc-soc-ohci: roothub.a 02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2=
)<br>
ppc-soc-ohci ppc-soc-ohci: roothub.b 00000000 PPCM=3D0000 DR=3D0000<br>
ppc-soc-ohci ppc-soc-ohci: roothub.status 00008000 DRWE<br>
ppc-soc-ohci ppc-soc-ohci: roothub.portstatus [0] 0x00000100 PPS<br>
ppc-soc-ohci ppc-soc-ohci: roothub.portstatus [1] 0x00000100 PPS<br>
ppc-soc-ohci ppc-soc-ohci: created debug files<br>
usb usb1: default language 0x0409<br>
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1<br>
usb usb1: Product: USB Host Controller<br>
usb usb1: Manufacturer: Linux 2.6.14 ohci_hcd<br>
usb usb1: SerialNumber: PPC-SOC USB<br>
usb usb1: adding 1-0:1.0 (config #1, interface 0)<br>
hub 1-0:1.0: usb_probe_interface<br>
hub 1-0:1.0: usb_probe_interface - got id<br>
hub 1-0:1.0: USB hub found<br>
hub 1-0:1.0: 2 ports detected<br>
hub 1-0:1.0: standalone hub<br>
hub 1-0:1.0: ganged power switching<br>
hub 1-0:1.0: global over-current protection<br>
hub 1-0:1.0: power on to power good time: 4ms<br>
hub 1-0:1.0: local power source is good<br>
hub 1-0:1.0: no over-current condition exists<br>
hub 1-0:1.0: enabling power on all ports<br>
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)<=
br>
ohci_hcd: block sizes: ed 64 td 64<br>
usbcore: registered new driver usbhid<br>
drivers/usb/input/hid-core.c: v2.6:USB HID core driver<br>
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0000<br>
Serial: MPC52xx PSC driver<br>
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC<br>
io scheduler noop registered<br>
io scheduler anticipatory registered<br>
io scheduler deadline registered<br>
io scheduler cfq registered<br>
RAMDISK driver initialized: 64 RAM disks of 4096K size 1024 blocksize<br>
eth0: Phy @ 0x0, type LXT971 (0x001378e2)<br>
Generic platform RAM MTD, (c) 2004 Simtec Electronics<br>
mice: PS/2 mouse device common for all mice<br>
NET: Registered protocol family 2<br>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<br>
TCP established hash table entries: 4096 (order: 2, 16384 bytes)<br>
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<br>
TCP: Hash tables configured (established 4096 bind 4096)<br>
TCP reno registered<br>
TCP bic registered<br>
NET: Registered protocol family 1<br>
NET: Registered protocol family 17<br>
RAMDISK: Compressed image found at block 0<br>
VFS: Mounted root (romfs filesystem) readonly.<br>
Freeing unused kernel memory: 108k init<br>
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002<br>
ppc-soc-ohci ppc-soc-ohci: GetStatus roothub.portstatus [0] =3D 0x00010301 =
CSC LSDA PPS CCS<br>
hub 1-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s<br>
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301<br>
ppc-soc-ohci ppc-soc-ohci: GetStatus roothub.portstatus [0] =3D 0x00100303 =
PRSC LSDA PPS PES CCS<br>
usb 1-1: new low speed USB device using ppc-soc-ohci and address 2<br>
ppc-soc-ohci ppc-soc-ohci: GetStatus roothub.portstatus [0] =3D 0x00100303 =
PRSC LSDA PPS PES CCS<br>
usb 1-1: skipped 1 descriptor after interface<br>
usb 1-1: default language 0x0409<br>
usb 1-1: new device strings: Mfr=3D4, Product=3D32, SerialNumber=3D0<br>
usb 1-1: Product: WingMan Strike Force 3D<br>
usb 1-1: Manufacturer: Logitech Inc.<br>
usb 1-1: adding 1-1:1.0 (config #1, interface 0)<br>
usbhid 1-1:1.0: usb_probe_interface<br>
usbhid 1-1:1.0: usb_probe_interface - got id<br>
drivers/usb/input/hid-core.c: timeout initializing reports<br>
<br>
Force feedback for Logitech force feedback devices by Johann Deneux &lt;<a =
href=3D"mailto:johann.deneux@it.uu.se">johann.deneux@it.uu.se</a>&gt;<br>
input: Logitech Inc. WingMan Strike Force 3D//class/input as input0<br>
evbug.c: Connected device: &quot;Logitech Inc. WingMan Strike Force 3D&quot=
;, usb-PPC-SOC USB-1/input0<br>
input&lt;7&gt;evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code:=
 0, Value: 620<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 1, Value: 536=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 5, Value: 140=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 6, Value: 126=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0<b=
r>
: USB HID v1.00 Joystick [Logitech Inc. WingMan Strike Force 3D] on usb-PPC=
-SOC USB-1<br>
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 619=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0<b=
r>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 5, Value: 141=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0<b=
r>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 618=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0<b=
r>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 624=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0<b=
r>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 3, Code: 0, Value: 618=
<br>
evbug.c: Event. Dev: usb-PPC-SOC USB-1/input0, Type: 0, Code: 0, Value: 0<b=
r>
/ # cat /dev/input/event2<br>
cat: /dev/input/event2: No such device<br>
<br>
<br>
<br>

------=_Part_2315_17437247.1133191649045--
