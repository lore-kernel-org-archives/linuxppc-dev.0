Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B4DD1A0FF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 21:35:49 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 602C71402BC
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 21:35:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 17:05:44 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 38C37125805E
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 17:08:29 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62BZgAR65863904
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 17:05:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62AREgu016554
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 15:57:14 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v4 2/4] introduce 8-byte LE helpers
Date: Thu,  2 Jul 2015 17:05:36 +0530
Message-Id: <1435836938-22889-3-git-send-email-nikunj@linux.vnet.ibm.com>
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
 slof/fs/little-endian.fs       | 6 ++++++
 slof/fs/packages/disk-label.fs | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/slof/fs/little-endian.fs b/slof/fs/little-endian.fs
index f2e4e8d..6b4779e 100644
--- a/slof/fs/little-endian.fs
+++ b/slof/fs/little-endian.fs
@@ -17,6 +17,9 @@ here c@ ef = CONSTANT ?littleendian
 
 ?bigendian [IF]
 
+: x!-le >r xbflip r> x! ;
+: x@-le x@ xbflip ;
+
 : l!-le  >r lbflip r> l! ;
 : l@-le  l@ lbflip ;
 
@@ -47,6 +50,9 @@ here c@ ef = CONSTANT ?littleendian
 
 [ELSE]
 
+: x!-le x! ;
+: x@-le x@ ;
+
 : l!-le  l! ;
 : l@-le  l@ ;
 
diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index f1f083a..b346774 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -383,8 +383,8 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
          debug-disk-label? IF
             ." GPT PReP partition found " cr
          THEN
-         block gpt-part-entry>first-lba x@ xbflip
-         block gpt-part-entry>last-lba x@ xbflip
+         block gpt-part-entry>first-lba x@-le
+         block gpt-part-entry>last-lba x@-le
          over - 1+                 ( addr offset len )
          swap                      ( addr len offset )
          block-size * to part-offset
-- 
2.4.3
