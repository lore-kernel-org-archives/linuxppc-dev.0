Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51A0B1A0FB8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:46:41 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BBAD1402ED
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 16:46:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AB2722BB003F
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P6kUxY16973952
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P6k57T022154
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:06 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v2 4/5] disk-label: introduce helper to check fat
 filesystem
Date: Thu, 25 Jun 2015 12:15:28 +0530
Message-Id: <1435214729-15952-5-git-send-email-nikunj@linux.vnet.ibm.com>
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 slof/fs/packages/disk-label.fs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index 0995808..7ed5526 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -321,6 +321,14 @@ CONSTANT /gpt-part-entry
 
 \ Load from first active DOS boot partition.
 
+: fat-bootblock? ( addr -- flag )
+   \ byte 0-2 of the bootblock is a jump instruction in
+   \ all FAT filesystems.
+   \ e9 and eb are jump instructions in x86 assembler.
+   dup c@ e9 = IF drop true EXIT THEN
+   dup c@ eb = swap 2+ c@ 90 = and
+;
+
 \ NOTE: block-size is always 512 bytes for DOS partition tables.
 
 : load-from-dos-boot-partition ( addr -- size )
@@ -549,14 +557,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 : try-dos-files ( -- found? )
    no-mbr? IF false EXIT THEN
 
-   \ disk-buf 0 byte 0-2 is a jump instruction in all FAT
-   \ filesystems.
-   \ e9 and eb are jump instructions in x86 assembler.
-   disk-buf c@ e9 <> IF
-      disk-buf c@ eb <>
-      disk-buf 2+ c@ 90 <> or
-      IF false EXIT THEN
-   THEN
+   disk-buf fat-bootblock? 0= IF false EXIT THEN
    s" fat-files" (interpose-filesystem)
    true
 ;
-- 
2.4.3
