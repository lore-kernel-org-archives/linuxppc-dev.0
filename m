Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00C011A191C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:13:31 +1000 (AEST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Thu, 28 May 2015 14:13:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2410817D8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:14:21 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4SDDP4B24445170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 13:13:25 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4SDDP2e002787
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:13:25 -0600
Subject: [PATCH 3/3] fbuffer: introduce the invert-region-x helper
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 28 May 2015 15:13:24 +0200
Message-ID: <20150528131324.5240.37470.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch simply moves the slow RX based logic from fb8-invert-screen
to board-js2x helpers and implement a fast hv-logical-memop based helper
for board-qemu. And we can drop hcall-invert-screen !

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 board-js2x/slof/helper.fs               |    5 +++++
 board-qemu/slof/helper.fs               |    4 ++++
 board-qemu/slof/pci-device_1234_1111.fs |   10 +---------
 slof/fs/fbuffer.fs                      |    4 +---
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/board-js2x/slof/helper.fs b/board-js2x/slof/helper.fs
index 918fdc4..ea2d584 100644
--- a/board-js2x/slof/helper.fs
+++ b/board-js2x/slof/helper.fs
@@ -30,3 +30,8 @@
 : invert-region ( addr len -- )
    0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
 ;
+
+
+: invert-region-x ( addr len -- )
+   /x / 0 ?DO dup dup rx@ -1 xor swap rx! xa1+ LOOP drop
+;
diff --git a/board-qemu/slof/helper.fs b/board-qemu/slof/helper.fs
index da676c7..c807bc6 100644
--- a/board-qemu/slof/helper.fs
+++ b/board-qemu/slof/helper.fs
@@ -36,3 +36,7 @@
 : invert-region ( addr len -- )
    over swap 0 swap 1 hv-logical-memop drop
 ;
+
+: invert-region-x ( addr len -- )
+   over swap /x / 3 swap 1 hv-logical-memop drop
+;
diff --git a/board-qemu/slof/pci-device_1234_1111.fs b/board-qemu/slof/pci-device_1234_1111.fs
index a5c3584..26b0623 100644
--- a/board-qemu/slof/pci-device_1234_1111.fs
+++ b/board-qemu/slof/pci-device_1234_1111.fs
@@ -188,16 +188,9 @@ a CONSTANT VBE_DISPI_INDEX_NB
 : display-remove ( -- ) 
 ;
 
-: hcall-invert-screen ( -- )
-    frame-buffer-adr frame-buffer-adr 3
-    screen-height screen-width * screen-depth * /x /
-    1 hv-logical-memop
-    drop
-;
-
 : hcall-blink-screen ( -- )
     \ 32 msec delay for visually noticing the blink
-    hcall-invert-screen 20 ms hcall-invert-screen
+    invert-screen 20 ms invert-screen
 ;
 
 : display-install ( -- )
@@ -211,7 +204,6 @@ a CONSTANT VBE_DISPI_INDEX_NB
         disp-width char-width / disp-height char-height /
         disp-depth 7 + 8 /                      ( width height #lines #cols depth )
         fb-install
-	['] hcall-invert-screen to invert-screen
 	['] hcall-blink-screen to blink-screen
          true to is-installed?
     THEN
diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
index deeba6b..fcdd2fa 100644
--- a/slof/fs/fbuffer.fs
+++ b/slof/fs/fbuffer.fs
@@ -170,9 +170,7 @@ CREATE bitmap-buffer 400 4 * allot
 ;
 
 : fb8-invert-screen ( -- )
-	frame-buffer-adr screen-height screen-width * screen-depth * 2dup /x / 0 ?DO
-		dup rx@ -1 xor over rx! xa1+
-	LOOP 3drop
+	frame-buffer-adr screen-height screen-width * screen-depth * invert-region-x
 ;
 
 : fb8-blink-screen ( -- ) fb8-invert-screen fb8-invert-screen ;
