Date: Thu, 22 Mar 2001 13:02:41 -0500 (EST)
From: "Todd M. Tomaino" <ttomaino@coe.neu.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: NTSC Video on the 823
Message-ID: <Pine.SV4.4.10.10103221257340.26535-100000@Radians.coe.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm currently using MontaVista CDK 1.2 w/ 2.2.14

I followed the readme instructions for adding the VideoTest.c and Vid823.c
files with the following header comments:

+ * Started with Dan's LCD code, created NTSC Video Driver (4/2000)
+ * Chuck Spaur (chuck@spaur.com)
+ *
+ * Proof of concept LCD driver for the 823.
+ * Grab some memory, initialize the controller, allow mmap()'ed access
+ * to the frame buffer.
+ * Dan Malek (dmalek@jlc.net)

I'm getting a kernel panic when I try to run VideoTest.c .  I have added
"mknod /dev/videoiic c 80 84" and "mknod /dev/vid c 63 0".  The hardware
is not the original Embedded Planet Video board, however I'm using the
ADV7176 IC and the control signals for Video reset and Video clock enable
are located at the same BCSR addresses as on the HIOX (FAC0000, bits 6 and
7).  I have the ALSB pin tied low, so the I2C address is 54h.  I have
included a screen dump below, and the line of code where things appear to
go haywire.  If anyone has any suggestions I would greatly appreciate it.

best regards,
Todd



NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
IIC driver version 1.0 Mar 17 2001, 06:07:58
buffer 1 physical address = 0xfa4000, virtual = 0xc0fa4000
buffer 2 physical address = 0xfa5f40, virtual = 0xc0fa5f40
memaddr = 0xc0fa4000
bd1 = 0xfa2028b0, buff 1 = 0xfa4000, status = 0x1000
bd2 = 0xfa2028b8, buff 2 = 0xfa5f40, status = 0x3000
SPMODE = 0x1570
SPI driver version 1.0 Mar 17 2001, 06:08:01

Loading NTSC Video Driver.......Mar 21 2001,02:46:01
VidClock OFF...
VidReset On...
VidReset OFF...
Video Initialzied
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:10:ec:00:10:fe
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of
California

PPP line discipline registered.
Sending BOOTP requests..... OK
IP-Config: Got BOOTP answer from 192.168.1.103, my address is
192.168.1.110
Looking up port of RPC 100003/2 on 192.168.1.103
Looking up port of RPC 100005/1 on 192.168.1.103
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 52k init
INIT: version 2.77 booting
INIT: Entering runlevel: 3
sh-2.03# ./Video


Initializing initVideo...
made it to here !!!
Open error -19
NIP: C00C9E9C XER: E000227F LR: C00C9E90 REGS: c0ce1d50 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0ce0000[17] 'Video' mm->pgd c0ea4000 Last syscall: 5
last math 00000000
GPR00: C00C9E90 C0CE1E00 C0CE0000 00000000 00000001 0000000F 00000001
C0FD8C20
GPR08: C0104AD2 C0100000 0000000F C0CE1D30 55F33F33 1001988C 100B23D0
00000000
GPR16: 100B2470 00411081 60000810 00000000 00009032 00CE1E80 00000000
C000253C
GPR24: C000227C 100B2470 10001330 C0CE9340 00000000 00000000 00000001
00000000
Call backtrace:
C00C9E90 C00265E4 C0024E9C C002510C C00022D0 10000CC0 1000092C
0FF094F8 00000000
Kernel panic: kernel access of bad area pc c00c9e9c lr c00c9e90 address 8
tsk Video/17
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
exit(2);




void initVideo(IMAGEINFO *p_image)
{
	int	num_pages, i, j;
	u_char	*fbuf, *cp;
	printf("made it to here !!!\n");
=====>>>if ((p_image->display_fd = open("/dev/vid", O_RDWR)) < 0) {
		perror("video open");
		exit(2);


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
