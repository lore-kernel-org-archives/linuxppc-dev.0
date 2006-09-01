Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s26.bay0.hotmail.com (bay0-omc2-s26.bay0.hotmail.com
	[65.54.246.162]) by ozlabs.org (Postfix) with ESMTP id 13D3267B93
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 18:45:22 +1000 (EST)
Message-ID: <BAY110-F33016EC773AB9689A12903B23C0@phx.gbl>
In-Reply-To: <000a01c6cd6e$5e1970a0$800101df@monstertop>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Unable to boot kernel 2.6 from u-boot 1.1.4 in Xilinx ML403
Date: Fri, 01 Sep 2006 08:45:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Aleck,

>1. When I directly download zImage.elf to the RAM and boot from there, I 
see
>the kernel starts booting, but it complains about not being able to mount
>/dev/sysace/disc0/part2 and thus kernel panic happens.
>
>The following is the output
>---------------------------------------------------------------
>loaded at:     00400000 004D313C
>board data at: 004D1124 004D113C
>relocated to:  004050F8 00405110
>zimage at:     0040580D 004D0AA8
>avail ram:     004D4000 04000000
>
>Linux/PPC load: console=ttyS0,9600 ip=off root=/dev/xsysace/disc0/part2 rw
>Uncompressing Linux...done.
>Now booting the kernel
>[    0.000000] Linux version 2.6.17.8 (aleck@sac.gdatech.com) (gcc version
>4.0.0 (DENX ELDK 4.0 4.0.0)) #2 Thu Aug 31 11:49:40 PDT 2006
>[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
>[    0.000000] Built 1 zonelists
>[    0.000000] Kernel command line: console=ttyS0,9600 ip=off
>root=/dev/xsysace/disc0/part2 rw
>[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
>[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
>[    0.000176] Console: colour dummy device 80x25
>[    0.000676] Dentry cache hash table entries: 8192 (order: 3, 32768 
bytes)
>[    0.001452] Inode-cache hash table entries: 4096 (order: 2, 16384 
bytes)
>[    0.015453] Memory: 63104k available (1268k kernel code, 468k data, 80k
>init, 0k highmem)
>[    0.204374] Mount-cache hash table entries: 512
>[    0.209943] NET: Registered protocol family 16
>[    0.218843] NET: Registered protocol family 2
>[    0.264481] IP route cache hash table entries: 512 (order: -1, 2048
>bytes)
>[    0.265267] TCP established hash table entries: 2048 (order: 1, 8192
>bytes)
>[    0.265465] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>[    0.265569] TCP: Hash tables configured (established 2048 bind 1024)
>[    0.265599] TCP reno registered
>[    0.272471] io scheduler noop registered
>[    0.272558] io scheduler anticipatory registered (default)
>[    0.272626] io scheduler deadline registered
>[    0.272759] io scheduler cfq registered
>[    0.318755] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
>sharing disabled
>[    0.323749] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450
>[    2.026296] RAMDISK driver initialized: 16 RAM disks of 65536K size 
1024
>blocksize
>[    2.117598] tun: Universal TUN/TAP device driver, 1.6
>[    2.177338] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>[    2.252474] mice: PS/2 mouse device common for all mice
>[    2.314381] TCP bic registered
>[    2.350802] NET: Registered protocol family 1
>[    2.402825] NET: Registered protocol family 17
>[    2.458051] VFS: Cannot open root device "xsysace/disc0/part2" or
>unknown-block(0,0)
>[    2.549979] Please append a correct "root=" boot option
>[    2.612426] Kernel panic - not syncing: VFS: Unable to mount root fs on
>unknown-block(0,0)
>[    2.711373]  <0>Rebooting in 180 seconds..<NULL>
>-----------------------------------------------------------
>
Try this:
mount the CF card onto your PC and then goto the /dev folder on your
root filesystem in the card. Here run the following commands as root:
# mknod -m 660 console c 5 1
# mknod -m 660 xsa b 254 0
# mknod -m 660 xsa1 b 254 1
# mknod -m 660 xsa2 b 254 2
# mknod -m 660 xsa3 b 254 3
Now there should be a directory tts in your dev. If not create one
"mkdir tts". Then do this in the dev/tts folder,
# mknod -m 660 0 c 4 64

If you don't need CF card at all, the easiest method to solve it is to 
remove it from the linux kernel configuration. 

Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
