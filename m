Return-Path: <dgibson@ozlabs.org>
Date: Mon, 25 Feb 2008 11:33:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Use aliases instead of linux,network-index on Ebony
Message-ID: <20080225003339.GB16071@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch alters the Ebony bootwrapper to use the new preferred
method of using aliases to work out which MAC address to attach to
which ethernet device node, rather than the old method based on the
linux,network-index property.

The now obsolete linux,network-index properties are removed from the
ebony device tree as well.  This won't break backwards compatiblity,
because in cases where this fixup code is relevant, the device tree is
part of the kernel image.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

For 2.6.26, tested on an Ebony board with treeboot.

Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2008-02-25 11:22:31.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ebony.c	2008-02-25 11:23:20.000000000 +1100
@@ -75,7 +75,8 @@ static void ebony_fixups(void)
 
 	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
 	ibm4xx_sdram_fixup_memsize();
-	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
+	dt_fixup_mac_address_by_alias("ethernet0", ebony_mac0);
+	dt_fixup_mac_address_by_alias("ethernet1", ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	ebony_flashsel_fixup();
 }
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2008-02-25 11:25:28.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2008-02-25 11:25:37.000000000 +1100
@@ -243,7 +243,6 @@
 			};
 
 			EMAC0: ethernet@40000800 {
-				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
@@ -263,7 +262,6 @@
 				zmii-channel = <0>;
 			};
 			EMAC1: ethernet@40000900 {
-				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
