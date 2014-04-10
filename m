Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 17453140090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 16:52:07 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 10 Apr 2014 12:22:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B9AA2E004B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 12:26:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3A6ppML62390502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 12:21:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3A6pwSI013563
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 12:21:58 +0530
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix 3bc95598 'powerpc/PCI: Use list_for_each_entry() for bus
 traversal'
Date: Thu, 10 Apr 2014 02:51:35 -0400
Message-Id: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: wangyijing@huawei.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 anton@samba.org, bhelgaas@google.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000041d78
Oops: Kernel access of bad area, sig: 11 [#1]
...
NIP [c000000000041d78] .sys_pciconfig_iobase+0x68/0x1f0
LR [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0
Call Trace:
[c0000003b4787db0] [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0 (unreliable)
[c0000003b4787e30] [c000000000009ed8] syscall_exit+0x0/0x98

This bug was introduced by commit 3bc955987fb377f3c95bc29deb498e96819b8451
The root cause was the 'bus' has been set to null while try to access
bus->next.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci_64.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 2a47790..7b6c1ae 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -209,6 +209,7 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 {
 	struct pci_controller* hose;
 	struct pci_bus *bus = NULL;
+	struct pci_bus *tmp_bus = NULL;
 	struct device_node *hose_node;
 
 	/* Argh ! Please forgive me for that hack, but that's the
@@ -229,10 +230,12 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	 * used on pre-domains setup. We return the first match
 	 */
 
-	list_for_each_entry(bus, &pci_root_buses, node) {
-		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
+	list_for_each_entry(tmp_bus, &pci_root_buses, node) {
+		if (in_bus >= tmp_bus->number &&
+		    in_bus <= tmp_bus->busn_res.end) {
+			bus = tmp_bus;
 			break;
-		bus = NULL;
+		}
 	}
 	if (bus == NULL || bus->dev.of_node == NULL)
 		return -ENODEV;
-- 
1.8.0.1
