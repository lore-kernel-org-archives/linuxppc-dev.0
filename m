Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 29C6268263
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 11:57:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Thu, 15 Sep 2005 09:57:13 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86506C@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: A question about the /dev/ide
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all:
  I had use the UPM of MPC8270 to create the device driver of my pcmcia =
CF card.=20
  How to create the "/dev/hda" device nodes? I had only "/dev/ide" =
device nodes, I want to use command like  "mkswap /dev/hda4".
  When I use "mkswap /dev/ide/host0/bus0/target0/lun0/part1p4", it shows =
the "No such file or directory" message. How can I create=20
  the right device nodes? thanks!


 When it booted, it showed the following message:

 Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ide0: MPC82xx IDE interface
Probing IDE interface ide0...
hda: STI Flash 7.2.0, CFA DISK drive
ide0 at 0xc900d800-0xc900d807,0xc900d80e on irq 24
hda: attached ide-disk driver.
hda: 250880 sectors (128 MB), CHS=3D980/8/32
Partition check:
Partition check:


 When using "fdisk -l" it shows the following message:

       Disk /dev/ide/host0/bus0/target0/lun0/disc: 128 MB, 128450560 =
bytes
       8 heads, 32 sectors/track, 980 cylinders
      Units =3D cylinders of 256 * 512 =3D 131072 bytes

       Device Boot                                      Start      End   =
 Blocks  Id  System
       /dev/ide/host0/bus0/target0/lun0/part1   *         1       972    =
124400    6  FAT16

 When use "p" option of "fdisk", it shows the following message:
      Disk /dev/ide/host0/bus0/target0/lun0/part1: 127 MB, 127385600 =
bytes
      8 heads, 32 sectors/track, 971 cylinders
      Units =3D cylinders of 256 * 512 =3D 131072 bytes

                            Device Boot                                 =
Start       End    Blocks   Id   System
/dev/ide/host0/bus0/target0/lun0/part1p1             1        16      =
2032   83    Linux
/dev/ide/host0/bus0/target0/lun0/part1p2            17        32      =
2048   83    Linux=20
/dev/ide/host0/bus0/target0/lun0/part1p3            33       788     =
96768   83    Linux=20
/dev/ide/host0/bus0/target0/lun0/part1p4           789       971     =
23424   83    Linux
   =20
