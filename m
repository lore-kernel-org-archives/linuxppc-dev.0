From: jonb@marel.is
Subject: Porting to custom MPC823e board
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFA9B0970B.BDAE570B-ON00256959.00516A8B@marel.is>
Date: Wed, 13 Sep 2000 15:42:31 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am working on getting Linux to run on a custom MPC823e board.  I have
little previous
experience with Linux, but I know the MPC823 quite well, since I have
already written the
board support layer for a commercial RTOS for our board.

I have the development tools working on Red Hat Linux 6.2 on a Pentium box.
I started by porting PPCBOOT (version 0.4.1) to our board.  This went
rather smoothly
and I have it working (except for the flash programming part).  I use a BDM
flash programmer
to program the on board flash chips.

The next step is to get the kernel running on our board.  I downloaded
version 2.3.18
of the Linux source tree (from where I can not remember).  I have made good
progress with this,
but there is still something wrong with the ethernet part.  The kernel is
configured to use SCC2
for ethernet.  Our board is in many ways similar to the BSE IP board.
The startup messages are as follows:

==================================
=> bootm 60000000
## Booting Linux kernel at 60000000 ...
   Image Name:   Linux kernel 2.3.18 on V37
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    418792 Bytes = 408 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Calling kernel at address 00000000...
Before lock
After lock
Linux version 2.3.18 (root@linus.marel.is) (gcc version egcs-2.91.66
19990314 (e
gcs-1.1.2 release)) #115 Fim Sep 14 13:58:09 GMT 2000
Boot arguments: root=/dev/nfs rw nfsroot=10.100.1.21:/LinuxPPC
nfsaddrs=10.100.5
0.99:10.100.1.21
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.63 BogoMIPS
Memory: 15000k available (756k kernel code, 588k data, 40k init)
[c0000000,c1000
000]
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (established 1024 bind 2048)
Starting kswapd v1.6
Serial driver version 4.30 with no serial options enabled
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:00:e0:ee:02:6c
PPP generic driver version 2.4.0
RTNL: assertion failed at devinet.c(784):inetdev_event
Looking up port of RPC 100003/2 on 10.100.1.21
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.
portmap: server 10.100.1.21 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.100.1.21
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.
portmap: server 10.100.1.21 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.

==================================


The first sign of trouble seems to be the "RTNL: assertion failed at
devinet.c (784): inetdev_event".
What does this suggest ?
Another sign of trouble is the "Device lo is down" messages I am getting.
Any suggestions on what
can be causing that ?

I have studied arch/ppc/8xx_io/enet.c and commproc.h and the only change I
made compared to the
BSE IP configuration was that I changed SICR_ENET_CLKRT from 0x00002c00 to
be 0x00002e00,
because our board has ETH_TCLK on CLK3 and ETH_RCLK on CLK2.  The other
board specific
setup looks alright to me.  The ethernet transceiver is a Level One
LXT905LC.  What can I be missing
here ?


Thanks in advance,

Jon Benediktsson
Marel hf.
www.marel.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
