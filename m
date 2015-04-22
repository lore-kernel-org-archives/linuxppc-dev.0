Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83AEC1A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:58:34 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 49BBF140133
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:58:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 22 Apr 2015 20:58:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 35A902BB0040
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:58:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3MAwNI250200738
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:58:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3MAvviU013116
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 20:57:57 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] pci: Use Qemu created PCI device nodes
Date: Wed, 22 Apr 2015 16:27:20 +0530
Message-Id: <1429700240-32373-2-git-send-email-nikunj@linux.vnet.ibm.com>
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

PCI Enumeration has been part of SLOF. Now with hotplug code addition
in Qemu, it makes more sense to have this code a one place, i.e. Qemu.

Adding routines to walk through the device nodes created by Qemu. SLOF
will configure the device/bridges and program the BARs for
communicating with the devices.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 board-qemu/slof/pci-phb.fs | 44 +++++++++++++++++++++++++++++++++++++++++++-
 slof/fs/pci-properties.fs  |  6 +++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
index e307d95..30b7443 100644
--- a/board-qemu/slof/pci-phb.fs
+++ b/board-qemu/slof/pci-phb.fs
@@ -283,6 +283,41 @@ setup-puid
    THEN
 ;
 
+: phb-pci-walk-bridge ( -- )
+    phb-debug? IF ."   Calling pci-walk-bridge " pwd cr THEN
+
+    get-node child ?dup 0= IF EXIT THEN    \ get and check if we have children
+    BEGIN
+        dup                           \ Continue as long as there are children
+    WHILE
+            \ Set child node as current node:
+            dup set-node
+            my-space pci-set-slot       \ set the slot bit
+            my-space pci-htype@         \ read HEADER-Type
+            7f and                      \ Mask bit 7 - multifunction device
+            CASE
+               0 OF my-space pci-device-setup ENDOF  \ | set up the device
+               1 OF my-space pci-bridge-setup ENDOF  \ | set up the bridge
+               dup OF my-space pci-htype@ pci-out ENDOF
+           ENDCASE
+           peer
+    REPEAT drop
+    get-parent set-node
+;
+
+\ Landing routing to probe the popuated device tree
+: phb-pci-probe-bus ( busnr -- )
+    drop phb-pci-walk-bridge
+;
+
+\ Stub routine, as qemu has enumerated, we already have the device
+\ properties set.
+: phb-pci-device-props ( addr -- )
+    dup pci-class-name device-name
+    dup pci-device-assigned-addresses-prop
+    drop
+;
+
 \ Scan the child nodes of the pci root node to assign bars, fixup
 \ properties etc.
 : phb-setup-children
@@ -290,7 +325,14 @@ setup-puid
    my-puid TO puid                  \ Set current puid
    phb-parse-ranges
    1 TO pci-hotplug-enabled
-   1 0 (probe-pci-host-bridge)
+   s" qemu,phb-enumerated" get-node get-property 0<> IF
+       1 0 (probe-pci-host-bridge)
+   ELSE
+       2drop
+       ['] phb-pci-probe-bus TO func-pci-probe-bus
+       ['] phb-pci-device-props TO func-pci-device-props
+       phb-pci-walk-bridge          \ PHB device tree is already populated.
+   THEN
    r> TO puid                       \ Restore previous puid
 ;
 phb-setup-children
diff --git a/slof/fs/pci-properties.fs b/slof/fs/pci-properties.fs
index 9efa87e..4f13402 100644
--- a/slof/fs/pci-properties.fs
+++ b/slof/fs/pci-properties.fs
@@ -651,6 +651,8 @@
         r> TO pci-device-slots          \ and reset the slot array
 ;
 
+DEFER func-pci-device-props
+
 \ used for an gerneric device set up
 \ if a device has no special handling for setup
 \ the device file (pci-device_VENDOR_DEVICE.fs) can call
@@ -659,6 +661,8 @@
         dup assign-all-device-bars      \ calc all BARs
         dup pci-set-irq-line            \ set the interrupt pin
         dup pci-set-capabilities        \ set up the capabilities
-        dup pci-device-props            \ and generate all properties
+        dup func-pci-device-props       \ and generate all properties
         drop                            \ forget the config-addr
 ;
+
+' pci-device-props TO func-pci-device-props
-- 
1.8.3.1
