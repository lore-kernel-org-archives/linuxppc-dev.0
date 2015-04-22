Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D25331A0AB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:58:36 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E4C6140083
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:58:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 22 Apr 2015 20:58:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 328622CE8050
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:58:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3MAwLBv37486684
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:58:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3MAvtkJ013081
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:57:56 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] pci-phb: check for the 32-bit overflow
Date: Wed, 22 Apr 2015 16:27:19 +0530
Message-Id: <1429700240-32373-1-git-send-email-nikunj@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, thuth@redhat.com, nikunj@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the addition of 64-bit BARS and increase in the mmio address
space, the code was hitting this limit. The memory of pci devices
across the bridges were not accessible due to which the drivers
failed.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 board-qemu/slof/pci-phb.fs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
index 529772f..e307d95 100644
--- a/board-qemu/slof/pci-phb.fs
+++ b/board-qemu/slof/pci-phb.fs
@@ -258,7 +258,8 @@ setup-puid
             decode-64 2 / dup >r                \ Decode and calc size/2
             pci-next-mem @ + dup pci-max-mem !  \ and calc max mem address
             dup pci-next-mmio !                 \ which is the same as MMIO base
-            r> + pci-max-mmio !                 \ calc max MMIO address
+            r> + FFFFFFFF min pci-max-mmio !    \ calc max MMIO address and
+                                                \ check the 32-bit boundary
          ENDOF
          3000000 OF                             \ 64-bit memory space?
 	    decode-64 pci-next-mem64 !
-- 
1.8.3.1
