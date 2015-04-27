Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 519FC1A0245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 18:03:36 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15B9F140328
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 18:03:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 82C102BB0040
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R83OXA47251592
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R82wkL005576
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:02:58 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: [PATCH v2 3/4] usb: support 64-bit pci bars
Date: Mon, 27 Apr 2015 13:32:32 +0530
Message-Id: <1430121753-24818-4-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the addition of 64-bit bar ranges (commit: 9fbfed08 - pci: use
64bit bar ranges), the usb-setup-hcidev needs to handle 64-bit
addresses.

For example, QEMU provided NEC USB XHCI device requests 64-bit memory
address. Added code to check the memory type before address
translation.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 slof/fs/devices/pci-class_0c.fs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/slof/fs/devices/pci-class_0c.fs b/slof/fs/devices/pci-class_0c.fs
index 9c47325..39453fb 100644
--- a/slof/fs/devices/pci-class_0c.fs
+++ b/slof/fs/devices/pci-class_0c.fs
@@ -25,8 +25,14 @@ CONSTANT /hci-dev
 
 : usb-setup-hcidev ( num hci-dev -- )
     >r
-    10 config-l@ translate-my-address
-    3 not AND
+    10 config-l@ F AND case
+	0 OF 10 config-l@ translate-my-address ENDOF       \ 32-bit memory space
+	4 OF                                               \ 64-bit memory space
+	    14 config-l@ 20 lshift                         \ Read two bars
+	    10 config-l@ OR translate-my-address
+	ENDOF
+    ENDCASE
+    F not AND
     ( io-base ) r@ hcd>base !
     08 config-l@ 8 rshift  0000000F0 AND 4 rshift
     ( usb-type ) r@ hcd>type !
-- 
1.8.3.1
