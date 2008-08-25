Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BA0F5DE6DD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 00:38:34 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KXdDC-000248-GY
	for linuxppc-embedded@ozlabs.org; Mon, 25 Aug 2008 07:38:30 -0700
Message-ID: <19145094.post@talk.nabble.com>
Date: Mon, 25 Aug 2008 07:38:30 -0700 (PDT)
From: hsongjiang <hsongjiang@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: ml403  u-boot can't load linux with nfs
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi all:
   now i want to use u-boot load linux with avnet minimodule(like ml403 or
ml405) and EDK 10.1 .
   
  after compliling  the  kernel, i use xmd down zImage.elf (nfs root),it
success
like this:
/////////////////////////////////////////////////////////////////////////
loaded at:     00400000 005501A0
board data at: 0054E124 0054E1A0
relocated to:  004050B4 00405130
zimage at:     00405EE9 0054D16F
avail ram:     00551000 04000000

Linux/PPC load: console=ttyS0,38400
ip=192.168.0.3:192.168.0.5:192.168.0.1:255.255.255.0 rw root=/dev/nfs
nfsroot=192.168.0.5:/myrootfs init=/bin/sh

 Kernel command line: console=ttyS0,38400 root=/dev/nfs rw
nfsroot=192.168.0.5:/myrootfs
ip=192.168.0.3:192.168.0.5:192.168.0.1:255.255.255.0 init=/bin/sh

Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.26 (root@ioe) (gcc version 4.1.1) #13
PREEMPT Sat Aug 23 17:02:29 CST 2008
[    0.000000] Xilinx Generic PowerPC board support package (Xilinx ML405)
(Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
   ......
[    0.000000] Kernel command line: console=ttyS0,38400
ip=192.168.0.3:192.168.0.5:192.168.0.1:255.255.255.0 rw root=/dev/nfs
nfsroot=192.168.0.5:/myrootfs init=/bin/sh
[    0.000000] Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFE000
......
[   15.894120] eth0: XLlTemac: We renegotiated the speed to: 100
[   15.921479] eth0: XLlTemac: speed set to 100Mb/s
[   15.935472] eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
[   15.955208] eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound =
254
[   16.979388] IP-Config: Complete:
[   16.988691]      device=eth0, addr=192.168.0.3, mask=255.255.255.0,
gw=192.168.0.1,
[   17.011779]      host=192.168.0.3, domain=, nis-domain=(none),
[   17.029405]      bootserver=192.168.0.5, rootserver=192.168.0.5,
rootpath=
[   17.051293] Looking up port of RPC 100003/2 on 192.168.0.5
[   17.078738] Looking up port of RPC 100005/1 on 192.168.0.5
[   17.150065] VFS: Mounted root (nfs filesystem).
[   17.164245] Freeing unused kernel memory: 96k init
# 
/////////////////////////////////////////////////////////////////////////
   but when i use u-boot load,it die.
///////////////////////////////////////////////////////////////////////
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.26
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1339912 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
[    0.000000] Linux version 2.6.26 (root@ioe) (gcc version 4.1.1) #14
PREEMPT Sat Aug 23 20:53:05 CST 2008
[    0.000000] Xilinx Generic PowerPC board support package (Xilinx ML405)
(Virtex-4 FX)
[    0.000000] Kernel command line: root=/dev/nfs console=ttyS0,38400
ip=192.168.0.3:192.168.0.5:192.168.0.1:255.255.255.0 rw
nfsroot=192.168.0.5:/myrootfs init=/bin/sh
[    0.000000] Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 128 (order: 7, 512 bytes)

[    1.234613] mice: PS/2 mouse device common for all mice
[    1.255086] TCP cubic registered
[    1.264907] NET: Registered protocol family 17
[    1.279754] RPC: Registered udp transport module.
[    1.294061] RPC: Registered tcp transport module.
[    1.817329] eth0: XLlTemac: Options: 0x3fa
[    1.829839] eth0: XLlTemac: allocating interrupt 0 for dma mode tx.
[    1.848830] eth0: XLlTemac: allocating interrupt 1 for dma mode rx.
[   13.840446] eth0: XLlTemac: Not able to set the speed to 1000 (status:
0x7949)
[   15.858277] eth0: XLlTemac: We renegotiated the speed to: 100
[   15.885639] eth0: XLlTemac: speed set to 100Mb/s
[   15.899634] eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
[   15.919370] eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound =
254
[   16.943365] IP-Config: Complete:
[   16.952670]      device=eth0, addr=192.168.0.3, mask=255.255.255.0,
gw=192.168.0.1,
[   16.975732]      host=192.168.0.3, domain=, nis-domain=(none),
[   16.993359]      bootserver=192.168.0.5, rootserver=192.168.0.5,
rootpath=
[   17.015238] Looking up port of RPC 100003/2 on 192.168.0.5
[   17.055939] Looking up port of RPC 100005/1 on 192.168.0.5
[   17.230661] VFS: Mounted root (nfs filesystem).
[   17.244815] Freeing unused kernel memory: 96k init
[   17.338452] ------------[ cut here ]------------
[   17.352390] Badness at kernel/mutex.c:134
[   17.364431] NIP: c021bd20 LR: c021bd08 CTR: c00e0794


  I find they are the same process except [   17.338452] ----[ cut here ]--
so i trace the code.and find
run_init_process("/bin/sh")->kernel_execve(),here may be the proplem. but i
am not sure.
   any suggestion will be very appreciated.thank you!
                         
                                                               hsongjiang 
-- 
View this message in context: http://www.nabble.com/ml403--u-boot-can%27t-load-linux-with-nfs-tp19145094p19145094.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
