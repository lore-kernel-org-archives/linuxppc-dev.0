Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E800F1A0736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:46:38 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B191E1402ED
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 16:46:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A49C43578048
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P6kRKB54788208
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P6k2JX022063
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:03 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v2 2/5] introduce 8-byte LE helpers
Date: Thu, 25 Jun 2015 12:15:26 +0530
Message-Id: <1435214729-15952-3-git-send-email-nikunj@linux.vnet.ibm.com>
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
index bb64d57..8c93cfb 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -384,8 +384,8 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
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
