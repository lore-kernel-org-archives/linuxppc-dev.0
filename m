Message-ID: <3EB024EA.4060909@mvista.com>
Date: Wed, 30 Apr 2003 12:32:58 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Bi_rec "Library"
Content-Type: multipart/mixed;
 boundary="------------040805070900070407070501"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040805070900070407070501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
   I was looking at all of the current bi_rec creation code and noticed
that there seemed to be a lot of work/code used to create the bi_recs. I
thought it would be relatively easy to create a bi_rec "library" to
clean things up and hide the messy details of bi_rec creation. I've
attached a patch which adds the library (boot/common/bootinfo.c) and
modified decompress_kernel in misc-simple.c to use it as an example. I
realize that there may not be much interest at this point, but I thought
I'd send it out anyway.

			Randy Vinson

--------------040805070900070407070501
Content-Type: text/plain;
 name="bi_rec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bi_rec.patch"

diff -Nru a/arch/ppc/boot/common/bootinfo.c b/arch/ppc/boot/common/bootinfo.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/common/bootinfo.c	Wed Apr 30 12:26:32 2003
@@ -0,0 +1,69 @@
+/*
+ * arch/ppc/common/bootinfo.c
+ *
+ * General bootinfo record utilities
+ * Author: Randy Vinson <rvinson@mvista.com>
+ *
+ * 2002 (c) MontaVista Software, Inc. This file is licensed under the terms
+ * of the GNU General Public License version 2. This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <asm/bootinfo.h>
+
+#include "nonstdio.h"
+
+static struct bi_record * birec = NULL;
+
+static struct bi_record *
+__bootinfo_build(struct bi_record *rec, unsigned long tag, unsigned long size,
+		 void *data)
+{
+	/* set the tag */
+	rec->tag = tag;
+
+	/* if the caller has any data, copy it */
+	if (size)
+		memcpy(rec->data, (char *)data, size);
+
+	/* set the record size */
+	rec->size = sizeof(struct bi_record) + size;
+
+	/* advance to the next available space */
+	rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
+	return rec;
+}
+
+void
+bootinfo_init(struct bi_record *rec)
+{
+
+	/* save start of birec area */
+	birec = rec;
+
+	/* create an empty list */
+	rec = __bootinfo_build(rec, BI_FIRST, 0, NULL);
+	(void) __bootinfo_build(rec, BI_LAST, 0, NULL);
+
+}
+
+void
+bootinfo_append(unsigned long tag, unsigned long size, void * data)
+{
+
+	struct bi_record *rec = birec;
+
+	/* paranoia */
+	if ((rec == NULL) || (rec->tag != BI_FIRST))
+		return;
+
+	/* find the last entry in the list */
+	while (rec->tag != BI_LAST)
+		rec = (struct bi_record *)((ulong)rec + rec->size);
+
+	/* overlay BI_LAST record with new one and tag on a new BI_LAST */
+	rec = __bootinfo_build(rec, tag, size, data);
+	(void) __bootinfo_build(rec, BI_LAST, 0, NULL);
+}
diff -Nru a/arch/ppc/boot/common/misc-simple.c b/arch/ppc/boot/common/misc-simple.c
--- a/arch/ppc/boot/common/misc-simple.c	Wed Apr 30 12:26:32 2003
+++ b/arch/ppc/boot/common/misc-simple.c	Wed Apr 30 12:26:32 2003
@@ -96,7 +96,7 @@
 #endif
 	char *cp;
 	struct bi_record *rec;
-	unsigned long rec_loc, initrd_loc, TotalMemory = 0;
+	unsigned long initrd_loc, TotalMemory = 0;

 	serial_fixups();
 	com_port = serial_init(0, NULL);
@@ -223,16 +223,13 @@
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
 	puts("done.\n");

-	/*
-	 * Create bi_recs for cmd_line and initrds
-	 */
-	rec_loc = _ALIGN((unsigned long)(zimage_size) +
-			(1 << 20) - 1, (1 << 20));
-	rec = (struct bi_record *)rec_loc;
+	/* get the bi_rec address */
+	rec = bootinfo_addr(zimage_size);

 	/* We need to make sure that the initrd and bi_recs do not
 	 * overlap. */
 	if ( initrd_size ) {
+		unsigned long rec_loc = (unsigned long) rec;
 		initrd_loc = (unsigned long)(&__ramdisk_begin);
 		/* If the bi_recs are in the middle of the current
 		 * initrd, move the initrd to the next MB
@@ -248,38 +245,24 @@
 		 	puts("\n");
 		}
 	}
-
-	rec->tag = BI_FIRST;
-	rec->size = sizeof(struct bi_record);
-	rec = (struct bi_record *)((unsigned long)rec + rec->size);
-
-	if ( TotalMemory ) {
-		rec->tag = BI_MEMSIZE;
-		rec->data[0] = TotalMemory;
-		rec->size = sizeof(struct bi_record) + sizeof(unsigned long);
-		rec = (struct bi_record *)((unsigned long)rec + rec->size);
-	}

-	rec->tag = BI_CMD_LINE;
-	memcpy( (char *)rec->data, cmd_line, strlen(cmd_line)+1);
-	rec->size = sizeof(struct bi_record) + strlen(cmd_line) + 1;
-	rec = (struct bi_record *)((unsigned long)rec + rec->size);
+	bootinfo_init(rec);
+	if ( TotalMemory )
+		bootinfo_append(BI_MEMSIZE, sizeof(int), (void*)&TotalMemory);

-	if ( initrd_size ) {
-		rec->tag = BI_INITRD;
-		rec->data[0] = initrd_loc;
-		rec->data[1] = initrd_size;
-		rec->size = sizeof(struct bi_record) + 2 *
-			sizeof(unsigned long);
-		rec = (struct bi_record *)((unsigned long)rec +
-				rec->size);
-	}
+	bootinfo_append(BI_CMD_LINE, strlen(cmd_line)+1, (void*)cmd_line);
+
+	/* add a bi_rec for the initrd if it exists */
+	if (initrd_size) {
+		unsigned long initrd[2];

-	rec->tag = BI_LAST;
-	rec->size = sizeof(struct bi_record);
-	rec = (struct bi_record *)((unsigned long)rec + rec->size);
+		initrd[0] = initrd_loc;
+		initrd[1] = initrd_size;
+
+		bootinfo_append(BI_INITRD, sizeof(initrd), &initrd);
+	}
 	puts("Now booting the kernel\n");
 	serial_close(com_port);

-	return (struct bi_record *)rec_loc;
+	return rec;
 }
diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	Wed Apr 30 12:26:32 2003
+++ b/arch/ppc/boot/simple/Makefile	Wed Apr 30 12:26:32 2003
@@ -16,7 +16,7 @@

 # Normally, we use the 'misc-simple.c' file for decompress_kernel and
 # whatnot.  Sometimes we need to override this however.
-MISC				:= ../common/misc-simple.o
+MISC				:= ../common/misc-simple.o ../common/bootinfo.o
 # Additionally, we normally don't need to mess with the L2 / L3 caches
 # if present on 'classic' PPC.
 ifeq ($(CONFIG_6xx),y)
diff -Nru a/include/asm-ppc/bootinfo.h b/include/asm-ppc/bootinfo.h
--- a/include/asm-ppc/bootinfo.h	Wed Apr 30 12:26:32 2003
+++ b/include/asm-ppc/bootinfo.h	Wed Apr 30 12:26:32 2003
@@ -10,6 +10,7 @@
 #define _PPC_BOOTINFO_H

 #include <linux/config.h>
+#include <asm/page.h>

 #if defined(CONFIG_APUS) && !defined(__BOOTER__)
 #include <asm-m68k/bootinfo.h>
@@ -32,9 +33,18 @@
 #define BI_BOARD_INFO		0x1018

 extern struct bi_record *find_bootinfo(void);
+extern void bootinfo_init(struct bi_record *rec);
+extern void bootinfo_append(unsigned long tag, unsigned long size, void * data);
 extern void parse_bootinfo(struct bi_record *rec);
 extern unsigned long boot_mem_size;

+static inline struct bi_record *
+bootinfo_addr(unsigned long offset)
+{
+
+	return (struct bi_record *)_ALIGN((offset) + (1 << 20) - 1,
+					  (1 << 20));
+}
 #endif /* CONFIG_APUS */



--------------040805070900070407070501--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
