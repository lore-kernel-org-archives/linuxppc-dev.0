Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AD1B33D.439A45D2@enst.fr>
Date: Mon, 09 Apr 2001 15:03:57 +0200
From: Stefan Nunninger <stefan.nunninger@enst.fr>
Reply-To: nunninger@web.de
MIME-Version: 1.0
To: linuxppc-embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: How to debug ethernet
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I got problems to get the ethernet working on my board with
Montavista
linux 2.2.14. As I'm using a custom board with a MPC860 I adjusted
the ethernet driver to reflect the configuration of my board.

To do so I changed the file /arch/ppc/8xx_io/commproc.h  the values
for
ethernet (SCC1) as follows:

#define PA_ENET_RXD	((ushort)0x0001)      /* Pin 15 Port A */
#define PA_ENET_TXD	((ushort)0x0002)      /* Pin 14 Port A */
#define PA_ENET_TCLK	((ushort)0x0200)      /* Pin  6 Port A */
#define PA_ENET_RCLK	((ushort)0x0100)      /* Pin  7 Port A */
#define PB_ENET_TENA	((ushort)0x00001000)  /* Pin 19 Port B */
#define PC_ENET_CLSN	((ushort)0x0010)      /* Pin 11 Port C */
#define PC_ENET_RENA	((ushort)0x0020)      /* Pin 10 Port C */

In the file /arch/ppc/8xx_io/enet.c a changement was necessary
as well a my TENA signal uses port B instead of port C.

Now I see the receive LED on the ethernet card flashing when
connected to
a hub. Also while booting the kernel sends some
RARP messages (transmit LED flashes as well). There is an answer
from my
BOOTP server. However my card seems not to react to this. Thus I get
the impression my kernel is not able to receive the packets
properly.

I dumped the packets that go over the cable using tcpdump.
My server is 137.194.161.13 called paris
the card is  aa:00:05:c2:a0:16 or 137.194.161.22 called paris2

using tcpdump
14:39:42.748407 B rarp who-is 137.194.161.22 tell 137.194.161.22
14:39:42.748423 > rarp reply 137.194.161.22 at 137.194.161.22

using tcpdump -n (numeric output)
14:39:33.521500 > 137.194.161.13.bootps > 255.255.255.255.bootpc:
xid:0x9c99997b secs:13 Y:137.194.161.22 S:137.194.161.13 ether
137.194.161.22 [|bootp] (ttl 64, id 44655)
14:39:42.731635 > 137.194.161.13.bootps > 255.255.255.255.bootpc:
xid:0x9c99997b secs:22 Y:137.194.161.22 S:137.194.161.13 ether
137.194.161.22 [|bootp] (ttl 64, id 44656)

The logfile on the DHCP server contains these messages:
Apr  9 14:30:38 paris dhcpd: BOOTREQUEST from aa:00:05:c2:a0:16 via
eth0
Apr  9 14:30:38 paris dhcpd: BOOTREPLY for 137.194.161.22 to
paris2.enst.fr (aa:00:05:c2:a0:16) via eth0
Apr  9 14:30:47 paris dhcpd: BOOTREQUEST from aa:00:05:c2:a0:16 via
eth0
Apr  9 14:30:47 paris dhcpd: BOOTREPLY for 137.194.161.22 to
paris2.enst.fr (aa:00:05:c2:a0:16) via eth0
Apr  9 14:30:58 paris dhcpd: BOOTREQUEST from aa:00:05:c2:a0:16 via
eth0
Apr  9 14:30:58 paris dhcpd: BOOTREPLY for 137.194.161.22 to
paris2.enst.fr (aa:00:05:c2:a0:16) via eth0

At the moment I have no idea how to figure out whats wrong.
Please, could anybody suggest what might be worth trying.

Thanks a lot
	Stefan


For the case that it is important I attach the kernel output
during booting.
--------------------------------------------------------
 decomp : ZIMAGE_OFFSET: 0001C1F0
INITRD_OFFSET: 00000000
INITRD_SIZE: 00000000
memory end_avail = 01000000
 loaded at:     00550000 005505FC
 board data at: 005501C4 005501F0
 relocated to:  00540100 0054012C
ZIMAGE_OFFSET: 0001C1F0
ZIMAGE_SIZE : 00060FB9
zimage_start : 0055C1F0
zimage_size : 00060FB9
 initrd_start : 00000000
 initrd_end   : 00000000
 zimage at:     0055C1F0 005BD1A9
 avail ram:     005BE000 01000000

Linux/PPC load:
Uncompressing Linux...
Gunzip ...
 Dest address   : 00000000
 Dest length    : 00200000
 Source address : 0055C1F0

 zip flags look ok
inflateInit2 returned OK
Calling inflate
Inflate returned OK
done.
Now booting the kernel
 mem_initialize, mp   : FA200100
 mem_initialize, mp->memc_mdr : FFFFFC04
 mem_initialize, mp->memc_br0 : FFF00401
 mem_initialize : done !
m8xx_setup.c::m8xx_init
commandline = root=/dev/nfs rw
Linux version 2.2.14 (stefan@paris.enst.fr) (gcc version 2.95.2
19991030 (2.95.1m8xx_setup.c::m8xx_setup_arch
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 120000000/60
Calibrating delay loop... 31.74 BogoMIPS
Memory: 15112k available (772k kernel code, 460k data, 40k init)
[c0000000,c100]Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
main.c::do_basic_setup
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
kswapd_setup
Starting kswapd v 1.5
start initialising the ram disk
initrd_start = 0
root_mountflags 0
mount_initrd = 0
device_setup
chr_dev_init
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
blk_dev_init
ll_rw_blk.c::blk_dev_init
harsect_size = c00fe3f8
blksize_size = c00fe438
blk_size     = c00fe478
RAM disk driver initialized:  16 RAM disks of 4096K size
loop.c::loop_init
loop: registered device at major 7
sti
passed behind sti
net_dev_init
eth0: CPM ENET Version 0.2, aa:00:05:c2:a0:16
Sending BOOTP and RARP requests...Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
.Send BOOTP packed
. timed out!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
