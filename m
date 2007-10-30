Return-Path: <dgibson@ozlabs.org>
Date: Tue, 30 Oct 2007 13:22:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Correctly handle versions > 17
Message-ID: <20071030022212.GB30041@localhost.localdomain>
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

If future dtb version > 17 are defined, that are still backwards
compatible with v16, libfdt will of course be able to read and
understand them.  However, when modifying such a tree, it can't
guarantee that it won't clobber additional structure from the new
version which it doesn't know about.  Therefore, before making
modifications to a tree of version >17, we must change it's version to
be exactly 17.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-29 16:09:23.000000000 +1100
+++ dtc/libfdt/fdt_rw.c	2007-10-29 16:34:37.000000000 +1100
@@ -61,7 +61,7 @@ static int rw_check_header(void *fdt)
 
 	if ((err = fdt_check_header(fdt)))
 		return err;
-	if (fdt_version(fdt) < 0x11)
+	if (fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
 	if (fdt_off_mem_rsvmap(fdt) < ALIGN(sizeof(struct fdt_header), 8))
 		return -FDT_ERR_BADLAYOUT;
@@ -74,6 +74,9 @@ static int rw_check_header(void *fdt)
 	if (fdt_totalsize(fdt) <
 	    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)))
 		return -FDT_ERR_BADLAYOUT;
+	if (fdt_version(fdt) > 17)
+		fdt_set_version(fdt, 17);
+
 	return 0;
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
