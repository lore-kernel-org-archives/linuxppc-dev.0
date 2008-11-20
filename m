Return-Path: <gianfranco.casanova@alice.it>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by ozlabs.org (Postfix) with ESMTP id 7BC13DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 01:16:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94B19.8F9C1FDD"
Subject: USB on lite5200 does not work.
Date: Thu, 20 Nov 2008 15:09:11 +0100
Message-ID: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
From: <gianfranco.casanova@alice.it>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C94B19.8F9C1FDD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi folks

I've got a "little" problem with USB using a board based on lite5200.

Some infos:

-uBoot 1.2.0
-Linux version 2.6.21.7-hrt1-WR2.0bl_standard
-time_init: processor frequency   =3D 396.000000 MHz

We are using a minimal rootfs in order to jump on the real rootfs.
We reach the shell using the rootfs minimal but when we plug-in an USB =
(hosting the real rootfs) the system frozen until the USB is unplugged.

>From uBoot, USB works well.

Here following snap of boot, cat of /proc/interrupts and some Trace =
messages.

We appreciate any help. We have already take a look to posts like:

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg24295.html

or

http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.html

Error:
hub 1-0:1.0: port_wait_reset: err =3D -22
is due to a USB mouse plugged in at boot time.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

root@RadioNav: /proc #cat /proc/interrupts
           CPU0      =20
 80:          0  MPC52xx Main Edge      mpc52xx-hwtimer
134:     100000  MPC52xx Peripherals Edge      ohci_hcd:usb1
139:      45882  MPC52xx Peripherals Edge      mpc52xx_psc_uart
143:          0  MPC52xx Peripherals Edge      i2c-mpc
144:          0  MPC52xx Peripherals Edge      i2c-mpc
145:          0  MPC52xx Peripherals Edge      can-mpc52xx
146:          0  MPC52xx Peripherals Edge      can-mpc52xx
BAD:          0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

usb 1-2: new full speed USB device using ppc-of-ohci and addr2
BUG: soft lockup detected on CPU#0!                                      =
      =20
Call Trace:                                                              =
      =20
[C7E07A50] [C0007F40] show_stack+0x3c/0x194 (unreliable)                 =
      =20
[C7E07A80] [C004A2E0] softlockup_tick+0xa4/0xd4                          =
      =20
[C7E07AA0] [C002B8F8] run_local_timers+0x18/0x28                         =
      =20
[C7E07AB0] [C002B938] update_process_times+0x30/0x7c                     =
      =20
[C7E07AC0] [C003FE9C] tick_sched_timer+0xb0/0x280                        =
      =20
[C7E07B20] [C003C498] hrtimer_interrupt+0x214/0x26c                      =
      =20
[C7E07B80] [C000E6A4] timer_interrupt+0x88/0x354                         =
      =20
[C7E07BF0] [C0011B64] ret_from_except+0x0/0x14                           =
      =20
--- Exception: 901 at handle_IRQ_event+0x7c/0x1e8                        =
      =20
    LR =3D handle_level_irq+0x90/0x13c                                   =
        =20
[C7E07CB0] [C7E21C00] 0xc7e21c00 (unreliable)                            =
      =20
[C7E07CD0] [C004C240] handle_level_irq+0x90/0x13c                        =
      =20
[C7E07CE0] [C000626C] do_IRQ+0x98/0xbc                                   =
      =20
[C7E07CF0] [C0011B64] ret_from_except+0x0/0x14                           =
      =20
--- Exception: 501 at schedule+0xac/0x64c                                =
      =20
    LR =3D schedule+0x78/0x64c                                           =
        =20
[C7E07E00] [C02A7C84] schedule_timeout+0x68/0xe4                         =
      =20
[C7E07E40] [C02A7658] wait_for_completion_timeout+0x8c/0x138             =
      =20
[C7E07E80] [C019D954] usb_start_wait_urb+0x68/0xcc                       =
      =20
[C7E07EB0] [C019DBB4] usb_control_msg+0xc4/0xf0                          =
      =20
[C7E07EF0] [C0198AB4] hub_port_init+0x3fc/0x5b0                          =
      =20
[C7E07F40] [C019A6F4] hub_thread+0x344/0xbe4                             =
      =20
[C7E07FC0] [C0037DC0] kthread+0xc0/0xfc                                  =
      =20
[C7E07FF0] [C0012358] original_kernel_thread+0x44/0x60                   =
      =20
ppc-of-ohci f0001000.usb: OHCI Unrecoverable Error, disabled             =
      =20
ppc-of-ohci f0001000.usb: HC died; cleaning up                           =
      =20
irq 134: nobody cared (try booting with the "irqpoll" option)            =
      =20
Call Trace:                                                              =
      =20
[C7E29DF0] [C0007F40] show_stack+0x3c/0x194 (unreliable)                 =
      =20
[C7E29E20] [C004B2B8] __report_bad_irq+0x34/0xac                         =
      =20
[C7E29E40] [C004B40C] note_interrupt+0xdc/0x288                          =
      =20
[C7E29E70] [C004C2A4] handle_level_irq+0xf4/0x13c                        =
      =20
[C7E29E80] [C000626C] do_IRQ+0x98/0xbc                                   =
      =20
[C7E29E90] [C0011B64] ret_from_except+0x0/0x14                           =
      =20
--- Exception: 501 at schedule+0x304/0x64c                               =
      =20
    LR =3D schedule+0x2d8/0x64c                                          =
        =20
[C7E29FA0] [C004A214] watchdog+0x4c/0x74                                 =
      =20
[C7E29FC0] [C0037DC0] kthread+0xc0/0xfc                                  =
      =20
[C7E29FF0] [C0012358] original_kernel_thread+0x44/0x60                   =
      =20
handlers:                                                                =
      =20
[<c019c078>] (usb_hcd_irq+0x0/0x9c)                                      =
      =20
Disabling IRQ #134                                                       =
      =20
hub 1-0:1.0: cannot reset port 2 (err =3D -19)                           =
        =20
hub 1-0:1.0: cannot disable port 2 (err =3D -19)                         =
        =20
ppc-of-ohci f0001000.usb: leak ed c050b000 (#00) state 0 (has tds)       =
      =20
hub 1-0:1.0: cannot reset port 2 (err =3D -19)                           =
        =20
hub 1-0:1.0: cannot disable port 2 (err =3D -19)                         =
        =20
hub 1-0:1.0: cannot reset port 2 (err =3D -19)                           =
        =20
hub 1-0:1.0: cannot disable port 2 (err =3D -19)                         =
        =20
hub 1-0:1.0: cannot reset port 2 (err =3D -19)                           =
        =20
hub 1-0:1.0: cannot disable port 2 (err =3D -19)                         =
        =20
hub 1-0:1.0: cannot disable port 2 (err =3D -19)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

root@RadioNav: /proc #usb 1-2: khubd timed out on ep0in len=3D0/64
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
ppc-of-ohci f0001000.usb: leak ed c0628000 (#00) state 0 (has tds)
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Linux version 2.6.21.7-hrt1-WR2.0bl_standard (asimmini@osstlab-acer-1) =
(gcc version 4.1.2 (Wind River Linux Sourcery G++ 4.1-84)) #1 8
Found initrd at 0xc7e2e000:0xc7f0fbf2
Entering add_active_range(0, 0, 32768) 0 entries of 256 used
Top of RAM: 0x8000000, Total RAM: 0x8000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
early_node_map[1] active PFN ranges
    0:        0 ->    32768
On node 0 totalpages: 32768
  DMA zone: 256 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 32512 pages, LIFO batch:7
  Normal zone: 0 pages used for memmap
Built 1 zonelists.  Total pages: 32512
Kernel command line: debug console=3DttyPSC3,115200 root=3D/dev/ram
MPC52xx PIC is up and running!
PID hash table entries: 512 (order: 9, 2048 bytes)
time_init: decrementer frequency =3D 33.000000 MHz
time_init: processor frequency   =3D 396.000000 MHz
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 124584k/131072k available (3908k kernel code, 6324k reserved, =
120k data, 165k bss, 172k init)
Calibrating delay loop... 65.79 BogoMIPS (lpj=3D131584)
Mount-cache hash table entries: 512
Initializing container subsys cpuacct
Initializing container subsys debug
NET: Registered protocol family 16
hwtimer: Added mpc52xx hwtimer (MPC52xx General-purpose timer) at =
index=3D0
PCI: Probing PCI hardware
DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
SCSI subsystem initialized
libata version 2.20 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 902k freed
Registering GDB sysrq handler
Time: timebase clocksource has been installed.
Switched to high resolution mode on CPU 0
Registering unionfs 2.1.6 (for 2.6.21.7)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
LTT : ltt-facilities init
LTT : ltt-relay init
i8042.c: No controller found.
Serial: MPC52xx PSC UART driver
f0002600.serial: ttyPSC3 at MMIO map 0xf0002600 mem 0xc9004600 (irq =3D =
139) is a MPC52xx PSC
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
i2c /dev entries driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
FSL Open Firmware MPC52xx IDE driver
mpc52xx-ide: Invalid port config, no ATA CS !
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
ppc-of-ohci f0001000.usb: initializing PPC-OF USB Controller
ppc-of-ohci f0001000.usb: OF OHCI
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number 1
ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000
ppc-of-ohci f0001000.usb: created debug files
ppc-of-ohci f0001000.usb: resetting from state 'reset', control =3D 0x0
ppc-of-ohci f0001000.usb: OHCI controller state
ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers
ppc-of-ohci f0001000.usb: control 0x083 HCFS=3Doperational CBSR=3D3
ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0
ppc-of-ohci f0001000.usb: intrstatus 0x00000004 SF
ppc-of-ohci f0001000.usb: intrenable 0x8000005a MIE RHSC UE RD WDH
ppc-of-ohci f0001000.usb: hcca frame #0000
ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP NPS =
NDP=3D2(2)
ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE
ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS
ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00010301 CSC LSDA PPS =
CCS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OF OHCI
usb usb1: Manufacturer: Linux 2.6.21.7-hrt1-WR2.0bl_standard ohci_hcd
usb usb1: SerialNumber: PPC-OF USB
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
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00010301 CSC LSDA PPS CCS
hub 1-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
USB Universal Host Controller Interface driver v3.0
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
hub 1-0:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
hub 1-0:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS
hub 1-0:1.0: port_wait_reset: err =3D -22
hub 1-0:1.0: port 2 not enabled, trying reset again...
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130100 PRSC PESC CSC PPS
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00030100 PESC CSC PPS
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
usbcore: registered new interface driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for =
USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for =
generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for GSM =
modem (1-port)
usbcore: registered new interface driver option
drivers/usb/serial/option.c: USB Driver for GSM modems: v0.7.1
drivers/usb/serial/usb-serial.c: USB Serial support registered for =
pl2303
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor =
driver
drivers/usb/misc/idmouse.c: Siemens ID Mouse FingerTIP Sensor Driver 0.6
usbcore: registered new interface driver idmouse
mice: PS/2 mouse device common for all mice
CAN device class register Version 0.1
CAN FIFO: 4800Bytes for Tx
CAN: Registering CAN endpoint can0
CAN:Irq 145 BaudR 1000000 Ext. Normal on /dev/can0.
CAN FIFO: 4800Bytes for Tx
CAN: Registering CAN endpoint can1
CAN:Irq 146 BaudR 1000000 Ext. Normal on /dev/can1.
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14 =
07:25:50 2007 UTC).
usbcore: registered new interface driver snd-usb-audio
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation =
<jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
Freeing unused kernel memory: 172k init
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

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

------_=_NextPart_001_01C94B19.8F9C1FDD
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
<TITLE>USB on lite5200 does not work.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi folks<BR>
<BR>
I've got a &quot;little&quot; problem with USB using a board based on =
lite5200.<BR>
<BR>
Some infos:<BR>
<BR>
-uBoot 1.2.0<BR>
-Linux version 2.6.21.7-hrt1-WR2.0bl_standard<BR>
-time_init: processor frequency&nbsp;&nbsp; =3D 396.000000 MHz<BR>
<BR>
We are using a minimal rootfs in order to jump on the real rootfs.<BR>
We reach the shell using the rootfs minimal but when we plug-in an USB =
(hosting the real rootfs) the system frozen until the USB is =
unplugged.<BR>
<BR>
>From uBoot, USB works well.<BR>
<BR>
Here following snap of boot, cat of /proc/interrupts and some Trace =
messages.<BR>
<BR>
We appreciate any help. We have already take a look to posts like:<BR>
<BR>
<A =
HREF=3D"http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg24295.html=
">http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg24295.html</A><B=
R>
<BR>
or<BR>
<BR>
<A =
HREF=3D"http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.ht=
ml">http://www.nabble.com/USB-support-on-mpc5200-broken-td19658810.html</=
A><BR>
<BR>
Error:<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
is due to a USB mouse plugged in at boot time.<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
root@RadioNav: /proc #cat /proc/interrupts<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CPU0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;80:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Main Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc52xx-hwtimer<BR>
134:&nbsp;&nbsp;&nbsp;&nbsp; 100000&nbsp; MPC52xx Peripherals =
Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ohci_hcd:usb1<BR>
139:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45882&nbsp; MPC52xx Peripherals =
Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc52xx_psc_uart<BR>
143:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc<BR>
144:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc<BR>
145:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can-mpc52xx<BR>
146:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can-mpc52xx<BR>
BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
usb 1-2: new full speed USB device using ppc-of-ohci and addr2<BR>
BUG: soft lockup detected on =
CPU#0!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
Call =
Trace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07A50] [C0007F40] show_stack+0x3c/0x194 =
(unreliable)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;<BR>
[C7E07A80] [C004A2E0] =
softlockup_tick+0xa4/0xd4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B=
R>
[C7E07AA0] [C002B8F8] =
run_local_timers+0x18/0x28&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07AB0] [C002B938] =
update_process_times+0x30/0x7c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07AC0] [C003FE9C] =
tick_sched_timer+0xb0/0x280&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07B20] [C003C498] =
hrtimer_interrupt+0x214/0x26c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07B80] [C000E6A4] =
timer_interrupt+0x88/0x354&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07BF0] [C0011B64] =
ret_from_except+0x0/0x14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;<BR>
--- Exception: 901 at =
handle_IRQ_event+0x7c/0x1e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; LR =3D =
handle_level_irq+0x90/0x13c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07CB0] [C7E21C00] 0xc7e21c00 =
(unreliable)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR=
>
[C7E07CD0] [C004C240] =
handle_level_irq+0x90/0x13c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07CE0] [C000626C] =
do_IRQ+0x98/0xbc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07CF0] [C0011B64] =
ret_from_except+0x0/0x14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;<BR>
--- Exception: 501 at =
schedule+0xac/0x64c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; LR =3D =
schedule+0x78/0x64c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07E00] [C02A7C84] =
schedule_timeout+0x68/0xe4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07E40] [C02A7658] =
wait_for_completion_timeout+0x8c/0x138&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;<BR>
[C7E07E80] [C019D954] =
usb_start_wait_urb+0x68/0xcc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07EB0] [C019DBB4] =
usb_control_msg+0xc4/0xf0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B=
R>
[C7E07EF0] [C0198AB4] =
hub_port_init+0x3fc/0x5b0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B=
R>
[C7E07F40] [C019A6F4] =
hub_thread+0x344/0xbe4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;<BR>
[C7E07FC0] [C0037DC0] =
kthread+0xc0/0xfc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E07FF0] [C0012358] =
original_kernel_thread+0x44/0x60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
ppc-of-ohci f0001000.usb: OHCI Unrecoverable Error, =
disabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
ppc-of-ohci f0001000.usb: HC died; cleaning =
up&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
irq 134: nobody cared (try booting with the &quot;irqpoll&quot; =
option)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
Call =
Trace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29DF0] [C0007F40] show_stack+0x3c/0x194 =
(unreliable)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;<BR>
[C7E29E20] [C004B2B8] =
__report_bad_irq+0x34/0xac&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29E40] [C004B40C] =
note_interrupt+0xdc/0x288&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B=
R>
[C7E29E70] [C004C2A4] =
handle_level_irq+0xf4/0x13c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29E80] [C000626C] =
do_IRQ+0x98/0xbc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29E90] [C0011B64] =
ret_from_except+0x0/0x14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;<BR>
--- Exception: 501 at =
schedule+0x304/0x64c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; LR =3D =
schedule+0x2d8/0x64c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29FA0] [C004A214] =
watchdog+0x4c/0x74&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29FC0] [C0037DC0] =
kthread+0xc0/0xfc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[C7E29FF0] [C0012358] =
original_kernel_thread+0x44/0x60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
handlers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[&lt;c019c078&gt;] =
(usb_hcd_irq+0x0/0x9c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
Disabling IRQ =
#134&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
ppc-of-ohci f0001000.usb: leak ed c050b000 (#00) state 0 (has =
tds)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D =
-19)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
root@RadioNav: /proc #usb 1-2: khubd timed out on ep0in len=3D0/64<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
ppc-of-ohci f0001000.usb: leak ed c0628000 (#00) state 0 (has tds)<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot reset port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
hub 1-0:1.0: cannot disable port 2 (err =3D -19)<BR>
hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
Linux version 2.6.21.7-hrt1-WR2.0bl_standard (asimmini@osstlab-acer-1) =
(gcc version 4.1.2 (Wind River Linux Sourcery G++ 4.1-84)) #1 8<BR>
Found initrd at 0xc7e2e000:0xc7f0fbf2<BR>
Entering add_active_range(0, 0, 32768) 0 entries of 256 used<BR>
Top of RAM: 0x8000000, Total RAM: 0x8000000<BR>
Memory hole size: 0MB<BR>
Zone PFN ranges:<BR>
&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 =
-&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
early_node_map[1] active PFN ranges<BR>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
-&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
On node 0 totalpages: 32768<BR>
&nbsp; DMA zone: 256 pages used for memmap<BR>
&nbsp; DMA zone: 0 pages reserved<BR>
&nbsp; DMA zone: 32512 pages, LIFO batch:7<BR>
&nbsp; Normal zone: 0 pages used for memmap<BR>
Built 1 zonelists.&nbsp; Total pages: 32512<BR>
Kernel command line: debug console=3DttyPSC3,115200 root=3D/dev/ram<BR>
MPC52xx PIC is up and running!<BR>
PID hash table entries: 512 (order: 9, 2048 bytes)<BR>
time_init: decrementer frequency =3D 33.000000 MHz<BR>
time_init: processor frequency&nbsp;&nbsp; =3D 396.000000 MHz<BR>
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>
Memory: 124584k/131072k available (3908k kernel code, 6324k reserved, =
120k data, 165k bss, 172k init)<BR>
Calibrating delay loop... 65.79 BogoMIPS (lpj=3D131584)<BR>
Mount-cache hash table entries: 512<BR>
Initializing container subsys cpuacct<BR>
Initializing container subsys debug<BR>
NET: Registered protocol family 16<BR>
hwtimer: Added mpc52xx hwtimer (MPC52xx General-purpose timer) at =
index=3D0<BR>
PCI: Probing PCI hardware<BR>
DMA: MPC52xx BestComm driver<BR>
DMA: MPC52xx BestComm engine @f0001200 ok !<BR>
SCSI subsystem initialized<BR>
libata version 2.20 loaded.<BR>
usbcore: registered new interface driver usbfs<BR>
usbcore: registered new interface driver hub<BR>
usbcore: registered new device driver usb<BR>
Bluetooth: Core ver 2.11<BR>
NET: Registered protocol family 31<BR>
Bluetooth: HCI device and connection manager initialized<BR>
Bluetooth: HCI socket layer initialized<BR>
NET: Registered protocol family 2<BR>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<BR>
TCP established hash table entries: 4096 (order: 3, 32768 bytes)<BR>
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<BR>
TCP: Hash tables configured (established 4096 bind 4096)<BR>
TCP reno registered<BR>
checking if image is initramfs... it is<BR>
Freeing initrd memory: 902k freed<BR>
Registering GDB sysrq handler<BR>
Time: timebase clocksource has been installed.<BR>
Switched to high resolution mode on CPU 0<BR>
Registering unionfs 2.1.6 (for 2.6.21.7)<BR>
io scheduler noop registered<BR>
io scheduler anticipatory registered (default)<BR>
io scheduler deadline registered<BR>
io scheduler cfq registered<BR>
LTT : ltt-facilities init<BR>
LTT : ltt-relay init<BR>
i8042.c: No controller found.<BR>
Serial: MPC52xx PSC UART driver<BR>
f0002600.serial: ttyPSC3 at MMIO map 0xf0002600 mem 0xc9004600 (irq =3D =
139) is a MPC52xx PSC<BR>
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize<BR>
loop: loaded (max 8 devices)<BR>
i2c /dev entries driver<BR>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<BR>
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx<BR>
FSL Open Firmware MPC52xx IDE driver<BR>
mpc52xx-ide: Invalid port config, no ATA CS !<BR>
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) =
Driver<BR>
ohci_hcd: block sizes: ed 64 td 64<BR>
ppc-of-ohci f0001000.usb: initializing PPC-OF USB Controller<BR>
ppc-of-ohci f0001000.usb: OF OHCI<BR>
drivers/usb/core/inode.c: creating file 'devices'<BR>
drivers/usb/core/inode.c: creating file '001'<BR>
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number =
1<BR>
ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000<BR>
ppc-of-ohci f0001000.usb: created debug files<BR>
ppc-of-ohci f0001000.usb: resetting from state 'reset', control =3D =
0x0<BR>
ppc-of-ohci f0001000.usb: OHCI controller state<BR>
ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers<BR>
ppc-of-ohci f0001000.usb: control 0x083 HCFS=3Doperational CBSR=3D3<BR>
ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0<BR>
ppc-of-ohci f0001000.usb: intrstatus 0x00000004 SF<BR>
ppc-of-ohci f0001000.usb: intrenable 0x8000005a MIE RHSC UE RD WDH<BR>
ppc-of-ohci f0001000.usb: hcca frame #0000<BR>
ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP NPS =
NDP=3D2(2)<BR>
ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 DR=3D0000<BR>
ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE<BR>
ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS<BR>
ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00010301 CSC LSDA PPS =
CCS<BR>
usb usb1: default language 0x0409<BR>
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1<BR>
usb usb1: Product: OF OHCI<BR>
usb usb1: Manufacturer: Linux 2.6.21.7-hrt1-WR2.0bl_standard =
ohci_hcd<BR>
usb usb1: SerialNumber: PPC-OF USB<BR>
usb usb1: uevent<BR>
usb usb1: usb_probe_device<BR>
usb usb1: configuration #1 chosen from 1 choice<BR>
usb usb1: adding 1-0:1.0 (config #1, interface 0)<BR>
usb 1-0:1.0: uevent<BR>
hub 1-0:1.0: usb_probe_interface<BR>
hub 1-0:1.0: usb_probe_interface - got id<BR>
hub 1-0:1.0: USB hub found<BR>
hub 1-0:1.0: 2 ports detected<BR>
hub 1-0:1.0: standalone hub<BR>
hub 1-0:1.0: ganged power switching<BR>
hub 1-0:1.0: global over-current protection<BR>
hub 1-0:1.0: power on to power good time: 4ms<BR>
hub 1-0:1.0: local power source is good<BR>
hub 1-0:1.0: no over-current condition exists<BR>
hub 1-0:1.0: enabling power on all ports<BR>
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000<BR>
drivers/usb/core/inode.c: creating file '001'<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00010301 CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s<BR>
USB Universal Host Controller Interface driver v3.0<BR>
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
hub 1-0:1.0: Cannot enable port 2.&nbsp; Maybe the USB cable is bad?<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
hub 1-0:1.0: Cannot enable port 2.&nbsp; Maybe the USB cable is bad?<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130301 PRSC PESC CSC LSDA PPS CCS<BR>
hub 1-0:1.0: port_wait_reset: err =3D -22<BR>
hub 1-0:1.0: port 2 not enabled, trying reset again...<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00130100 PRSC PESC CSC PPS<BR>
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004<BR>
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D =
0x00030100 PESC CSC PPS<BR>
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s<BR>
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100<BR>
usbcore: registered new interface driver cdc_acm<BR>
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for =
USB modems and ISDN adapters<BR>
Initializing USB Mass Storage driver...<BR>
usbcore: registered new interface driver usb-storage<BR>
USB Mass Storage support registered.<BR>
usbcore: registered new interface driver libusual<BR>
usbcore: registered new interface driver hiddev<BR>
usbcore: registered new interface driver usbhid<BR>
drivers/usb/input/hid-core.c: v2.6:USB HID core driver<BR>
usbcore: registered new interface driver usbserial<BR>
drivers/usb/serial/usb-serial.c: USB Serial support registered for =
generic<BR>
usbcore: registered new interface driver usbserial_generic<BR>
drivers/usb/serial/usb-serial.c: USB Serial Driver core<BR>
drivers/usb/serial/usb-serial.c: USB Serial support registered for GSM =
modem (1-port)<BR>
usbcore: registered new interface driver option<BR>
drivers/usb/serial/option.c: USB Driver for GSM modems: v0.7.1<BR>
drivers/usb/serial/usb-serial.c: USB Serial support registered for =
pl2303<BR>
usbcore: registered new interface driver pl2303<BR>
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor =
driver<BR>
drivers/usb/misc/idmouse.c: Siemens ID Mouse FingerTIP Sensor Driver =
0.6<BR>
usbcore: registered new interface driver idmouse<BR>
mice: PS/2 mouse device common for all mice<BR>
CAN device class register Version 0.1<BR>
CAN FIFO: 4800Bytes for Tx<BR>
CAN: Registering CAN endpoint can0<BR>
CAN:Irq 145 BaudR 1000000 Ext. Normal on /dev/can0.<BR>
CAN FIFO: 4800Bytes for Tx<BR>
CAN: Registering CAN endpoint can1<BR>
CAN:Irq 146 BaudR 1000000 Ext. Normal on /dev/can1.<BR>
Bluetooth: HCI USB driver ver 2.9<BR>
usbcore: registered new interface driver hci_usb<BR>
Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14 =
07:25:50 2007 UTC).<BR>
usbcore: registered new interface driver snd-usb-audio<BR>
ALSA device list:<BR>
&nbsp; No soundcards found.<BR>
TCP cubic registered<BR>
NET: Registered protocol family 1<BR>
NET: Registered protocol family 17<BR>
Bluetooth: L2CAP ver 2.8<BR>
Bluetooth: L2CAP socket layer initialized<BR>
Bluetooth: SCO (Voice Link) ver 0.5<BR>
Bluetooth: SCO socket layer initialized<BR>
Bluetooth: RFCOMM socket layer initialized<BR>
Bluetooth: RFCOMM TTY layer initialized<BR>
Bluetooth: RFCOMM ver 1.8<BR>
Bluetooth: BNEP (Ethernet Emulation) ver 1.2<BR>
Bluetooth: HIDP (Human Interface Emulation) ver 1.2<BR>
ieee80211: 802.11 data/management/control stack, git-1.1.13<BR>
ieee80211: Copyright (C) 2004-2005 Intel Corporation =
&lt;jketreno@linux.intel.com&gt;<BR>
ieee80211_crypt: registered algorithm 'NULL'<BR>
ieee80211_crypt: registered algorithm 'WEP'<BR>
Freeing unused kernel memory: 172k init<BR>
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
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C94B19.8F9C1FDD--
