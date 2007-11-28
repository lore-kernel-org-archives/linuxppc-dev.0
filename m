Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A60F9DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 06:36:32 +1100 (EST)
Message-ID: <474DC326.6070209@anagramm.de>
Date: Wed, 28 Nov 2007 20:36:06 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
In-Reply-To: <20071128194321.0804b3aa@i1501.lan.towertech.it>
Content-Type: multipart/mixed; boundary="------------050809040907010808010502"
Cc: rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050809040907010808010502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Alessandro Zummo schrieb:
> On Wed, 28 Nov 2007 19:25:00 +0100
> Clemens Koller <clemens.koller@anagramm.de> wrote:
> 
>> Well, as already mentioned, I have problems to get my DS1337 RTC on I2C
>> on my MPC8540(ads like) PowerPC working properly on
>> latest 2.6.24-rc2-ge6a5c27f kernels. A paulus.git 2.6.21-rc5-g9a5ee4cc
>> as well as a 2.6.22-rc6-gb75ae860 is working fine.
>> (mainstream's console is broken, so cannot test these, yet.)
>>
>>
>> My guess is that the new rtc-lib's RTC_DRV_DS1307 support is still broken
>> and it also breaks the deprecated SENSORS_DS1337. :-(
> 
>  mmm. I've been told it should work ;)
> 
>> Here is a snippet from my .config which is similar among my kernels.
>> CONFIG_GEN_RTC=y
> 
>  this one must be deselected.
> 
>> CONFIG_SENSORS_DS1337=y
>> CONFIG_SENSORS_DS1374=y
> 
>  ditto.
> 
>> DEV: registering device: ID = '0-0068'
>> bus i2c: add device 0-0068
>> bound device '0-0068' to driver 'ds1337'
> 
>  maybe the wrong driver is kicking in here.
>  the fact that there is no rtc class
>  related output in dmesg should and that
>  there is no /dev/rtc0 could be a sign that the whole class
>  is not going in.
> 
>  do you have full dmesg? 

My current
.config as well as the dmesg is attached with your
suggested changes.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

--------------050809040907010808010502
Content-Type: text/plain;
 name="dmesg-fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-fail.txt"

DEV: registering device: ID = 'tty47'
DEV: registering device: ID = 'tty48'
DEV: registering device: ID = 'tty49'
DEV: registering device: ID = 'tty50'
DEV: registering device: ID = 'tty51'
DEV: registering device: ID = 'tty52'
DEV: registering device: ID = 'tty53'
DEV: registering device: ID = 'tty54'
DEV: registering device: ID = 'tty55'
DEV: registering device: ID = 'tty56'
DEV: registering device: ID = 'tty57'
DEV: registering device: ID = 'tty58'
DEV: registering device: ID = 'tty59'
DEV: registering device: ID = 'tty60'
DEV: registering device: ID = 'tty61'
DEV: registering device: ID = 'tty62'
DEV: registering device: ID = 'tty63'
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Registering platform device 'serial8250'. Parent at platform
DEV: registering device: ID = 'serial8250'
bus platform: add device serial8250
DEV: registering device: ID = 'ttyS0'
DEV: registering device: ID = 'ttyS1'
DEV: registering device: ID = 'ttyS2'
DEV: registering device: ID = 'ttyS3'
bus platform: add driver serial8250
platform: Matched Device serial8250.0 with Driver serial8250
platform: Probing driver serial8250 with device serial8250.0
DEV: Unregistering device. ID = 'ttyS0'
device_create_release called for ttyS0
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
console [ttyS0] enabled
DEV: registering device: ID = 'ttyS0'
DEV: Unregistering device. ID = 'ttyS1'
device_create_release called for ttyS1
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
DEV: registering device: ID = 'ttyS1'
bound device 'serial8250.0' to driver 'serial8250'
platform: Bound Device serial8250.0 to Driver serial8250
platform: Matched Device serial8250 with Driver serial8250
platform: Probing driver serial8250 with device serial8250
bound device 'serial8250' to driver 'serial8250'
platform: Bound Device serial8250 to Driver serial8250
bus pci: add driver serial
loop: module loaded
bus platform: add driver fsl-gianfar_mdio
platform: Matched Device fsl-gianfar_mdio.-5 with Driver fsl-gianfar_mdio
platform: Probing driver fsl-gianfar_mdio with device fsl-gianfar_mdio.-5
DEV: registering device: ID = 'e0024520:00'
bus mdio_bus: add device e0024520:00
DEV: registering device: ID = 'e0024520:1f'
bus mdio_bus: add device e0024520:1f
Gianfar MII Bus: probed
bound device 'fsl-gianfar_mdio.-5' to driver 'fsl-gianfar_mdio'
platform: Bound Device fsl-gianfar_mdio.-5 to Driver fsl-gianfar_mdio
bus platform: add driver fsl-gianfar
platform: Matched Device fsl-gianfar.0 with Driver fsl-gianfar
platform: Probing driver fsl-gianfar with device fsl-gianfar.0
DEV: registering device: ID = 'eth0'
eth0: Gianfar Ethernet Controller Version 1.2, 00:d0:93:0e:4e:c4
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
bound device 'fsl-gianfar.0' to driver 'fsl-gianfar'
platform: Bound Device fsl-gianfar.0 to Driver fsl-gianfar
platform: Matched Device fsl-gianfar.1 with Driver fsl-gianfar
platform: Probing driver fsl-gianfar with device fsl-gianfar.1
DEV: registering device: ID = 'eth1'
eth1: Gianfar Ethernet Controller Version 1.2, 00:d0:93:0e:4e:c5
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
bound device 'fsl-gianfar.1' to driver 'fsl-gianfar'
platform: Bound Device fsl-gianfar.1 to Driver fsl-gianfar
platform: Matched Device fsl-gianfar.2 with Driver fsl-gianfar
platform: Probing driver fsl-gianfar with device fsl-gianfar.2
DEV: registering device: ID = 'eth2'
eth2: Gianfar Ethernet Controller Version 1.2, 00:d0:93:0e:4e:c6
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
bound device 'fsl-gianfar.2' to driver 'fsl-gianfar'
platform: Bound Device fsl-gianfar.2 to Driver fsl-gianfar
bus mdio_bus: add driver Marvell 88E1101
bus mdio_bus: add driver Marvell 88E1112
bus mdio_bus: add driver Marvell 88E1111
mdio_bus: Matched Device e0024520:00 with Driver Marvell 88E1111
mdio_bus: Probing driver Marvell 88E1111 with device e0024520:00
bound device 'e0024520:00' to driver 'Marvell 88E1111'
mdio_bus: Bound Device e0024520:00 to Driver Marvell 88E1111
bus mdio_bus: add driver Marvell 88E1145
bus mdio_bus: add driver Marvell 88E1240
bus mdio_bus: add driver LXT970
bus mdio_bus: add driver LXT971
DEV: registering device: ID = 'dummy0'
device class 'scsi_disk': registering
bus scsi: add driver sd
bus pci: add driver sata_promise
pci: Matched Device 0000:00:12.0 with Driver sata_promise
pci: Probing driver sata_promise with device 0000:00:12.0
sata_promise 0000:00:12.0: version 2.11
scsi0 : sata_promise
DEV: registering device: ID = 'host0'
CLASS: registering class device: ID = 'host0'
class_uevent - name = host0
scsi1 : sata_promise
DEV: registering device: ID = 'host1'
CLASS: registering class device: ID = 'host1'
class_uevent - name = host1
scsi2 : sata_promise
DEV: registering device: ID = 'host2'
CLASS: registering class device: ID = 'host2'
class_uevent - name = host2
ata1: SATA max UDMA/133 mmio m4096@0x80000000 port 0x80000200 irq 18
ata2: SATA max UDMA/133 mmio m4096@0x80000000 port 0x80000280 irq 18
ata3: PATA max UDMA/133 mmio m4096@0x80000000 port 0x80000300 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: FUJITSU MHW2100BH, 00000012, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
DEV: registering device: ID = 'target0:0:0'
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHW2100B 0000 PQ: 0 ANSI: 5
DEV: registering device: ID = '0:0:0:0'
bus scsi: add device 0:0:0:0
scsi: Matched Device 0:0:0:0 with Driver sd
scsi: Probing driver sd with device 0:0:0:0
CLASS: registering class device: ID = '0:0:0:0'
class_uevent - name = 0:0:0:0
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
bound device '0:0:0:0' to driver 'sd'
scsi: Bound Device 0:0:0:0 to Driver sd
CLASS: registering class device: ID = '0:0:0:0'
class_uevent - name = 0:0:0:0
bound device '0000:00:12.0' to driver 'sata_promise'
pci: Bound Device 0000:00:12.0 to Driver sata_promise
bus pci: add driver pata_pdc2027x
usbmon: debugfs is not available
bus pci: add driver ehci_hcd
pci: Matched Device 0000:00:14.2 with Driver ehci_hcd
pci: Probing driver ehci_hcd with device 0000:00:14.2
ehci_hcd 0000:00:14.2: EHCI Host Controller
CLASS: registering class device: ID = 'usb_host1'
class_uevent - name = usb_host1
class_device_create_uevent called for usb_host1
ehci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:14.2: irq 20, io mem 0x81202000
ehci_hcd 0000:00:14.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
DEV: registering device: ID = 'usb1'
bus usb: add device usb1
usb: Matched Device usb1 with Driver usb
usb: Probing driver usb with device usb1
device class 'usb_endpoint': registering
DEV: registering device: ID = 'usbdev1.1_ep00'
usb usb1: configuration #1 chosen from 1 choice
DEV: registering device: ID = '1-0:1.0'
bus usb: add device 1-0:1.0
usb: Matched Device 1-0:1.0 with Driver hub
usb: Probing driver hub with device 1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
bound device '1-0:1.0' to driver 'hub'
usb: Bound Device 1-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev1.1_ep81'
DEV: registering device: ID = 'usbdev1.1'
bound device 'usb1' to driver 'usb'
usb: Bound Device usb1 to Driver usb
bound device '0000:00:14.2' to driver 'ehci_hcd'
pci: Bound Device 0000:00:14.2 to Driver ehci_hcd
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
bus of_platform: add driver ppc-of-ohci
bus pci: add driver ohci_hcd
pci: Matched Device 0000:00:14.0 with Driver ohci_hcd
pci: Probing driver ohci_hcd with device 0000:00:14.0
ohci_hcd 0000:00:14.0: OHCI Host Controller
CLASS: registering class device: ID = 'usb_host2'
class_uevent - name = usb_host2
class_device_create_uevent called for usb_host2
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:14.0: irq 20, io mem 0x81200000
DEV: registering device: ID = 'usb2'
bus usb: add device usb2
usb: Matched Device usb2 with Driver usb
usb: Probing driver usb with device usb2
DEV: registering device: ID = 'usbdev2.1_ep00'
usb usb2: configuration #1 chosen from 1 choice
DEV: registering device: ID = '2-0:1.0'
bus usb: add device 2-0:1.0
usb: Matched Device 2-0:1.0 with Driver hub
usb: Probing driver hub with device 2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
bound device '2-0:1.0' to driver 'hub'
usb: Bound Device 2-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev2.1_ep81'
DEV: registering device: ID = 'usbdev2.1'
bound device 'usb2' to driver 'usb'
usb: Bound Device usb2 to Driver usb
bound device '0000:00:14.0' to driver 'ohci_hcd'
pci: Bound Device 0000:00:14.0 to Driver ohci_hcd
pci: Matched Device 0000:00:14.1 with Driver ohci_hcd
pci: Probing driver ohci_hcd with device 0000:00:14.1
ohci_hcd 0000:00:14.1: OHCI Host Controller
CLASS: registering class device: ID = 'usb_host3'
class_uevent - name = usb_host3
class_device_create_uevent called for usb_host3
ohci_hcd 0000:00:14.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:14.1: irq 20, io mem 0x81201000
DEV: registering device: ID = 'usb3'
bus usb: add device usb3
usb: Matched Device usb3 with Driver usb
usb: Probing driver usb with device usb3
DEV: registering device: ID = 'usbdev3.1_ep00'
usb usb3: configuration #1 chosen from 1 choice
DEV: registering device: ID = '3-0:1.0'
bus usb: add device 3-0:1.0
usb: Matched Device 3-0:1.0 with Driver hub
usb: Probing driver hub with device 3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
bound device '3-0:1.0' to driver 'hub'
usb: Bound Device 3-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev3.1_ep81'
DEV: registering device: ID = 'usbdev3.1'
bound device 'usb3' to driver 'usb'
usb: Bound Device usb3 to Driver usb
bound device '0000:00:14.1' to driver 'ohci_hcd'
pci: Bound Device 0000:00:14.1 to Driver ohci_hcd
Initializing USB Mass Storage driver...
bus usb: add driver usb-storage
usb 3-2: new low speed USB device using ohci_hcd and address 2
DEV: registering device: ID = '3-2'
bus usb: add device 3-2
usb: Matched Device 3-2 with Driver usb
usb: Probing driver usb with device 3-2
DEV: registering device: ID = 'usbdev3.2_ep00'
usb 3-2: configuration #1 chosen from 1 choice
DEV: registering device: ID = '3-2:1.0'
bus usb: add device 3-2:1.0
DEV: registering device: ID = 'usbdev3.2_ep81'
DEV: registering device: ID = 'usbdev3.2'
bound device '3-2' to driver 'usb'
usb: Bound Device 3-2 to Driver usb
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
bus type 'usb-serial' registered
bus usb: add driver usbserial
usbcore: registered new interface driver usbserial
bus usb-serial: add driver generic
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
bus usb: add driver usbserial_generic
usb: Matched Device 3-2:1.0 with Driver usbserial_generic
usb: Probing driver usbserial_generic with device 3-2:1.0
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
bus usb-serial: add driver ftdi_sio
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI USB Serial Device
bus usb: add driver ftdi_sio
usbcore: registered new interface driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
bus usb-serial: add driver pl2303
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
bus usb: add driver pl2303
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
DEV: registering device: ID = 'mice'
DEV: registering device: ID = 'psaux'
mice: PS/2 mouse device common for all mice
bus usb: add driver usbtouchscreen
usb: Matched Device 3-2:1.0 with Driver usbtouchscreen
usb: Probing driver usbtouchscreen with device 3-2:1.0
DEV: registering device: ID = 'input0'
input: TSC-10 DM as /devices/pci0000:00/0000:00:14.1/usb3/3-2/3-2:1.0/input/input0
DEV: registering device: ID = 'mouse0'
DEV: registering device: ID = 'event0'
bound device '3-2:1.0' to driver 'usbtouchscreen'
usb: Bound Device 3-2:1.0 to Driver usbtouchscreen
usbcore: registered new interface driver usbtouchscreen
bus i2c: add driver rtc-ds1307
i2c /dev entries driver
device class 'i2c-dev': registering
bus i2c: add driver dev_driver
bus platform: add driver fsl-i2c
platform: Matched Device fsl-i2c.0 with Driver fsl-i2c
platform: Probing driver fsl-i2c with device fsl-i2c.0
DEV: registering device: ID = 'i2c-0'
DEV: registering device: ID = 'i2c-0'
bound device 'fsl-i2c.0' to driver 'fsl-i2c'
platform: Bound Device fsl-i2c.0 to Driver fsl-i2c
bus usb: add driver usbhid
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
DEV: registering device: ID = 'sit0'
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
driver_probe_done: probe_count = 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 120k init
class_uevent - name = 0000:00
class_uevent - name = 0:0:0:0
class_uevent - name = 0:0:0:0
class_uevent - name = host0
class_uevent - name = host1
class_uevent - name = host2
class_uevent - name = usb_host1
class_device_create_uevent called for usb_host1
class_uevent - name = usb_host2
class_device_create_uevent called for usb_host2
class_uevent - name = usb_host3
class_device_create_uevent called for usb_host3
EXT3 FS on sda1, internal journal
Adding 2939884k swap on /dev/sda2.  Priority:-1 extents:1 across:2939884k
DEV: registering device: ID = 'vcs1'
DEV: registering device: ID = 'vcsa1'
DEV: Unregistering device. ID = 'vcs1'
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
DEV: registering device: ID = 'vcsa1'
DEV: Unregistering device. ID = 'vcs1'
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
DEV: registering device: ID = 'vcsa1'
DEV: registering device: ID = 'vcs2'
DEV: registering device: ID = 'vcsa2'
DEV: registering device: ID = 'vcs3'
DEV: registering device: ID = 'vcsa3'
DEV: registering device: ID = 'vcs5'
DEV: registering device: ID = 'vcsa5'
DEV: registering device: ID = 'vcs6'
DEV: registering device: ID = 'vcsa6'
DEV: registering device: ID = 'vcs4'
DEV: registering device: ID = 'vcsa4'
PHY: e0024520:00 - Link is Up - 100/Half
eth0: no IPv6 routers present

--------------050809040907010808010502
Content-Type: application/x-config;
 name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMg
TGludXgga2VybmVsIHZlcnNpb246IDIuNi4yNC1yYzIKIyBXZWQgTm92IDI4IDIwOjIyOjAy
IDIwMDcKIwojIENPTkZJR19QUEM2NCBpcyBub3Qgc2V0CgojCiMgUHJvY2Vzc29yIHN1cHBv
cnQKIwojIENPTkZJR182eHggaXMgbm90IHNldApDT05GSUdfUFBDXzg1eHg9eQojIENPTkZJ
R19QUENfOHh4IGlzIG5vdCBzZXQKIyBDT05GSUdfNDB4IGlzIG5vdCBzZXQKIyBDT05GSUdf
NDR4IGlzIG5vdCBzZXQKIyBDT05GSUdfRTIwMCBpcyBub3Qgc2V0CkNPTkZJR184NXh4PXkK
Q09ORklHX0U1MDA9eQpDT05GSUdfQk9PS0U9eQpDT05GSUdfRlNMX0JPT0tFPXkKIyBDT05G
SUdfUEhZU182NEJJVCBpcyBub3Qgc2V0CkNPTkZJR19TUEU9eQojIENPTkZJR19QUENfTU1f
U0xJQ0VTIGlzIG5vdCBzZXQKQ09ORklHX1BQQzMyPXkKQ09ORklHX1dPUkRfU0laRT0zMgpD
T05GSUdfUFBDX01FUkdFPXkKQ09ORklHX01NVT15CkNPTkZJR19HRU5FUklDX0NNT1NfVVBE
QVRFPXkKQ09ORklHX0dFTkVSSUNfVElNRT15CkNPTkZJR19HRU5FUklDX1RJTUVfVlNZU0NB
TEw9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CkNPTkZJR19HRU5FUklDX0hBUkRJ
UlFTPXkKQ09ORklHX0lSUV9QRVJfQ1BVPXkKQ09ORklHX1JXU0VNX1hDSEdBRERfQUxHT1JJ
VEhNPXkKQ09ORklHX0FSQ0hfSEFTX0lMT0cyX1UzMj15CkNPTkZJR19HRU5FUklDX0hXRUlH
SFQ9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdfR0VORVJJQ19G
SU5EX05FWFRfQklUPXkKIyBDT05GSUdfQVJDSF9OT19WSVJUX1RPX0JVUyBpcyBub3Qgc2V0
CkNPTkZJR19QUEM9eQpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0dFTkVSSUNfTlZS
QU09eQpDT05GSUdfU0NIRURfTk9fTk9fT01JVF9GUkFNRV9QT0lOVEVSPXkKQ09ORklHX0FS
Q0hfTUFZX0hBVkVfUENfRkRDPXkKQ09ORklHX1BQQ19PRj15CkNPTkZJR19PRj15CkNPTkZJ
R19QUENfVURCR18xNjU1MD15CiMgQ09ORklHX0dFTkVSSUNfVEJTWU5DIGlzIG5vdCBzZXQK
Q09ORklHX0FVRElUX0FSQ0g9eQpDT05GSUdfR0VORVJJQ19CVUc9eQpDT05GSUdfREVGQVVM
VF9VSU1BR0U9eQojIENPTkZJR19QUENfRENSX05BVElWRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1BQQ19EQ1JfTU1JTyBpcyBub3Qgc2V0CkNPTkZJR19ERUZDT05GSUdfTElTVD0iL2xpYi9t
b2R1bGVzLyRVTkFNRV9SRUxFQVNFLy5jb25maWciCgojCiMgR2VuZXJhbCBzZXR1cAojCkNP
TkZJR19FWFBFUklNRU5UQUw9eQpDT05GSUdfQlJPS0VOX09OX1NNUD15CkNPTkZJR19JTklU
X0VOVl9BUkdfTElNSVQ9MzIKQ09ORklHX0xPQ0FMVkVSU0lPTj0iIgpDT05GSUdfTE9DQUxW
RVJTSU9OX0FVVE89eQpDT05GSUdfU1dBUD15CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX1NZ
U1ZJUENfU1lTQ1RMPXkKQ09ORklHX1BPU0lYX01RVUVVRT15CiMgQ09ORklHX0JTRF9QUk9D
RVNTX0FDQ1QgaXMgbm90IHNldAojIENPTkZJR19UQVNLU1RBVFMgaXMgbm90IHNldAojIENP
TkZJR19VU0VSX05TIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVESVQgaXMgbm90IHNldApDT05G
SUdfSUtDT05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CkNPTkZJR19MT0dfQlVGX1NI
SUZUPTE0CiMgQ09ORklHX0NHUk9VUFMgaXMgbm90IHNldApDT05GSUdfRkFJUl9HUk9VUF9T
Q0hFRD15CkNPTkZJR19GQUlSX1VTRVJfU0NIRUQ9eQojIENPTkZJR19GQUlSX0NHUk9VUF9T
Q0hFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU0ZTX0RFUFJFQ0FURUQgaXMgbm90IHNldApD
T05GSUdfUkVMQVk9eQojIENPTkZJR19CTEtfREVWX0lOSVRSRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NDX09QVElNSVpFX0ZPUl9TSVpFIGlzIG5vdCBzZXQKQ09ORklHX1NZU0NUTD15CiMg
Q09ORklHX0VNQkVEREVEIGlzIG5vdCBzZXQKQ09ORklHX1NZU0NUTF9TWVNDQUxMPXkKQ09O
RklHX0tBTExTWU1TPXkKQ09ORklHX0tBTExTWU1TX0FMTD15CkNPTkZJR19LQUxMU1lNU19F
WFRSQV9QQVNTPXkKQ09ORklHX0hPVFBMVUc9eQpDT05GSUdfUFJJTlRLPXkKQ09ORklHX0JV
Rz15CkNPTkZJR19FTEZfQ09SRT15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9
eQpDT05GSUdfQU5PTl9JTk9ERVM9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9
eQpDT05GSUdfRVZFTlRGRD15CkNPTkZJR19TSE1FTT15CkNPTkZJR19WTV9FVkVOVF9DT1VO
VEVSUz15CkNPTkZJR19TTFVCX0RFQlVHPXkKIyBDT05GSUdfU0xBQiBpcyBub3Qgc2V0CkNP
TkZJR19TTFVCPXkKIyBDT05GSUdfU0xPQiBpcyBub3Qgc2V0CkNPTkZJR19SVF9NVVRFWEVT
PXkKIyBDT05GSUdfVElOWV9TSE1FTSBpcyBub3Qgc2V0CkNPTkZJR19CQVNFX1NNQUxMPTAK
Q09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVf
Rk9SQ0VfVU5MT0FEPXkKQ09ORklHX01PRFZFUlNJT05TPXkKIyBDT05GSUdfTU9EVUxFX1NS
Q1ZFUlNJT05fQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfS01PRCBpcyBub3Qgc2V0CkNPTkZJ
R19CTE9DSz15CiMgQ09ORklHX0xCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSU9f
VFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19MU0YgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX0JTRyBpcyBub3Qgc2V0CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJR19JT1NDSEVE
X05PT1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19JT1NDSEVEX0RFQURMSU5FPXkK
Q09ORklHX0lPU0NIRURfQ0ZRPXkKQ09ORklHX0RFRkFVTFRfQVM9eQojIENPTkZJR19ERUZB
VUxUX0RFQURMSU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfREVGQVVMVF9DRlEgaXMgbm90IHNl
dAojIENPTkZJR19ERUZBVUxUX05PT1AgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9JT1ND
SEVEPSJhbnRpY2lwYXRvcnkiCgojCiMgUGxhdGZvcm0gc3VwcG9ydAojCiMgQ09ORklHX1BQ
Q19NUEM1Mnh4IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzUyMDAgaXMgbm90IHNldAoj
IENPTkZJR19QUENfQ0VMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19DRUxMX05BVElWRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BRMkFEUyBpcyBub3Qgc2V0CkNPTkZJR19NUEM4NTQwX0FE
Uz15CiMgQ09ORklHX01QQzg1NjBfQURTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDODV4eF9D
RFMgaXMgbm90IHNldAojIENPTkZJR19NUEM4NXh4X01EUyBpcyBub3Qgc2V0CiMgQ09ORklH
X01QQzg1eHhfRFMgaXMgbm90IHNldApDT05GSUdfTVBDODU0MD15CkNPTkZJR19NUEM4NXh4
PXkKQ09ORklHX01QSUM9eQojIENPTkZJR19NUElDX1dFSVJEIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFBDX0k4MjU5IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX1JUQVMgaXMgbm90IHNldAoj
IENPTkZJR19NTUlPX05WUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzEwNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BQQ185NzBfTkFQIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0lO
RElSRUNUX0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVJJQ19JT01BUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NQVV9GUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BNMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZTTF9VTEkxNTc1IGlzIG5vdCBzZXQKCiMKIyBLZXJuZWwgb3B0aW9ucwoj
CiMgQ09ORklHX0hJR0hNRU0gaXMgbm90IHNldApDT05GSUdfVElDS19PTkVTSE9UPXkKIyBD
T05GSUdfTk9fSFogaXMgbm90IHNldApDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKQ09ORklH
X0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQojIENPTkZJR19IWl8xMDAgaXMgbm90IHNl
dApDT05GSUdfSFpfMjUwPXkKIyBDT05GSUdfSFpfMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFpfMTAwMCBpcyBub3Qgc2V0CkNPTkZJR19IWj0yNTAKQ09ORklHX1BSRUVNUFRfTk9ORT15
CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJFRU1Q
VCBpcyBub3Qgc2V0CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9NSVNDPXkK
Q09ORklHX01BVEhfRU1VTEFUSU9OPXkKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9IT1RQ
TFVHPXkKQ09ORklHX0FSQ0hfRkxBVE1FTV9FTkFCTEU9eQpDT05GSUdfQVJDSF9QT1BVTEFU
RVNfTk9ERV9NQVA9eQpDT05GSUdfU0VMRUNUX01FTU9SWV9NT0RFTD15CkNPTkZJR19GTEFU
TUVNX01BTlVBTD15CiMgQ09ORklHX0RJU0NPTlRJR01FTV9NQU5VQUwgaXMgbm90IHNldAoj
IENPTkZJR19TUEFSU0VNRU1fTUFOVUFMIGlzIG5vdCBzZXQKQ09ORklHX0ZMQVRNRU09eQpD
T05GSUdfRkxBVF9OT0RFX01FTV9NQVA9eQojIENPTkZJR19TUEFSU0VNRU1fU1RBVElDIGlz
IG5vdCBzZXQKIyBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVBfRU5BQkxFIGlzIG5vdCBzZXQK
Q09ORklHX1NQTElUX1BUTE9DS19DUFVTPTQKIyBDT05GSUdfUkVTT1VSQ0VTXzY0QklUIGlz
IG5vdCBzZXQKQ09ORklHX1pPTkVfRE1BX0ZMQUc9MQpDT05GSUdfQk9VTkNFPXkKQ09ORklH
X1ZJUlRfVE9fQlVTPXkKQ09ORklHX1BST0NfREVWSUNFVFJFRT15CiMgQ09ORklHX0NNRExJ
TkVfQk9PTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BNIGlzIG5vdCBzZXQKQ09ORklHX1NVU1BF
TkRfVVBfUE9TU0lCTEU9eQpDT05GSUdfSElCRVJOQVRJT05fVVBfUE9TU0lCTEU9eQojIENP
TkZJR19TRUNDT01QIGlzIG5vdCBzZXQKQ09ORklHX1dBTlRfREVWSUNFX1RSRUU9eQpDT05G
SUdfREVWSUNFX1RSRUU9Im1wYzg1NDBfZm94XzEuZHRzIgpDT05GSUdfSVNBX0RNQV9BUEk9
eQoKIwojIEJ1cyBvcHRpb25zCiMKQ09ORklHX1pPTkVfRE1BPXkKQ09ORklHX1BQQ19JTkRJ
UkVDVF9QQ0k9eQpDT05GSUdfRlNMX1NPQz15CkNPTkZJR19GU0xfUENJPXkKQ09ORklHX1BD
ST15CkNPTkZJR19QQ0lfRE9NQUlOUz15CkNPTkZJR19QQ0lfU1lTQ0FMTD15CiMgQ09ORklH
X1BDSUVQT1JUQlVTIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfU1VQUE9SVFNfTVNJPXkKIyBD
T05GSUdfUENJX01TSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9MRUdBQ1kgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19QQ0NBUkQgaXMgbm90
IHNldAojIENPTkZJR19IT1RQTFVHX1BDSSBpcyBub3Qgc2V0CgojCiMgQWR2YW5jZWQgc2V0
dXAKIwojIENPTkZJR19BRFZBTkNFRF9PUFRJT05TIGlzIG5vdCBzZXQKCiMKIyBEZWZhdWx0
IHNldHRpbmdzIGZvciBhZHZhbmNlZCBjb25maWd1cmF0aW9uIG9wdGlvbnMgYXJlIHVzZWQK
IwpDT05GSUdfSElHSE1FTV9TVEFSVD0weGZlMDAwMDAwCkNPTkZJR19MT1dNRU1fU0laRT0w
eDMwMDAwMDAwCkNPTkZJR19LRVJORUxfU1RBUlQ9MHhjMDAwMDAwMApDT05GSUdfVEFTS19T
SVpFPTB4YzAwMDAwMDAKQ09ORklHX0JPT1RfTE9BRD0weDAwODAwMDAwCgojCiMgTmV0d29y
a2luZwojCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19Q
QUNLRVQ9eQojIENPTkZJR19QQUNLRVRfTU1BUCBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkK
Q09ORklHX1hGUk09eQpDT05GSUdfWEZSTV9VU0VSPXkKIyBDT05GSUdfWEZSTV9TVUJfUE9M
SUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9NSUdSQVRFIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0tFWSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FT
VD15CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBub3Qgc2V0CkNPTkZJR19JUF9G
SUJfSEFTSD15CkNPTkZJR19JUF9QTlA9eQpDT05GSUdfSVBfUE5QX0RIQ1A9eQpDT05GSUdf
SVBfUE5QX0JPT1RQPXkKIyBDT05GSUdfSVBfUE5QX1JBUlAgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lQX01ST1VURSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSUEQgaXMgbm90IHNldApD
T05GSUdfU1lOX0NPT0tJRVM9eQojIENPTkZJR19JTkVUX0FIIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5FVF9FU1AgaXMgbm90IHNldAojIENPTkZJR19JTkVUX0lQQ09NUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfWEZSTV9UVU5ORUwgaXMgbm90IHNldApDT05GSUdfSU5FVF9UVU5O
RUw9eQpDT05GSUdfSU5FVF9YRlJNX01PREVfVFJBTlNQT1JUPXkKQ09ORklHX0lORVRfWEZS
TV9NT0RFX1RVTk5FTD15CkNPTkZJR19JTkVUX1hGUk1fTU9ERV9CRUVUPXkKIyBDT05GSUdf
SU5FVF9MUk8gaXMgbm90IHNldApDT05GSUdfSU5FVF9ESUFHPXkKQ09ORklHX0lORVRfVENQ
X0RJQUc9eQojIENPTkZJR19UQ1BfQ09OR19BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19U
Q1BfQ09OR19DVUJJQz15CkNPTkZJR19ERUZBVUxUX1RDUF9DT05HPSJjdWJpYyIKIyBDT05G
SUdfVENQX01ENVNJRyBpcyBub3Qgc2V0CkNPTkZJR19JUFY2PXkKIyBDT05GSUdfSVBWNl9Q
UklWQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9ST1VURVJfUFJFRiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQVjZfT1BUSU1JU1RJQ19EQUQgaXMgbm90IHNldAojIENPTkZJR19JTkVU
Nl9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X0VTUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lORVQ2X0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfTUlQNiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVQ2X1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZf
VFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ2X1hGUk1fTU9ERV9UUkFOU1BPUlQ9eQpD
T05GSUdfSU5FVDZfWEZSTV9NT0RFX1RVTk5FTD15CkNPTkZJR19JTkVUNl9YRlJNX01PREVf
QkVFVD15CiMgQ09ORklHX0lORVQ2X1hGUk1fTU9ERV9ST1VURU9QVElNSVpBVElPTiBpcyBu
b3Qgc2V0CkNPTkZJR19JUFY2X1NJVD15CiMgQ09ORklHX0lQVjZfVFVOTkVMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBWNl9NVUxUSVBMRV9UQUJMRVMgaXMgbm90IHNldAojIENPTkZJR19O
RVRXT1JLX1NFQ01BUksgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVIgaXMgbm90IHNl
dAojIENPTkZJR19JUF9EQ0NQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfU0NUUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RJUEMgaXMgbm90IHNldAojIENPTkZJR19BVE0gaXMgbm90IHNldAoj
IENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0CiMgQ09ORklH
X0VDT05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTl9ST1VURVIgaXMgbm90IHNldAojIENP
TkZJR19ORVRfU0NIRUQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwojCiMgQ09O
RklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lSREEgaXMgbm90IHNldAojIENPTkZJR19CVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0FGX1JYUlBDIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcwojCiMgQ09ORklHX0NGRzgw
MjExIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lSRUxFU1NfRVhUIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUFDODAyMTEgaXMgbm90IHNldAojIENPTkZJR19JRUVFODAyMTEgaXMgbm90IHNldAoj
IENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVAgaXMgbm90IHNldAoK
IwojIERldmljZSBEcml2ZXJzCiMKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09O
RklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iL3NiaW4vaG90cGx1ZyIKQ09ORklHX1NUQU5EQUxP
TkU9eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CiMgQ09ORklHX0ZXX0xPQURF
UiBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19EUklWRVI9eQojIENPTkZJR19ERUJVR19ERVZS
RVMgaXMgbm90IHNldAojIENPTkZJR19TWVNfSFlQRVJWSVNPUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX01URCBpcyBub3Qgc2V0CkNPTkZJ
R19PRl9ERVZJQ0U9eQojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0JMS19E
RVY9eQojIENPTkZJR19CTEtfREVWX0ZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9E
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfREFDOTYwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VTUVNIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKQ09ORklH
X0JMS19ERVZfTE9PUD15CiMgQ09ORklHX0JMS19ERVZfQ1JZUFRPTE9PUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TWDgg
aXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1VCIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9SQU0gaXMgbm90IHNldAojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19ERVZJQ0VT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSURFIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIGRldmljZSBz
dXBwb3J0CiMKIyBDT05GSUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJPXkK
Q09ORklHX1NDU0lfRE1BPXkKIyBDT05GSUdfU0NTSV9UR1QgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX05FVExJTksgaXMgbm90IHNldApDT05GSUdfU0NTSV9QUk9DX0ZTPXkKCiMKIyBT
Q1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19CTEtfREVW
X1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9ERVZf
T1NTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU1IgaXMgbm90IHNldAojIENPTkZJ
R19DSFJfREVWX1NHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNl
dAoKIwojIFNvbWUgU0NTSSBkZXZpY2VzIChlLmcuIENEIGp1a2Vib3gpIHN1cHBvcnQgbXVs
dGlwbGUgTFVOcwojCiMgQ09ORklHX1NDU0lfTVVMVElfTFVOIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9DT05TVEFOVFMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1NDQU5fQVNZTkMgaXMgbm90IHNldApDT05GSUdfU0NT
SV9XQUlUX1NDQU49bQoKIwojIFNDU0kgVHJhbnNwb3J0cwojCiMgQ09ORklHX1NDU0lfU1BJ
X0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19M
SUJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfTE9XTEVWRUwgaXMgbm90IHNldApDT05GSUdfQVRBPXkKIyBDT05GSUdf
QVRBX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9BSENJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0FUQV9TVlcgaXMgbm90IHNldAojIENPTkZJR19BVEFfUElJWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NBVEFfTVYgaXMgbm90IHNldAojIENPTkZJR19TQVRBX05WIGlz
IG5vdCBzZXQKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1FT
VE9SIGlzIG5vdCBzZXQKQ09ORklHX1NBVEFfUFJPTUlTRT15CiMgQ09ORklHX1NBVEFfU1g0
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSUwgaXMgbm90IHNldAojIENPTkZJR19TQVRB
X1NJTDI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90IHNldAojIENPTkZJ
R19TQVRBX1VMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVklBIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FUQV9WSVRFU1NFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9JTklDMTYyWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQUxJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9B
TUQgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0FSVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9BVElJWFAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NNRDY0MF9QQ0kgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX0NNRDY0WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ1M1
NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DUzU1MzAgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX0NZUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0VGQVIgaXMgbm90IHNl
dAojIENPTkZJR19BVEFfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzY2
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzN1ggaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX0hQVDNYMk4gaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDNYMyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfSVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9JVDgyMTMg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX0pNSUNST04gaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX1RSSUZMRVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX01BUlZFTEwgaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX01QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlY
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9ORVRDRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9OUzg3NDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3NDE1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9PUFRJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PUFRJRE1B
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QRENfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9SQURJU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SWjEwMDAgaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX1NDMTIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfU0VSVkVS
V09SS1MgaXMgbm90IHNldApDT05GSUdfUEFUQV9QREMyMDI3WD15CiMgQ09ORklHX1BBVEFf
U0lMNjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TSVMgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfV0lOQk9ORCBpcyBub3Qgc2V0
CiMgQ09ORklHX01EIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMK
IyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKIyBDT05GSUdfRklSRVdJUkUgaXMg
bm90IHNldAojIENPTkZJR19JRUVFMTM5NCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTIGlzIG5vdCBzZXQKQ09ORklHX05F
VERFVklDRVM9eQpDT05GSUdfTkVUREVWSUNFU19NVUxUSVFVRVVFPXkKQ09ORklHX0RVTU1Z
PXkKIyBDT05GSUdfQk9ORElORyBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1ZMQU4gaXMgbm90
IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldAojIENPTkZJR19UVU4gaXMgbm90
IHNldAojIENPTkZJR19WRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfSVAxMDAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKQ09ORklHX1BIWUxJQj15CgojCiMgTUlJ
IFBIWSBkZXZpY2UgZHJpdmVycwojCkNPTkZJR19NQVJWRUxMX1BIWT15CiMgQ09ORklHX0RB
VklDT01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUVNFTUlfUEhZIGlzIG5vdCBzZXQKQ09O
RklHX0xYVF9QSFk9eQojIENPTkZJR19DSUNBREFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdf
VklURVNTRV9QSFkgaXMgbm90IHNldAojIENPTkZJR19TTVNDX1BIWSBpcyBub3Qgc2V0CiMg
Q09ORklHX0JST0FEQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lDUExVU19QSFkgaXMg
bm90IHNldAojIENPTkZJR19GSVhFRF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NRElPX0JJ
VEJBTkcgaXMgbm90IHNldApDT05GSUdfTkVUX0VUSEVSTkVUPXkKQ09ORklHX01JST15CiMg
Q09ORklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NBU1NJTkkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SXzNDT00g
aXMgbm90IHNldAojIENPTkZJR19ORVRfVFVMSVAgaXMgbm90IHNldAojIENPTkZJR19IUDEw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19aTUlJIGlzIG5vdCBzZXQKIyBD
T05GSUdfSUJNX05FV19FTUFDX1JHTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX05FV19F
TUFDX1RBSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19FTUFDNCBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9QQ0kgaXMgbm90IHNldAojIENPTkZJR19CNDQgaXMgbm90IHNl
dApDT05GSUdfTkVUREVWXzEwMDA9eQojIENPTkZJR19BQ0VOSUMgaXMgbm90IHNldAojIENP
TkZJR19ETDJLIGlzIG5vdCBzZXQKIyBDT05GSUdfRTEwMDAgaXMgbm90IHNldAojIENPTkZJ
R19FMTAwMEUgaXMgbm90IHNldAojIENPTkZJR19OUzgzODIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfSEFNQUNISSBpcyBub3Qgc2V0CiMgQ09ORklHX1lFTExPV0ZJTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1I4MTY5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0lTMTkwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0tHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NLWTIgaXMgbm90IHNldAojIENPTkZJ
R19TSzk4TElOIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1ZFTE9DSVRZIGlzIG5vdCBzZXQK
IyBDT05GSUdfVElHT04zIGlzIG5vdCBzZXQKIyBDT05GSUdfQk5YMiBpcyBub3Qgc2V0CkNP
TkZJR19HSUFORkFSPXkKQ09ORklHX0dGQVJfTkFQST15CiMgQ09ORklHX1FMQTNYWFggaXMg
bm90IHNldAojIENPTkZJR19BVEwxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUREVWXzEwMDAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfVFIgaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIExBTgoj
CiMgQ09ORklHX1dMQU5fUFJFODAyMTEgaXMgbm90IHNldAojIENPTkZJR19XTEFOXzgwMjEx
IGlzIG5vdCBzZXQKCiMKIyBVU0IgTmV0d29yayBBZGFwdGVycwojCiMgQ09ORklHX1VTQl9D
QVRDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9QRUdBU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xJUCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NIQVBFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVENPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19ORVRQT0xMIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1BPTExfQ09OVFJPTExFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lTRE4g
aXMgbm90IHNldAojIENPTkZJR19QSE9ORSBpcyBub3Qgc2V0CgojCiMgSW5wdXQgZGV2aWNl
IHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQojIENPTkZJR19JTlBVVF9GRl9NRU1MRVNTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUE9MTERFViBpcyBub3Qgc2V0CgojCiMgVXNlcmxh
bmQgaW50ZXJmYWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBVVF9N
T1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWD02NDAKQ09O
RklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9ZPTQ4MAojIENPTkZJR19JTlBVVF9KT1lERVYg
aXMgbm90IHNldApDT05GSUdfSU5QVVRfRVZERVY9eQojIENPTkZJR19JTlBVVF9FVkJVRyBp
cyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwojIENPTkZJR19JTlBVVF9L
RVlCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01PVVNFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfSk9ZU1RJQ0sgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9UQUJMRVQg
aXMgbm90IHNldApDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU49eQojIENPTkZJR19UT1VDSFND
UkVFTl9GVUpJVFNVIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fR1VOWkUgaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FTE8gaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9NVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9NSzcx
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1BFTk1PVU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfVE9VQ0hTQ1JFRU5fVE9VQ0hSSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX1RPVUNIV0lOIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVUNC
MTQwMCBpcyBub3Qgc2V0CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfQ09NUE9TSVRFPXkKQ09O
RklHX1RPVUNIU0NSRUVOX1VTQl9FR0FMQVg9eQpDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX1BB
TkpJVD15CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfM009eQpDT05GSUdfVE9VQ0hTQ1JFRU5f
VVNCX0lUTT15CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfRVRVUkJPPXkKQ09ORklHX1RPVUNI
U0NSRUVOX1VTQl9HVU5aRT15CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfRE1DX1RTQzEwPXkK
Q09ORklHX1RPVUNIU0NSRUVOX1VTQl9JUlRPVUNIPXkKQ09ORklHX1RPVUNIU0NSRUVOX1VT
Ql9JREVBTFRFSz15CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfR0VORVJBTF9UT1VDSD15CkNP
TkZJR19UT1VDSFNDUkVFTl9VU0JfR09UT1A9eQojIENPTkZJR19JTlBVVF9NSVNDIGlzIG5v
dCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwpDT05GSUdfU0VSSU89eQojIENPTkZJ
R19TRVJJT19JODA0MiBpcyBub3Qgc2V0CkNPTkZJR19TRVJJT19TRVJQT1JUPXkKIyBDT05G
SUdfU0VSSU9fUENJUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBz
ZXQKIyBDT05GSUdfR0FNRVBPUlQgaXMgbm90IHNldAoKIwojIENoYXJhY3RlciBkZXZpY2Vz
CiMKQ09ORklHX1ZUPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfSFdfQ09OU09MRT15
CiMgQ09ORklHX1ZUX0hXX0NPTlNPTEVfQklORElORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
UklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05G
SUdfU0VSSUFMXzgyNTA9eQpDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15CkNPTkZJR19T
RVJJQUxfODI1MF9QQ0k9eQpDT05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9NApDT05GSUdf
U0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz00CiMgQ09ORklHX1NFUklBTF84MjUwX0VYVEVO
REVEIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX1NIQVJFX0lSUT15CgojCiMgTm9u
LTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklHX1NFUklBTF9VQVJUTElURSBp
cyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09SRV9DT05T
T0xFPXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9P
Rl9QTEFURk9STSBpcyBub3Qgc2V0CkNPTkZJR19VTklYOThfUFRZUz15CiMgQ09ORklHX0xF
R0FDWV9QVFlTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQK
Q09ORklHX0hXX1JBTkRPTT15CiMgQ09ORklHX05WUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdf
R0VOX1JUQyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdf
QVBQTElDT00gaXMgbm90IHNldAojIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfVENHX1RQTSBpcyBub3Qgc2V0CkNPTkZJR19ERVZQT1JUPXkKQ09ORklHX0kyQz15
CkNPTkZJR19JMkNfQk9BUkRJTkZPPXkKQ09ORklHX0kyQ19DSEFSREVWPXkKCiMKIyBJMkMg
QWxnb3JpdGhtcwojCkNPTkZJR19JMkNfQUxHT0JJVD15CiMgQ09ORklHX0kyQ19BTEdPUENG
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMR09QQ0EgaXMgbm90IHNldAoKIwojIEkyQyBI
YXJkd2FyZSBCdXMgc3VwcG9ydAojCiMgQ09ORklHX0kyQ19BTEkxNTM1IGlzIG5vdCBzZXQK
IyBDT05GSUdfSTJDX0FMSTE1NjMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxJMTVYMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAojIENPTkZJR19JMkNf
QU1EODExMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JODAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0k4MTAgaXMgbm90IHNldAojIENPTkZJR19JMkNfUElJWDQgaXMgbm90IHNldApD
T05GSUdfSTJDX01QQz15CiMgQ09ORklHX0kyQ19ORk9SQ0UyIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX09DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQVJQT1JUX0xJR0hUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1BST1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19TQVZBR0U0IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJTVRFQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0kyQ19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzYzMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM5NlggaXMgbm90IHNldAojIENPTkZJR19JMkNfVEFP
U19FVk0gaXMgbm90IHNldAojIENPTkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0CiMgQ09ORklH
X0kyQ19USU5ZX1VTQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUEgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZPT0RPTzMgaXMg
bm90IHNldAoKIwojIE1pc2NlbGxhbmVvdXMgSTJDIENoaXAgc3VwcG9ydAojCiMgQ09ORklH
X1NFTlNPUlNfRFMxMzM3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19EUzEzNzQgaXMg
bm90IHNldAojIENPTkZJR19EUzE2ODIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0VF
UFJPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENGODU3NCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfUENBOTUzOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENG
ODU5MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTTQxVDAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19NQVg2ODc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UU0wy
NTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAojIENP
TkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19CVVMg
aXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQ0hJUCBpcyBub3Qgc2V0CgojCiMgU1BJ
IHN1cHBvcnQKIwojIENPTkZJR19TUEkgaXMgbm90IHNldAojIENPTkZJR19TUElfTUFTVEVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfVzEgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9TVVBQ
TFkgaXMgbm90IHNldAojIENPTkZJR19IV01PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1dBVENI
RE9HIGlzIG5vdCBzZXQKCiMKIyBTb25pY3MgU2lsaWNvbiBCYWNrcGxhbmUKIwpDT05GSUdf
U1NCX1BPU1NJQkxFPXkKIyBDT05GSUdfU1NCIGlzIG5vdCBzZXQKCiMKIyBNdWx0aWZ1bmN0
aW9uIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKCiMK
IyBNdWx0aW1lZGlhIGRldmljZXMKIwojIENPTkZJR19WSURFT19ERVYgaXMgbm90IHNldAoj
IENPTkZJR19EVkJfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RBQiBpcyBub3Qgc2V0Cgoj
CiMgR3JhcGhpY3Mgc3VwcG9ydAojCiMgQ09ORklHX0FHUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZHQVNUQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VklERU9fT1VUUFVUX0NPTlRST0wgaXMgbm90IHNldAojIENPTkZJR19GQiBpcyBub3Qgc2V0
CiMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgRGlzcGxh
eSBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0RJU1BMQVlfU1VQUE9SVCBpcyBub3Qgc2V0
CgojCiMgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CiMKIyBDT05GSUdfVkdBX0NP
TlNPTEUgaXMgbm90IHNldApDT05GSUdfRFVNTVlfQ09OU09MRT15CgojCiMgU291bmQKIwoj
IENPTkZJR19TT1VORCBpcyBub3Qgc2V0CkNPTkZJR19ISURfU1VQUE9SVD15CkNPTkZJR19I
SUQ9eQojIENPTkZJR19ISURfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ISURSQVcgaXMg
bm90IHNldAoKIwojIFVTQiBJbnB1dCBEZXZpY2VzCiMKQ09ORklHX1VTQl9ISUQ9eQojIENP
TkZJR19VU0JfSElESU5QVVRfUE9XRVJCT09LIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0ZG
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hJRERFViBpcyBub3Qgc2V0CkNPTkZJR19VU0Jf
U1VQUE9SVD15CkNPTkZJR19VU0JfQVJDSF9IQVNfSENEPXkKQ09ORklHX1VTQl9BUkNIX0hB
U19PSENJPXkKQ09ORklHX1VTQl9BUkNIX0hBU19FSENJPXkKQ09ORklHX1VTQj15CiMgQ09O
RklHX1VTQl9ERUJVRyBpcyBub3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9u
cwojCkNPTkZJR19VU0JfREVWSUNFRlM9eQpDT05GSUdfVVNCX0RFVklDRV9DTEFTUz15CiMg
Q09ORklHX1VTQl9EWU5BTUlDX01JTk9SUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEcg
aXMgbm90IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCkNPTkZJR19V
U0JfRUhDSV9IQ0Q9eQpDT05GSUdfVVNCX0VIQ0lfU1BMSVRfSVNPPXkKQ09ORklHX1VTQl9F
SENJX1JPT1RfSFVCX1RUPXkKIyBDT05GSUdfVVNCX0VIQ0lfVFRfTkVXU0NIRUQgaXMgbm90
IHNldAojIENPTkZJR19VU0JfSVNQMTE2WF9IQ0QgaXMgbm90IHNldApDT05GSUdfVVNCX09I
Q0lfSENEPXkKQ09ORklHX1VTQl9PSENJX0hDRF9QUENfT0Y9eQpDT05GSUdfVVNCX09IQ0lf
SENEX1BQQ19PRl9CRT15CiMgQ09ORklHX1VTQl9PSENJX0hDRF9QUENfT0ZfTEUgaXMgbm90
IHNldApDT05GSUdfVVNCX09IQ0lfSENEX1BDST15CkNPTkZJR19VU0JfT0hDSV9CSUdfRU5E
SUFOX0RFU0M9eQpDT05GSUdfVVNCX09IQ0lfQklHX0VORElBTl9NTUlPPXkKQ09ORklHX1VT
Ql9PSENJX0xJVFRMRV9FTkRJQU49eQojIENPTkZJR19VU0JfVUhDSV9IQ0QgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0w4MTFfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1I4QTY2
NTk3X0hDRCBpcyBub3Qgc2V0CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMKIyBD
T05GSUdfVVNCX0FDTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QUklOVEVSIGlzIG5vdCBz
ZXQKCiMKIyBOT1RFOiBVU0JfU1RPUkFHRSBlbmFibGVzIFNDU0ksIGFuZCAnU0NTSSBkaXNr
IHN1cHBvcnQnCiMKCiMKIyBtYXkgYWxzbyBiZSBuZWVkZWQ7IHNlZSBVU0JfU1RPUkFHRSBI
ZWxwIGZvciBtb3JlIGluZm9ybWF0aW9uCiMKQ09ORklHX1VTQl9TVE9SQUdFPXkKIyBDT05G
SUdfVVNCX1NUT1JBR0VfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9E
QVRBRkFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfRlJFRUNPTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX0RQQ00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9VU0JBVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFIwOSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TVE9SQUdFX1NERFI1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdF
X0pVTVBTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfQUxBVURBIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfT05FVE9VQ0ggaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU1RPUkFHRV9LQVJNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MSUJVU1VBTCBp
cyBub3Qgc2V0CgojCiMgVVNCIEltYWdpbmcgZGV2aWNlcwojCiMgQ09ORklHX1VTQl9NREM4
MDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfTUlDUk9URUsgaXMgbm90IHNldApDT05GSUdf
VVNCX01PTj15CgojCiMgVVNCIHBvcnQgZHJpdmVycwojCgojCiMgVVNCIFNlcmlhbCBDb252
ZXJ0ZXIgc3VwcG9ydAojCkNPTkZJR19VU0JfU0VSSUFMPXkKIyBDT05GSUdfVVNCX1NFUklB
TF9DT05TT0xFIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfR0VORVJJQz15CiMgQ09O
RklHX1VTQl9TRVJJQUxfQUlSQ0FCTEUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X0FJUlBSSU1FIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9BUkszMTE2IGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9CRUxLSU4gaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX0NIMzQxIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9XSElURUhF
QVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0RJR0lfQUNDRUxFUE9SVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1AyMTAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9DWVBSRVNTX004IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9F
TVBFRyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFMX0ZURElfU0lPPXkKIyBDT05GSUdf
VVNCX1NFUklBTF9GVU5TT0ZUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9WSVNP
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBBUSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfSVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQ
T1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9FREdFUE9SVF9USSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfR0FSTUlOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9JUFcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fUERB
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NFUklBTF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9L
T0JJTF9TQ1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NT1M3NzIwIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9NT1M3ODQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9OQVZN
QU4gaXMgbm90IHNldApDT05GSUdfVVNCX1NFUklBTF9QTDIzMDM9eQojIENPTkZJR19VU0Jf
U0VSSUFMX09USTY4NTggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0hQNFggaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1NBRkUgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX1NJRVJSQVdJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9USSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1lCRVJKQUNLIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YSVJDT00gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX09QVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT01OSU5FVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfREVCVUcgaXMgbm90IHNldAoKIwojIFVT
QiBNaXNjZWxsYW5lb3VzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfRU1JNjIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfRU1JMjYgaXMgbm90IHNldAojIENPTkZJR19VU0JfQURVVFVYIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0FVRVJTV0FMRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9SSU81MDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVHT1RPV0VSIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0xDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9CRVJSWV9DSEFSR0Ug
aXMgbm90IHNldAojIENPTkZJR19VU0JfTEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZ
UFJFU1NfQ1k3QzYzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZVEhFUk0gaXMgbm90IHNl
dAojIENPTkZJR19VU0JfUEhJREdFVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JRE1PVVNF
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0ZURElfRUxBTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9BUFBMRURJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0lTVVNCVkdBIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RSQU5D
RVZJQlJBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lPV0FSUklPUiBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9URVNUIGlzIG5vdCBzZXQKCiMKIyBVU0IgRFNMIG1vZGVtIHN1cHBv
cnQKIwoKIwojIFVTQiBHYWRnZXQgU3VwcG9ydAojCiMgQ09ORklHX1VTQl9HQURHRVQgaXMg
bm90IHNldAojIENPTkZJR19NTUMgaXMgbm90IHNldAojIENPTkZJR19ORVdfTEVEUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lORklOSUJBTkQgaXMgbm90IHNldAojIENPTkZJR19FREFDIGlz
IG5vdCBzZXQKQ09ORklHX1JUQ19MSUI9eQpDT05GSUdfUlRDX0NMQVNTPXkKQ09ORklHX1JU
Q19IQ1RPU1lTPXkKQ09ORklHX1JUQ19IQ1RPU1lTX0RFVklDRT0icnRjMCIKIyBDT05GSUdf
UlRDX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBSVEMgaW50ZXJmYWNlcwojCkNPTkZJR19SVENf
SU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklHX1JUQ19JTlRGX0RF
Vj15CkNPTkZJR19SVENfSU5URl9ERVZfVUlFX0VNVUw9eQojIENPTkZJR19SVENfRFJWX1RF
U1QgaXMgbm90IHNldAoKIwojIEkyQyBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfRFJWX0RT
MTMwNz15CiMgQ09ORklHX1JUQ19EUlZfRFMxMzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9EUzE2NzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01BWDY5MDAgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX1JTNUMzNzIgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX0lTTDEyMDggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1gxMjA1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9QQ0Y4NTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDFUODAgaXMgbm90IHNl
dAoKIwojIFNQSSBSVEMgZHJpdmVycwojCgojCiMgUGxhdGZvcm0gUlRDIGRyaXZlcnMKIwoj
IENPTkZJR19SVENfRFJWX0NNT1MgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTU1
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfU1RLMTdUQTggaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX0RTMTc0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDg2
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUNTkgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX1YzMDIwIGlzIG5vdCBzZXQKCiMKIyBvbi1DUFUgUlRDIGRyaXZlcnMKIwoK
IwojIFVzZXJzcGFjZSBJL08KIwojIENPTkZJR19VSU8gaXMgbm90IHNldAoKIwojIEZpbGUg
c3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPXkKIyBDT05GSUdfRVhUMl9GU19YQVRUUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfWElQIGlzIG5vdCBzZXQKQ09ORklHX0VYVDNfRlM9
eQpDT05GSUdfRVhUM19GU19YQVRUUj15CiMgQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNMIGlz
IG5vdCBzZXQKIyBDT05GSUdfRVhUM19GU19TRUNVUklUWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0VYVDRERVZfRlMgaXMgbm90IHNldApDT05GSUdfSkJEPXkKQ09ORklHX0ZTX01CQ0FDSEU9
eQpDT05GSUdfUkVJU0VSRlNfRlM9eQojIENPTkZJR19SRUlTRVJGU19DSEVDSyBpcyBub3Qg
c2V0CiMgQ09ORklHX1JFSVNFUkZTX1BST0NfSU5GTyBpcyBub3Qgc2V0CiMgQ09ORklHX1JF
SVNFUkZTX0ZTX1hBVFRSIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfR0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUlOSVhfRlMgaXMgbm90IHNldAojIENPTkZJR19ST01GU19G
UyBpcyBub3Qgc2V0CkNPTkZJR19JTk9USUZZPXkKQ09ORklHX0lOT1RJRllfVVNFUj15CiMg
Q09ORklHX1FVT1RBIGlzIG5vdCBzZXQKQ09ORklHX0ROT1RJRlk9eQojIENPTkZJR19BVVRP
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfRlVTRV9GUyBpcyBub3Qgc2V0CgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCiMg
Q09ORklHX0lTTzk2NjBfRlMgaXMgbm90IHNldAojIENPTkZJR19VREZfRlMgaXMgbm90IHNl
dAoKIwojIERPUy9GQVQvTlQgRmlsZXN5c3RlbXMKIwojIENPTkZJR19NU0RPU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZGQVRfRlMgaXMgbm90IHNldAojIENPTkZJR19OVEZTX0ZTIGlz
IG5vdCBzZXQKCiMKIyBQc2V1ZG8gZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNP
TkZJR19QUk9DX0tDT1JFPXkKQ09ORklHX1BST0NfU1lTQ1RMPXkKQ09ORklHX1NZU0ZTPXkK
Q09ORklHX1RNUEZTPXkKIyBDT05GSUdfVE1QRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFVHRVRMQl9QQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09ORklHRlNfRlMgaXMg
bm90IHNldAoKIwojIE1pc2NlbGxhbmVvdXMgZmlsZXN5c3RlbXMKIwojIENPTkZJR19BREZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU1BMVVNfRlMgaXMgbm90IHNldAojIENPTkZJ
R19CRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JBTUZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfVlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUV09SS19GSUxFU1lTVEVN
UyBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKIyBDT05GSUdfUEFSVElUSU9O
X0FEVkFOQ0VEIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BBUlRJVElPTj15CiMgQ09ORklH
X05MUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RMTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VDQ19T
TE9XIGlzIG5vdCBzZXQKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0JJVFJFVkVS
U0U9eQojIENPTkZJR19DUkNfQ0NJVFQgaXMgbm90IHNldAojIENPTkZJR19DUkMxNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSQ19JVFVfVCBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMj15CiMg
Q09ORklHX0NSQzcgaXMgbm90IHNldAojIENPTkZJR19MSUJDUkMzMkMgaXMgbm90IHNldApD
T05GSUdfUExJU1Q9eQpDT05GSUdfSEFTX0lPTUVNPXkKQ09ORklHX0hBU19JT1BPUlQ9eQpD
T05GSUdfSEFTX0RNQT15CiMgQ09ORklHX0lOU1RSVU1FTlRBVElPTiBpcyBub3Qgc2V0Cgoj
CiMgS2VybmVsIGhhY2tpbmcKIwojIENPTkZJR19QUklOVEtfVElNRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0VOQUJMRV9XQVJOX0RFUFJFQ0FURUQgaXMgbm90IHNldAojIENPTkZJR19FTkFC
TEVfTVVTVF9DSEVDSyBpcyBub3Qgc2V0CkNPTkZJR19NQUdJQ19TWVNSUT15CiMgQ09ORklH
X1VOVVNFRF9TWU1CT0xTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfRlMgaXMgbm90IHNl
dAojIENPTkZJR19IRUFERVJTX0NIRUNLIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0tFUk5F
TD15CiMgQ09ORklHX0RFQlVHX1NISVJRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVURUNUX1NP
RlRMT0NLVVAgaXMgbm90IHNldAojIENPTkZJR19TQ0hFRF9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDSEVEU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19USU1FUl9TVEFUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NMVUJfREVCVUdfT04gaXMgbm90IHNldAojIENPTkZJR19ERUJV
R19SVF9NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRfTVVURVhfVEVTVEVSIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfU1BJTkxPQ0sgaXMgbm90IHNldAojIENPTkZJR19ERUJV
R19NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1BJTkxPQ0tfU0xFRVAgaXMg
bm90IHNldAojIENPTkZJR19ERUJVR19MT0NLSU5HX0FQSV9TRUxGVEVTVFMgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19LT0JKRUNUIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0JVR1ZF
UkJPU0U9eQpDT05GSUdfREVCVUdfSU5GTz15CiMgQ09ORklHX0RFQlVHX1ZNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVCVUdfTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NHIGlz
IG5vdCBzZXQKIyBDT05GSUdfRk9SQ0VEX0lOTElOSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdf
Qk9PVF9QUklOVEtfREVMQVkgaXMgbm90IHNldAojIENPTkZJR19SQ1VfVE9SVFVSRV9URVNU
IGlzIG5vdCBzZXQKIyBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0FNUExFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLT1ZFUkZMT1cgaXMg
bm90IHNldAojIENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX1BBR0VBTExPQyBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR0dFUj15CiMgQ09ORklH
X1hNT04gaXMgbm90IHNldAojIENPTkZJR19CRElfU1dJVENIIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFBDX0VBUkxZX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMK
IyBDT05GSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VDVVJJVFlfRklMRV9DQVBBQklMSVRJRVMgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE8gaXMgbm90IHNldAojIENPTkZJR19QUENfQ0xPQ0sgaXMgbm90IHNldAo=
--------------050809040907010808010502--
