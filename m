Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56C5E1A19A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:13:26 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Thu, 28 May 2015 14:13:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E8C617D8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:14:16 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4SDDK2n20054214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 13:13:20 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4SDDJAZ012741
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:13:20 -0600
Subject: [PATCH 2/3] fbuffer: introduce the invert-region helper
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 28 May 2015 15:13:19 +0200
Message-ID: <20150528131319.5240.4785.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
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

The inner loop in fb8-toggle-cursor can be implemented with hv-logical-memop
in board-qemu and get an incredible performance boost.

Let's introduce a per-board helper:
- board-js2x: slow RB based, taken from current fb8-toggle-cursor
- board-qemu: faster hv-logical-memop based

With standard graphical settings on board-qemu, we go from 512 hcall
invocations per character down to 16.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 board-js2x/slof/helper.fs |    4 ++++
 board-qemu/slof/helper.fs |    3 +++
 slof/fs/fbuffer.fs        |    2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/board-js2x/slof/helper.fs b/board-js2x/slof/helper.fs
index 34d60da..918fdc4 100644
--- a/board-js2x/slof/helper.fs
+++ b/board-js2x/slof/helper.fs
@@ -26,3 +26,7 @@
    s" , " $cat
    bdate2human $cat encode-string THEN
 ;
+
+: invert-region ( addr len -- )
+   0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
+;
diff --git a/board-qemu/slof/helper.fs b/board-qemu/slof/helper.fs
index 96da498..da676c7 100644
--- a/board-qemu/slof/helper.fs
+++ b/board-qemu/slof/helper.fs
@@ -33,3 +33,6 @@
   swap -
 ;
 
+: invert-region ( addr len -- )
+   over swap 0 swap 1 hv-logical-memop drop
+;
diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
index faae6a9..deeba6b 100644
--- a/slof/fs/fbuffer.fs
+++ b/slof/fs/fbuffer.fs
@@ -99,7 +99,7 @@ CREATE bitmap-buffer 400 4 * allot
 : fb8-toggle-cursor ( -- )
 	line# fb8-line2addr column# fb8-columns2bytes +
 	char-height 0 ?DO
-		dup char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
+		dup char-width screen-depth * invert-region
 		screen-width screen-depth * +
 	LOOP drop
 ;
