Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6CE5@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: USB on MPC823 FADS board
Date: Tue, 6 Nov 2001 18:45:31 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I get m8xxhci.c last release form Brad Parker's page
http://www.heeltoe.com/usb/ppc <http://www.heeltoe.com/usb/ppc>  and I have
modificated to use on the MPC823 FADS board. This drivers has also Roman
Weissgaerber changes.

I have done the following modifications:

1.- At the begin of the file:

#ifdef CONFIG_FADS
#define POLL_FOR_HUB      /* don't use RXP/RXP, poll with msg */
#define USE_BRG3                /* 48mhz clock via brg3 */
#define USE_TIMER2_FOR_SOF
#endif

2.- In the function  m8xxhci_setup_board_specific

#ifdef CONFIG_FADS

*((volatile uint *)BCSR4) &= ~(BCSR4_USB_EN | BCSR4_USB_VCC0);
*((volatile uint *)BCSR4) |=  BCSR4_USB_SPEED;

#endif /* CONFG_FADS*/

3.-I have loaded the microcode patch.

4.-I put TIMER 2 output (PA4) in the DRQ1 input.

After booting Linux I have the following mesages:

Linux version 2.4.4 (root@ILURI2000) (gcc version 2.95.3 20010315
(release/MontaVista)) #53 mar nov 6 08:58:16 EST 2001
-->USB uCode patch installed
MPC823 LCD memory at C01A2000
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0 root=/dev/ram init=/linuxrc
NR_IRQS=32 NR_SIU_INTS=16 RTL_SOFT_IRQS_FILL=16
Decrementer Frequency: 3000000
Console: colour dummy device 80x25
Calibrating delay loop... 47.82 BogoMIPS
Memory: 5700k available (1104k kernel code, 488k data, 60k init, 0k highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Console: switching to colour frame buffer device 80x30
fb0:  MPC823 LCD frame buffer device
El valor de LCCR es:	0x960153e7
El valor de LCHCR es: 	0x018a0093
El valor de LCVCR es: 	0x200f0021
El valor de LCFAA es: 	0x001a2000
El valor de LCFBA es: 	0x001a2000
El valor de LCSR es: 	0x00000001
El valor de CAR_SCCR es: 	0x02000004
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG2
pty: 256 Unix98 ptys configured
block: queued sectors max/low 3672kB/1224kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 2048K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC2, 08:00:22:50:70:63
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194300k freed
loop: loaded (max 8 devices)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
m8xxhci: initializing controller
m8xxhci_setup()
usb.c: new USB bus registered, assigned bus number 1
m8xxhci_start_controller()
m8xxhci: MPC823e (mask 1)
m8xxhci: USING BRG3 (sysclk) for USB clock!
m8xxhci: ring sizes: rx 32, tx 40
m8xxhci: assert reset
m8xxhci: enable USB controller
m8xxhci_timer_setup()
m8xxhci: timer, intfreq 48, busfreq 48, count 3000
m8xxhci: USING TIMER2 FOR SOF!
m8xxhci: timer2 started
m8xxhci: usb bus is NOT idle
Product: USB MPC8xx Root Hub
SerialNumber: ff000a00
hub.c: USB hub found
hub.c: 1 port detected
rh_submit_urb() int pipe
rh_port_power(1)
m8xxhci: initializing done
usb.c: registered new driver usb_mouse
usb.c: registered new driver keyboard
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
m8xxhci: control thread starting
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 60k init
m8xxhci: assert reset
wait_for_qe(qe=c022a27c) done; urb 00000000, status -110

### Initial RAM disk starting interactive shell ###
BusyBox v0.60.0 (2001.10.05-20:58+0000) Built-in shell (msh)
Enter 'help' for a list of builtm8xxhci: assert reset
-in commands.


m8xxhci: assert reset
wait_for_qe(qe=c022a27c) done; urb 00000000, status -110
m8xxhci: assert reset
wait_for_qe(qe=c022a27c) done; urb 00000000, status -110
m8xxhci: assert reset
wait_for_qe(qe=c022a27c) done; urb 00000000, status -110
m8xxhci: assert reset
wait_for_qe(qe=c022a27c) done; urb 00000000, status -110
.
.
.

This mesages probably appear because I havent 1 KHz signal in PA4. What I am
doing wrong? Why the timer doesn't appear in the PA4 pin?

Also I have readden that MPC850 with the Philips PDIUSB11 transceiver needs
a hardware patch, delay gates between Receive plus/Receive minus and MPC823e
Receive inputs, and the FADS board uses PDIUSB11 transceiver.

I would know if I have to do the hardware patch with the MPC823e and exactly
what is this hardware patch.

Thanks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
