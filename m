Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 903F51A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:15 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:13 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EDF556E803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:54 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t93164553168
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t8a3012236
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 10/16] Implement measurements of the master boot record
Date: Fri,  7 Aug 2015 21:54:59 -0400
Message-Id: <1438998905-4085665-11-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for measuring the boot block of the
MBR and logging the measurement.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-js2x/slof/OF.fs          |  2 ++
 slof/fs/packages/disk-label.fs |  6 +++++-
 slof/fs/tpm/tpm-static.fs      | 13 +++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/board-js2x/slof/OF.fs b/board-js2x/slof/OF.fs
index 3e37735..8e736c7 100644
--- a/board-js2x/slof/OF.fs
+++ b/board-js2x/slof/OF.fs
@@ -255,6 +255,8 @@ create vpd-bootlist 4 allot
 #include <usb/usb-static.fs>
 320 cp
 #include <scsi-loader.fs>
+\\ need tpm-static for verbs in disk-labels.fs
+#include <tpm/tpm-static.fs>
 #include <root.fs>
 360 cp
 #include "tree.fs"
diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
index e034d64..f827d72 100644
--- a/slof/fs/packages/disk-label.fs
+++ b/slof/fs/packages/disk-label.fs
@@ -545,7 +545,11 @@ B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
 \ load from a bootable partition
 : load-from-boot-partition ( addr -- size )
    debug-disk-label? IF ." Trying DOS boot " .s cr THEN
-   dup load-from-dos-boot-partition ?dup 0 <> IF nip EXIT THEN
+   dup load-from-dos-boot-partition ?dup 0 <> IF
+      nip
+      80 block 200 vtpm-add-bcv
+      EXIT
+   THEN
 
    debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
    1 disk-chrp-boot !
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index 7954be2..bc5138a 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -44,6 +44,19 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+: vtpm-add-bcv ( boodrv addr length -- )
+    vtpm-available? IF
+        tpm-add-bcv                                    ( -- errcode )
+        vtpm-debug? IF
+            ." VTPM: Error code from tpm-add-bootdevice-ipl: " . cr
+        ELSE
+            drop
+        THEN
+    ELSE
+        3drop
+    THEN
+;
+
 1 CONSTANT TPM_ST_ENABLED
 2 CONSTANT TPM_ST_ACTIVE
 4 CONSTANT TPM_ST_OWNED
-- 
1.9.3
