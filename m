To: linuxppc-embedded@lists.linuxppc.org
Subject: mpc823e usb most mode - once again
Message-ID: <1022828348.3cf71f3c36575@imp.imms.de>
Date: Fri, 31 May 2002 08:59:08 +0200 (MEST)
From: Christian Schroeder <christian.schroeder@imms.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I try to play once again with the usb host code for the mpc823e.

1. I collected some information from the Internet and the linuxppc-
    embedded mailing list.

2. I downloaded Brad Parkers new usb hci driver (rev. 2) from heeltoe.com
   and integrated it in the kernel sorces (2.4.4) from ftp.denx.de

3. I did some modifications specific to the TQM823L board (mpc823e chip
   revision B2)
   - #define USE_TIMER1_FOR_SOF
   - #define USE_PA4_CLK4
   - #undef POLL_FOR_HUB

4. I loaded the IIC/SPI microcode patch from Brads distribution and
   connected the timer1 output to /dreq1 to enable the patch. I tried
   the microcode patch, which is contained in Wolfgang Denks kernel
   source, too - with the same results.

5. I didn't insert delay gates between the USBXRM/USBXRP inputs of the
    mpc823 and the VM/VP outputs of the PDIUSB11A usb transceiver. I know,
    that the mpc850 needs theese delay gates, but I use the latest release
    of the mpc823e (PPC823EZTnnB2) and there's no hint in the errata.

6.   I tested some devices and got the following results:

6.1. Booting with no device connected

PPCBoot 1.1.5 (May 28 2002 - 10:23:33)

CPU:   PPC823EZTnnB2 at 50 MHz: 16 kB I-Cache 8 kB D-Cache
Board: TQM823LDB0A3.200
DRAM:  16 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
PCMCIA:   No Card found
Hit any key to stop autoboot:  0
ARP broadcast 1
TFTP from server 194.95.133.21; our IP address is 194.95.133.100
Filename '/bdi2000/pImage-tq'.
Load address: 0x100000
Loading: #################################################################
         ################################################
done
Bytes transferred = 578280 (8d2e8 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.4
   Created:      2002-05-30  12:58:54 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    578216 Bytes = 564 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 40100000 ...
   Image Name:   LinuxPPC Ramdisk Image
   Created:      2001-03-19   8:29:39 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1999700 Bytes = 1952 kB = 1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00dc7000, end 00faf354 ... OK
Linux version 2.4.4 (root@thor) (gcc version 2.95.2 19991024 (release)) #2 Thu May 30 14:57:53 CEST 2002
USB uCode patch installed
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw init=/sbin/init ip=194.95.133.100:194.95.133.21:194.95.133.126:255.255.255.128 ram
disk_size=8192
Decrementer Frequency: 3125000
Calibrating delay loop... 49.86 BogoMIPS
Memory: 12516k available (1092k kernel code, 456k data, 56k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG2
pty: 256 Unix98 ptys configured
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at 40000000
Registered flash device /dev/flasha (minor 0, 4 partitions)
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at 40400000
Registered flash device /dev/flashb (minor 8, 2 partitions)
block: queued sectors max/low 8224kB/2741kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
No card in slot B: PIPR=ff00ff00
eth0: CPM ENET Version 0.2 on SCC2, 00:d0:93:00:03:c6
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1952k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
m8xxhci: initializing controller
m8xxhci_setup()
usb.c: new USB bus registered, assigned bus number 1
m8xxhci_start_controller()
m8xxhci: MPC823e (mask 1)
m8xxhci: USING CLK4 for USB clock!
m8xxhci: ring sizes: rx 32, tx 40
m8xxhci: enable USB controller
m8xxhci_timer_setup()
m8xxhci: timer, intfreq 50, busfreq 50, count 3125
m8xxhci: USING TIMER1 FOR SOF!
m8xxhci: timer1 started
m8xxhci: usb bus is NOT idle
hub.c: USB hub found
hub.c: 1 port detected
rh_submit_urb() int pipe
rh_port_power(1)
m8xxhci: initializing done
usb.c: registered new driver usb_mouse
usb.c: registered new driver keyboard
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 56k init
#

6.2. Connecting a cherry usb keybord (5 port hub integrated)

# (connect)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: USB new device connect on bus1/1/4, assigned device number 3
input0: USB HIDBP Keyboard 046a:0001 on on usb1:3.0
# (disconnect)
usb.c: USB disconnect on device 2
usb.c: USB disconnect on device 3
rh_port_enable(0)

6.3. Connecting a Thunderbird 4-port usb hub

# (connect)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device not responding, giving up (error=-110)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 3
hub.c: USB hub found
hub.c: 4 ports detected
# (disconnect)
usb.c: USB disconnect on device 3
rh_port_enable(0)

6.4. Connecting a simple usb mouse

# (connect)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
rh_port_enable(0)
#
(Disconnecting the mouse, the usb bus remains silent)

6.5. Connecting the mouse to the Thunderbird hub and then
       connecting the hub to the mpc823

# (connect)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device not responding, giving up (error=-110)
rh_port_reset(1)
hub.c: USB new device connect on bus1/1, assigned device number 3
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: get_port_status failed (err = -110)
hub.c: get_port_status failed (err = -110)
hub.c: get_port_status failed (err = -110)
hub.c: get_port_status failed (err = -110)
hub.c: get_hub_status failed
hub.c: get_port_status(1) failed (err = -110)
hub.c: get_port_status(1) failed (err = -110)
hub.c: USB new device connect on bus1/1/1, assigned device number 4
input0: Cypress Sem. Cypress USB Mouse on usb1:4.0
hub.c: get_port_status failed (err = -110)
hub.c: get_port_status failed (err = -110)
hub.c: get_port_status failed (err = -110)
hub.c: get_hub_status failed
hub.c: get_port_status failed (err = -110)
hub.c: get_port_status failed (err = -110)
hub.c: get_hub_status failed
#

Conclusions and questions:

Obviously my mpc823e detects only high speed devices correctly.
This is a known behaviour of the mpc850, but i thought, that the
mpc823 also can work with low speed devices. Did anyone notice
this behaviour too ???

What about the error (-110) connecting the Thunderbird hub ???
Sometimes the hub is detected, sometimes not. A mouse, con-
nected to one of the slave ports of the Thunderbird hub is detected
only sometimes and everytime with errors.
Now, I'm not sure if the USB driver works correctly or not anf if
I need to insert the delay gates or not ... ??? What can I do to
make  driver  more stable ????

I could never receive a character from the usb keyboard, althoug
it was detected correctly everytime. Is there a simple test program,
to check if a usb device in not only detected correctly, but can ex-
change data with the usb host ???

any help would be greatly appreciated.

Christian Schroeder


Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
www:     http://www.imms.de/~christi/cs.html
pgp:     finger christi@finger.imms.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
