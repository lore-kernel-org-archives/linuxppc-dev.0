Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EC1BDDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 22:29:24 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ht0pF-0005ga-1l
	for linuxppc-dev@ozlabs.org; Tue, 29 May 2007 05:29:21 -0700
Message-ID: <10853134.post@talk.nabble.com>
Date: Tue, 29 May 2007 05:29:20 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: jffs2 and Amdflash
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


hi.........
I m using custom board same as MPC8272ADS board.
                                        u-boot is u-boot-1.1.2.
                                        linux-2.6.10
                                        Flash AM29LV641ML
                                        no.of flash chips are 2
I have already tested jffs2 in 2 ways on MPC8272ADS board..........        =
                              =20
1) booted kernel with root as nfs and after that mounted jffs2 using comman=
d
           mount -t jffs2 /dev/mtdblock0 /mnt
           its working fine.
2) with root as jffs2....it is also working fine.

Now i m testing jffs2 on Custom board...
case 1 is working fine but 2nd is not working..

I have enabled DEBUG options in kernel so it is reading correctly as cfi
datas as per datasheet.

here is bootlog for Custom board...
bootlog for case 1
------------------------------------------------

physmap flash device: 1000000 at ff000000
Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
Primary Algorithm Table at 0040
Alternative Vendor Command Set: 0000 (None)
No Alternate Algorithm Table
Vcc Minimum:  2.7 V
Vcc Maximum:  3.6 V
No Vpp line
Typical byte/word write timeout: 128 =C2=B5s
Maximum byte/word write timeout: 256 =C2=B5s
Typical full buffer write timeout: 128 =C2=B5s
Maximum full buffer write timeout: 4096 =C2=B5s
Typical block erase timeout: 1024 ms
Maximum block erase timeout: 16384 ms
Chip erase not supported
 cfip->DevSize=3D0x17
Device size: 0x800000 bytes (8 MiB)
Flash Device Interface description: 0x0001
  - x16-only asynchronous interface
Max. bytes in buffer write: 0x20
Number of Erase Block Regions: 1
  Erase Region #0: BlockSize 0x10000 bytes, 128 blocks
phys_mapped_flash: Found 2 x16 devices at 0x0 in 32-bit bank
Amd/Fujitsu Extended Query Table at 0x0040
Silicon revision: 4
  Address sensitive unlock: Required
  Erase Suspend: Read/write
  Block protection: 4 sectors per group
  Temporary block unprotect: Supported
  Block protect/unprotect scheme: 4
  Number of simultaneous operations: 0
  Burst mode: Not supported
  Page mode: 4 word page
  Vpp Supply Minimum Program/Erase Voltage: 11.5 V
  Vpp Supply Maximum Program/Erase Voltage: 12.5 V
  Top/Bottom Boot Block: Uniform, Bottom WP
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
  cmdlinepart partition parsing not available
  RedBoot partition parsing not available
  num_physmap_partitions=3D0x5
  Using physmap partition definition
Creating 5 MTD partitions on "phys_mapped_flash":
0x00000000-0x00040000 : "HRCW"
0x00040000-0x00e00000 : "User FS"
0x00e00000-0x00f00000 : "uImage"
0x00f00000-0x00f40000 : "bootloader"
0x00f40000-0x00f80000 : "bootloader env"
-------------------------------

bootlog for 2nd case..........
-----------------------------
physmap flash device: 1000000 at ff000000
Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
Primary Algorithm Table at 0040
Alternative Vendor Command Set: 0000 (None)
No Alternate Algorithm Table
Vcc Minimum:  2.7 V
Vcc Maximum:  3.6 V
No Vpp line
Typical byte/word write timeout: 128 =C2=B5s
Maximum byte/word write timeout: 256 =C2=B5s
Typical full buffer write timeout: 128 =C2=B5s
Maximum full buffer write timeout: 4096 =C2=B5s
Typical block erase timeout: 1024 ms
Maximum block erase timeout: 16384 ms
Chip erase not supported
 cfip->DevSize=3D0x17
Device size: 0x800000 bytes (8 MiB)
Flash Device Interface description: 0x0001
  - x16-only asynchronous interface
Max. bytes in buffer write: 0x20
Number of Erase Block Regions: 1
  Erase Region #0: BlockSize 0x10000 bytes, 128 blocks
phys_mapped_flash: Found 2 x16 devices at 0x0 in 32-bit bank
Amd/Fujitsu Extended Query Table at 0x0040
Silicon revision: 4
  Address sensitive unlock: Required
  Erase Suspend: Read/write
  Block protection: 4 sectors per group
  Temporary block unprotect: Supported
  Block protect/unprotect scheme: 4
  Number of simultaneous operations: 0
  Burst mode: Not supported
  Page mode: 4 word page
  Vpp Supply Minimum Program/Erase Voltage: 11.5 V
  Vpp Supply Maximum Program/Erase Voltage: 12.5 V
  Top/Bottom Boot Block: Uniform, Bottom WP
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
  cmdlinepart partition parsing not available
  RedBoot partition parsing not available
  num_physmap_partitions=3D0x5
  Using physmap partition definition
Creating 5 MTD partitions on "phys_mapped_flash":
0x00000000-0x00040000 : "HRCW"
0x00040000-0x00e00000 : "User FS"
0x00e00000-0x00f00000 : "uImage"
0x00f00000-0x00f40000 : "bootloader"
0x00f40000-0x00f80000 : "bootloader env"
Empty flash at 0x004de47c ends at 0x004de480
Empty flash at 0x004de484 ends at 0x004de488
Empty flash at 0x004de4e4 ends at 0x004de4e8
Empty flash at 0x004de78c ends at 0x004de790
Empty flash at 0x004de794 ends at 0x004de798
Empty flash at 0x004de7f4 ends at 0x004de7f8
Empty flash at 0x004dea9c ends at 0x004deaa0
Empty flash at 0x004deaa4 ends at 0x004deaa8
Empty flash at 0x004deb04 ends at 0x004deb08
Empty flash at 0x004dedac ends at 0x004dedb0
Empty flash at 0x004dedb4 ends at 0x004dedb8
Empty flash at 0x004dee14 ends at 0x004dee18
Empty flash at 0x004df0bc ends at 0x004df0c0
Empty flash at 0x004df0c4 ends at 0x004df0c8
Empty flash at 0x004df124 ends at 0x004df128
Empty flash at 0x004df3cc ends at 0x004df3d0
Empty flash at 0x004df3d4 ends at 0x004df3d8
Empty flash at 0x004df434 ends at 0x004df438
Empty flash at 0x004df6dc ends at 0x004df6e0
Empty flash at 0x004df6e4 ends at 0x004df6e8
Empty flash at 0x004df744 ends at 0x004df748
Empty flash at 0x004df9ec ends at 0x004df9f0
Empty flash at 0x004df9f4 ends at 0x004df9f8
Empty flash at 0x004dfa54 ends at 0x004dfa58
Empty flash at 0x004dfcfc ends at 0x004dfd00
Empty flash at 0x004dfd04 ends at 0x004dfd08
Empty flash at 0x004dfd64 ends at 0x004dfd68
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 100k init
273c282, ino #51
rent (c0238dac)
right from frag 225280-229376, before the region we care about
ght (c0238ad4), parent (c0238c24)
8). left (c3d9e540), right (c3d9e658), parent (c3d9e578)
: hole (*c0238f34). left (c0238f6c} right (c0238f50), parent (c3d9d2d8)
: 0x00019464(2) on flash (*c0238ec4). left (c0238d74), right (c0238e54),
parent (c0238f88)
3873224, checked_ino #37
001a

what is the error...can anybody help me..?
thanks in advance

nethra

--=20
View this message in context: http://www.nabble.com/jffs2-and-Amdflash-tf38=
33576.html#a10853134
Sent from the linuxppc-dev mailing list archive at Nabble.com.
