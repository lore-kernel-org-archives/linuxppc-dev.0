Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 68265DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 17:02:40 +1000 (EST)
Date: Tue, 7 Aug 2007 09:02:30 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2] lite5200b: flash definition in dts
Message-ID: <20070807070229.GP4529@moe.telargo.com>
References: <20070619095408.GK23294@moe.telargo.com>
	<20070801065203.GK4529@moe.telargo.com>
	<fa686aa40708010541n4d4900cfv7042d6ca685416d1@mail.gmail.com>
	<20070802055830.GM4529@moe.telargo.com>
	<fa686aa40708012323p2eca4b05pd47acac635cf6370@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40708012323p2eca4b05pd47acac635cf6370@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add flash definition for in lite5200b dts, and while at it
fix "ranges" for soc node.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
OK.

Then how about something like this?

# ls /sys/devices/
total 0
drwxr-xr-x 34 root root 0 Dec  9  1993 f0000000.soc5200
drwxr-xr-x  3 root root 0 Dec  9  1993 fe000000.flash
drwxr-xr-x  3 root root 0 Dec  9  1993 ff000000.flash
drwxr-xr-x  4 root root 0 Dec  9  1993 pci0000:00
drwxr-xr-x  5 root root 0 Dec  9  1993 platform
drwxr-xr-x  6 root root 0 Aug  7 08:39 system

# cat /proc/mtd 
dev:    size   erasesize  name
mtd0: 01000000 00020000 "data0"
mtd1: 00f00000 00020000 "data1"
mtd2: 00100000 00020000 "u-boot"


	Domen

 arch/powerpc/boot/dts/lite5200b.dts          |   23 ++++++++++++++++++++++-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   15 +++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

Index: clean-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- clean-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ clean-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -52,7 +52,7 @@
 		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
-		ranges = <0 f0000000 f0010000>;
+		ranges = <00000000 f0000000 00010000>;
 		reg = <f0000000 00010000>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
@@ -345,4 +345,25 @@
 			reg = <8000 4000>;
 		};
 	};
+
+	flash@fe000000 {
+		device_type = "rom";
+		compatible = "direct-mapped";
+		probe-type = "CFI";
+		reg = <fe000000 01000000>;
+		bank-width = <1>;
+		partitions = <00000000 01000000>;
+		partition-names = "data0";
+	};
+
+	flash@ff000000 {
+		device_type = "rom";
+		compatible = "direct-mapped";
+		probe-type = "CFI";
+		reg = <ff000000 01000000>;
+		bank-width = <1>;
+		partitions = <00000000 00f00000
+			      00f00000 00100000>;
+		partition-names = "data1", "u-boot";
+	};
 };
Index: clean-powerpc.git/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- clean-powerpc.git.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ clean-powerpc.git/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -119,9 +119,24 @@ unmap_regs:
 void __init
 mpc52xx_declare_of_platform_devices(void)
 {
+	struct device_node *root, *child;
+	static const struct of_device_id matches[] = {
+		{ .type = "rom", .compatible = "direct-mapped", },
+		{}
+	};
+
 	/* Find every child of the SOC node and add it to of_platform */
 	if (of_platform_bus_probe(NULL, NULL, NULL))
 		printk(KERN_ERR __FILE__ ": "
 			"Error while probing of_platform bus\n");
+
+	/* add flash chips */
+	root = of_find_node_by_path("/");
+	child = NULL;
+	while ((child = of_get_next_child(root, child))) {
+		if (of_match_node(matches, child))
+			of_platform_device_create(child, NULL, NULL);
+	}
+	of_node_put(root);
 }
 
