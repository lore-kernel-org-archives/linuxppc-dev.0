Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 931371A0CA4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 18:00:04 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB11B140310
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 18:00:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 13:29:54 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 610D0394006A
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:52 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5M7xpJR61735010
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5M7xnve008363
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:51 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, dvaleev@suse.com,
 nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF 4/5] disk-label: add support for booting from GPT FAT
 partition
Date: Mon, 22 Jun 2015 13:29:46 +0530
Message-Id: <1434959987-8530-5-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
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

The patch add support to read from BASIC_DATA UUID
partition. Installer has installed CHRP-BOOT config on a FAT file
system.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 slof/fs/packages/disk-label.fs | 54 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index e317e93..821e959 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -266,7 +266,10 @@ CONSTANT /gpt-part-entry
 
 : try-dos-partition ( -- okay? )
    \ Read partition table and check magic.
-   no-mbr? IF cr ." No DOS disk-label found." cr false EXIT THEN
+   no-mbr? IF
+       debug-disk-label? IF cr ." No DOS disk-label found." cr THEN
+       false EXIT
+   THEN
 
    count-dos-logical-partitions TO dos-logical-partitions
 
@@ -381,18 +384,38 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
    TRUE
 ;
 
-: load-from-gpt-prep-partition ( addr -- size )
+\ Check for GPT MSFT BASIC DATA GUID - fat based
+EBD0A0A2            CONSTANT GPT-BASIC-DATA-PARTITION-1
+B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
+4433                CONSTANT GPT-BASIC-DATA-PARTITION-3
+87C068B6B72699C7    CONSTANT GPT-BASIC-DATA-PARTITION-4
+
+: gpt-basic-data-partition? ( -- true|false )
+   block gpt-part-entry>part-type-guid
+   dup l@-le     GPT-BASIC-DATA-PARTITION-1 <> IF DROP FALSE EXIT THEN
+   dup 4 + w@-le GPT-BASIC-DATA-PARTITION-2 <> IF DROP FALSE EXIT THEN
+   dup 6 + w@-le GPT-BASIC-DATA-PARTITION-3 <> IF DROP FALSE EXIT THEN
+       8 + x@    GPT-BASIC-DATA-PARTITION-4 <> IF FALSE EXIT THEN
+   TRUE
+;
+
+\ Can be called from two path
+\ 1) load-from-boot-partition for GPT PReP partition
+\ 2) try-partitions for gpt basic data partition having fat chrp-boot
+\
+: load-from-gpt-partition ( [ addr ] -- size | TRUE )
    no-gpt? IF drop FALSE EXIT THEN
    debug-disk-label? IF
       cr ." GPT partition found " cr
    THEN
-   1 read-sector block gpt>part-entry-lba l@-le
+   1 read-sector block gpt>part-entry-lba x@-le
    block-size * to seek-pos
    block gpt>part-entry-size l@-le to gpt-part-size
    block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
    1+ 1 ?DO
       seek-pos 0 seek drop
-      block gpt-part-size read drop gpt-prep-partition? IF
+       block gpt-part-size read drop
+       gpt-prep-partition? IF
          debug-disk-label? IF
             ." GPT PReP partition found " cr
          THEN
@@ -404,6 +427,24 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
          0 0 seek drop             ( addr len )
          block-size * read         ( size )
          UNLOOP EXIT
+     THEN
+     gpt-basic-data-partition? IF
+         debug-disk-label? IF
+            ." GPT LINUX DATA partition found " cr
+         THEN
+         block gpt-part-entry>first-lba x@ xbflip
+         dup to part-start
+         block gpt-part-entry>last-lba x@ xbflip
+         over - 1+                 ( addr offset len )
+         dup block-size * to part-size
+         swap                      ( addr len offset )
+         block-size * to part-offset
+         0 0 seek
+         block block-size read
+         3drop
+         block has-fat-filesystem 0= IF false UNLOOP EXIT THEN
+         TRUE
+         UNLOOP EXIT
       THEN
       seek-pos gpt-part-size i * + to seek-pos
    LOOP
@@ -495,11 +536,11 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
    debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
    1 disk-chrp-boot !
-   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
+   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
    0 disk-chrp-boot !
 
    debug-disk-label? IF ." Trying GPT boot " .s cr THEN
-   load-from-gpt-prep-partition
+   load-from-gpt-partition
    \ More boot partition formats ...
 ;
 
@@ -594,6 +635,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : try-partitions ( -- found? )
    try-dos-partition IF try-files EXIT THEN
+   load-from-gpt-partition IF try-files EXIT THEN
    \ try-iso9660-partition IF try-files EXIT THEN
    \ ... more partition types here...
    false
-- 
1.8.3.1
