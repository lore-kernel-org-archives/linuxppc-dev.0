Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD3CD1A0FBF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:46:42 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96E3C1402ED
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 16:46:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D1F42BB0047
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P6kVLf61734990
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P6k7OL022211
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:07 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v2 5/5] disk-label: add support for booting from GPT FAT
 partition
Date: Thu, 25 Jun 2015 12:15:29 +0530
Message-Id: <1435214729-15952-6-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1435214729-15952-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435214729-15952-1-git-send-email-nikunj@linux.vnet.ibm.com>
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
* Check for Protective MBR Magic
* Check for valid GPT Signature
* Boundary check for allocated block size before reading into the
  buffer

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 slof/fs/packages/disk-label.fs | 96 +++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 20 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index 7ed5526..e5759a3 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -179,7 +179,8 @@ CONSTANT /gpt-part-entry
 \ This word returns true if the currently loaded disk-buf has _NO_ GPT partition id
 : no-gpt? ( -- true|false )
    0 read-disk-buf
-   1 partition>part-entry part-entry>id c@ ee <>
+   1 partition>part-entry part-entry>id c@ ee <> IF true EXIT THEN
+   disk-buf mbr>magic w@-le aa55 <>
 ;
 
 : pc-extended-partition? ( part-entry-addr -- true|false )
@@ -267,7 +268,10 @@ CONSTANT /gpt-part-entry
 
 : try-dos-partition ( -- okay? )
    \ Read partition table and check magic.
-   no-mbr? IF cr ." No DOS disk-label found." cr false EXIT THEN
+   no-mbr? IF
+       debug-disk-label? IF cr ." No DOS disk-label found." cr THEN
+       false EXIT
+   THEN
 
    count-dos-logical-partitions TO dos-logical-partitions
 
@@ -378,29 +382,80 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
    true
 ;
 
-: load-from-gpt-prep-partition ( addr -- size )
-   no-gpt? IF drop false EXIT THEN
-   debug-disk-label? IF
-      cr ." GPT partition found " cr
-   THEN
-   1 read-disk-buf disk-buf gpt>part-entry-lba l@-le
+\ Check for GPT MSFT BASIC DATA GUID - fat based
+EBD0A0A2            CONSTANT GPT-BASIC-DATA-PARTITION-1
+B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
+4433                CONSTANT GPT-BASIC-DATA-PARTITION-3
+87C068B6B72699C7    CONSTANT GPT-BASIC-DATA-PARTITION-4
+
+: gpt-basic-data-partition? ( -- true|false )
+   disk-buf gpt-part-entry>part-type-guid
+   dup l@-le     GPT-BASIC-DATA-PARTITION-1 <> IF drop false EXIT THEN
+   dup 4 + w@-le GPT-BASIC-DATA-PARTITION-2 <> IF drop false EXIT THEN
+   dup 6 + w@-le GPT-BASIC-DATA-PARTITION-3 <> IF drop false EXIT THEN
+       8 + x@    GPT-BASIC-DATA-PARTITION-4 <> IF false EXIT THEN
+   true
+;
+
+\
+\ GPT Signature
+\ ("EFI PART", 45h 46h 49h 20h 50h 41h 52h 54h)
+\
+4546492050415254 CONSTANT GPT-SIGNATURE
+
+: verify-gpt-partition ( -- true | false )
+   no-gpt? IF false EXIT THEN
+   debug-disk-label? IF cr ." GPT partition found " cr  THEN
+   1 read-disk-buf
+   disk-buf gpt>part-entry-lba x@-le
    block-size * to seek-pos
    disk-buf gpt>part-entry-size l@-le to gpt-part-size
-   disk-buf gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
+   gpt-part-size disk-buf-size > IF
+      cr ." GPT part size exceeds buffer allocated " cr
+      false exit
+   THEN
+   disk-buf gpt>signature x@ GPT-SIGNATURE =
+;
+
+: load-from-gpt-prep-partition ( addr -- size )
+   verify-gpt-partition 0= IF false EXIT THEN
+   disk-buf gpt>num-part-entry l@-le dup 0= IF false exit THEN
    1+ 1 ?DO
       seek-pos 0 seek drop
       disk-buf gpt-part-size read drop gpt-prep-partition? IF
-         debug-disk-label? IF
-            ." GPT PReP partition found " cr
-         THEN
-         disk-buf gpt-part-entry>first-lba x@-le
-         disk-buf gpt-part-entry>last-lba x@-le
-         over - 1+                 ( addr offset len )
-         swap                      ( addr len offset )
-         block-size * to part-offset
-         0 0 seek drop             ( addr len )
-         block-size * read         ( size )
+         debug-disk-label? IF  ." GPT PReP partition found " cr THEN
+         disk-buf gpt-part-entry>first-lba x@-le ( addr first-lba )
+         disk-buf gpt-part-entry>last-lba x@-le  ( addr first-lba last-lba)
+         over - 1+                            ( addr first-lba blocks )
+         swap                                 ( addr blocks )
+         block-size * to part-offset          ( addr blocks )
+         0 0 seek drop                        ( addr blocks )
+         block-size * read                    ( size )
          UNLOOP EXIT
+     THEN
+     seek-pos gpt-part-size i * + to seek-pos
+   LOOP
+   false
+;
+
+: try-gpt-dos-partition ( -- true | false )
+   verify-gpt-partition 0= IF false EXIT THEN
+   disk-buf gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
+   1+ 1 ?DO
+      seek-pos 0 seek drop
+      disk-buf gpt-part-size read drop
+      gpt-basic-data-partition? IF
+         debug-disk-label? IF ." GPT LINUX DATA partition found " cr THEN
+         disk-buf gpt-part-entry>first-lba x@-le       ( first-lba )
+         dup to part-start                          ( first-lba )
+         disk-buf gpt-part-entry>last-lba x@-le        ( first-lba last-lba )
+         over - 1+                                  ( first-lba s1 )
+         block-size * to part-size                  ( first-lba )
+         block-size * to part-offset                ( )
+         0 0 seek drop                              ( )
+         disk-buf block-size read drop                 ( )
+         disk-buf fat-bootblock? 0= IF false UNLOOP EXIT THEN
+         true UNLOOP EXIT
       THEN
       seek-pos gpt-part-size i * + to seek-pos
    LOOP
@@ -492,7 +547,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
    debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
    1 disk-chrp-boot !
-   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
+   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
    0 disk-chrp-boot !
 
    debug-disk-label? IF ." Trying GPT boot " .s cr THEN
@@ -592,6 +647,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : try-partitions ( -- found? )
    try-dos-partition IF try-files EXIT THEN
+   try-gpt-dos-partition IF try-files EXIT THEN
    \ try-iso9660-partition IF try-files EXIT THEN
    \ ... more partition types here...
    false
-- 
2.4.3
