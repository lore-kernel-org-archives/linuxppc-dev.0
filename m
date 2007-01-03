Return-Path: <dwm@enoyolf.org>
Received: from bebe.enoyolf.org (falcon30.maxeymade.com [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bebe.enoyolf.org",
	Issuer "CA Cert Signing Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B22EDDEC4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 18:17:55 +1100 (EST)
To: Paul Nasrat <pnasrat@redhat.com>,
	Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/1] determine last ext3 LBA to fix wild LBA reads - v2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2007 01:17:46 -0600
Message-ID: <32361.1167808666@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: yaboot-devel@ozlabs.org, Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The issue seen in the current code is linux_read_blk() is
(apparently) looking at the alternate offsets for all possible
superblocks.  As yaboot scans each partition for all fs types, until
it finds the appropriate signature, when searching the ext fs, libext2
appears to calculate some blocks to read that may be 10x the size of
the actual disk.

Normally, this is does not cause a problem, other than a message from
OFW (maybe) "Request exceeds device size".

However, on a Netapp serving an iSCSI target disk, a read or seek
beyond the end of the lun causes an underflow, which takes 30 seconds
or so for the target to recover.  The net effect is to add 5+ minutes
to what is already a slow boot while the OFW does polling transfers.

This version incorporates the suggestions from benh to
1) not use a cross-module global,
2) track the part sizes by passing to add_new_partition() and use
   those in the ext2_open() to compute the new dend var.

- dend is then used in linux_read_blk() to mark the end of the valid
  seek or read range.

- removed the local def of swab32() in parititions.c and included
  "byteorder.h" to use the common macros.

Signed-off-by: Doug Maxey <dwm@austin.ibm.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
---
Paul,

This is version 2 of fixing a pretty significant performance issue when
booting from a Netapp.  With the fix, the boot time is down to roughly 3m
45s, vs. 8m 45s without.   For comparison, the local disk boot is about
2m 35 s.  More improvement may happen when the debug code is turned off
in the iboot side of OFW.

Oh, this one should go to the correct list.  :)

++doug
---
 second/fs_ext2.c   |   23 ++++++++++++++++++++---
 second/partition.c |   20 +++-----------------
 4 files changed, 23 insertions(+), 20 deletions(-)


diff --git a/second/fs_ext2.c b/second/fs_ext2.c
index bffebb4..0b9bcec 100644
--- a/second/fs_ext2.c
+++ b/second/fs_ext2.c
@@ -93,6 +93,7 @@ static io_manager linux_io_manager = &struct_linux_manager;
 static int opened = 0;		/* We can't open twice ! */
 static unsigned int bs;		/* Blocksize */
 static unsigned long long doff;	/* Byte offset where partition starts */
+static unsigned long long dend;	/* Byte offset where partition ends */
 static ino_t root,cwd;
 static ext2_filsys fs = 0;
 static struct boot_file_t* cur_file;
@@ -149,13 +150,23 @@ ext2_open(	struct boot_file_t*	file,
       * compatible with older versions of OF
       */
      bs = 1024;
-     doff = 0;
-     if (part)
+
+     /*
+      * On the other hand, we do care about the actual size of the
+      * partition, reads or seeks past the end may cause undefined
+      * behavior on some devices.  A netapp that tries to seek and
+      * read past the end of the lun takes ~30 secs to recover per
+      * attempt.
+      */
+     doff = dend = 0;
+     if (part) {
 	  doff = (unsigned long long)(part->part_start) * part->blocksize;
+	  dend = doff + (unsigned long long)part->part_size * part->blocksize;
+     }
      cur_file = file;
 
 
-     DEBUG_F("partition offset: %Lu\n", doff);
+     DEBUG_F("partition offset: %Lx, end: %Lx\n", doff, dend);
 
      /* Open the OF device for the entire disk */
      strncpy(buffer, dev_name, 1020);
@@ -582,6 +593,7 @@ static errcode_t linux_close (io_channel channel)
 
 static errcode_t linux_set_blksize (io_channel channel, int blksize)
 {
+     DEBUG_F("bs set to 0x%x\n", blksize);
      channel->block_size = bs = blksize;
      if (block_buffer) {
 	  free(block_buffer);
@@ -600,6 +612,11 @@ static errcode_t linux_read_blk (io_channel channel, unsigned long block, int co
     
      tempb = (((unsigned long long) block) *
 	      ((unsigned long long)bs)) + (unsigned long long)doff;
+     if (tempb > dend) {
+	  DEBUG_F("\nSeek error on block %lx, tempb=%Lx\n", block, tempb >> 9);
+	  return EXT2_ET_LLSEEK_FAILED;
+     }
+
      size = (count < 0) ? -count : count * bs;
      prom_lseek(cur_file->of_device, tempb);
      if (prom_read(cur_file->of_device, data, size) != size) {
diff --git a/second/partition.c b/second/partition.c
index 53c7bd0..5839105 100644
--- a/second/partition.c
+++ b/second/partition.c
@@ -40,6 +40,7 @@
 #include "linux/iso_fs.h"
 #include "debug.h"
 #include "errors.h"
+#include "byteorder.h"
 
 /* We currently don't check the partition type, some users
  * are putting crap there and still expect it to work...
@@ -58,9 +59,6 @@ static const char *valid_mac_partition_types[] = {
 #endif
     
 
-/* Local functions */
-static unsigned long swab32(unsigned long value);
-
 #define MAX_BLOCK_SIZE	2048
 static unsigned char block_buffer[MAX_BLOCK_SIZE];
 
@@ -177,8 +175,8 @@ partition_fdisk_lookup( const char *dev_name, prom_handle disk,
 				   partition,
 				   "Linux", /* type */
 				   '\0', /* name */
-				   swab32(*(unsigned int *)(part->start4)),
-				   swab32(*(unsigned int *)(part->size4)),
+				   le32_to_cpu(*(unsigned int *)part->start4),
+				   le32_to_cpu(*(unsigned int *)part->size4),
 				   512 /*blksize*/,
 				   part->sys_ind /* partition type */ );
 	  }
@@ -432,18 +430,6 @@ partitions_free(struct partition_t* list)
 	  list = next;
      }
 }
-unsigned long
-swab32(unsigned long value)
-{
-     __u32 result;
-
-     __asm__("rlwimi %0,%1,24,16,23\n\t"
-	     "rlwimi %0,%1,8,8,15\n\t"
-	     "rlwimi %0,%1,24,0,7"
-	     : "=r" (result)
-	     : "r" (value), "0" (value >> 24));
-     return result;
-}
 
 
 /* 
-- 
1.4.4.3
