Message-ID: <20040305105421.67799.qmail@web15202.mail.bjs.yahoo.com>
Date: Fri, 5 Mar 2004 18:54:21 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: Re: PCI daughter card with USB on a 405GP
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>,
	Xavier Miville <xmiville@oerlikon.ca>, v.sudeep@exgate.tek.com,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040224085353.A13974@home.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Matt,

Sorry for the late reply.I tested your USB patch on
LITE_DW(MPC823e) and found that this patch couldn't
take effect on MPC8xx directly.Maybe the reason was
that there was no CONFIG_USB_MODULE in LINUX kernel
configuration(Perhaps I use MVL 3.0 - 2.4.18 kernel).
So I changed your patch one line

#if (defined(CONFIG_4xx) && defined(CONFIG_USB)) ||
defined(CONFIG_USB_MODULE)

with this line:

#if (defined(CONFIG_4xx) && defined(CONFIG_USB)) ||
defined(CONFIG_USB_MPC8xx)

Then the USB performance improved a lot but not
perfect yet.There are few failure with USB keyboard in
boot-ups.Much better than before-only few success in
boot-ups.I listed the test result and some kernel
configuration + boot message as follows.Pls see
whether there are some faults in it.

_Test_result

Present performance: [OK--USB keybaord alive]

POWER-ON  1st(reboot)  2nd   3rd    4th   5th
OK-10:00am   OK        OK    OK     OK   FAILED
OK-10:30     OK        OK    FAILED
OK-11:00     OK        FAILED
OK-11:30     OK        OK    FAILED
OK-12:00     OK        OK    FAILED

The former performance:

POWER-ON  1st(reboot)  2nd          3rd
OK-10:00am     OK      FAILED
FAILED until next morning to work.

_LINUX_CONFIG

# General setup
#
# CONFIG_HIGHMEM is not set
# CONFIG_KERNEL_START_BOOL is not set
# CONFIG_TASK_SIZE_BOOL is not set
# CONFIG_ILATENCY is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
# CONFIG_PCI_QSPAN is not set
# CONFIG_PCI is not set
CONFIG_USB_KBD=y
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SEMMNI=128
CONFIG_SYSVIPC_SEMMSL=250
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
# CONFIG_MULTITHREADED_CORES is not set
CONFIG_KERNEL_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_HOTPLUG=y

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y

# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_MPC8xx=y
# CONFIG_USB_OHCI is not set
# CONFIG_USB_NON_PCI_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

_Boot_message

u-boot>run net_nfs
Trying SCC ETHERNET
TFTP from server 172.16.115.6; our IP address is
172.16.115.7
Filename 'uImage.liteusb'.
Load address: 0x200000
Loading:
################################################################################################################################################
done
Bytes transferred = 733721 (b3219 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.18_mvl30-rpxlite
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    733657 Bytes = 716.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03FBE928 => set upper limit
to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFFB1
bd address  = 0x03FBEFC4
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFF000000
flashsize   = 0x01000000
flashoffset = 0x0001B400
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xFA200000
bootflags   = 0x00000001
intfreq     =     48 MHz
busfreq     =     24 MHz
ethaddr     = 00:10:EC:00:37:5B
IP addr     = 172.16.115.7
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000)
...
Linux version 2.4.18_mvl30-rpxlite (root@sgj) (gcc
version 3.2.1 20020930 (MontaVista)) #1 Thu Mar 4
22:40:33 CST 2004
USB uCode patch installed
rpxfb: allocated 75 pages for frame buffer
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=tty0 console=ttyS0,9600
root=/dev/nfs rw
nfsroot=172.16.115.6:/workspace/myfilesystem/target/
ip=172.16.115.7:172.16.115.6:172.16.115.254:255.255.255.0::eth0:off
panic=1
Decrementer Frequency = 180000000/60
Console: colour dummy device 80x25
Calibrating delay loop... 47.82 BogoMIPS
Memory: 62412k available (1252k kernel code, 444k
data, 76k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536
bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768
bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192
bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc.,
designed by Axis Communications AB.
Console: switching to colour frame buffer device 80x30
fb0: RPX LCD frame buffer device
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG2
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:37:5b
loop: loaded (max 8 devices)
RPX Lite or CLLF flash device: 2000000 at fe000000
 Amd/Fujitsu Extended Query Table v1.2 at 0x0040
number of CFI chips: 1
Creating 3 MTD partitions on "RPX":
0x00000000-0x00080000 : "RPXLITE flash BOOT partition"
0x00080000-0x00200000 : "RPXLITE flash DATA partition"
0x00200000-0x01000000 : "RPXLITE flash APPLICATION
partition"
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
m8xxhci: initializing controller
usb.c: new USB bus registered, assigned bus number 1
m8xxhci: part 24, mask 1
m8xxhci: MPC823eB2
hub.c: USB hub found
hub.c: 1 port detected
m8xxhci: initializing done
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver keyboard
usbkbd.c: :USB HID Boot Protocol keyboard driver
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
IP-Config: Complete:
      device=eth0, addr=172.16.115.7,
mask=255.255.255.0, gw=172.16.115.254,
     host=172.16.115.7, domain=, nis-domain=(none),
     bootserver=172.16.115.6, rootserver=172.16.115.6,
rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.115.6
Looking up port of RPC 100005/1 on 172.16.115.6
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.22 (22-Jun-2001)
Calculating module dependencies... depmod: ***
Unresolved symbols in
/lib/modules/2.4.18_mvl30-rpxlite/kernel/drivers/ide/ide-cs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18_mvl30-rpxlite/kernel/fs/nfsd/nfsd.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18_mvl30-rpxlite/kernel/fs/smbfs/smbfs.o
done.
Loading modules:
mkdir: cannot create directory `/dev/pts': File exists
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 3
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.

MontaVista Linux 3.0, Professional Edition

172.16.115.7 login: root
Last login: Thu Jan  1 00:06:21 1970 on console
Linux 172.16.115.7 2.4.18_mvl30-rpxlite #1 Thu Mar 4
22:40:33 CST 2004 ppc unknown

Welcome to MontaVista Linux 3.0, Professional Edition

root@172.16.115.7:~#

Thanks for reading and look forward to any suggestion.

Best regards,

Sam

---------------Original message -----------------
> On Tue, Feb 24, 2004 at 10:38:41PM +0800, song sam wrote:
> >
> > Wolfgang Denk wrote:
> > > We tested a Adaptec AUA-200LP USB 2.0 card in some PPC sytems. It
> > > worked fine when the devices were already connected at power-on or
> > > at least when booting Linux, while hot-plug would reliably crash
> > > the kernel. As far as I understand such behaviour is typical of
> > > some of the alignment/cache bugs in the Linux kernel's USB code.
> >
> > I also met this USB problem on LITE_DW board when using USB keyboard
> > and mouse.Has it solved or not?
>
> I use the following hack locally to work around some of the 2.4 USB
> stack DMA problems.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
