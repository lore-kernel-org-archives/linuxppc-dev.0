Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0B801A0FFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 21:35:48 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 177C31402BA
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 21:35:47 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 17:05:42 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E96A5394005B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 17:05:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62BZg3u54001764
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 17:05:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62AREPY016592
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 15:57:15 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v4 3/4] disk-label: introduce helper to check fat
 filesystem
Date: Thu,  2 Jul 2015 17:05:37 +0530
Message-Id: <1435836938-22889-4-git-send-email-nikunj@linux.vnet.ibm.com>
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 slof/fs/packages/disk-label.fs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index b346774..142e54f 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -320,6 +320,14 @@ CONSTANT /gpt-part-entry
 
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
@@ -547,14 +555,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 : try-dos-files ( -- found? )
    no-mbr? IF false EXIT THEN
 
-   \ block 0 byte 0-2 is a jump instruction in all FAT
-   \ filesystems.
-   \ e9 and eb are jump instructions in x86 assembler.
-   block c@ e9 <> IF
-      block c@ eb <>
-      block 2+ c@ 90 <> or
-      IF false EXIT THEN
-   THEN
+   block fat-bootblock? 0= IF false EXIT THEN
    s" fat-files" (interpose-filesystem)
    true
 ;
-- 
2.4.3
