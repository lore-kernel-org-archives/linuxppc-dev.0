Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20A9F14007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 20:48:55 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 13 May 2014 20:48:46 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6A7DB2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 20:48:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4DARR1h2228512
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 20:27:28 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4DAmivT011334
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 20:48:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] pci-scan: Fix setting the limit
Date: Tue, 13 May 2014 20:48:38 +1000
Message-Id: <1399978118-10298-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI spec says that lower 20 bits are assumed 0xFFFFF. The existing code
seems to get it right in pci-bridge-set-mem-limit.

However pci-bridge-set-mem-base does not account 0xFFFFF and poison
the limit. Since the limit is not stored anywhere in SLOF and only
besides in the config space, it remains broken.

This fixes pci-bridge-set-mem-base.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I have doubts this is the right fix as I tried to "fix"
pci-bridge-set-mmio-base (while I am here) and it broke the guest.

The problem I am fixing by this is that QEMU started as below is
unable to initialize virtio-net device because there are overlapping
virtio's BAR and bridge's "ranges" property. Note that virtio-net is
attached to the PHB, not that additional bridge.

/home/aik/qemu-system-ppc64 \
-enable-kvm \
-m 1024 \
-machine pseries \
-nographic \
-vga none \
-device pci-bridge,id=id0,bus=pci.0,addr=5.0,chassis_nr=7 \
-netdev tap,id=id1,ifname=tap1,script=ifup.sh,downscript=ifdown.sh \
-device virtio-net-pci,id=id2,netdev=id1 \
-initrd 1.cpio \
-kernel vml315rc3 \

This is from the guest:

PCI host bridge /pci@800000020000000  ranges:
  IO 0x0000010080000000..0x000001008000ffff -> 0x0000000000000000
 MEM 0x00000100a0000000..0x00000100bfffffff -> 0x0000000080000000

PCI:0000:00:00.0 Resource 0 0000000000010020-000000000001003f [40101]
PCI:0000:00:00.0 Resource 1 00000100b0000000-00000100b0000fff [40200]
PCI:0000:00:00.0 Resource 6 00000100b0040000-00000100b007ffff [4c200]

PCI:0000:00:05.0 Bus rsrc 1 0000000090100000-00000000a00fffff [40200]
PCI:0000:00:05.0 Bus rsrc 2 00000100a0000000-00000100b00fffff [42208]
PCI: PHB (bus 0) bridge rsrc 4: 0000000000010000-000000000001ffff [0x100], parent c000000000f765b8 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 5: 00000100a0000000-00000100bfffffff [0x200], parent c000000000f76580 (PCI mem)
PCI: Allocating 0000:00:00.0: Resource 0: 0000000000010020..000000000001003f [40101]
PCI: Allocating 0000:00:00.0: Resource 1: 00000100b0000000..00000100b0000fff [40200]
PCI: Cannot allocate resource region 1 of device 0000:00:00.0, will remap

This are PHB and bridge "ranges":
[root@erif_root ~]# hexdump -e '7/4 "%08x "' -e '"\n"' /proc/device-tree/pci@800000020000000/ranges
01000000 00000000 00000000 00000100 80000000 00000000 00010000
02000000 00000000 80000000 00000100 a0000000 00000000 20000000
[root@erif_root ~]# hexdump -e '8/4 "%08x "' -e '"\n"' /proc/device-tree/pci@800000020000000/pci@5/ranges
02000000 00000000 90100000 02000000 00000000 90100000 00000000 10000000
42000000 00000000 80000000 42000000 00000000 80000000 00000000 10100000

And virtio-net BARs:
[root@erif_root ~]# hexdump -e '5/4 "%08x "' -e '"\n"' /proc/device-tree/pci@800000020000000/ethernet@0/reg
00000000 00000000 00000000 00000000 00000000
01000010 00000000 00000000 00000000 00000020
02000014 00000000 00000000 00000000 00001000
02000030 00000000 00000000 00000000 00040000
[root@erif_root ~]# hexdump -e '5/4 "%08x "' -e '"\n"' /proc/device-tree/pci@800000020000000/ethernet@0/assigned-addres
es
82000030 00000000 90040000 00000000 00040000
81000010 00000000 00000020 00000000 00000020
82000014 00000000 90000000 00000000 00001000
---
 slof/fs/pci-scan.fs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/slof/fs/pci-scan.fs b/slof/fs/pci-scan.fs
index ec9bd27..53b3b2c 100644
--- a/slof/fs/pci-scan.fs
+++ b/slof/fs/pci-scan.fs
@@ -115,6 +115,7 @@ here 100 allot CONSTANT pci-device-vec
         THEN                                    \ FI
         10 rshift                               \ keep upper 16 bits
         pci-max-mem @ FFFF0000 and or           \ and Insert mmem Limit (set it to max)
+        1-
         swap 24 + rtas-config-l!                \ and write it into the bridge
 ;
 
-- 
1.9.rc0
