Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 969FA2C008E
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 05:15:24 +1100 (EST)
Received: by mail-bk0-f42.google.com with SMTP id j5so3236893bkw.15
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2012 11:15:20 -0700 (PDT)
Message-ID: <507EF5AD.5070203@gmail.com>
Date: Wed, 17 Oct 2012 21:15:09 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: ELDK 4.2/kilauea/3.5+ kernel broken
Content-Type: multipart/mixed; boundary="------------050003040008060809060100"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050003040008060809060100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

The attached patch from here:
http://thread.gmane.org/gmane.linux.ports.ppc.embedded/49637/focus=49903
works as far as I can say from > 3.2 kernels until 3.4.12 and applies
happily even on 3.5.

Unfortunately the last kernel version which boots on a kilauea with ELDK
4.2 is v3.4.12 (with the attached patch applied). BTW v3.6 does not need
the patch anymore, but exposes the same behavior as described below.

A default config with PPC_EARLY_DEBUG_40x makes the board stuck instead
of rebooting, which happens from v3.5 onwards (with patch applied):

U-Boot 2012.10-classic-rber-dirty (Oct 17 2012 - 11:35:47)

CPU:   AMCC PowerPC 405EX Rev. A at 533.333 MHz (PLB=177 OPB=88 EBC=88)
       Security support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       16 kB I-Cache 16 kB D-Cache
Board: Kilauea - AMCC PPC405EX Evaluation Board (CPLD rev. 0)
I2C:   ready
DRAM:  256 MiB (ECC not enabled, 355 MHz, CL4)
Reserving 16384k for kernel logbuffer at 0fffb000
Top of RAM usable for U-Boot at: 0fffb000
Reserving 432k for U-Boot at: 0ff8e000
Reserving 1040k for malloc() at: 0fe8a000
Reserving 132 Bytes for Board Info at: 0fe89f7c
Reserving 104 Bytes for Global Data at: 0fe89f14
Stack Pointer at: 0fe89f00
New Stack Pointer is: 0fe89f00
Now running in RAM - U-Boot at: 0ff8e000
Flash: 64 MiB
NAND:  64 MiB
PCI:   Bus Dev VenId DevId Class Int
PCIE0: link is not up.
PCIE1: link is not up.
U-Boot relocated to 0ff8e000
Net:   ppc_4xx_eth0, ppc_4xx_eth1

Hit any key to stop autoboot:  0
=> run rootfs_nfs

Waiting for PHY auto negotiation to complete... done
ENET Speed is 1000 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 192.168.5.5; our IP address is 192.168.5.11
Filename 'kilauea/uImage'.
Load address: 0x400000
Loading: #################################################################
         ######################################################
done
Bytes transferred = 1738410 (1a86aa hex)
Using ppc_4xx_eth0 device
TFTP from server 192.168.5.5; our IP address is 192.168.5.11
Filename 'kilauea/kilauea.dtb'.
Load address: 0x800000
Loading: #
done
Bytes transferred = 8667 (21db hex)
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-3.5.0-classic-rber-dirty
   Created:      2012-10-17  16:48:39 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1738346 Bytes = 1.7 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00800000
   Booting using the fdt blob at 0x00800000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 00ffa000, end 00fff1da ... OK


---> here the board reboots into u-boot <---

U-Boot 2012.10-classic-rber-dirty (Oct 17 2012 - 11:35:47)

CPU:   AMCC PowerPC 405EX Rev. A at 533.333 MHz (PLB=177 OPB=88 EBC=88)
       Security support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       16 kB I-Cache 16 kB D-Cache
Board: Kilauea - AMCC PPC405EX Evaluation Board (CPLD rev. 0)
...


Please advise.

Regards,

Robert

..."Teaching of beginners should be done by a master, not by a
hack." - Deming

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



--------------050003040008060809060100
Content-Type: text/x-patch;
 name="bake-your-noodle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bake-your-noodle.patch"

>From e0b1ac84bfd539482bc88b943724e577e6b8dfb3 Mon Sep 17 00:00:00 2001
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Mon, 2 Apr 2012 16:20:35 +1000
Subject: [PATCH] powerpc/boot: Only build board support files when required.

Currently we build all board files regardless of the final zImage
target.  This is sub-optimal (in terms on compilation) and leads to
problems in one platform needlessly causing failures for other
platforms.

Use the Kconfig variables to selectively construct this board files to
build.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/Makefile |   56 +++++++++++++++++++++++++++++++++----------
 1 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e8461cb..a3c4ae0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -69,19 +69,49 @@ src-wlib := string.S crt0.S crtsavres.S stdio.c main.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
 		fsl-soc.c mpc8xx.c pq2.c ugecon.c
-src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
-		cuboot-ebony.c cuboot-hotfoot.c epapr.c treeboot-ebony.c \
-		prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
-		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
-		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
-		fixed-head.S ep88xc.c ep405.c cuboot-c2k.c \
-		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
-		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
-		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
-		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c \
-		treeboot-currituck.c
+src-plat := of.c
+ifeq ($(CONFIG_40x),y)
+src-plat += fixed-head.S ep405.c cuboot-hotfoot.c treeboot-walnut.c \
+		cuboot-acadia.c cuboot-kilauea.c \
+		simpleboot.c virtex405-head.S virtex.c
+endif
+ifeq ($(CONFIG_44x),y)
+src-plat  += treeboot-ebony cuboot-ebony treeboot-bamboo cuboot-bamboo \
+		cuboot-sam440ep.c cuboot-sequoia.c cuboot-rainier.c \
+		cuboot-taishan.c cuboot-katmai.c cuboot-warp.c \
+		cuboot-yosemite.c treeboot-iss4xx.c treeboot-currituck.c \
+		simpleboot.c fixed-head.S virtex.c
+endif
+ifeq ($(CONFIG_8xx),y)
+src-plat  += cuboot-8xx.c fixed-head.S ep88xc.c redboot-8xx.c
+endif
+ifeq ($(CONFIG_PPC_MPC52xx),y)
+src-plat  += cuboot-52xx.c
+endif
+ifeq ($(CONFIG_PPC_82xx),y)
+src-plat  += cuboot-pq2.c fixed-head.S ep8248e.c cuboot-824x.c
+endif
+ifeq ($(CONFIG_PPC_82xx),y)
+src-plat  += cuboot-83xx.c fixed-head.S redboot-83xx.c
+endif
+ifeq ($(CONFIG_FSL_SOC_BOOKE),y)
+src-plat  += cuboot-85xx.c cuboot-85xx-cpm2.c
+endif
+ifeq ($(CONFIG_EMBEDDED6xx),y)
+src-plat  += cuboot-pq2.c cuboot-mpc7448hpc2.c cuboot-c2k.c \
+		gamecube-head.S gamecube.c wii-head.S wii.c holly.c \
+		prpmc2800.c
+endif
+ifeq ($(CONFIG_AMIGAONE),y)
+src-plat  += cuboot-amigaone.c
+endif
+ifeq ($(CONFIG_PPC_PS3),y)
+src-plat  += ps3-head.S ps3-hvcall.S ps3.c
+endif
+ifeq ($(CONFIG_EPAPR_BOOT),y)
+src-plat  += epapr.c
+endif
+src-plat  := $(sort $(src-plat))
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
-- 1.7.7.6 

--------------050003040008060809060100--
