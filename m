Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 11:55:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Wool <vwool@ru.mvista.com>, David Woodhouse <dwmw2@redhat.com>
Subject: Fix missing printk() parameter in physmap_of.c MTD driver
Message-ID: <20070509015551.GG4198@localhost.localdomain>
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

Squashes a compiler warning, and provides more useful information in
the case messed up device tree information.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/mtd/maps/physmap_of.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-05-07 12:57:07.000000000 +1000
+++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-05-09 11:53:53.000000000 +1000
@@ -186,7 +186,7 @@ static int __devinit of_physmap_probe(st
 	else {
  		if (strcmp(of_probe, "ROM"))
 			dev_dbg(&dev->dev, "map_probe: don't know probe type "
-			"'%s', mapping as rom\n");
+			"'%s', mapping as rom\n", of_probe);
 		info->mtd = do_map_probe("mtd_rom", &info->map);
 	}
 	if (info->mtd == NULL) {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
