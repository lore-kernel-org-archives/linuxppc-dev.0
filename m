Message-ID: <159C486347C8D3119B1D005004A4694002E7F3ED@OLIVE>
From: Abdul Basit <Abdul@raritan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mtd/fsload.jffs2/ramdisk [ problems ]
Date: Tue, 25 Nov 2003 13:49:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

 I want to boot the ramdisk off the flash and having various problems in
this regards (the kernel is booting
off the flash just fine though].....

First way, When i tried to boot ramdisk off the flash by jffs2 partition,  I
am having a problem, The problem
is when i try to read my rootimage from flash/jffs2 partition the uboot
claims "Bad Data CRC" at verify
checksum .... I copy over the rootimage to flash by means of simply mounting
the jffs2 parition
[ /dev/mtdblock3 in my case] and cp the image to it. Now this ramdisk image
isn't corrupt, as
i verify booting the same image by means of tftp and the uboot doesn't claim
any "Bad Data CRC" this time.
and ofcourse this image is in u-boot format (made using mkImage with -T
ramdisk). and a ls in uboot prompt
shows files on jffs2 partition just fine. So can anyone please give me some
hint of what could be wrong ?

Second way, i copied over the raw uboot format ramdisk to /dev/mtd2 by just
dd if=/pRoot of=/dev/mtd2
and gave the start address of mtd2 FE100000 to bootm command , it loads
ramdisk in memory
but kernel was unable to find rootdisk start, here is the dump.
the Uboot enviroment variables are

bootargs=root=/dev/ram rw ramdisk_size=16384 mem=112M
bootcmd=bootm FE040000 FE100000

Uboot> boot
## Booting image at fe040000 ...
   Image Name:   Linux-2.4.4
   Created:      2003-11-24  21:57:05 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    574327 Bytes = 560.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at fe100000 ...
   Image Name:   Basit ramdisk Image
   Created:      2003-11-25   0:59:38 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    4660881 Bytes =  4.4 MB
   Load Address: fe100000
   Entry Point:  fe100000
   Verifying Checksum ... OK
   Loading Ramdisk to 07abd000, end 07f2ee91 ... OK

But after booting , kernel crashed.
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 4551k freed
kernel BUG at page_alloc.c:77!
Oops: Exception in kernel mode, sig: 4
NIP: C002D6FC XER: 0000005F LR: C002D6FC SP: C01CFC50 REGS: c01cfba0 TRAP:
0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01ce000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C002D6FC C01CFC50 C01CE000 0000001F 00001032 00000001 0000001F
C04F5160
GPR08: F0000110 00000000 C01B31E4 C01CFBA0 00000001 100199D0 07FE3000
007FFF3F
GPR16: 00000000 00000400 00000100 00000000 00000000 C01CFE88 000001FA
C01CFD48
GPR24: C0141250 00000000 C0160000 00000000 F0F0F0F1 C0160000 C7F2EE91
C0489A50
Call backtrace:
C002D6FC C002E2AC C002E2EC C000CC1C C009CC00 C0155884 C0155994
C0153F14 C014F78C C014F830 C0003970 C0006454
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..

Can any one help or provide some documentation pointers (i find a topic in
DENX Linux/ELDK guide though
but its not enough human for me ;-) , i need to find doc that describes how
to setup initrd with Uboot
say what we should pass to initrd=XXX kernel argument , the filename ? if
the filename from where U-boot
load it ? jffs2? how we specify ? ).

Thanks.
Basit

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
