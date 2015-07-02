Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEFCB1A0FF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 21:35:49 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09B2C1402BC
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 21:35:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 17:05:44 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D9C8D1258064
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 17:08:29 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62BZgKm1179908
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 17:05:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62AREkN016651
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 15:57:15 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v4 4/4] disk-label: add support for booting from GPT FAT
 partition
Date: Thu,  2 Jul 2015 17:05:38 +0530
Message-Id: <1435836938-22889-5-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1435836938-22889-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435836938-22889-1-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a GPT+LVM combination disk, older bootloader that does not support
LVM, cannot load kernel from LVM.

The patch adds support to read from BASIC_DATA UUID partitions for the
case that the OS installer has installed the CHRP-BOOT config on a FAT
file system.

Makes GPT detection robust
* Fix bug in seek-pos updation code
* Check for Protective MBR Magic
* Check for valid GPT Signature
* Boundary check for allocated block size before reading into the
  buffer

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 slof/fs/packages/disk-label.fs | 108 ++++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 24 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index 142e54f..e034d64 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -20,6 +20,7 @@ false VALUE debug-disk-label?
 \ If we ever want to put a large kernel with initramfs from a PREP partition
 \ we might need to increase this value. The default value is 65536 blocks (32MB)
 d# 65536 value max-prep-partition-blocks
+d# 4096 CONSTANT block-array-size
 
 s" disk-label" device-name
 
@@ -152,8 +153,8 @@ CONSTANT /gpt-part-entry
 : init-block ( -- )
    s" block-size" ['] $call-parent CATCH IF ABORT" parent has no block-size." THEN
    to block-size
-   d# 4096 alloc-mem
-   dup d# 4096 erase
+   block-array-size alloc-mem
+   dup block-array-size erase
    to block
    debug-disk-label? IF
       ." init-block: block-size=" block-size .d ." block=0x" block u. cr
@@ -178,7 +179,8 @@ CONSTANT /gpt-part-entry
 \ This word returns true if the currently loaded block has _NO_ GPT partition id
 : no-gpt? ( -- true|false )
    0 read-sector
-   1 partition>part-entry part-entry>id c@ ee <>
+   1 partition>part-entry part-entry>id c@ ee <> IF true EXIT THEN
+   block mbr>magic w@-le aa55 <>
 ;
 
 : pc-extended-partition? ( part-entry-addr -- true|false )
@@ -266,7 +268,10 @@ CONSTANT /gpt-part-entry
 
 : try-dos-partition ( -- okay? )
    \ Read partition table and check magic.
-   no-mbr? IF cr ." No DOS disk-label found." cr false EXIT THEN
+   no-mbr? IF
+       debug-disk-label? IF cr ." No DOS disk-label found." cr THEN
+       false EXIT
+   THEN
 
    count-dos-logical-partitions TO dos-logical-partitions
 
@@ -376,31 +381,85 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
        8 + x@    GPT-PREP-PARTITION-4 =
 ;
 
-: load-from-gpt-prep-partition ( addr -- size )
-   no-gpt? IF drop false EXIT THEN
-   debug-disk-label? IF
-      cr ." GPT partition found " cr
-   THEN
-   1 read-sector block gpt>part-entry-lba l@-le
+\ Check for GPT MSFT BASIC DATA GUID - fat based
+EBD0A0A2            CONSTANT GPT-BASIC-DATA-PARTITION-1
+B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
+4433                CONSTANT GPT-BASIC-DATA-PARTITION-3
+87C068B6B72699C7    CONSTANT GPT-BASIC-DATA-PARTITION-4
+
+: gpt-basic-data-partition? ( -- true|false )
+   block gpt-part-entry>part-type-guid
+   dup l@-le     GPT-BASIC-DATA-PARTITION-1 <> IF drop false EXIT THEN
+   dup 4 + w@-le GPT-BASIC-DATA-PARTITION-2 <> IF drop false EXIT THEN
+   dup 6 + w@-le GPT-BASIC-DATA-PARTITION-3 <> IF drop false EXIT THEN
+       8 + x@    GPT-BASIC-DATA-PARTITION-4 =
+;
+
+\
+\ GPT Signature
+\ ("EFI PART", 45h 46h 49h 20h 50h 41h 52h 54h)
+\
+4546492050415254 CONSTANT GPT-SIGNATURE
+
+\ The routine checks whether the protective MBR has GPT ID and then
+\ reads the gpt data from the sector. Also set the seek position and
+\ the partition size used in caller routines.
+
+: get-gpt-partition ( -- true|false )
+   no-gpt? IF false EXIT THEN
+   debug-disk-label? IF cr ." GPT partition found " cr  THEN
+   1 read-sector
+   block gpt>part-entry-lba x@-le
    block-size * to seek-pos
    block gpt>part-entry-size l@-le to gpt-part-size
-   block gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
+   gpt-part-size block-array-size > IF
+      cr ." GPT part size exceeds buffer allocated " cr
+      false exit
+   THEN
+   block gpt>signature x@ GPT-SIGNATURE =
+;
+
+: load-from-gpt-prep-partition ( addr -- size )
+   get-gpt-partition 0= IF false EXIT THEN
+   block gpt>num-part-entry l@-le dup 0= IF false exit THEN
    1+ 1 ?DO
       seek-pos 0 seek drop
       block gpt-part-size read drop gpt-prep-partition? IF
-         debug-disk-label? IF
-            ." GPT PReP partition found " cr
-         THEN
-         block gpt-part-entry>first-lba x@-le
-         block gpt-part-entry>last-lba x@-le
-         over - 1+                 ( addr offset len )
-         swap                      ( addr len offset )
-         block-size * to part-offset
-         0 0 seek drop             ( addr len )
-         block-size * read         ( size )
+         debug-disk-label? IF  ." GPT PReP partition found " cr THEN
+         block gpt-part-entry>first-lba x@-le ( addr first-lba )
+         block gpt-part-entry>last-lba x@-le  ( addr first-lba last-lba)
+         over - 1+                            ( addr first-lba blocks )
+         swap                                 ( addr blocks first-lba )
+         block-size * to part-offset          ( addr blocks )
+         0 0 seek drop                        ( addr blocks )
+         block-size * read                    ( size )
+         UNLOOP EXIT
+     THEN
+     seek-pos gpt-part-size + to seek-pos
+   LOOP
+   false
+;
+
+: try-gpt-dos-partition ( -- true|false )
+   get-gpt-partition 0= IF false EXIT THEN
+   block gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
+   1+ 1 ?DO
+      seek-pos 0 seek drop
+      block gpt-part-size read drop
+      gpt-basic-data-partition? IF
+         debug-disk-label? IF ." GPT BASIC DATA partition found " cr THEN
+         block gpt-part-entry>first-lba x@-le       ( first-lba )
+         dup to part-start                          ( first-lba )
+         block gpt-part-entry>last-lba x@-le        ( first-lba last-lba )
+         over - 1+                                  ( first-lba s1 )
+         block-size * to part-size                  ( first-lba )
+         block-size * to part-offset                ( )
+         0 0 seek drop
+         block block-size read drop
+         block fat-bootblock?                    ( true|false )
          UNLOOP EXIT
       THEN
-      seek-pos gpt-part-size i * + to seek-pos
+      seek-pos gpt-part-size + to seek-pos
    LOOP
    false
 ;
@@ -490,7 +549,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
    debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
    1 disk-chrp-boot !
-   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
+   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
    0 disk-chrp-boot !
 
    debug-disk-label? IF ." Trying GPT boot " .s cr THEN
@@ -590,6 +649,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : try-partitions ( -- found? )
    try-dos-partition IF try-files EXIT THEN
+   try-gpt-dos-partition IF try-files EXIT THEN
    \ try-iso9660-partition IF try-files EXIT THEN
    \ ... more partition types here...
    false
@@ -600,7 +660,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : close ( -- )
    debug-disk-label? IF ." Closing disk-label: block=0x" block u. ." block-size=" block-size .d cr THEN
-   block d# 4096 free-mem
+   block block-array-size free-mem
 ;
 
 
-- 
2.4.3
