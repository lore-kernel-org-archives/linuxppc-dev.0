Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:54 -0500 (CDT)
Subject: [PATCH 11/11] dtc: format memory reserve as pairs on two lines
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-11.miltonm@bga.com>
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

When writing the memory reserve table in assembly output,
emit both halves of each 64 bit number on a single .long
statement.  This results in two lines per memory reserve
slot instead of four, each line contains one field (start
or size).

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Purely consmentic but aids in showing the data is from
a single 64 bit quantity.  The end marker and the extra
reserved slots were already emitting a pair of zeros per
statement.

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-14 22:59:24.000000000 -0500
+++ dtc/flattree.c	2007-06-14 22:59:28.000000000 -0500
@@ -514,10 +514,10 @@ void dt_to_asm(FILE *f, struct boot_info
 			fprintf(f, "\t.globl\t%s\n", re->label);
 			fprintf(f, "%s:\n", re->label);
 		}
-		fprintf(f, "\t.long\t0x%08x\n\t.long\t0x%08x\n",
+		fprintf(f, "\t.long\t0x%08x, 0x%08x\n",
 			(unsigned int)(re->re.address >> 32),
 			(unsigned int)(re->re.address & 0xffffffff));
-		fprintf(f, "\t.long\t0x%08x\n\t.long\t0x%08x\n",
+		fprintf(f, "\t.long\t0x%08x, 0x%08x\n",
 			(unsigned int)(re->re.size >> 32),
 			(unsigned int)(re->re.size & 0xffffffff));
 	}
