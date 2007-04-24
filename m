Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78D2BDDF57
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 23:42:16 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HgLHZ-0004ml-E3
	for linuxppc-embedded@ozlabs.org; Tue, 24 Apr 2007 06:42:13 -0700
Message-ID: <10161229.post@talk.nabble.com>
Date: Tue, 24 Apr 2007 06:42:13 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <528646bc0704231035g6a1ac904wc6b9b7b77afd1037@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<528646bc0704231035g6a1ac904wc6b9b7b77afd1037@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks for the suggestions. I have changed the command line argument:
console:ttl0 -> ttyUL0 and kernel has booted up to the point to mount the
root file system.

I have set up the kernel to mount the root file systems via the nfs. I have
started the nfs server on the remote pc.
Unfortunately the kernel did not mount the nfs root file system. The strange
thing is that during booting the kernel I did not see any entry which refers
to the TEMAC driver (which I have enabled in the kernel). 

I have noticed that in the drivers/net/xilinx_temac directory there is a
file xtemac_g.c. It creates the global variable (a table) which contains all
fo the definitions to configure TEMAC interface. All of the definitions used
in the xtemac_g.c file come from xparameters_ml403.h. The strange thing is
that this xtemac_g.c is not include in the Makefile to be compiled. 

I have incluede that file to the Makefile in order to use the TEMAC config
parameters but when booting the kernel I did not find any diffrence
compering to the driver which was originaly built without the xtemac_g.c

The kernel boots as following:

loaded at:     00400000 004F9138
board data at: 004F7120 004F7138
relocated to:  004040B8 004040D0
zimage at:     00404E45 004F6D1F
avail ram:     004FA000 04000000

Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw
nfsroot=129.129.130.106:/opt/eldk41/ppc_4xx,tcp
ip=129.129.129.29:255.255.255.0:LM200:eth0:off panic=1

Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.21-rc6-gd4bba4bf-dirty (root@pc5215) (gcc
version 4.0.2) #8 Tue Apr 24 14:51:35 CEST 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists.  Total pages: 16256
[    0.000000] Kernel command line: console=ttyUL0,9600 root=/dev/nfs rw
nfsroot=129.129.130.106:/opt/eldk41/ppc_4xx,tcp
ip=129.129.129.29:255.255.255.0:LM200:eth0:off panic=1
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000418] Console: colour dummy device 80x25
[    0.001487] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.003212] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.034378] Memory: 62720k available (1568k kernel code, 512k data, 96k
init, 0k highmem)
[    0.121194] Mount-cache hash table entries: 512
[    0.129484] NET: Registered protocol family 16
[    0.162553] NET: Registered protocol family 2
[    0.196706] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.197898] TCP established hash table entries: 2048 (order: 2, 16384
bytes)
[    0.198605] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.199040] TCP: Hash tables configured (established 2048 bind 2048)
[    0.199126] TCP reno registered
[    0.219619] io scheduler noop registered
[    0.219727] io scheduler anticipatory registered (default)
[    0.219807] io scheduler deadline registered
[    0.220367] io scheduler cfq registered
[    0.321949] uartlite.0: ttyUL0 at MMIO 0x40600003 (irq = 0) is a uartlite
[    2.254924] RAMDISK driver initialized: 1 RAM disks of 8192K size 1024
blocksize
[    2.346633] tun: Universal TUN/TAP device driver, 1.6
[    2.407407] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.485482] mice: PS/2 mouse device common for all mice
[    2.548404] TCP cubic registered
[    2.587334] NET: Registered protocol family 1
[    2.639671] NET: Registered protocol family 17
[    3.197934] IP-Config: No network devices available.
[    3.259979] Looking up port of RPC 100003/2 on 129.129.130.106
[    3.331237] Root-NFS: Unable to get nfsd port number from server, using
default
[    3.419194] Looking up port of RPC 100005/1 on 129.129.130.106
[    3.490204] Root-NFS: Unable to get mountd port number from server, using
default
[    3.581337] Root-NFS: Server returned error -5 while mounting
/opt/eldk41/ppc_4xx
[    3.671568] VFS: Unable to mount root fs via NFS, trying floppy.
[    3.747080] VFS: Cannot open root device "nfs" or unknown-block(2,0)
[    3.823496] Please append a correct "root=" boot option
[    3.886242] Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
[    3.985551] Rebooting in 1 seconds..<NULL>



Would you have any idea why it did not recognise the TEMAC interface and how
to configure the kernel that it recognises the network device.

Mirek

-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10161229
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
