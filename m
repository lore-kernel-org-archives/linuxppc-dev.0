From: "Jerry Walden" <jwalden123@adelphia.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: custom PPC405GPr board almost boots - one last step
Date: Fri, 4 Apr 2003 23:24:16 -0500
Message-ID: <MMEKKOMGOBGEIENHLGDLMEJGCHAA.jwalden123@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

Well I'm getting much further now.  Problem was I did not have ext2
filesystem in
my kernel configuration.  Now the initialization seems to complete and it
looks to
me like either a prompt is trying to print out, or some other type of text.
In any
case I am wonder when the boot gets as far as this one does, can or does
something
happen to the serial port?  Does it try to bring up a console on the serial
port
and somehow is getting confused?


Thanks

Jerry

See trace below:

U-Boot 0.2.0 (Apr  4 2003 - 16:29:38)


CPU:   IBM PowerPC 405GPr Rev. A at 133 MHz (PLB=66, OPB=16, EBC=16 MHz
       PCI async ext clock used, internal PCI arbiter enabled
       16 kB I-Cache 16 kB D-Cache

Board: ### No HW ID - assuming WALNUT405
I2C:   ready
HDRAM:  64 MB
Now running in RAM - U-Boot at: 03fcf000
FLASH: 512 kB

*** Warning - bad CRC, using default environment
PCI:   Bus Dev VenId DevId Class Int
PCI Autoconfig: Memory region: [20000000-27ffffff]
PCI Autoconfig: I/O region: [800000-3ffffff]
PCI Scan: Found Bus 0, Device 0, Function 0
PCI Scan: Found Bus 0, Device 7, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000000, address=0x20000000
PCI Autoconfig: BAR 1, I/O, size=0xffffff04, No room in resource
PCI Autoconfig: BAR 2, I/O, size=0x1000000, address=0x1000000
        00  07  1394  0978  0200  1c
In:    serial
Out:   serial
Err:   serial

U-Boot relocated to 03fcf000
IDE:   Bus 0: port = c
OK
   Device 0: Model: SanDisk SDCFB-32 Firm: Vdg 1.23. Ser#: 109907A2203F1542
   Type: Removable Hard Disk
   Capacity: 30.6 MB = 0.0 GB (62720 x 512)
=>
=> bootm 0x100000 0x000         300000

## Booting image at 00100000 ...
   Image Name:   Linux-2.4.18_mvl30-walnut
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    351692 Bytes = 343.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03F9EBE8 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF7E
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFFF80000
flashsize   = 0x00080000
flashoffset = 0x00031000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x001E8480
procfreq    =    133 MHz
plb_busfreq = 66.500 MHz
pci_busfreq = 33.250 MHz
ethaddr     = 00:00:E0:18:94:38
IP addr     = 0.192.168.0
baudrate    =   9600 bps

## Loading RAMDisk Image at 00300000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1476478 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

## initrd at 0x00300040 ... 0x004687BD (len=1476478=0x16877E)
   Loading Ramdisk to 03e35000, end 03f9d77e ... OK
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.18_mvl30-walnut (root@hhl) (gcc version 3.2.1 20020930
(MontaVista)) #35 Fri Apr 4 18:37:14 EST 2003
<6>IBM Sycamore (IBM405GPr) Platform
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.

Kernel command line: root=/dev/ram rw ramdisk_size=4096 console=ttyS0,9600n8
console=tty0  ip=192.168.2.176:192.168.2.190:192.168.2.79:255.2

Calibrating delay loop... 132.71 BogoMIPS
Memory: 62156k available (600k kernel code, 264k data, 36k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
OCP uart ver 1.2 init complete
Starting kswapd
Disabling the Out Of Memory Killer
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 1) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Tracer: Initialization complete
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1441k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 36k init
.É
9Há.6ùñ.ùá).Æ)!).!)!ñ..ÆÉ..áÉñ9.æÉá.Æ).éÉñá.ñÖ...Ñ1.ùñ1É9Ñ.6ù..)!Ñ..!!.)...æ
3HéÉáÉ.æ...!)!.&É...ù!ù


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
