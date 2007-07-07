Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:47 -0500 (CDT)
Subject: [PATCH 01/11] dtc: fix asm for version 17
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-01.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The version 17 flat device tree format added struct size.  When
writing versin 17 assembly output the field must be emitted.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Found when trying to parse the binary from the assembled output.

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-14 22:56:59.000000000 -0500
+++ dtc/flattree.c	2007-06-14 22:59:00.000000000 -0500
@@ -477,6 +477,10 @@ void dt_to_asm(FILE *f, struct boot_info
 		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/* size_dt_strings */\n",
 			symprefix, symprefix);
 
+	if (vi->flags & FTF_STRUCTSIZE)
+		fprintf(f, "\t.long\t_%s_struct_end - _%s_struct_start\t/* size_dt_struct */\n",
+			symprefix, symprefix);
+
 	/*
 	 * Reserve map entries.
 	 * Align the reserve map to a doubleword boundary.
