From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [kernel26@ppc] fixes...
Date: Wed, 7 Jul 2004 00:42:56 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wry6A5l2NJ4Frl1"
Message-Id: <200407070042.56649.pluto@pld-linux.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_wry6A5l2NJ4Frl1
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
Could You look at attached patches?

[1] 2.6.7-ppc-asm-defs.patch
assembler reports an error at `dssall'

[2] 2.6.7-ppc-cciss-div.patch
a shift in sector_div() > bit-size of int.

[3] 2.6.7-ppc-ipr-div.patch
similar sector_div() bug.

[4] 2.6.7-ppc-saa7146-workaround.patch
is only workaround for a conflict:

"CC [M] =A0drivers/media/common/saa7146_video.o
 drivers/media/common/saa7146_video.c:3: error: conflicting types for `memo=
ry'
 include/asm-m68k/setup.h:365: error: previous declaration of `memory'"

[5] 2.6.7-ppc-strncasecmp.patch
a confilct with strncasecmp in arch-ppc/lib/strcase.c

=2D-=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_wry6A5l2NJ4Frl1
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.7-ppc-asm-defs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-ppc-asm-defs.patch"

--- linux-2.6.7/include/asm-ppc/ppc_asm.h.orig	2004-07-06 16:44:48.000000000 +0200
+++ linux-2.6.7/include/asm-ppc/ppc_asm.h	2004-07-06 16:57:45.784635032 +0200
@@ -73,6 +73,16 @@
 #define REST_16EVR(n,s,base)	REST_8EVR(n,s,base); REST_8EVR(n+8,s,base)
 #define REST_32EVR(n,s,base)	REST_16EVR(n,s,base); REST_16EVR(n+16,s,base)

+/*
+ * Once a version of gas that understands the AltiVec instructions
+  * is freely available, we can do this the normal way...  - paulus
+   */
+#define LVX(r,a,b)	.long	(31<<26)+((r)<<21)+((a)<<16)+((b)<<11)+(103<<1)
+#define STVX(r,a,b)	.long	(31<<26)+((r)<<21)+((a)<<16)+((b)<<11)+(231<<1)
+#define MFVSCR(r)	.long	(4<<26)+((r)<<21)+(770<<1)
+#define MTVSCR(r)	.long	(4<<26)+((r)<<11)+(802<<1)
+#define DSSALL		.long	(0x1f<<26)+(0x10<<21)+(0x336<<1)
+
 #ifdef CONFIG_PPC601_SYNC_FIX
 #define SYNC				\
 BEGIN_FTR_SECTION			\

--Boundary-00=_wry6A5l2NJ4Frl1
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.7-ppc-cciss-div.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-ppc-cciss-div.patch"

--- linux-2.6.7/drivers/block/cciss.c.orig	2004-07-06 19:11:30.000000000 +0200
+++ linux-2.6.7/drivers/block/cciss.c	2004-07-06 21:53:26.603620600 +0200
@@ -208,7 +208,7 @@
         ctlr_info_t *h = (ctlr_info_t*)data;
         drive_info_struct *drv;
 	unsigned long flags;
-	unsigned int vol_sz, vol_sz_frac;
+	uint64_t vol_sz, vol_sz_frac;

         ctlr = h->ctlr;

@@ -269,7 +269,7 @@
 		if (drv->raid_level > 5)
 			drv->raid_level = RAID_UNKNOWN;
 		size = sprintf(buffer+len, "cciss/c%dd%d:"
-				"\t%4d.%02dGB\tRAID %s\n",
+				"\t%4llu.%02lluGB\tRAID %s\n",
 				ctlr, i, vol_sz,vol_sz_frac,
 				raid_label[drv->raid_level]);
                 pos += size; len += size;

--Boundary-00=_wry6A5l2NJ4Frl1
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.7-ppc-ipr-div.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-ppc-ipr-div.patch"

--- linux-2.6.7/drivers/scsi/ipr.c.orig	2004-07-06 22:03:17.000000000 +0200
+++ linux-2.6.7/drivers/scsi/ipr.c	2004-07-06 23:33:37.539819400 +0200
@@ -2785,7 +2785,8 @@
 			 struct block_device *block_device,
 			 sector_t capacity, int *parm)
 {
-	int heads, sectors, cylinders;
+	int heads, sectors;
+	sector_t cylinders;

 	heads = 128;
 	sectors = 32;

--Boundary-00=_wry6A5l2NJ4Frl1
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.7-ppc-saa7146-workaround.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-ppc-saa7146-workaround.patch"

--- linux-2.6.7/drivers/media/common/saa7146_video.c.orig	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.7/drivers/media/common/saa7146_video.c	2004-07-06 23:10:55.768840056 +0200
@@ -1,9 +1,9 @@
 #include <media/saa7146_vv.h>

-static int memory = 32;
+static int capmemory = 32;

-MODULE_PARM(memory,"i");
-MODULE_PARM_DESC(memory, "maximum memory usage for capture buffers (default: 32Mb)");
+MODULE_PARM(capmemory,"i");
+MODULE_PARM_DESC(capmemory, "maximum memory usage for capture buffers (default: 32Mb)");

 #define IS_CAPTURE_ACTIVE(fh) \
 	(((vv->video_status & STATUS_CAPTURE) != 0) && (vv->video_fh == fh))
@@ -1331,9 +1331,9 @@

 	*size = fh->video_fmt.sizeimage;

-	/* check if we exceed the "memory" parameter */
-	if( (*count * *size) > (memory*1048576) ) {
-		*count = (memory*1048576) / *size;
+	/* check if we exceed the "capmemory" parameter */
+	if( (*count * *size) > (capmemory*1048576) ) {
+		*count = (capmemory*1048576) / *size;
 	}

 	DEB_CAP(("%d buffers, %d bytes each.\n",*count,*size));

--Boundary-00=_wry6A5l2NJ4Frl1
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.7-ppc-strncasecmp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-ppc-strncasecmp.patch"

--- linux-2.6.7/fs/gfs_locking/lock_gulm/utils_verb_flags.c.orig	2004-07-06 18:20:32.000000000 +0000
+++ linux-2.6.7/fs/gfs_locking/lock_gulm/utils_verb_flags.c	2004-07-06 19:20:55.868623553 +0000
@@ -20,6 +20,7 @@

 #include "gulm_log_msg_bits.h"

+#ifndef CONFIG_PPC
 static __inline__ int
 strncasecmp (const char *s1, const char *s2, size_t l)
 {
@@ -40,6 +41,7 @@
 	}
 	return (c1 - c2);
 }
+#endif

 static int bit_array[16] = { 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4 };


--Boundary-00=_wry6A5l2NJ4Frl1--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
