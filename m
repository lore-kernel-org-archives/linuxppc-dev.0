Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CA481A1908
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:13:21 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Thu, 28 May 2015 14:13:18 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A6A642190046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:12:55 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4SDDFVo25886764
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 13:13:15 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4SDDEni002224
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:13:15 -0600
Subject: [PATCH 1/3] fbuffer: simplify address computations in
 fb8-toggle-cursor
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 28 May 2015 15:13:14 +0200
Message-ID: <20150528131314.5240.44784.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
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

The inner loop deals with a contiguous region. It could easily be replaced
by faster board specific functions like hv-logical-memop in board-qemu.
Since hv-logical-memop does not return an address, let's have the enclosing
loop compute the next line address by itself and drop the confusing
"char-width screen-depth * -" address adjustment.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 slof/fs/fbuffer.fs |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
index 756f05a..faae6a9 100644
--- a/slof/fs/fbuffer.fs
+++ b/slof/fs/fbuffer.fs
@@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
 : fb8-toggle-cursor ( -- )
 	line# fb8-line2addr column# fb8-columns2bytes +
 	char-height 0 ?DO
-		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
-		screen-width screen-depth * + char-width screen-depth * -
+		dup char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
+		screen-width screen-depth * +
 	LOOP drop
 ;
 
