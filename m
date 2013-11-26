Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE1872C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 15:07:55 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 26 Nov 2013 14:07:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 89F242BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 15:07:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAQ47BBU62586890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 15:07:11 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAQ47KV5017828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 15:07:21 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] boot: enable support for bootindex
Date: Tue, 26 Nov 2013 15:07:16 +1100
Message-Id: <1385438836-30561-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1385364460-24332-1-git-send-email-aik@ozlabs.ru>
References: <1385364460-24332-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

QEMU supports a bootindex property for every device in the command line.
With the respective support from the QEMU side, this change is enough
to make SLOF go through the list and try to boot.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

That seems to work but it also seems too easy. What do I miss here?

---
 board-qemu/slof/qemu-bootlist.fs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board-qemu/slof/qemu-bootlist.fs b/board-qemu/slof/qemu-bootlist.fs
index 7e9482d..4778e16 100644
--- a/board-qemu/slof/qemu-bootlist.fs
+++ b/board-qemu/slof/qemu-bootlist.fs
@@ -26,6 +26,12 @@ defer add-boot-device
 ;
 
 : qemu-read-bootlist ( -- )
+   \ See if QEMU has set exact boot device list
+   " qemu,boot-list" get-chosen IF
+        s" boot-device" $setenv
+        EXIT
+   THEN
+
    0 0 set-boot-device
 
    " qemu,boot-device" get-chosen not IF
-- 
1.8.4.rc4
