Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3A0A1A0679
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 10:11:23 +1000 (AEST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 27 May 2015 01:11:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14C3A2190046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 01:10:57 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4R0BGwM26149034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 00:11:16 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4R0BFhr020775
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 18:11:16 -0600
Subject: [PATCH] fbuffer: improve toggle cursor performance
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 May 2015 02:11:13 +0200
Message-ID: <20150527001113.2506.23159.stgit@bahia.huguette.org>
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

SLOF currently calls hv-logical-load and hv-logical-store for every pixel
when enabling or disabling the cursor. This is suboptimal when writing one
char at a time to the console since terminal-write always toggles the cursor.
And this is precisely what grub is doing when the user wants to edit a menu
entry... the result is an incredibly slow and barely usable interface.

The inner loop in fb8-toggle-cursor handles a contiguous region: it can be
converted to hv-logical-memop. The result is 32 times less hcalls per char
and a serious improvement in grub usability.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 slof/fs/fbuffer.fs |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
index 756f05a..46b59bf 100644
--- a/slof/fs/fbuffer.fs
+++ b/slof/fs/fbuffer.fs
@@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
 : fb8-toggle-cursor ( -- )
 	line# fb8-line2addr column# fb8-columns2bytes +
 	char-height 0 ?DO
-		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
-		screen-width screen-depth * + char-width screen-depth * -
+		dup dup 0 char-width screen-depth * 1 hv-logical-memop drop
+		screen-width screen-depth * +
 	LOOP drop
 ;
 
