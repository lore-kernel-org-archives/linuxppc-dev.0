Return-Path: <rbrito@ime.usp.br>
Received: from nm3-vm0.bullet.mail.bf1.yahoo.com
 (nm3-vm0.bullet.mail.bf1.yahoo.com [98.139.212.154])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2F981A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:49:04 +1000 (AEST)
Date: Thu, 14 May 2015 02:48:59 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: debian-arm@lists.debian.org
Subject: Specifying the MTD partitions in a device tree
Message-ID: <20150514054858.GA4608@ime.usp.br>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Cc: scottwood@freescale.com, debian-powerpc@lists.debian.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi.

I am sending this message to Debian/powerpc, Debian/arm lists because and
linuxppc-dev.  While the issue that I'm having is with a powerpc machine,
the arm people may also be of valuable help with device trees, since they
have to deal with them seemingly all the time.

Anyway, the problem that I have is as follows: I have a Kurobox HG (powerpc)
NAS that Riku Voipio donated me a few years ago.

Everything worked fine and I was able to get Debian (since kernel 2.6.20 or
similar) running up to with kernels 2.6.28 (if my memory serves me well).
With kernel 2.6.29, the partitions of the MTD device that this machine has
were not displayed anymore (only one big device was presented to the user).

In a recent exchange [0] with Scott Wood from the linuxppc-dev, I was
finally able to partition the MTD flash device with the original layout of
the device by passing an `mtdparts` option to the kernel.

[0]: http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/80215


It seems, though, that the proper way to fix this issue for good is to
include such description in the DTS files for the particular board (in fact,
at least 2---but potentially 4---boards are affected by this).

I tried a few experiments with writing a patch to the existing dts files,
but I wasn't successful, since I am not sure about a good amount of the
things and I would appreciate some assistance here.

In particular, I don't know if I filled all the fields correctly and, also,
I don't know where I should "graft" the description of the flash chip in the
rest of the device tree.

Can anybody help here? I am sending a verbosely and dirty patch (not yet
suitable for inclusion in the main kernel tree) that I created (and which
didn't work) with as much information that I know about the system, but I
can surely collect more information.

Ideally, I would like to get many of the things automated and add support
for the Kurobox HD/HG to the Debian installer, so that people with these
devices can breathe new life into their systems (instead of the original
2.4.20 kernel that came with it).

I would ge greateful for anybody that can help here. I hope to both learn
and help with the maintainance of such machines.


Once again, thanks a lot for any help,

Rogério Brito.

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-arch-powerpc-dts-First-try-at-specifying-partitions-.patch"
Content-Transfer-Encoding: 8bit

>From a4e80dc8edb19d323318900020e5cb2e010bda94 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Rog=C3=A9rio=20Brito?= <rbrito@ime.usp.br>
Date: Thu, 14 May 2015 02:42:22 -0300
Subject: [PATCH] arch/powerpc: dts: First try at specifying partitions for the
 Kurobox HG.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is based on my (successful) experience with partitioning the MTD flash
device of the Kurobox HG by passing the `mtdparts` option to the kernel.

For the sake of documentation, the option that works is:

    mtdparts=physmap-flash.0:3072k@0k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf),4096k@0k(full)

Unfortunately, my attempts at mimic'ing the line above in
arch/powerpc/boot/dts/kuroboxHG.dts didn't bear fruits so far.

Signed-off-by: Rogério Brito <rbrito@ime.usp.br>
---
 arch/powerpc/boot/dts/kuroboxHG.dts | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 0e758b3..e3de7fb 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -143,5 +143,73 @@ XXXX add flash parts, rtc, ??
 				0x7000 0x0 0x0 0x4 &mpic 0x3 0x1
 			>;
 		};
+
+		/* Based on a mix of information from:
+		   - personal experiments
+		   - http://buffalo.nas-central.org/wiki/Flash_ROM
+		   - Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+		   - Documentation/devicetree/bindings/mtd/partition.txt
+		 */
+		flash@fff80000 {
+			compatible = "amd,am29lv320" /*  Fujitsu 29PL32TM-90PFTN 4MB Flash ROM chip */, "cfi-flash";
+			reg = <0xfff80000 0x400000>;
+			bank-width = <1>; /* "Found 1 x16 devices at 0x0 in 8-bit bank." */
+			device-width = <1>; /* unneeded? */
+
+			/* linux,mtd-name = <>; */ /* FIXME: unneeded? */
+			/* use-advanced-sector-protection = <>; */ /* FIXME: unneeded? */
+			vendor-id = <0x0004>; /* "Manufacturer ID 0x000004" */
+			device-id = <0x007e>; /* "Chip ID 0x00007e" */
+
+			erase-size = <0x10000>; /* 64 KiB */
+
+			#address-cells = <1>; /* FIXME: verify */
+			#size-cells = <1>; /* FIXME: verify */
+
+			/*
+
+			My (rbrito) u-boot currently uses:
+
+			   mtdparts=physmap-flash.0:3072k@0k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf),4096k@0k(full)
+
+			  For reference:
+
+			  * 3072KiB = 0x300000
+			  *  448KiB =  0x70000
+			  * 3520KiB = 0x370000
+			  *   64KiB =  0x10000
+			  * 3584KiB = 0x380000
+			  *  512KiB =  0x80000
+			  * 4096KiB = 0x400000
+
+			  FIXME: A partition like uboot-env for uboot's environment
+			  should really exist.
+			*/
+
+			firmimg@0 {
+				label = "kernel + initrd";
+				reg = <0 0x300000>;		/* 3072k@0k */
+			};
+
+			bootcode@300000 {
+				label = "uboot";
+				reg = <0x300000 0x70000>;	/* 448k@3072k */
+			};
+
+			status@370000 {
+				label = "status";
+				reg = <0x370000 0x10000>;	/* 64k@3520k */
+			};
+
+			conf@680000 {
+				label = "conf";
+				reg = <0xc80000 0>;		/* 512k@3584k */
+			};
+
+			full@0 {
+				label = "full";
+				reg = <0 0x400000>;		/* 4096k@0k */
+			};
+		};
 	};
 };
-- 
2.1.4


--cNdxnHkX5QqsyA0e--
