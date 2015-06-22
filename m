Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B83AA1A0F81
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 18:00:18 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 935C4140319
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 18:00:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 13:29:55 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B2B88125804F
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:32:29 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5M7xpOD33358058
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5M7xnq9008356
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:50 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, dvaleev@suse.com,
 nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF 3/5] disk-label: introduce helper to check fat filesystem
Date: Mon, 22 Jun 2015 13:29:45 +0530
Message-Id: <1434959987-8530-4-git-send-email-nikunj@linux.vnet.ibm.com>
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 slof/fs/packages/disk-label.fs | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index 2cf1b85..e317e93 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -320,6 +320,18 @@ CONSTANT /gpt-part-entry
 
 \ Load from first active DOS boot partition.
 
+: has-fat-filesystem ( block -- true | false )
+   \ block 0 byte 0-2 is a jump instruction in all FAT
+   \ filesystems.
+   \ e9 and eb are jump instructions in x86 assembler.
+   dup c@ e9 <> IF
+      dup c@ eb <> swap
+      2+  c@ 90 <> or
+      IF false EXIT THEN
+   ELSE DROP THEN
+   TRUE
+;
+
 \ NOTE: block-size is always 512 bytes for DOS partition tables.
 
 : load-from-dos-boot-partition ( addr -- size )
@@ -547,15 +559,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : try-dos-files ( -- found? )
    no-mbr? IF false EXIT THEN
-
-   \ block 0 byte 0-2 is a jump instruction in all FAT
-   \ filesystems.
-   \ e9 and eb are jump instructions in x86 assembler.
-   block c@ e9 <> IF
-      block c@ eb <>
-      block 2+ c@ 90 <> or
-      IF false EXIT THEN
-   THEN
+   block has-fat-filesystem 0= IF false EXIT THEN
    s" fat-files" (interpose-filesystem)
    true
 ;
-- 
1.8.3.1
