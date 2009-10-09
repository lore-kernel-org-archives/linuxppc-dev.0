Return-Path: <roberto.j.guerra@gmail.com>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187]) by ozlabs.org (Postfix) with ESMTP id 34BEFB7BA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 01:14:57 +1100 (EST)
Received: by qyk17 with SMTP id 17so7513332qyk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 09 Oct 2009 07:14:56 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 9 Oct 2009 10:14:56 -0400
Message-ID: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
Subject: Support for S29JL064 in MPC8272ADS?
From: Roberto Guerra <roberto.j.guerra@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
My uboot can read my flash chip, finding the uImage and the initramfs,
and booting the kernel fine. However, I'd like the Linux kernel to
read my flash chip so that it can update files in it.
My flash chip is the Spansion S29JL064H (AMD), 16 bit wide, 64 Mbit.
The chip is mapped from FF800000 to FFFFFFFF. The rootfs.jffs2 was
written on 0XFF990000 and is 0x390000 long.
I know that the JFFS is written correctly, because it is detected by uboot:

=> fsinfo
### filesystem type is JFFS2
Scanning JFFS2 FS: ....... done.
Compression: NONE
        frag count: 523
        compressed sum: 138074
        uncompressed sum: 138074
Compression: ZERO
        frag count: 0
        compressed sum: 0
        uncompressed sum: 0
Compression: RTIME
        frag count: 1
        compressed sum: 48
        uncompressed sum: 52
Compression: RUBINMIPS
        frag count: 0
        compressed sum: 0
        uncompressed sum: 0
Compression: COPY
        frag count: 0
        compressed sum: 0
        uncompressed sum: 0
Compression: DYNRUBIN
        frag count: 0
        compressed sum: 0
        uncompressed sum: 0
Compression: ZLIB
        frag count: 2031
        compressed sum: 3370991
        uncompressed sum: 7598685

=> flinfo

Bank # 1: CFI conformant FLASH (16 x 16)  Size: 8 MB in 142 Sectors
  AMD Standard command set, Manufacturer ID: 0x01, Device ID: 0x7E0201
  Erase timeout: 8192 ms, write timeout: 1 ms

  Sector Start Addresses:
  FF800000        FF802000        FF804000        FF806000        FF808000
  FF80A000        FF80C000        FF80E000        FF810000        FF820000
  FF830000        FF840000        FF850000        FF860000        FF870000
  FF880000        FF890000        FF8A0000        FF8B0000        FF8C0000
  FF8D0000        FF8E0000        FF8F0000        FF900000        FF910000
  FF920000        FF930000        FF940000        FF950000        FF960000
  FF970000        FF980000        FF990000        FF9A0000        FF9B0000
  FF9C0000        FF9D0000        FF9E0000        FF9F0000        FFA00000
  FFA10000        FFA20000        FFA30000        FFA40000        FFA50000
  FFA60000        FFA70000        FFA80000        FFA90000        FFAA0000
  FFAB0000        FFAC0000        FFAD0000        FFAE0000        FFAF0000
  FFB00000        FFB10000        FFB20000        FFB30000        FFB40000
  FFB50000        FFB60000        FFB70000        FFB80000        FFB90000
  FFBA0000        FFBB0000        FFBC0000        FFBD0000        FFBE0000
  FFBF0000        FFC00000        FFC10000        FFC20000        FFC30000
  FFC40000        FFC50000        FFC60000        FFC70000        FFC80000
  FFC90000        FFCA0000        FFCB0000        FFCC0000        FFCD0000
  FFCE0000        FFCF0000        FFD00000        FFD10000        FFD20000
  FFD30000        FFD40000        FFD50000        FFD60000        FFD70000
  FFD80000        FFD90000        FFDA0000        FFDB0000        FFDC0000
  FFDD0000        FFDE0000        FFDF0000        FFE00000        FFE10000
  FFE20000        FFE30000        FFE40000        FFE50000        FFE60000
  FFE70000        FFE80000        FFE90000        FFEA0000        FFEB0000
  FFEC0000        FFED0000        FFEE0000        FFEF0000        FFF00000   RO
  FFF10000   RO   FFF20000   RO   FFF30000   RO   FFF40000   RO   FFF50000   RO
  FFF60000   RO   FFF70000   RO   FFF80000        FFF90000        FFFA0000
  FFFB0000        FFFC0000        FFFD0000        FFFE0000        FFFF0000
  FFFF2000        FFFF4000        FFFF6000        FFFF8000        FFFFA000
  FFFFC000        FFFFE000

My bootargs are:
bootargs=console=ttyCPM0,115200 root=/dev/mtdblock1 rw
mtdparts=phys:1600K(ROM)ro,6M(root),512K(U-Boot)ro,512K(unused)

However, the kernel does not detect any flash chip (nor there's any
indication that a CFI probe is being performed).

My flash kconfig section:

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

Roberto Guerra
