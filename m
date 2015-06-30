Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B9F41A103F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 21:02:23 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5881A1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 21:02:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D9B2A2BB003F
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:19 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5UB2BUW29950092
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5UB1lxt028986
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:01:47 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v3 3/5] disk-label: rename confusing "block" word
Date: Tue, 30 Jun 2015 16:31:19 +0530
Message-Id: <1435662081-4293-4-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"block" word is not a block number, actually its an allocated host
address.  Rename it to disk-buf along with a associated
size(disk-buf-size=4096) for using during allocation/free.

Also renaming the helper routine read-sector to read-disk-buf. This
routine assumes the address to be disk-buf and only takes sector number
as argument.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 slof/fs/packages/disk-label.fs | 78 ++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index b346774..e5a0546 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -33,7 +33,8 @@ s" disk-label" device-name
 0 INSTANCE VALUE dos-logical-partitions
 
 0 INSTANCE VALUE block-size
-0 INSTANCE VALUE block
+0 INSTANCE VALUE disk-buf
+d# 4096    VALUE disk-buf-size
 
 0 INSTANCE VALUE args
 0 INSTANCE VALUE args-len
@@ -126,11 +127,11 @@ CONSTANT /gpt-part-entry
 ;
 
 
-\ read sector to array "block"
-: read-sector ( sector-number -- )
+\ read sector to array "disk-buf"
+: read-disk-buf ( sector-number -- )
    \ block-size is 0x200 on disks, 0x800 on cdrom drives
    block-size * 0 seek drop      \ seek to sector
-   block block-size read drop    \ read sector
+   disk-buf block-size read drop    \ read sector
 ;
 
 : (.part-entry) ( part-entry )
@@ -149,35 +150,35 @@ CONSTANT /gpt-part-entry
 
 : (.name) r@ begin cell - dup @ <colon> = UNTIL xt>name cr type space ;
 
-: init-block ( -- )
+: init-disk-buf ( -- )
    s" block-size" ['] $call-parent CATCH IF ABORT" parent has no block-size." THEN
    to block-size
-   d# 4096 alloc-mem
-   dup d# 4096 erase
-   to block
+   disk-buf-size alloc-mem
+   dup disk-buf-size erase
+   to disk-buf
    debug-disk-label? IF
-      ." init-block: block-size=" block-size .d ." block=0x" block u. cr
+      ." init-disk-buf: block-size=" block-size .d ." disk-buf=0x" disk-buf u. cr
    THEN
 ;
 
 : partition>part-entry ( partition -- part-entry )
-   1- /partition-entry * block mbr>partition-table +
+   1- /partition-entry * disk-buf mbr>partition-table +
 ;
 
 : partition>start-sector ( partition -- sector-offset )
    partition>part-entry part-entry>sector-offset l@-le
 ;
 
-\ This word returns true if the currently loaded block has _NO_ MBR magic
+\ This word returns true if the currently loaded disk-buf has _NO_ MBR magic
 : no-mbr? ( -- true|false )
-   0 read-sector
+   0 read-disk-buf
    1 partition>part-entry part-entry>id c@ ee = IF TRUE EXIT THEN \ GPT partition found
-   block mbr>magic w@-le aa55 <>
+   disk-buf mbr>magic w@-le aa55 <>
 ;
 
-\ This word returns true if the currently loaded block has _NO_ GPT partition id
+\ This word returns true if the currently loaded disk-buf has _NO_ GPT partition id
 : no-gpt? ( -- true|false )
-   0 read-sector
+   0 read-disk-buf
    1 partition>part-entry part-entry>id c@ ee <>
 ;
 
@@ -197,7 +198,7 @@ CONSTANT /gpt-part-entry
          part-entry>sector-offset l@-le    ( current sector )
          dup to part-start to lpart-start  ( current )
          BEGIN
-            part-start read-sector          \ read EBR
+            part-start read-disk-buf          \ read EBR
             1 partition>start-sector IF
                \ ." Logical Partition found at " part-start .d cr
                1+
@@ -240,7 +241,7 @@ CONSTANT /gpt-part-entry
             part-entry>sector-offset l@-le        ( log-part current sector )
             dup to part-start to lpart-start      ( log-part current )
             BEGIN
-               part-start read-sector             \ read EBR
+               part-start read-disk-buf             \ read EBR
                1 partition>start-sector IF        \ first partition entry
                   1+ 2dup = IF                    ( log-part current )
                      2drop
@@ -306,13 +307,13 @@ CONSTANT /gpt-part-entry
 : has-iso9660-filesystem  ( -- TRUE|FALSE )
    \ Seek to the beginning of logical 2048-byte sector 16
    \ refer to Chapter C.11.1 in PAPR 2.0 Spec
-   \ was: 10 read-sector, but this might cause trouble if you
+   \ was: 10 read-disk-buf, but this might cause trouble if you
    \ try booting an ISO image from a device with 512b sectors.
    10 800 * 0 seek drop      \ seek to sector
-   block 800 read drop       \ read sector
+   disk-buf 800 read drop       \ read sector
    \ Check for CD-ROM volume magic:
-   block c@ 1 =
-   block 1+ 5 s" CD001"  str=
+   disk-buf c@ 1 =
+   disk-buf 1+ 5 s" CD001"  str=
    and
    dup IF 800 to block-size THEN
 ;
@@ -361,7 +362,7 @@ C612                CONSTANT GPT-PREP-PARTITION-2
 AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : gpt-prep-partition? ( -- true|false )
-   block gpt-part-entry>part-type-guid
+   disk-buf gpt-part-entry>part-type-guid
    dup l@-le     GPT-PREP-PARTITION-1 <> IF drop false EXIT THEN
    dup 4 + w@-le GPT-PREP-PARTITION-2 <> IF drop false EXIT THEN
    dup 6 + w@-le GPT-PREP-PARTITION-3 <> IF drop false EXIT THEN
@@ -373,18 +374,18 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
    debug-disk-label? IF
       cr ." GPT partition found " cr
    THEN
-   1 read-sector block gpt>part-entry-lba l@-le
+   1 read-disk-buf disk-buf gpt>part-entry-lba l@-le
    block-size * to seek-pos
-   block gpt>part-entry-size l@-le to gpt-part-size
-   block gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
+   disk-buf gpt>part-entry-size l@-le to gpt-part-size
+   disk-buf gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
    1+ 1 ?DO
       seek-pos 0 seek drop
-      block gpt-part-size read drop gpt-prep-partition? IF
+      disk-buf gpt-part-size read drop gpt-prep-partition? IF
          debug-disk-label? IF
             ." GPT PReP partition found " cr
          THEN
-         block gpt-part-entry>first-lba x@-le
-         block gpt-part-entry>last-lba x@-le
+         disk-buf gpt-part-entry>first-lba x@-le
+         disk-buf gpt-part-entry>last-lba x@-le
          over - 1+                 ( addr offset len )
          swap                      ( addr len offset )
          block-size * to part-offset
@@ -547,12 +548,12 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 : try-dos-files ( -- found? )
    no-mbr? IF false EXIT THEN
 
-   \ block 0 byte 0-2 is a jump instruction in all FAT
+   \ disk-buf 0 byte 0-2 is a jump instruction in all FAT
    \ filesystems.
    \ e9 and eb are jump instructions in x86 assembler.
-   block c@ e9 <> IF
-      block c@ eb <>
-      block 2+ c@ 90 <> or
+   disk-buf c@ e9 <> IF
+      disk-buf c@ eb <>
+      disk-buf 2+ c@ 90 <> or
       IF false EXIT THEN
    THEN
    s" fat-files" (interpose-filesystem)
@@ -560,8 +561,8 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 ;
 
 : try-ext2-files ( -- found? )
-   2 read-sector               \ read first superblock
-   block d# 56 + w@-le         \ fetch s_magic
+   2 read-disk-buf               \ read first superblock
+   disk-buf d# 56 + w@-le         \ fetch s_magic
    ef53 <> IF false EXIT THEN  \ s_magic found?
    s" ext2-files" (interpose-filesystem)
    true
@@ -598,13 +599,16 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 \ as defined by IEEE 1275-1994 3.8.1
 
 : close ( -- )
-   debug-disk-label? IF ." Closing disk-label: block=0x" block u. ." block-size=" block-size .d cr THEN
-   block d# 4096 free-mem
+   debug-disk-label? IF
+      ." Closing disk-label: disk-buf=0x" disk-buf u.
+      ." block-size=" block-size .d cr
+   THEN
+   disk-buf disk-buf-size free-mem
 ;
 
 
 : open ( -- true|false )
-   init-block
+   init-disk-buf
 
    parse-partition 0= IF
       close
-- 
2.4.3
