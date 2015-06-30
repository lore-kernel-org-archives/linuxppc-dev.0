Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E70A21A1024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 21:02:20 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC0CA1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:20 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 21:02:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8DA552CE804E
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:16 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5UB288845023474
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5UB1h9L028847
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:01:44 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v3 1/5] disk-label: simplify gpt-prep-partition? routine
Date: Tue, 30 Jun 2015 16:31:17 +0530
Message-Id: <1435662081-4293-2-git-send-email-nikunj@linux.vnet.ibm.com>
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
 slof/fs/packages/disk-label.fs | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index fe1c25e..f1f083a 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -352,42 +352,31 @@ CONSTANT /gpt-part-entry
    drop 0
 ;
 
-\ Check for GPT PReP partition GUID
-9E1A2D38     CONSTANT GPT-PREP-PARTITION-1
-C612         CONSTANT GPT-PREP-PARTITION-2
-4316         CONSTANT GPT-PREP-PARTITION-3
-AA26         CONSTANT GPT-PREP-PARTITION-4
-8B49521E5A8B CONSTANT GPT-PREP-PARTITION-5
+\ Check for GPT PReP partition GUID. Only first 3 blocks are
+\ byte-swapped treating last two blocks as contigous for simplifying
+\ comparison
+9E1A2D38            CONSTANT GPT-PREP-PARTITION-1
+C612                CONSTANT GPT-PREP-PARTITION-2
+4316                CONSTANT GPT-PREP-PARTITION-3
+AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
 
 : gpt-prep-partition? ( -- true|false )
-   block gpt-part-entry>part-type-guid l@-le GPT-PREP-PARTITION-1 = IF
-      block gpt-part-entry>part-type-guid 4 + w@-le
-      GPT-PREP-PARTITION-2 = IF
-         block gpt-part-entry>part-type-guid 6 + w@-le
-         GPT-PREP-PARTITION-3 = IF
-            block gpt-part-entry>part-type-guid 8 + w@
-            GPT-PREP-PARTITION-4 = IF
-               block gpt-part-entry>part-type-guid a + w@
-               block gpt-part-entry>part-type-guid c + l@ swap lxjoin
-               GPT-PREP-PARTITION-5 = IF
-                   TRUE EXIT
-               THEN
-            THEN
-         THEN
-      THEN
-   THEN
-   FALSE
+   block gpt-part-entry>part-type-guid
+   dup l@-le     GPT-PREP-PARTITION-1 <> IF drop false EXIT THEN
+   dup 4 + w@-le GPT-PREP-PARTITION-2 <> IF drop false EXIT THEN
+   dup 6 + w@-le GPT-PREP-PARTITION-3 <> IF drop false EXIT THEN
+       8 + x@    GPT-PREP-PARTITION-4 =
 ;
 
 : load-from-gpt-prep-partition ( addr -- size )
-   no-gpt? IF drop FALSE EXIT THEN
+   no-gpt? IF drop false EXIT THEN
    debug-disk-label? IF
       cr ." GPT partition found " cr
    THEN
    1 read-sector block gpt>part-entry-lba l@-le
    block-size * to seek-pos
    block gpt>part-entry-size l@-le to gpt-part-size
-   block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
+   block gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
    1+ 1 ?DO
       seek-pos 0 seek drop
       block gpt-part-size read drop gpt-prep-partition? IF
@@ -405,7 +394,7 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
       THEN
       seek-pos gpt-part-size i * + to seek-pos
    LOOP
-   FALSE
+   false
 ;
 
 \ Extract the boot loader path from a bootinfo.txt file
-- 
2.4.3
