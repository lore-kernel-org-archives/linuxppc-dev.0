Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C671DDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 22:30:39 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m38CUYLr020914
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 14:30:34 +0200
Message-ID: <10fd01c89974$57a0c830$f52f9e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W><fa686aa40804072055i1f7036afn4d453e968cc625d6@mail.gmail.com>
	<10d401c8995a$1a63beb0$f52f9e86@LPSC0173W>
Subject: Re: Booting a Xilinx board
Date: Tue, 8 Apr 2008 14:30:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm making progress, thanks in no small part to this list, but I still need 
coaching, if you don't mind. The current boot is currently going as such:


loaded at:     00400000 005A819C
board data at: 005A6120 005A619C
relocated to:  00404054 004040D0
zimage at:     00404E40 00515AD1
initrd at:     00516000 005A5AF9
avail ram:     005A9000 08000000

Linux/PPC load: console=ttyUL0,9600 root=/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.24-rc8-xlnx (guinevere@lpsc6185x.in2p3.fr)
(gcc version 4.1.2) #4 Tue Apr 8 13:41:02 CEST 2008
[    0.000000] Xilinx Generic PowerPC board support package (Xilinx ML405)
(Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    32768
[    0.000000]   Normal      32768 ->    32768
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 32512
[    0.000000] Kernel command line: console=ttyUL0,9600 root=/dev/ram rw
[    0.000000] Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000224] Console: colour dummy device 80x25
[    0.001417] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.003197] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.039286] Memory: 126804k available (1728k kernel code, 572k data, 104k
init, 0k highmem)
[    0.132784] Mount-cache hash table entries: 512
[    0.138698] net_namespace: 64 bytes
[    0.143763] NET: Registered protocol family 16
[    0.147717] Registering device uartlite:0
[    0.148883] Registering device xsysace:0
[    0.149913] Registering device xilinx_emaclite:0
[    0.191001] NET: Registered protocol family 2
[    0.224934] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.228161] TCP established hash table entries: 4096 (order: 3, 32768
bytes)
[    0.228808] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.229168] TCP: Hash tables configured (established 4096 bind 4096)
[    0.229201] TCP reno registered
[    0.241592] checking if image is initramfs...it isn't (no cpio magic);
looks like an initrd
[    0.854687] Freeing initrd memory: 574k freed
[    0.855157] sysctl table check failed: /kernel/l2cr .1.31 Missing
strategy
[    0.855208] Call Trace:
[    0.855227] [c7c17eb0] [c00081b8] show_stack+0x50/0x184 (unreliable)
[    0.855329] [c7c17ed0] [c0030514] set_fail+0x50/0x68
[    0.855406] [c7c17ef0] [c0030b7c] sysctl_check_table+0x650/0x698
[    0.855454] [c7c17f20] [c0030b8c] sysctl_check_table+0x660/0x698
[    0.855501] [c7c17f50] [c001e874] register_sysctl_table+0x64/0xb4
[    0.855567] [c7c17f70] [c0231c24] register_ppc_htab_sysctl+0x18/0x2c
[    0.855629] [c7c17f80] [c022b1e4] kernel_init+0xc8/0x284
[    0.855667] [c7c17ff0] [c0004b18] kernel_thread+0x44/0x60
[    0.864221] io scheduler noop registered
[    0.864277] io scheduler anticipatory registered (default)
[    0.864302] io scheduler deadline registered
[    0.864525] io scheduler cfq registered
[    0.939088] uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 2) is a uartlite
[    0.939174] console [ttyUL0] enabled
[    3.953024] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024
blocksize
[    4.036331] loop: module loaded
[    4.067349] xsysace xsa: Xilinx SystemACE revision 1.0.12
[    4.131096] xsysace xsa: capacity: 1014048 sectors
[    4.186902]  xsa: xsa1 xsa2
[    4.222849] Xilinx SystemACE device driver, major=254
[    4.280365] tun: Universal TUN/TAP device driver, 1.6
[    4.340667] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.416748] xilinx_emaclite xilinx_emaclite.0: MAC address is now  2: 0:
0: 0: 0: 0
[    4.506421] xilinx_emaclite xilinx_emaclite.0: using fifo mode.
[    4.580452] xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at
0x81000000 mapped to 0xC9020000, irq=0
[    4.691953] mice: PS/2 mouse device common for all mice
[    4.753483] TCP cubic registered
[    4.791772] NET: Registered protocol family 1
[    4.843849] NET: Registered protocol family 17
[    4.897987] RPC: Registered udp transport module.
[    4.953147] RPC: Registered tcp transport module.
[    5.011138] RAMDISK: Compressed image found at block 0
[    5.905538] VFS: Mounted root (ext2 filesystem).
[    5.945703] Freeing unused kernel memormdev: /etc/mdev.conf: No such file
or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mdev: /etc/mdev.conf: No such file or directory
mount: mounting configfs on /config failed: No such device
Initializing random number generator... done.
Starting network...
ip: RTNETLINK answers: File exists


And then it stops, although I still have echo when I type.
Now there's no /etc/mdev.conf file in my root fylesystem and I understand I 
need to create the devices.
I've been reading docs/mdev.txt and 
http://www.lfs-matrix.org/clfs/view/clfs-embedded/mips/bootscripts/mdev.html 
and I'm a bit confused.

- do the devices need to be created in the FS before building the ramdisk 
and subsequent ACE file ?

- are they created dynamically by /bin/mdev on boot based on a manually 
written /etc/mdev.conf table as the error messages seem to imply ?

- can they be generated automagically by a MAKEDEV script ?

In the second case, how do I know which devices and what names I'm supposed 
to define ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/Climbing/
