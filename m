Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 271092C014A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 22:25:34 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 12 Sep 2013 22:17:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1ABE62CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 22:25:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8CC8njQ42008624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 22:08:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8CCPKE1026841
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 22:25:20 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] pci: fix interrupt-map for bridges
Date: Thu, 12 Sep 2013 22:25:17 +1000
Message-Id: <1378988717-15112-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous scheme always put 0 as a parent slot#. However it is
not always the case and QEMU's PCI bridge does not support putting
device at slot#0 as it claims SHPC support for hotplug.

This modifies the interrups map to let the linux guest resolve XICS
global interrupt number correctly.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is the example of working system:

[root@erif_root pci@1]# lspci
0001:00:01.0 PCI bridge: Red Hat, Inc. Device 0001
0001:01:02.0 PCI bridge: Red Hat, Inc. Device 0001
0001:01:03.0 PCI bridge: Red Hat, Inc. Device 0001
0001:02:01.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (Copper) (rev 06)
0001:02:02.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (Copper) (rev 06)
0001:03:01.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (Copper) (rev 06)
0001:03:02.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (Copper) (rev 06)
[root@erif_root pci@1]# pwd
/proc/device-tree/pci@80000002000000f/pci@1
[root@erif_root pci@1]# hexdump -e '9/4 "%08x "' -e '"\n"' i*map
00001000 00000000 00000000 00000001 3e57f7e0 00000800 00000000 00000000 00000003
00001000 00000000 00000000 00000002 3e57f7e0 00000800 00000000 00000000 00000000
00001000 00000000 00000000 00000003 3e57f7e0 00000800 00000000 00000000 00000001
00001000 00000000 00000000 00000004 3e57f7e0 00000800 00000000 00000000 00000002
00001800 00000000 00000000 00000001 3e57f7e0 00000800 00000000 00000000 00000000
00001800 00000000 00000000 00000002 3e57f7e0 00000800 00000000 00000000 00000001
00001800 00000000 00000000 00000003 3e57f7e0 00000800 00000000 00000000 00000002
00001800 00000000 00000000 00000004 3e57f7e0 00000800 00000000 00000000 00000003
[root@erif_root pci@1]# cd pci@2/
[root@erif_root pci@2]# hexdump -e '9/4 "%08x "' -e '"\n"' i*map
00000800 00000000 00000000 00000001 3e5a86f0 00001000 00000000 00000000 00000002
00000800 00000000 00000000 00000002 3e5a86f0 00001000 00000000 00000000 00000003
00000800 00000000 00000000 00000003 3e5a86f0 00001000 00000000 00000000 00000000
00000800 00000000 00000000 00000004 3e5a86f0 00001000 00000000 00000000 00000001
00001000 00000000 00000000 00000001 3e5a86f0 00001000 00000000 00000000 00000003
00001000 00000000 00000000 00000002 3e5a86f0 00001000 00000000 00000000 00000000
00001000 00000000 00000000 00000003 3e5a86f0 00001000 00000000 00000000 00000001
00001000 00000000 00000000 00000004 3e5a86f0 00001000 00000000 00000000 00000002
[root@erif_root pci@2]# cd ethernet@
ethernet@1/ ethernet@2/
[root@erif_root pci@2]# cd ethernet@1/
[root@erif_root ethernet@1]# lsprop reg
reg              00020800 00000000 00000000 00000000 00000000
		 02020810 00000000 00000000 00000000 00020000
 		 02020814 00000000 00000000 00000000 00020000
 		 01020818 00000000 00000000 00000000 00000020
 		 02020830 00000000 00000000 00000000 00020000
[root@erif_root ethernet@1]# lsprop interrupts
interrupts       00000002
---
 board-qemu/slof/pci-interrupts.fs | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/board-qemu/slof/pci-interrupts.fs b/board-qemu/slof/pci-interrupts.fs
index a12d7bb..62785a7 100644
--- a/board-qemu/slof/pci-interrupts.fs
+++ b/board-qemu/slof/pci-interrupts.fs
@@ -1,17 +1,26 @@
 
 : pci-gen-irq-map-one ( prop-addr prop-len slot pin -- prop-addr prop-len )
-        2dup + 4 mod                                        ( prop-addr prop-len slot pin parentpin )
+        2dup + 4 mod                ( prop-addr prop-len slot pin parentpin )
+        >r >r >r                    ( prop-addr prop-len R: swizzledpin pin slot )
+
+        \ Child slot#
+        r> B lshift encode-int+     ( prop-addr prop-len R: swizzledpin pin )
+        \ Child 64bit BAR (not really used)
+        0 encode-64+
+        \ Chile pin#
+        r> encode-int+              ( prop-addr prop-len R: swizzledpin )
+
+        \ Parent phandle
+        get-parent encode-int+
+
+        \ Parent slot#
         get-node >space
-        pci-addr2dev + 1- 4 mod 1+  \ do swizzling          ( prop-addr prop-len slot pin swizzledpin )
-        >r >r >r                                            ( prop-addr prop-len R: swizzledpin pin slot )
-
-        r> B lshift encode-int+
-        0 encode-64+                \ device slot           ( prop-addr prop-len R: swizzledpin pin )
-        r> encode-int+              \ device pin            ( prop-addr prop-len R: swizzledpin )
-
-        get-parent encode-int+      \ parent phandle
-        0 encode-int+ 0 encode-64+  \ parent slot
-        r> encode-int+              \ parent swizzled pin   ( prop-addr prop-len R: )
+        pci-addr2dev B lshift       ( prop-addr prop-len parent-slot R: swizzledpin )
+        encode-int+
+        \ Parent 64bit BAR (not really used)
+        0 encode-64+
+        \ Parent pin
+        r> encode-int+              ( prop-addr prop-len R: )
 ;
 
 : pci-gen-irq-entry ( prop-addr prop-len config-addr -- prop-addr prop-len )
-- 
1.8.4.rc4
