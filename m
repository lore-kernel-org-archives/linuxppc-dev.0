Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A4C1DB7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:39:34 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 93032DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 22:39:33 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-mtd@lists.infradead.org
Subject: [PATCH] mtd/maps: add mtd-ram support to physmap_of
Date: Fri, 17 Jul 2009 14:39:23 +0200
Message-Id: <1247834363-28198-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: devicetree-discuss@ozlabs.org, Vitaly Wool <vwool@ru.mvista.com>,
	Artem Bityutskiy <dedekind@infradead.org>,
	=?utf-8?q?Albrecht=20Dre=C3=9F?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org, Ken MacLeod <ken@bitsko.slc.ut.us>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use physmap_of to access RAMs as mtd and add documenation for it. This approach
is a lot less intrusive as adding an of-wrapper around plat-ram.c. As most
extensions of plat-ram.c (e.g. custom map-functions) can't be mapped to the
device tree anyhow, extending physmap_of seems to be the cleanest approach.

Tested with a phyCORE-MPC5121e.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Vitaly Wool <vwool@ru.mvista.com>
Cc: Artem Bityutskiy <dedekind@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ken MacLeod <ken@bitsko.slc.ut.us>
Cc: Albrecht Dreß <albrecht.dress@arcor.de>
---
 Documentation/powerpc/dts-bindings/mtd-physmap.txt |   42 ++++++++++++-------
 drivers/mtd/maps/physmap_of.c                      |    4 ++
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/mtd-physmap.txt b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
index 667c9bd..80152cb 100644
--- a/Documentation/powerpc/dts-bindings/mtd-physmap.txt
+++ b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
@@ -1,18 +1,19 @@
-CFI or JEDEC memory-mapped NOR flash
+CFI or JEDEC memory-mapped NOR flash, MTD-RAM (NVRAM...)
 
 Flash chips (Memory Technology Devices) are often used for solid state
 file systems on embedded devices.
 
- - compatible : should contain the specific model of flash chip(s)
-   used, if known, followed by either "cfi-flash" or "jedec-flash"
- - reg : Address range(s) of the flash chip(s)
+ - compatible : should contain the specific model of mtd chip(s)
+   used, if known, followed by either "cfi-flash", "jedec-flash"
+   or "mtd-ram".
+ - reg : Address range(s) of the mtd chip(s)
    It's possible to (optionally) define multiple "reg" tuples so that
-   non-identical NOR chips can be described in one flash node.
- - bank-width : Width (in bytes) of the flash bank.  Equal to the
+   non-identical chips can be described in one node.
+ - bank-width : Width (in bytes) of the bank.  Equal to the
    device width times the number of interleaved chips.
- - device-width : (optional) Width of a single flash chip.  If
+ - device-width : (optional) Width of a single mtd chip.  If
    omitted, assumed to be equal to 'bank-width'.
- - #address-cells, #size-cells : Must be present if the flash has
+ - #address-cells, #size-cells : Must be present if the device has
    sub-nodes representing partitions (see below).  In this case
    both #address-cells and #size-cells must be equal to 1.
 
@@ -22,24 +23,24 @@ are defined:
  - vendor-id : Contains the flash chip's vendor id (1 byte).
  - device-id : Contains the flash chip's device id (1 byte).
 
-In addition to the information on the flash bank itself, the
+In addition to the information on the mtd bank itself, the
 device tree may optionally contain additional information
-describing partitions of the flash address space.  This can be
+describing partitions of the address space.  This can be
 used on platforms which have strong conventions about which
-portions of the flash are used for what purposes, but which don't
+portions of a flash are used for what purposes, but which don't
 use an on-flash partition table such as RedBoot.
 
-Each partition is represented as a sub-node of the flash device.
+Each partition is represented as a sub-node of the mtd device.
 Each node's name represents the name of the corresponding
-partition of the flash device.
+partition of the mtd device.
 
 Flash partitions
- - reg : The partition's offset and size within the flash bank.
- - label : (optional) The label / name for this flash partition.
+ - reg : The partition's offset and size within the mtd bank.
+ - label : (optional) The label / name for this partition.
    If omitted, the label is taken from the node name (excluding
    the unit address).
  - read-only : (optional) This parameter, if present, is a hint to
-   Linux that this flash partition should only be mounted
+   Linux that this partition should only be mounted
    read-only.  This is usually used for flash partitions
    containing early-boot firmware images or data which should not
    be clobbered.
@@ -78,3 +79,12 @@ Here an example with multiple "reg" tuples:
 			reg = <0 0x04000000>;
 		};
 	};
+
+An example using SRAM:
+
+	sram@2,0 {
+		compatible = "samsung,k6f1616u6a", "mtd-ram";
+		reg = <2 0 0x00200000>;
+		bank-width = <2>;
+	};
+
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 39d357b..45eee20 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -360,6 +360,10 @@ static struct of_device_id of_flash_match[] = {
 		.data		= (void *)"jedec_probe",
 	},
 	{
+		.compatible     = "mtd-ram",
+		.data           = (void *)"map_ram",
+	},
+	{
 		.type		= "rom",
 		.compatible	= "direct-mapped"
 	},
-- 
1.6.3.1
