Date: Fri, 8 Feb 2002 13:36:04 -0700
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] adjust BAT mapping according to max_low_mem
Message-ID: <20020208133604.H25005@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm testing highmem by setting max_low_mem to 64MB and using 256MB RAM
total (this does not trigger my SCSI bug).  I had to change a few
things in adjust_total_lowmem to force it to _not_ BAT map of all the
RAM.  I think the printout of residual is wrong but I'm not sure.

-VAL

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.201   -> 1.202
#	arch/ppc/mm/pgtable.c	1.15    -> 1.16
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/08	val@evilcat.fsmlabs.com	1.202
# Fix bat calculations to take into account max_low_mem.  This maps only the
# max_low_mem RAM with BATs, so you can test the highmem code on machines with
# less ram.  The printout of "residual" is probably wrong, since it now only
# lists the residual lowmem, rather than all residual mem.
# --------------------------------------------
#
diff -Nru a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c	Fri Feb  8 13:29:29 2002
+++ b/arch/ppc/mm/pgtable.c	Fri Feb  8 13:29:29 2002
@@ -205,7 +205,7 @@
 #ifdef HAVE_BATS
 	unsigned long bat_max = 0x10000000;
 	unsigned long align;
-	unsigned long ram = total_lowmem;
+	unsigned long ram;
 	int is601 = 0;

 	/* 601s have smaller BATs */
@@ -213,6 +213,16 @@
 		bat_max = 0x00800000;
 		is601 = 1;
 	}
+
+	/* adjust BAT block size to max_low_mem */
+	if (max_low_mem < bat_max)
+		bat_max = max_low_mem;
+
+	/* adjust lowmem size to max_low_mem */
+	if (max_low_mem < total_lowmem)
+		total_lowmem = max_low_mem;
+
+	ram = total_lowmem;

 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
