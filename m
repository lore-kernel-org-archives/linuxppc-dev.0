Return-Path: <gianfranco.casanova@alice.it>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C956DA.1F291F97"
Subject: R: Installation on a MPC5200 based custom board
Date: Fri, 5 Dec 2008 14:00:41 +0100
Message-ID: <47602D18F269934AB73B7E550804A1E002137985@FBCMST09V03.fbc.local>
References: <688884.68610.qm@web23105.mail.ird.yahoo.com>
	<49391C93.1070303@mlbassoc.com>
From: <gianfranco.casanova@alice.it>
To: "Gary Thomas" <gary@mlbassoc.com>,
	<s104259@yahoo.it>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C956DA.1F291F97
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Regarding Angelo's post, is related to:

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21109.html:
(USB on ARCH=3DPPC works on ARCH=3Dpowerpc does not).

and

http://www.nabble.com/USB-on-lite5200-does-not-work.-td20601948.html
(my previous post)

Some NEWS:

we are using now a more recent kernel:

Linux-2.6.26

On our HW:
port_config =3D  0x0C712E66;

difference between lite5200b.dts and that one for our HW:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
...
	memory {
		device_type =3D "memory";
		reg =3D <0x00000000 0x08000000>;	// 128MB
	};
...
//		rtc@800 {	// Real time clock
//			compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
//			device_type =3D "rtc";
//			reg =3D <0x800 0x100>;
//			interrupts =3D <1 5 0 1 6 0>;
//			interrupt-parent =3D <&mpc5200_pic>;
//		};
...
		// PSC4 in uart mode example
		serial@2600 {		// PSC4
			device_type =3D "serial";
			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
			cell-index =3D <3>;
			port-number =3D <3>;
			reg =3D <0x2600 0x100>;
			interrupts =3D <2 11 0>;
			interrupt-parent =3D <&mpc5200_pic>;
		};
...
//		ethernet@3000 {
//			device_type =3D "network";
//			compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
//			reg =3D <0x3000 0x400>;
//			local-mac-address =3D [ 00 00 00 00 00 00 ];
//			interrupts =3D <2 5 0>;
//			interrupt-parent =3D <&mpc5200_pic>;
//			phy-handle =3D <&phy0>;
//		};
...
//	chosen {
//		linux,stdout-path =3D "/soc5200@f0000000/serial@2600";
//	};
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D


We have got in any case the same problem:

some logs:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
U-Boot 1.2.0-RadioNav (Nov 27 2008 - 12:04:20)

CPU:   MPC5200 v2.2, Core v1.4 at 396 MHz
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
Board: MMSE Samoa
DRAM:  128 MB
FLASH: 16 MB
*** Warning - bad CRC, using default environment

PCI:   Bus Dev VenId DevId Class Int
        00  18  1172  0004  ff00  00
        00  1a  1057  5809  0680  00
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
Loading FPGA Device 0... OK? ... ** fpga_done_fn *******************.
attesa della configurazione
 OK
Configuration of FPGA done.
In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Hit any key to stop autoboot:  0
## Booting image at 00060000 ...
   Image Name:   Linux-2.6.26
   Created:      2008-12-05  10:06:22 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1992454 Bytes =3D  1.9 MB
   Load Address: f8000000
   Entry Point:  f8000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Case type_kernel
Case OS_linux
## Current stack ends at 0xFFF106F8 =3D> set upper limit to 0xF8800000
## Loading RAMDisk Image at 00600000 ...
   Image Name:   RamDisk Image RadioNav
   Created:      2007-12-14  16:18:56 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    924658 Bytes =3D 903 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using flat device tree at 0xfe0000
   Loading Ramdisk to ffe2e000, end fff0fbf2 ... OK
   Loading Device Tree to ffe2a000, end ffe2b511 ... [    0.000000] =
Using lite5200 machine description
[    0.000000] Linux version 2.6.26 (root@casanova-laptop) (gcc version =
4.2.2) #2 Fri Dec 5 11:06:14 CET 2008
[    0.000000] Found initrd at 0xc7e2e000:0xc7f0fbf2
[    0.000000] Entering add_active_range(0, 0, 32768) 0 entries of 256 =
used
[    0.000000] PCI host bridge /pci@f0000d00 (primary) ranges:
[    0.000000]  MEM 0x0000000080000000..0x000000009fffffff -> =
0x0000000080000000 Prefetch
[    0.000000]  MEM 0x00000000a0000000..0x00000000afffffff -> =
0x00000000a0000000
[    0.000000]   IO 0x00000000b0000000..0x00000000b0ffffff -> =
0x0000000000000000
[    0.000000] Top of RAM: 0x8000000, Total RAM: 0x8000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    32768
[    0.000000]   Normal      32768 ->    32768
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    32768
[    0.000000] On node 0 totalpages: 32768
[    0.000000]   DMA zone: 256 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 32512 pages, LIFO batch:7
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32512
[    0.000000] Kernel command line: debug console=3DttyPSC3,115200 =
root=3D/dev/ram
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000000] time_init: decrementer frequency =3D 33.000000 MHz
[    0.000000] time_init: processor frequency   =3D 396.000000 MHz
[    0.000013] clocksource: timebase mult[79364d9] shift[22] registered
[    0.000035] clockevent: decrementer mult[872] shift[16] cpu[0]
[    0.000098] /soc5200@f0000000/serial@2600 assigned to ttyPSC3
[    0.000120] mpc52xx_console_setup co=3Dc03e2624, co->index=3D3, =
options=3D115200
[    0.000137] Console on ttyPSC3 is /soc5200@f0000000/serial@2600
[    0.000249] mpc52xx-psc uart at f0002600, mapped to fcff7600, =
irq=3D8b, freq=3D33000000
[    0.000273] Setting console parameters: 115200 8n1 flow=3Dn
[    0.000298] console [ttyPSC3] enabled
[    0.200954] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.209036] Inode-cache hash table entries: 8192 (order: 3, 32768 =
bytes)
[    0.231866] Memory: 124628k/131072k available (3908k kernel code, =
6280k reserved, 120k data, 141k bss, 184k init)
[    0.242534] SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, =
MinObjects=3D0, CPUs=3D1, Nodes=3D1
[    0.250420] Calibrating delay loop... 65.79 BogoMIPS (lpj=3D131584)
[    0.345394] Mount-cache hash table entries: 512
[    0.354135] net_namespace: 192 bytes
[    0.358525] NET: Registered protocol family 16
[    0.381643] PCI: Probing PCI hardware
[    0.385961] PCI: Scanning bus 0000:00
[    0.389924] PCI: Found 0000:00:18.0 [1172/0004] 00ff00 00
[    0.395529] pci 0000:00:18.0: calling =
pcibios_fixup_resources+0x0/0xe4
[    0.402307] PCI: Found 0000:00:1a.0 [1057/5809] 000680 00
[    0.407898] pci 0000:00:1a.0: calling =
fixup_hide_host_resource_fsl+0x0/0x60
[    0.415064] pci 0000:00:1a.0: calling =
pcibios_fixup_resources+0x0/0xe4
[    0.421791] PCI: Fixups for bus 0000:00
[    0.425840] PCI: Bus scan for 0000:00 returning with max=3D00
[    0.432679]   got res [80000000:83ffffff] bus [80000000:83ffffff] =
flags 20021208 for BAR 1 of 0000:00:18.0
[    0.442609] PCI: moved device 0000:00:18.0 resource 1 (21208) to =
80000000
[    0.449639]   got res [a0000000:a003ffff] bus [a0000000:a003ffff] =
flags 20020200 for BAR 0 of 0000:00:1a.0
[    0.459543] PCI: moved device 0000:00:1a.0 resource 0 (20200) to =
a0000000
[    0.466517]   got res [a0040000:a00407ff] bus [a0040000:a00407ff] =
flags 20020200 for BAR 0 of 0000:00:18.0
[    0.476413] PCI: moved device 0000:00:18.0 resource 0 (20200) to =
a0040000
[    0.483563] DMA: MPC52xx BestComm driver
[    0.487913] DMA: MPC52xx BestComm engine @f0001200 ok !
[    0.512213] SCSI subsystem initialized
[    0.516419] libata version 3.00 loaded.
[    0.523098] usbcore: registered new interface driver usbfs
[    0.529672] usbcore: registered new interface driver hub
[    0.535840] usbcore: registered new device driver usb
[    0.553226] Bluetooth: Core ver 2.11
[    0.558578] NET: Registered protocol family 31
[    0.563176] Bluetooth: HCI device and connection manager initialized
[    0.569698] Bluetooth: HCI socket layer initialized
[    0.594863] Switched to high resolution mode on CPU 0
[    0.602387] NET: Registered protocol family 2
[    0.643013] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.650538] TCP established hash table entries: 4096 (order: 3, 32768 =
bytes)
[    0.658154] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.664975] TCP: Hash tables configured (established 4096 bind 4096)
[    0.671529] TCP reno registered
[    0.683128] NET: Registered protocol family 1
[    0.688348] Unpacking initramfs... done
[    0.945090] Freeing initrd memory: 902k freed
[    0.987524] NTFS driver 2.1.29 [Flags: R/W DEBUG].
[    0.994230] msgmni has been set to 245
[    0.999420] io scheduler noop registered
[    1.003521] io scheduler anticipatory registered (default)
[    1.009213] io scheduler deadline registered
[    1.013868] io scheduler cfq registered
[    1.017870] pci 0000:00:18.0: calling quirk_cardbus_legacy+0x0/0x54
[    1.024392] pci 0000:00:18.0: calling =
quirk_usb_early_handoff+0x0/0x4dc
[    1.031266] pci 0000:00:1a.0: calling quirk_cardbus_legacy+0x0/0x54
[    1.037730] pci 0000:00:1a.0: calling =
quirk_usb_early_handoff+0x0/0x4dc
[    1.044687] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.392845] Serial: MPC52xx PSC UART driver
[    1.397453] mpc52xx-psc-uart f0002600.serial: =
mpc52xx_uart_probe(op=3Dc7843800, match=3Dc03e2314)
[    1.406315] Found /soc5200@f0000000/serial@2600 assigned to ttyPSC3
[    1.412839] mpc52xx-psc-uart f0002600.serial: mpc52xx-psc uart at =
f0002600, irq=3D8b, freq=3D33000000
[    1.421987] f0002600.serial: ttyPSC3 at MMIO 0xf0002600 (irq =3D 139) =
is a MPC52xx PSC
[    1.440108] loop: module loaded
[    1.443499] PPP generic driver version 2.4.2
[    1.449263] Driver 'sd' needs updating - please use bus_type methods
[    1.547816] scsi0 : scsi_debug, version 1.81 [20070104], =
dev_size_mb=3D8, opts=3D0x0
[    1.556926] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       =
0004 PQ: 0 ANSI: 5
[    1.566982] sd 0:0:0:0: [sda] 16384 512-byte hardware sectors (8 MB)
[    1.574957] sd 0:0:0:0: [sda] Write Protect is off
[    1.579923] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[    1.590924] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, supports DPO and FUA
[    1.602938] sd 0:0:0:0: [sda] 16384 512-byte hardware sectors (8 MB)
[    1.610920] sd 0:0:0:0: [sda] Write Protect is off
[    1.615881] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[    1.626922] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, supports DPO and FUA
[    1.635698]  sda: unknown partition table
[    1.642424] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.648990] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller =
(OHCI) Driver
[    1.656713] ohci_hcd: block sizes: ed 64 td 64
[    1.662000] ppc-of-ohci f0001000.usb: initializing PPC-OF USB =
Controller
[    1.669050] ppc-of-ohci f0001000.usb: OF OHCI
[    1.674182] drivers/usb/core/inode.c: creating file 'devices'
[    1.680166] drivers/usb/core/inode.c: creating file '001'
[    1.686414] ppc-of-ohci f0001000.usb: new USB bus registered, =
assigned bus number 1
[    1.694376] ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000
[    1.700673] ppc-of-ohci f0001000.usb: created debug files
[    1.762868] ppc-of-ohci f0001000.usb: OHCI controller state
[    1.768611] ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support =
registers
[    1.775772] ppc-of-ohci f0001000.usb: control 0x083 =
HCFS=3Doperational CBSR=3D3
[    1.782929] ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0
[    1.788844] ppc-of-ohci f0001000.usb: intrstatus 0x00000004 SF
[    1.794854] ppc-of-ohci f0001000.usb: intrenable 0x8000005a MIE RHSC =
UE RD WDH
[    1.802277] ppc-of-ohci f0001000.usb: hcca frame #0000
[    1.807579] ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 =
NOCP NPS NDP=3D2(2)
[    1.815443] ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 =
DR=3D0000
[    1.822509] ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE
[    1.828873] ppc-of-ohci f0001000.usb: roothub.portstatus [0] =
0x00000100 PPS
[    1.836032] ppc-of-ohci f0001000.usb: roothub.portstatus [1] =
0x00000100 PPS
[    1.843265] usb usb1: default language 0x0409
[    1.848118] usb usb1: uevent
[    1.851577] usb usb1: usb_probe_device
[    1.855489] usb usb1: configuration #1 chosen from 1 choice
[    1.861274] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    1.867352] usb 1-0:1.0: uevent
[    1.871058] hub 1-0:1.0: usb_probe_interface
[    1.875517] hub 1-0:1.0: usb_probe_interface - got id
[    1.880728] hub 1-0:1.0: USB hub found
[    1.884680] hub 1-0:1.0: 2 ports detected
[    1.888819] hub 1-0:1.0: standalone hub
[    1.892765] hub 1-0:1.0: ganged power switching
[    1.897418] hub 1-0:1.0: global over-current protection
[    1.902780] hub 1-0:1.0: power on to power good time: 4ms
[    1.908350] hub 1-0:1.0: local power source is good
[    1.913373] hub 1-0:1.0: no over-current condition exists
[    1.918916] hub 1-0:1.0: enabling power on all ports
[    2.027349] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[    2.034176] drivers/usb/core/inode.c: creating file '001'
[    2.040541] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0001
[    2.047577] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    2.055002] usb usb1: Product: OF OHCI
[    2.058874] usb usb1: Manufacturer: Linux 2.6.26 ohci_hcd
[    2.064430] usb usb1: SerialNumber: PPC-OF USB
[    2.070505] usbcore: registered new interface driver cdc_acm
[    2.076390] cdc_acm: v0.26:USB Abstract Control Model driver for USB =
modems and ISDN adapters
[    2.085186] Initializing USB Mass Storage driver...
[    2.090715] usbcore: registered new interface driver usb-storage
[    2.096995] USB Mass Storage support registered.
[    2.102944] usbcore: registered new interface driver usbserial
[    2.109455] usbserial: USB Serial support registered for generic
[    2.116195] usbcore: registered new interface driver =
usbserial_generic
[    2.122969] usbserial: USB Serial Driver core
[    2.127935] usbserial: USB Serial support registered for pl2303
[    2.134547] usbcore: registered new interface driver pl2303
[    2.140344] pl2303: Prolific PL2303 USB to serial adaptor driver
[    2.147630] mice: PS/2 mouse device common for all mice
[    2.156991] i2c /dev entries driver
[    2.164982] usbcore: registered new interface driver usbhid
[    2.170774] usbhid: v2.6:USB HID core driver
[    2.175851] Advanced Linux Sound Architecture Driver Version 1.0.16.
[    2.184703] ALSA device list:
[    2.187808]   No soundcards found.
[    2.192578] TCP cubic registered
[    2.195967] NET: Registered protocol family 17
[    2.200655] Bluetooth: L2CAP ver 2.9
[    2.204371] Bluetooth: L2CAP socket layer initialized
[    2.209593] Bluetooth: SCO (Voice Link) ver 0.5
[    2.214269] Bluetooth: SCO socket layer initialized
[    2.219496] Bluetooth: RFCOMM socket layer initialized
[    2.224887] Bluetooth: RFCOMM TTY layer initialized
[    2.229951] Bluetooth: RFCOMM ver 1.8
[    2.233743] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
[    2.241047] Freeing unused kernel memory: 184k init
mknod: /dev/loop0: File exists
mknod: /dev/sda1: File exists
mknod: /dev/sda2: File exists
*** SLEEP
*** Try mounting REALROOT from rootfs.ext3 in /dev/sda1(vfat)
mount: mounting /dev/sda1 on /media/sda1 failed
*** Try mounting REALROOT from /dev/sda2(ext3)
mount: mounting /dev/sda2 on /media/realroot failed
*** Try mounting REALROOT /dev/mtdblock4(jffs2)
mount: mounting /dev/mtdblock4 on /media/realroot failed
*** Cannot find real rootfs - dropping to a shell
/bin/sh: can't access tty; job control turned off
root@RadioNav: ~ #
root@RadioNav: ~ #
root@RadioNav: ~ #

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Now plugging-in USB:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

root@RadioNav: ~ #[   17.228078] hub 1-0:1.0: state 7 ports 2 chg 0000 =
evt 0004
root@RadioNav: ~ #[   17.233798] ppc-of-ohci f0001000.usb: GetStatus =
roothub.portstatus [1] =3D 0x00010101 CSC PPS CCS
root@RadioNav: ~ #[   17.242776] hub 1-0:1.0: port 2, status 0101, =
change 0001, 12 Mb/s
root@RadioNav: ~ #[   17.374796] hub 1-0:1.0: debounce: port 2: total =
100ms stable 100ms status 0x101
root@RadioNav: ~ #[   17.450780] ppc-of-ohci f0001000.usb: GetStatus =
roothub.portstatus [1] =3D 0x00100103 PRSC PPS PES CCS
root@RadioNav: ~ #[   17.514787] usb 1-2: new full speed USB device =
using ppc-of-ohci and address 2
root@RadioNav: ~ #[   24.027842] usb 1-2: khubd timed out on ep0in =
len=3D0/64
root@RadioNav: ~ #[   29.199841] usb 1-2: khubd timed out on ep0in =
len=3D0/64
root@RadioNav: ~ #[   34.307841] usb 1-2: khubd timed out on ep0in =
len=3D0/64
root@RadioNav: ~ #[   34.382786] ppc-of-ohci f0001000.usb: GetStatus =
roothub.portstatus [1] =3D 0x00100103 PRSC PPS PES CCS
root@RadioNav: ~ #[   34.446789] usb 1-2: device descriptor read/64, =
error -110
root@RadioNav: ~ #
root@RadioNav: ~ #cat /proc/interrupts
           CPU0
134:       5689  MPC52xx Peripherals Edge      ohci_hcd:usb1
139:        207  MPC52xx Peripherals Edge      mpc52xx_psc_uart
143:          0  MPC52xx Peripherals Edge      i2c-mpc
144:          0  MPC52xx Peripherals Edge      i2c-mpc
BAD:          0
root@RadioNav: ~ #

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

we were thinking to some problem like:

http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.html

or

http://www.nabble.com/MPC5200-PCI-interrupt-routing-p19608472.html

We are also thinking about the fact that from .config for PPC we have:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
PCI support (PCI) [Y/n/?] (NEW) n
  Freescale MPC52xx SoC internal IDE (PATA_MPC52xx) [N/m/y/?] (NEW) n
Freescale MPC52xx family PSC serial support (SERIAL_MPC52xx) [N/m/y/?] =
(NEW) y
  Console on a Freescale MPC52xx family PSC serial port =
(SERIAL_MPC52xx_CONSOLE) [N/y/?] (NEW) y
    Freescale MPC52xx family PSC serial port baud =
(SERIAL_MPC52xx_CONSOLE_BAUD) [9600] (NEW) 9600
OHCI support for on-chip PPC USB controller (USB_OHCI_HCD_PPC_SOC) =
[Y/n/?] (NEW) y
OHCI support for PCI-bus USB controllers (USB_OHCI_HCD_PCI) [Y/n/?] =
(NEW) y
Include xmon kernel debugger (XMON) [N/y/?] (NEW) n
Support for early boot texts over serial port (SERIAL_TEXT_DEBUG) [N/y] =
(NEW) y
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

and for PowerPC we have PCI support on .config and on *.dts but with any =
PCI modification respects node on lite5200.dts (some interrupt ?)

Have you got any ideas?

Thanks a lot J

-----Messaggio originale-----
Da: linuxppc-dev-bounces+gianfranco.casanova=3Dalice.it@ozlabs.org per =
conto di Gary Thomas
Inviato: ven 05/12/2008 13.20
A: s104259@yahoo.it
Cc: Linuxppc-dev@ozlabs.org
Oggetto: Re: Installation on a MPC5200 based custom board
=20
Angelo wrote:
> Hi all.
>=20
> I saw that someones trying to work on a custom board based on mpc5200.
> I have:
> * u-boot 1.2.0
> * kernel 2.6.21
> * arch=3Dpowerpc
> * custom dts based on lite5200b.dts
> * USB port (USB2) configured on the Ethernet port
>=20
> Is it necessary to combine Ethernet and usb nodes?
> However this is the log when a usb-storage is plugged:
>=20
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
> ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00010101
> CSC PPS CCS
> hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
> hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
> ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00100103
> PRSC PPS PES CCS
> usb 1-2: new full speed USB device using ppc-of-ohci and address 2
> BUG: soft lockup detected on CPU#0!
> Call Trace:
> [C7E05A50] [C0007FD8] show_stack+0x3c/0x194 (unreliable)
> [C7E05A80] [C004A380] softlockup_tick+0xa4/0xd4
> [C7E05AA0] [C002B998] run_local_timers+0x18/0x28
> [C7E05AB0] [C002B9D8] update_process_times+0x30/0x7c
> [C7E05AC0] [C003FF3C] tick_sched_timer+0xb0/0x280
> [C7E05B20] [C003C538] hrtimer_interrupt+0x214/0x26c
> [C7E05B80] [C000E744] timer_interrupt+0x88/0x354
> [C7E05BF0] [C0011C04] ret_from_except+0x0/0x14
> --- Exception: 901 at handle_IRQ_event+0x7c/0x1e8
>     LR =3D handle_level_irq+0x90/0x13c
> [C7E05CB0] [C7F15C00] 0xc7f15c00 (unreliable)
> [C7E05CD0] [C004C2E0] handle_level_irq+0x90/0x13c
> [C7E05CE0] [C0006304] do_IRQ+0x98/0xbc
> [C7E05CF0] [C0011C04] ret_from_except+0x0/0x14
> --- Exception: 501 at schedule+0x38/0x64c
>     LR =3D schedule_timeout+0x68/0xe4
> [C7E05DB0] [C01A1650] usb_hcd_submit_urb+0x190/0x8a0 (unreliable)
> [C7E05E00] [C02389A4] schedule_timeout+0x68/0xe4
> [C7E05E40] [C0238378] wait_for_completion_timeout+0x8c/0x138
> [C7E05E80] [C01A2B60] usb_start_wait_urb+0x64/0x124
> [C7E05EB0] [C01A2E1C] usb_control_msg+0xc4/0xf0
> [C7E05EF0] [C019D0D0] hub_port_init+0x424/0x614
> [C7E05F40] [C019F42C] hub_thread+0x434/0xe64
> [C7E05FC0] [C0037E60] kthread+0xc0/0xfc
> [C7E05FF0] [C00123F8] original_kernel_thread+0x44/0x60
> ppc-of-ohci f0001000.usb: OHCI Unrecoverable Error, disabled
> ppc-of-ohci f0001000.usb: OHCI controller state
> ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers
> ppc-of-ohci f0001000.usb: control 0x093 HCFS=3Doperational CLE =
CBSR=3D3
> ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0
> ppc-of-ohci f0001000.usb: intrstatus 0x00000074 RHSC FNO UE SF
> ppc-of-ohci f0001000.usb: intrenable 0x8000001a MIE UE RD WDH
> ppc-of-ohci f0001000.usb: ed_controlhead 07fcc000
> ppc-of-ohci f0001000.usb: ed_controlcurrent fffffff0
> ppc-of-ohci f0001000.usb: hcca frame #ddb6
> ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP NPS =
NDP=3D2(2)
> ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 DR=3D0000
> ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE
> ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS
> ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00030100 PESC CSC =
PPS
> ppc-of-ohci f0001000.usb: HC died; cleaning up
> irq 134: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [C046FDF0] [C0007FD8] show_stack+0x3c/0x194 (unreliable)
> [C046FE20] [C004B358] __report_bad_irq+0x34/0xac
> [C046FE40] [C004B4AC] note_interrupt+0xdc/0x288
> [C046FE70] [C004C344] handle_level_irq+0xf4/0x13c
> [C046FE80] [C0006304] do_IRQ+0x98/0xbc
> [C046FE90] [C0011C04] ret_from_except+0x0/0x14
> --- Exception: 501 at schedule+0x304/0x64c
>     LR =3D schedule+0x2d8/0x64c
> [C046FFA0] [C004A2B4] watchdog+0x4c/0x74
> [C046FFC0] [C0037E60] kthread+0xc0/0xfc
> [C046FFF0] [C00123F8] original_kernel_thread+0x44/0x60
> handlers:
> [<c01a1008>] (usb_hcd_irq+0x0/0x9c)
> Disabling IRQ #134
> usb 1-2: khubd timed out on ep0in len=3D0/64
> hub 1-0:1.0: cannot reset port 2 (err =3D -19)
> hub 1-0:1.0: cannot disable port 2 (err =3D -19)
> ppc-of-ohci f0001000.usb: leak ed c7fcc000 (#00) state 0 (has tds)
> hub 1-0:1.0: cannot reset port 2 (err =3D -19)
> hub 1-0:1.0: cannot disable port 2 (err =3D -19)
> hub 1-0:1.0: cannot reset port 2 (err =3D -19)
> hub 1-0:1.0: cannot disable port 2 (err =3D -19)
> hub 1-0:1.0: cannot reset port 2 (err =3D -19)
> hub 1-0:1.0: cannot disable port 2 (err =3D -19)
> hub 1-0:1.0: cannot disable port 2 (err =3D -19)
> hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004
>=20
> Please mail me any idea...

Update to the latest kernel (2.6.27+) - there has been lots
of work on the MPC5200 in the past three years (that's how
old 2.6.21 is!)

--=20
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev


------_=_NextPart_001_01C956DA.1F291F97
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.27">
<TITLE>R: Installation on a MPC5200 based custom board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Regarding Angelo's post, is related to:<BR>
<BR>
http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21109.html:<BR>
(USB on ARCH=3DPPC works on ARCH=3Dpowerpc does not).<BR>
<BR>
and<BR>
<BR>
<A =
HREF=3D"http://www.nabble.com/USB-on-lite5200-does-not-work.-td20601948.h=
tml">http://www.nabble.com/USB-on-lite5200-does-not-work.-td20601948.html=
</A><BR>
(my previous post)<BR>
<BR>
Some NEWS:<BR>
<BR>
we are using now a more recent kernel:<BR>
<BR>
Linux-2.6.26<BR>
<BR>
On our HW:<BR>
port_config =3D&nbsp; 0x0C712E66;<BR>
<BR>
difference between lite5200b.dts and that one for our HW:<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
...<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;memory&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x00000000 =
0x08000000&gt;;&nbsp; // 128MB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
...<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc@800 =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Real time clock<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc5200b-rtc&quot;,&quot;fsl,mpc5200-rtc&quot;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;rtc&quot;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x800 =
0x100&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;1 5 0 1 6 =
0&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;mpc5200_pic&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
...<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PSC4 in uart mode =
example<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial@2600 {&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PSC4<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;serial&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc5200b-psc-uart&quot;,&quot;fsl,mpc5200-psc-uart&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index =3D &lt;3&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port-number =3D =
&lt;3&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x2600 =
0x100&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;2 11 =
0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;mpc5200_pic&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
...<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethernet@3000 {<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;network&quot;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc5200b-fec&quot;,&quot;fsl,mpc5200-fec&quot;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x3000 =
0x400&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local-mac-address =3D [ 00 00 =
00 00 00 00 ];<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;2 5 =
0&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;mpc5200_pic&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-handle =3D =
&lt;&amp;phy0&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
...<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chosen {<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,stdout-path =3D =
&quot;/soc5200@f0000000/serial@2600&quot;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
<BR>
<BR>
We have got in any case the same problem:<BR>
<BR>
some logs:<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
U-Boot 1.2.0-RadioNav (Nov 27 2008 - 12:04:20)<BR>
<BR>
CPU:&nbsp;&nbsp; MPC5200 v2.2, Core v1.4 at 396 MHz<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB 66 MHz, PCI 33 =
MHz<BR>
Board: MMSE Samoa<BR>
DRAM:&nbsp; 128 MB<BR>
FLASH: 16 MB<BR>
*** Warning - bad CRC, using default environment<BR>
<BR>
PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 18&nbsp; 1172&nbsp; =
0004&nbsp; ff00&nbsp; 00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 1a&nbsp; 1057&nbsp; =
5809&nbsp; 0680&nbsp; 00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB 66 MHz, PCI 33 =
MHz<BR>
Loading FPGA Device 0... OK? ... ** fpga_done_fn =
*******************.<BR>
attesa della configurazione<BR>
&nbsp;OK<BR>
Configuration of FPGA done.<BR>
In:&nbsp;&nbsp;&nbsp; serial<BR>
Out:&nbsp;&nbsp; serial<BR>
Err:&nbsp;&nbsp; serial<BR>
Net:&nbsp;&nbsp; No ethernet found.<BR>
Hit any key to stop autoboot:&nbsp; 0<BR>
## Booting image at 00060000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.26<BR>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-12-05&nbsp; =
10:06:22 UTC<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1992454 Bytes =3D&nbsp; 1.9 =
MB<BR>
&nbsp;&nbsp; Load Address: f8000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; f8000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
Case type_kernel<BR>
Case OS_linux<BR>
## Current stack ends at 0xFFF106F8 =3D&gt; set upper limit to =
0xF8800000<BR>
## Loading RAMDisk Image at 00600000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; RamDisk Image RadioNav<BR>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-12-14&nbsp; =
16:18:56 UTC<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 924658 Bytes =3D 903 kB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Booting using flat device tree at 0xfe0000<BR>
&nbsp;&nbsp; Loading Ramdisk to ffe2e000, end fff0fbf2 ... OK<BR>
&nbsp;&nbsp; Loading Device Tree to ffe2a000, end ffe2b511 ... =
[&nbsp;&nbsp;&nbsp; 0.000000] Using lite5200 machine description<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.26 =
(root@casanova-laptop) (gcc version 4.2.2) #2 Fri Dec 5 11:06:14 CET =
2008<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Found initrd at 0xc7e2e000:0xc7f0fbf2<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Entering add_active_range(0, 0, 32768) 0 =
entries of 256 used<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] PCI host bridge /pci@f0000d00 (primary) =
ranges:<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; MEM =
0x0000000080000000..0x000000009fffffff -&gt; 0x0000000080000000 =
Prefetch<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; MEM =
0x00000000a0000000..0x00000000afffffff -&gt; 0x00000000a0000000<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; IO =
0x00000000b0000000..0x00000000b0ffffff -&gt; 0x0000000000000000<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Top of RAM: 0x8000000, Total RAM: =
0x8000000<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Memory hole size: 0MB<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; =
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&nbsp;&nbsp; =
32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start PFN for each node<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[1] active PFN ranges<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; =
32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] On node 0 totalpages: 32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 256 pages used for =
memmap<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 0 pages reserved<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 32512 pages, LIFO =
batch:7<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal zone: 0 pages used for =
memmap<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Movable zone: 0 pages used for =
memmap<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists in Zone order, mobility =
grouping on.&nbsp; Total pages: 32512<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: debug =
console=3DttyPSC3,115200 root=3D/dev/ram<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] MPC52xx PIC is up and running!<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 512 (order: 9, =
2048 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] time_init: decrementer frequency =3D =
33.000000 MHz<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] time_init: processor frequency&nbsp;&nbsp; =
=3D 396.000000 MHz<BR>
[&nbsp;&nbsp;&nbsp; 0.000013] clocksource: timebase mult[79364d9] =
shift[22] registered<BR>
[&nbsp;&nbsp;&nbsp; 0.000035] clockevent: decrementer mult[872] =
shift[16] cpu[0]<BR>
[&nbsp;&nbsp;&nbsp; 0.000098] /soc5200@f0000000/serial@2600 assigned to =
ttyPSC3<BR>
[&nbsp;&nbsp;&nbsp; 0.000120] mpc52xx_console_setup co=3Dc03e2624, =
co-&gt;index=3D3, options=3D115200<BR>
[&nbsp;&nbsp;&nbsp; 0.000137] Console on ttyPSC3 is =
/soc5200@f0000000/serial@2600<BR>
[&nbsp;&nbsp;&nbsp; 0.000249] mpc52xx-psc uart at f0002600, mapped to =
fcff7600, irq=3D8b, freq=3D33000000<BR>
[&nbsp;&nbsp;&nbsp; 0.000273] Setting console parameters: 115200 8n1 =
flow=3Dn<BR>
[&nbsp;&nbsp;&nbsp; 0.000298] console [ttyPSC3] enabled<BR>
[&nbsp;&nbsp;&nbsp; 0.200954] Dentry cache hash table entries: 16384 =
(order: 4, 65536 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.209036] Inode-cache hash table entries: 8192 =
(order: 3, 32768 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.231866] Memory: 124628k/131072k available (3908k =
kernel code, 6280k reserved, 120k data, 141k bss, 184k init)<BR>
[&nbsp;&nbsp;&nbsp; 0.242534] SLUB: Genslabs=3D12, HWalign=3D32, =
Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1<BR>
[&nbsp;&nbsp;&nbsp; 0.250420] Calibrating delay loop... 65.79 BogoMIPS =
(lpj=3D131584)<BR>
[&nbsp;&nbsp;&nbsp; 0.345394] Mount-cache hash table entries: 512<BR>
[&nbsp;&nbsp;&nbsp; 0.354135] net_namespace: 192 bytes<BR>
[&nbsp;&nbsp;&nbsp; 0.358525] NET: Registered protocol family 16<BR>
[&nbsp;&nbsp;&nbsp; 0.381643] PCI: Probing PCI hardware<BR>
[&nbsp;&nbsp;&nbsp; 0.385961] PCI: Scanning bus 0000:00<BR>
[&nbsp;&nbsp;&nbsp; 0.389924] PCI: Found 0000:00:18.0 [1172/0004] 00ff00 =
00<BR>
[&nbsp;&nbsp;&nbsp; 0.395529] pci 0000:00:18.0: calling =
pcibios_fixup_resources+0x0/0xe4<BR>
[&nbsp;&nbsp;&nbsp; 0.402307] PCI: Found 0000:00:1a.0 [1057/5809] 000680 =
00<BR>
[&nbsp;&nbsp;&nbsp; 0.407898] pci 0000:00:1a.0: calling =
fixup_hide_host_resource_fsl+0x0/0x60<BR>
[&nbsp;&nbsp;&nbsp; 0.415064] pci 0000:00:1a.0: calling =
pcibios_fixup_resources+0x0/0xe4<BR>
[&nbsp;&nbsp;&nbsp; 0.421791] PCI: Fixups for bus 0000:00<BR>
[&nbsp;&nbsp;&nbsp; 0.425840] PCI: Bus scan for 0000:00 returning with =
max=3D00<BR>
[&nbsp;&nbsp;&nbsp; 0.432679]&nbsp;&nbsp; got res [80000000:83ffffff] =
bus [80000000:83ffffff] flags 20021208 for BAR 1 of 0000:00:18.0<BR>
[&nbsp;&nbsp;&nbsp; 0.442609] PCI: moved device 0000:00:18.0 resource 1 =
(21208) to 80000000<BR>
[&nbsp;&nbsp;&nbsp; 0.449639]&nbsp;&nbsp; got res [a0000000:a003ffff] =
bus [a0000000:a003ffff] flags 20020200 for BAR 0 of 0000:00:1a.0<BR>
[&nbsp;&nbsp;&nbsp; 0.459543] PCI: moved device 0000:00:1a.0 resource 0 =
(20200) to a0000000<BR>
[&nbsp;&nbsp;&nbsp; 0.466517]&nbsp;&nbsp; got res [a0040000:a00407ff] =
bus [a0040000:a00407ff] flags 20020200 for BAR 0 of 0000:00:18.0<BR>
[&nbsp;&nbsp;&nbsp; 0.476413] PCI: moved device 0000:00:18.0 resource 0 =
(20200) to a0040000<BR>
[&nbsp;&nbsp;&nbsp; 0.483563] DMA: MPC52xx BestComm driver<BR>
[&nbsp;&nbsp;&nbsp; 0.487913] DMA: MPC52xx BestComm engine @f0001200 ok =
!<BR>
[&nbsp;&nbsp;&nbsp; 0.512213] SCSI subsystem initialized<BR>
[&nbsp;&nbsp;&nbsp; 0.516419] libata version 3.00 loaded.<BR>
[&nbsp;&nbsp;&nbsp; 0.523098] usbcore: registered new interface driver =
usbfs<BR>
[&nbsp;&nbsp;&nbsp; 0.529672] usbcore: registered new interface driver =
hub<BR>
[&nbsp;&nbsp;&nbsp; 0.535840] usbcore: registered new device driver =
usb<BR>
[&nbsp;&nbsp;&nbsp; 0.553226] Bluetooth: Core ver 2.11<BR>
[&nbsp;&nbsp;&nbsp; 0.558578] NET: Registered protocol family 31<BR>
[&nbsp;&nbsp;&nbsp; 0.563176] Bluetooth: HCI device and connection =
manager initialized<BR>
[&nbsp;&nbsp;&nbsp; 0.569698] Bluetooth: HCI socket layer =
initialized<BR>
[&nbsp;&nbsp;&nbsp; 0.594863] Switched to high resolution mode on CPU =
0<BR>
[&nbsp;&nbsp;&nbsp; 0.602387] NET: Registered protocol family 2<BR>
[&nbsp;&nbsp;&nbsp; 0.643013] IP route cache hash table entries: 1024 =
(order: 0, 4096 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.650538] TCP established hash table entries: 4096 =
(order: 3, 32768 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.658154] TCP bind hash table entries: 4096 (order: =
2, 16384 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.664975] TCP: Hash tables configured (established =
4096 bind 4096)<BR>
[&nbsp;&nbsp;&nbsp; 0.671529] TCP reno registered<BR>
[&nbsp;&nbsp;&nbsp; 0.683128] NET: Registered protocol family 1<BR>
[&nbsp;&nbsp;&nbsp; 0.688348] Unpacking initramfs... done<BR>
[&nbsp;&nbsp;&nbsp; 0.945090] Freeing initrd memory: 902k freed<BR>
[&nbsp;&nbsp;&nbsp; 0.987524] NTFS driver 2.1.29 [Flags: R/W DEBUG].<BR>
[&nbsp;&nbsp;&nbsp; 0.994230] msgmni has been set to 245<BR>
[&nbsp;&nbsp;&nbsp; 0.999420] io scheduler noop registered<BR>
[&nbsp;&nbsp;&nbsp; 1.003521] io scheduler anticipatory registered =
(default)<BR>
[&nbsp;&nbsp;&nbsp; 1.009213] io scheduler deadline registered<BR>
[&nbsp;&nbsp;&nbsp; 1.013868] io scheduler cfq registered<BR>
[&nbsp;&nbsp;&nbsp; 1.017870] pci 0000:00:18.0: calling =
quirk_cardbus_legacy+0x0/0x54<BR>
[&nbsp;&nbsp;&nbsp; 1.024392] pci 0000:00:18.0: calling =
quirk_usb_early_handoff+0x0/0x4dc<BR>
[&nbsp;&nbsp;&nbsp; 1.031266] pci 0000:00:1a.0: calling =
quirk_cardbus_legacy+0x0/0x54<BR>
[&nbsp;&nbsp;&nbsp; 1.037730] pci 0000:00:1a.0: calling =
quirk_usb_early_handoff+0x0/0x4dc<BR>
[&nbsp;&nbsp;&nbsp; 1.044687] pci_hotplug: PCI Hot Plug PCI Core =
version: 0.5<BR>
[&nbsp;&nbsp;&nbsp; 1.392845] Serial: MPC52xx PSC UART driver<BR>
[&nbsp;&nbsp;&nbsp; 1.397453] mpc52xx-psc-uart f0002600.serial: =
mpc52xx_uart_probe(op=3Dc7843800, match=3Dc03e2314)<BR>
[&nbsp;&nbsp;&nbsp; 1.406315] Found /soc5200@f0000000/serial@2600 =
assigned to ttyPSC3<BR>
[&nbsp;&nbsp;&nbsp; 1.412839] mpc52xx-psc-uart f0002600.serial: =
mpc52xx-psc uart at f0002600, irq=3D8b, freq=3D33000000<BR>
[&nbsp;&nbsp;&nbsp; 1.421987] f0002600.serial: ttyPSC3 at MMIO =
0xf0002600 (irq =3D 139) is a MPC52xx PSC<BR>
[&nbsp;&nbsp;&nbsp; 1.440108] loop: module loaded<BR>
[&nbsp;&nbsp;&nbsp; 1.443499] PPP generic driver version 2.4.2<BR>
[&nbsp;&nbsp;&nbsp; 1.449263] Driver 'sd' needs updating - please use =
bus_type methods<BR>
[&nbsp;&nbsp;&nbsp; 1.547816] scsi0 : scsi_debug, version 1.81 =
[20070104], dev_size_mb=3D8, opts=3D0x0<BR>
[&nbsp;&nbsp;&nbsp; 1.556926] scsi 0:0:0:0: =
Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; Linux&nbsp;&nbsp;&nbsp; =
scsi_debug&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0004 PQ: 0 ANSI: 5<BR>
[&nbsp;&nbsp;&nbsp; 1.566982] sd 0:0:0:0: [sda] 16384 512-byte hardware =
sectors (8 MB)<BR>
[&nbsp;&nbsp;&nbsp; 1.574957] sd 0:0:0:0: [sda] Write Protect is off<BR>
[&nbsp;&nbsp;&nbsp; 1.579923] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 =
08<BR>
[&nbsp;&nbsp;&nbsp; 1.590924] sd 0:0:0:0: [sda] Write cache: enabled, =
read cache: enabled, supports DPO and FUA<BR>
[&nbsp;&nbsp;&nbsp; 1.602938] sd 0:0:0:0: [sda] 16384 512-byte hardware =
sectors (8 MB)<BR>
[&nbsp;&nbsp;&nbsp; 1.610920] sd 0:0:0:0: [sda] Write Protect is off<BR>
[&nbsp;&nbsp;&nbsp; 1.615881] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 =
08<BR>
[&nbsp;&nbsp;&nbsp; 1.626922] sd 0:0:0:0: [sda] Write cache: enabled, =
read cache: enabled, supports DPO and FUA<BR>
[&nbsp;&nbsp;&nbsp; 1.635698]&nbsp; sda: unknown partition table<BR>
[&nbsp;&nbsp;&nbsp; 1.642424] sd 0:0:0:0: [sda] Attached SCSI disk<BR>
[&nbsp;&nbsp;&nbsp; 1.648990] ohci_hcd: 2006 August 04 USB 1.1 'Open' =
Host Controller (OHCI) Driver<BR>
[&nbsp;&nbsp;&nbsp; 1.656713] ohci_hcd: block sizes: ed 64 td 64<BR>
[&nbsp;&nbsp;&nbsp; 1.662000] ppc-of-ohci f0001000.usb: initializing =
PPC-OF USB Controller<BR>
[&nbsp;&nbsp;&nbsp; 1.669050] ppc-of-ohci f0001000.usb: OF OHCI<BR>
[&nbsp;&nbsp;&nbsp; 1.674182] drivers/usb/core/inode.c: creating file =
'devices'<BR>
[&nbsp;&nbsp;&nbsp; 1.680166] drivers/usb/core/inode.c: creating file =
'001'<BR>
[&nbsp;&nbsp;&nbsp; 1.686414] ppc-of-ohci f0001000.usb: new USB bus =
registered, assigned bus number 1<BR>
[&nbsp;&nbsp;&nbsp; 1.694376] ppc-of-ohci f0001000.usb: irq 134, io mem =
0xf0001000<BR>
[&nbsp;&nbsp;&nbsp; 1.700673] ppc-of-ohci f0001000.usb: created debug =
files<BR>
[&nbsp;&nbsp;&nbsp; 1.762868] ppc-of-ohci f0001000.usb: OHCI controller =
state<BR>
[&nbsp;&nbsp;&nbsp; 1.768611] ppc-of-ohci f0001000.usb: OHCI 1.0, NO =
legacy support registers<BR>
[&nbsp;&nbsp;&nbsp; 1.775772] ppc-of-ohci f0001000.usb: control 0x083 =
HCFS=3Doperational CBSR=3D3<BR>
[&nbsp;&nbsp;&nbsp; 1.782929] ppc-of-ohci f0001000.usb: cmdstatus =
0x00000 SOC=3D0<BR>
[&nbsp;&nbsp;&nbsp; 1.788844] ppc-of-ohci f0001000.usb: intrstatus =
0x00000004 SF<BR>
[&nbsp;&nbsp;&nbsp; 1.794854] ppc-of-ohci f0001000.usb: intrenable =
0x8000005a MIE RHSC UE RD WDH<BR>
[&nbsp;&nbsp;&nbsp; 1.802277] ppc-of-ohci f0001000.usb: hcca frame =
#0000<BR>
[&nbsp;&nbsp;&nbsp; 1.807579] ppc-of-ohci f0001000.usb: roothub.a =
02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2)<BR>
[&nbsp;&nbsp;&nbsp; 1.815443] ppc-of-ohci f0001000.usb: roothub.b =
00000000 PPCM=3D0000 DR=3D0000<BR>
[&nbsp;&nbsp;&nbsp; 1.822509] ppc-of-ohci f0001000.usb: roothub.status =
00008000 DRWE<BR>
[&nbsp;&nbsp;&nbsp; 1.828873] ppc-of-ohci f0001000.usb: =
roothub.portstatus [0] 0x00000100 PPS<BR>
[&nbsp;&nbsp;&nbsp; 1.836032] ppc-of-ohci f0001000.usb: =
roothub.portstatus [1] 0x00000100 PPS<BR>
[&nbsp;&nbsp;&nbsp; 1.843265] usb usb1: default language 0x0409<BR>
[&nbsp;&nbsp;&nbsp; 1.848118] usb usb1: uevent<BR>
[&nbsp;&nbsp;&nbsp; 1.851577] usb usb1: usb_probe_device<BR>
[&nbsp;&nbsp;&nbsp; 1.855489] usb usb1: configuration #1 chosen from 1 =
choice<BR>
[&nbsp;&nbsp;&nbsp; 1.861274] usb usb1: adding 1-0:1.0 (config #1, =
interface 0)<BR>
[&nbsp;&nbsp;&nbsp; 1.867352] usb 1-0:1.0: uevent<BR>
[&nbsp;&nbsp;&nbsp; 1.871058] hub 1-0:1.0: usb_probe_interface<BR>
[&nbsp;&nbsp;&nbsp; 1.875517] hub 1-0:1.0: usb_probe_interface - got =
id<BR>
[&nbsp;&nbsp;&nbsp; 1.880728] hub 1-0:1.0: USB hub found<BR>
[&nbsp;&nbsp;&nbsp; 1.884680] hub 1-0:1.0: 2 ports detected<BR>
[&nbsp;&nbsp;&nbsp; 1.888819] hub 1-0:1.0: standalone hub<BR>
[&nbsp;&nbsp;&nbsp; 1.892765] hub 1-0:1.0: ganged power switching<BR>
[&nbsp;&nbsp;&nbsp; 1.897418] hub 1-0:1.0: global over-current =
protection<BR>
[&nbsp;&nbsp;&nbsp; 1.902780] hub 1-0:1.0: power on to power good time: =
4ms<BR>
[&nbsp;&nbsp;&nbsp; 1.908350] hub 1-0:1.0: local power source is =
good<BR>
[&nbsp;&nbsp;&nbsp; 1.913373] hub 1-0:1.0: no over-current condition =
exists<BR>
[&nbsp;&nbsp;&nbsp; 1.918916] hub 1-0:1.0: enabling power on all =
ports<BR>
[&nbsp;&nbsp;&nbsp; 2.027349] hub 1-0:1.0: state 7 ports 2 chg 0000 evt =
0000<BR>
[&nbsp;&nbsp;&nbsp; 2.034176] drivers/usb/core/inode.c: creating file =
'001'<BR>
[&nbsp;&nbsp;&nbsp; 2.040541] usb usb1: New USB device found, =
idVendor=3D1d6b, idProduct=3D0001<BR>
[&nbsp;&nbsp;&nbsp; 2.047577] usb usb1: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1<BR>
[&nbsp;&nbsp;&nbsp; 2.055002] usb usb1: Product: OF OHCI<BR>
[&nbsp;&nbsp;&nbsp; 2.058874] usb usb1: Manufacturer: Linux 2.6.26 =
ohci_hcd<BR>
[&nbsp;&nbsp;&nbsp; 2.064430] usb usb1: SerialNumber: PPC-OF USB<BR>
[&nbsp;&nbsp;&nbsp; 2.070505] usbcore: registered new interface driver =
cdc_acm<BR>
[&nbsp;&nbsp;&nbsp; 2.076390] cdc_acm: v0.26:USB Abstract Control Model =
driver for USB modems and ISDN adapters<BR>
[&nbsp;&nbsp;&nbsp; 2.085186] Initializing USB Mass Storage =
driver...<BR>
[&nbsp;&nbsp;&nbsp; 2.090715] usbcore: registered new interface driver =
usb-storage<BR>
[&nbsp;&nbsp;&nbsp; 2.096995] USB Mass Storage support registered.<BR>
[&nbsp;&nbsp;&nbsp; 2.102944] usbcore: registered new interface driver =
usbserial<BR>
[&nbsp;&nbsp;&nbsp; 2.109455] usbserial: USB Serial support registered =
for generic<BR>
[&nbsp;&nbsp;&nbsp; 2.116195] usbcore: registered new interface driver =
usbserial_generic<BR>
[&nbsp;&nbsp;&nbsp; 2.122969] usbserial: USB Serial Driver core<BR>
[&nbsp;&nbsp;&nbsp; 2.127935] usbserial: USB Serial support registered =
for pl2303<BR>
[&nbsp;&nbsp;&nbsp; 2.134547] usbcore: registered new interface driver =
pl2303<BR>
[&nbsp;&nbsp;&nbsp; 2.140344] pl2303: Prolific PL2303 USB to serial =
adaptor driver<BR>
[&nbsp;&nbsp;&nbsp; 2.147630] mice: PS/2 mouse device common for all =
mice<BR>
[&nbsp;&nbsp;&nbsp; 2.156991] i2c /dev entries driver<BR>
[&nbsp;&nbsp;&nbsp; 2.164982] usbcore: registered new interface driver =
usbhid<BR>
[&nbsp;&nbsp;&nbsp; 2.170774] usbhid: v2.6:USB HID core driver<BR>
[&nbsp;&nbsp;&nbsp; 2.175851] Advanced Linux Sound Architecture Driver =
Version 1.0.16.<BR>
[&nbsp;&nbsp;&nbsp; 2.184703] ALSA device list:<BR>
[&nbsp;&nbsp;&nbsp; 2.187808]&nbsp;&nbsp; No soundcards found.<BR>
[&nbsp;&nbsp;&nbsp; 2.192578] TCP cubic registered<BR>
[&nbsp;&nbsp;&nbsp; 2.195967] NET: Registered protocol family 17<BR>
[&nbsp;&nbsp;&nbsp; 2.200655] Bluetooth: L2CAP ver 2.9<BR>
[&nbsp;&nbsp;&nbsp; 2.204371] Bluetooth: L2CAP socket layer =
initialized<BR>
[&nbsp;&nbsp;&nbsp; 2.209593] Bluetooth: SCO (Voice Link) ver 0.5<BR>
[&nbsp;&nbsp;&nbsp; 2.214269] Bluetooth: SCO socket layer =
initialized<BR>
[&nbsp;&nbsp;&nbsp; 2.219496] Bluetooth: RFCOMM socket layer =
initialized<BR>
[&nbsp;&nbsp;&nbsp; 2.224887] Bluetooth: RFCOMM TTY layer =
initialized<BR>
[&nbsp;&nbsp;&nbsp; 2.229951] Bluetooth: RFCOMM ver 1.8<BR>
[&nbsp;&nbsp;&nbsp; 2.233743] Bluetooth: BNEP (Ethernet Emulation) ver =
1.2<BR>
[&nbsp;&nbsp;&nbsp; 2.241047] Freeing unused kernel memory: 184k =
init<BR>
mknod: /dev/loop0: File exists<BR>
mknod: /dev/sda1: File exists<BR>
mknod: /dev/sda2: File exists<BR>
*** SLEEP<BR>
*** Try mounting REALROOT from rootfs.ext3 in /dev/sda1(vfat)<BR>
mount: mounting /dev/sda1 on /media/sda1 failed<BR>
*** Try mounting REALROOT from /dev/sda2(ext3)<BR>
mount: mounting /dev/sda2 on /media/realroot failed<BR>
*** Try mounting REALROOT /dev/mtdblock4(jffs2)<BR>
mount: mounting /dev/mtdblock4 on /media/realroot failed<BR>
*** Cannot find real rootfs - dropping to a shell<BR>
/bin/sh: can't access tty; job control turned off<BR>
root@RadioNav: ~ #<BR>
root@RadioNav: ~ #<BR>
root@RadioNav: ~ #<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
<BR>
Now plugging-in USB:<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 17.228078] hub 1-0:1.0: state 7 ports 2 =
chg 0000 evt 0004<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 17.233798] ppc-of-ohci f0001000.usb: =
GetStatus roothub.portstatus [1] =3D 0x00010101 CSC PPS CCS<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 17.242776] hub 1-0:1.0: port 2, status =
0101, change 0001, 12 Mb/s<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 17.374796] hub 1-0:1.0: debounce: port =
2: total 100ms stable 100ms status 0x101<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 17.450780] ppc-of-ohci f0001000.usb: =
GetStatus roothub.portstatus [1] =3D 0x00100103 PRSC PPS PES CCS<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 17.514787] usb 1-2: new full speed USB =
device using ppc-of-ohci and address 2<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 24.027842] usb 1-2: khubd timed out on =
ep0in len=3D0/64<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 29.199841] usb 1-2: khubd timed out on =
ep0in len=3D0/64<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 34.307841] usb 1-2: khubd timed out on =
ep0in len=3D0/64<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 34.382786] ppc-of-ohci f0001000.usb: =
GetStatus roothub.portstatus [1] =3D 0x00100103 PRSC PPS PES CCS<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 34.446789] usb 1-2: device descriptor =
read/64, error -110<BR>
root@RadioNav: ~ #<BR>
root@RadioNav: ~ #cat /proc/interrupts<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<BR>
134:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5689&nbsp; MPC52xx Peripherals =
Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ohci_hcd:usb1<BR>
139:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 207&nbsp; MPC52xx =
Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc52xx_psc_uart<BR>
143:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc<BR>
144:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc<BR>
BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>
root@RadioNav: ~ #<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
<BR>
we were thinking to some problem like:<BR>
<BR>
<A =
HREF=3D"http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.ht=
ml">http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.html</=
A><BR>
<BR>
or<BR>
<BR>
<A =
HREF=3D"http://www.nabble.com/MPC5200-PCI-interrupt-routing-p19608472.htm=
l">http://www.nabble.com/MPC5200-PCI-interrupt-routing-p19608472.html</A>=
<BR>
<BR>
We are also thinking about the fact that from .config for PPC we =
have:<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
PCI support (PCI) [Y/n/?] (NEW) n<BR>
&nbsp; Freescale MPC52xx SoC internal IDE (PATA_MPC52xx) [N/m/y/?] (NEW) =
n<BR>
Freescale MPC52xx family PSC serial support (SERIAL_MPC52xx) [N/m/y/?] =
(NEW) y<BR>
&nbsp; Console on a Freescale MPC52xx family PSC serial port =
(SERIAL_MPC52xx_CONSOLE) [N/y/?] (NEW) y<BR>
&nbsp;&nbsp;&nbsp; Freescale MPC52xx family PSC serial port baud =
(SERIAL_MPC52xx_CONSOLE_BAUD) [9600] (NEW) 9600<BR>
OHCI support for on-chip PPC USB controller (USB_OHCI_HCD_PPC_SOC) =
[Y/n/?] (NEW) y<BR>
OHCI support for PCI-bus USB controllers (USB_OHCI_HCD_PCI) [Y/n/?] =
(NEW) y<BR>
Include xmon kernel debugger (XMON) [N/y/?] (NEW) n<BR>
Support for early boot texts over serial port (SERIAL_TEXT_DEBUG) [N/y] =
(NEW) y<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<BR>
<BR>
and for PowerPC we have PCI support on .config and on *.dts but with any =
PCI modification respects node on lite5200.dts (some interrupt ?)<BR>
<BR>
Have you got any ideas?<BR>
<BR>
Thanks a lot J<BR>
<BR>
-----Messaggio originale-----<BR>
Da: linuxppc-dev-bounces+gianfranco.casanova=3Dalice.it@ozlabs.org per =
conto di Gary Thomas<BR>
Inviato: ven 05/12/2008 13.20<BR>
A: s104259@yahoo.it<BR>
Cc: Linuxppc-dev@ozlabs.org<BR>
Oggetto: Re: Installation on a MPC5200 based custom board<BR>
<BR>
Angelo wrote:<BR>
&gt; Hi all.<BR>
&gt;<BR>
&gt; I saw that someones trying to work on a custom board based on =
mpc5200.<BR>
&gt; I have:<BR>
&gt; * u-boot 1.2.0<BR>
&gt; * kernel 2.6.21<BR>
&gt; * arch=3Dpowerpc<BR>
&gt; * custom dts based on lite5200b.dts<BR>
&gt; * USB port (USB2) configured on the Ethernet port<BR>
&gt;<BR>
&gt; Is it necessary to combine Ethernet and usb nodes?<BR>
&gt; However this is the log when a usb-storage is plugged:<BR>
&gt;<BR>
&gt; hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004<BR>
&gt; ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00010101<BR>
&gt; CSC PPS CCS<BR>
&gt; hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s<BR>
&gt; hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status =
0x101<BR>
&gt; ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00100103<BR>
&gt; PRSC PPS PES CCS<BR>
&gt; usb 1-2: new full speed USB device using ppc-of-ohci and address =
2<BR>
&gt; BUG: soft lockup detected on CPU#0!<BR>
&gt; Call Trace:<BR>
&gt; [C7E05A50] [C0007FD8] show_stack+0x3c/0x194 (unreliable)<BR>
&gt; [C7E05A80] [C004A380] softlockup_tick+0xa4/0xd4<BR>
&gt; [C7E05AA0] [C002B998] run_local_timers+0x18/0x28<BR>
&gt; [C7E05AB0] [C002B9D8] update_process_times+0x30/0x7c<BR>
&gt; [C7E05AC0] [C003FF3C] tick_sched_timer+0xb0/0x280<BR>
&gt; [C7E05B20] [C003C538] hrtimer_interrupt+0x214/0x26c<BR>
&gt; [C7E05B80] [C000E744] timer_interrupt+0x88/0x354<BR>
&gt; [C7E05BF0] [C0011C04] ret_from_except+0x0/0x14<BR>
&gt; --- Exception: 901 at handle_IRQ_event+0x7c/0x1e8<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D handle_level_irq+0x90/0x13c<BR>
&gt; [C7E05CB0] [C7F15C00] 0xc7f15c00 (unreliable)<BR>
&gt; [C7E05CD0] [C004C2E0] handle_level_irq+0x90/0x13c<BR>
&gt; [C7E05CE0] [C0006304] do_IRQ+0x98/0xbc<BR>
&gt; [C7E05CF0] [C0011C04] ret_from_except+0x0/0x14<BR>
&gt; --- Exception: 501 at schedule+0x38/0x64c<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D schedule_timeout+0x68/0xe4<BR>
&gt; [C7E05DB0] [C01A1650] usb_hcd_submit_urb+0x190/0x8a0 =
(unreliable)<BR>
&gt; [C7E05E00] [C02389A4] schedule_timeout+0x68/0xe4<BR>
&gt; [C7E05E40] [C0238378] wait_for_completion_timeout+0x8c/0x138<BR>
&gt; [C7E05E80] [C01A2B60] usb_start_wait_urb+0x64/0x124<BR>
&gt; [C7E05EB0] [C01A2E1C] usb_control_msg+0xc4/0xf0<BR>
&gt; [C7E05EF0] [C019D0D0] hub_port_init+0x424/0x614<BR>
&gt; [C7E05F40] [C019F42C] hub_thread+0x434/0xe64<BR>
&gt; [C7E05FC0] [C0037E60] kthread+0xc0/0xfc<BR>
&gt; [C7E05FF0] [C00123F8] original_kernel_thread+0x44/0x60<BR>
&gt; ppc-of-ohci f0001000.usb: OHCI Unrecoverable Error, disabled<BR>
&gt; ppc-of-ohci f0001000.usb: OHCI controller state<BR>
&gt; ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers<BR>
&gt; ppc-of-ohci f0001000.usb: control 0x093 HCFS=3Doperational CLE =
CBSR=3D3<BR>
&gt; ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0<BR>
&gt; ppc-of-ohci f0001000.usb: intrstatus 0x00000074 RHSC FNO UE SF<BR>
&gt; ppc-of-ohci f0001000.usb: intrenable 0x8000001a MIE UE RD WDH<BR>
&gt; ppc-of-ohci f0001000.usb: ed_controlhead 07fcc000<BR>
&gt; ppc-of-ohci f0001000.usb: ed_controlcurrent fffffff0<BR>
&gt; ppc-of-ohci f0001000.usb: hcca frame #ddb6<BR>
&gt; ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP NPS =
NDP=3D2(2)<BR>
&gt; ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 =
DR=3D0000<BR>
&gt; ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE<BR>
&gt; ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS<BR>
&gt; ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00030100 PESC =
CSC PPS<BR>
&gt; ppc-of-ohci f0001000.usb: HC died; cleaning up<BR>
&gt; irq 134: nobody cared (try booting with the &quot;irqpoll&quot; =
option)<BR>
&gt; Call Trace:<BR>
&gt; [C046FDF0] [C0007FD8] show_stack+0x3c/0x194 (unreliable)<BR>
&gt; [C046FE20] [C004B358] __report_bad_irq+0x34/0xac<BR>
&gt; [C046FE40] [C004B4AC] note_interrupt+0xdc/0x288<BR>
&gt; [C046FE70] [C004C344] handle_level_irq+0xf4/0x13c<BR>
&gt; [C046FE80] [C0006304] do_IRQ+0x98/0xbc<BR>
&gt; [C046FE90] [C0011C04] ret_from_except+0x0/0x14<BR>
&gt; --- Exception: 501 at schedule+0x304/0x64c<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D schedule+0x2d8/0x64c<BR>
&gt; [C046FFA0] [C004A2B4] watchdog+0x4c/0x74<BR>
&gt; [C046FFC0] [C0037E60] kthread+0xc0/0xfc<BR>
&gt; [C046FFF0] [C00123F8] original_kernel_thread+0x44/0x60<BR>
&gt; handlers:<BR>
&gt; [&lt;c01a1008&gt;] (usb_hcd_irq+0x0/0x9c)<BR>
&gt; Disabling IRQ #134<BR>
&gt; usb 1-2: khubd timed out on ep0in len=3D0/64<BR>
&gt; hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
&gt; ppc-of-ohci f0001000.usb: leak ed c7fcc000 (#00) state 0 (has =
tds)<BR>
&gt; hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
&gt; hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004<BR>
&gt;<BR>
&gt; Please mail me any idea...<BR>
<BR>
Update to the latest kernel (2.6.27+) - there has been lots<BR>
of work on the MPC5200 in the past three years (that's how<BR>
old 2.6.21 is!)<BR>
<BR>
--<BR>
------------------------------------------------------------<BR>
Gary =
Thomas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; Consulting for the<BR>
MLB =
Associates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; Embedded world<BR>
------------------------------------------------------------<BR>
_______________________________________________<BR>
Linuxppc-dev mailing list<BR>
Linuxppc-dev@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C956DA.1F291F97--
