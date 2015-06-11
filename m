Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE751A0615
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 20:19:58 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C41CF1402AD
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 20:19:58 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 20:19:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AB149357804F
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 20:19:51 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5BAJhfC49283234
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 20:19:51 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5BAJJHx007766
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 20:19:19 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, dvaleev@suse.com,
 nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF] disk-label: add support for booting from GPT FAT
 partition
Date: Thu, 11 Jun 2015 15:48:49 +0530
Message-Id: <1434017929-1792-1-git-send-email-nikunj@linux.vnet.ibm.com>
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
 slof/fs/packages/disk-label.fs | 72 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index fe1c25e..bf5fb5c 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -266,7 +266,7 @@ CONSTANT /gpt-part-entry
 
 : try-dos-partition ( -- okay? )
    \ Read partition table and check magic.
-   no-mbr? IF cr ." No DOS disk-label found." cr false EXIT THEN
+   no-mbr? IF false EXIT THEN
 
    count-dos-logical-partitions TO dos-logical-partitions
 
@@ -408,6 +408,73 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
    FALSE
 ;
 
+\ Check for GPT MSFT BASIC DATA GUID - vfat based
+EBD0A0A2     CONSTANT GPT-BASIC-DATA-PARTITION-1
+B9E5         CONSTANT GPT-BASIC-DATA-PARTITION-2
+4433         CONSTANT GPT-BASIC-DATA-PARTITION-3
+87C0         CONSTANT GPT-BASIC-DATA-PARTITION-4
+68B6B72699C7 CONSTANT GPT-BASIC-DATA-PARTITION-5
+
+: gpt-basic-data-partition? ( -- true|false )
+   block gpt-part-entry>part-type-guid l@-le GPT-BASIC-DATA-PARTITION-1 = IF
+      block gpt-part-entry>part-type-guid 4 + w@-le
+      GPT-BASIC-DATA-PARTITION-2 = IF
+         block gpt-part-entry>part-type-guid 6 + w@-le
+         GPT-BASIC-DATA-PARTITION-3 = IF
+            block gpt-part-entry>part-type-guid 8 + w@
+            GPT-BASIC-DATA-PARTITION-4 = IF
+               block gpt-part-entry>part-type-guid a + w@
+               block gpt-part-entry>part-type-guid c + l@ swap lxjoin
+               GPT-BASIC-DATA-PARTITION-5 = IF
+                   TRUE EXIT
+               THEN
+            THEN
+         THEN
+      THEN
+   THEN
+   FALSE
+;
+
+: try-gpt-vfat-partition ( -- okay? )
+   \ Read partition table and check magic.
+   no-gpt? IF cr ." No GPT disk-label found." cr false EXIT THEN
+   1 read-sector block gpt>part-entry-lba l@-le
+   block-size * to seek-pos
+   block gpt>part-entry-size l@-le to gpt-part-size
+   block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
+   1+ 1 ?DO
+      seek-pos 0 seek drop
+      block gpt-part-size read drop
+      gpt-basic-data-partition? IF
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
+         \ block 0 byte 0-2 is a jump instruction in all FAT
+         \ filesystems.
+         \ e9 and eb are jump instructions in x86 assembler.
+         block c@ e9 <> IF
+            block c@ eb <>
+            block 2+ c@ 90 <> or
+            IF false EXIT THEN
+         THEN
+         TRUE
+         UNLOOP EXIT
+      THEN
+      seek-pos gpt-part-size i * + to seek-pos
+    LOOP
+    FALSE
+;
+
 \ Extract the boot loader path from a bootinfo.txt file
 \ In: address and length of buffer where the bootinfo.txt has been loaded to.
 \ Out: string address and length of the boot loader (within the input buffer)
@@ -493,7 +560,7 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
 
    debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
    1 disk-chrp-boot !
-   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
+   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
    0 disk-chrp-boot !
 
    debug-disk-label? IF ." Trying GPT boot " .s cr THEN
@@ -600,6 +667,7 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
 
 : try-partitions ( -- found? )
    try-dos-partition IF try-files EXIT THEN
+   try-gpt-vfat-partition IF try-files EXIT THEN
    \ try-iso9660-partition IF try-files EXIT THEN
    \ ... more partition types here...
    false
-- 
1.8.3.1
