Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 325BC1A1060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 21:02:25 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 029AD1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 21:02:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B0A1C3578048
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5UB2EVa61145092
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5UB1nT1029038
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:01:49 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v3 4/5] disk-label: introduce helper to check fat
 filesystem
Date: Tue, 30 Jun 2015 16:31:20 +0530
Message-Id: <1435662081-4293-5-git-send-email-nikunj@linux.vnet.ibm.com>
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 slof/fs/packages/disk-label.fs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index e5a0546..347dc5d 100644
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
@@ -548,14 +556,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
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
