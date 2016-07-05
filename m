Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk6C63z1FzDqvY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 11:45:06 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u651iOoh067452
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 21:45:04 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23xa4cnv2m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 21:45:04 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 4 Jul 2016 22:45:01 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 18D7B352005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 21:44:41 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u651iwYQ13435294
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 22:44:58 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u651iwqO004951
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 22:44:58 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix oops in pcibios_release_device() after
 pcibios_free_controller()
Date: Mon,  4 Jul 2016 22:44:45 -0300
Message-Id: <1467683085-3537-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's possible to hit an oops/crash if pcibios_release_device() accesses the
phb struct and it had been freed earlier -- by pcibios_free_controller() --
as the memory it pointed to can be reused.

If after reuse 'phb->controller_ops.release_device' is non-NULL it will be
called, but it points to an invalid location (that function pointer is not
set anywhere in the code, so if it's non-NULL, that's not correct), and so
it hits an oops and the system crashes.

The solution is to verify whether 'phb' is still in 'hose_list' before any
access to it in pcibios_release_device() -- as it is removed from the list
by pcibios_free_controller() -- and ensure it cannot be used after kfree().

That problem can happen with the pSeries platform's DLPAR remove operation
if references to devices are held until after the pcibios_free_controller()
function runs, and then released - exercising pcibios_release_device() path.

It's been seen in multipath configurations during the removal/add of fibre
channel adapters, which may lead to tasks blocked for IO (thus holding the
references to devices) until adapters reappear later on, then hitting oops.

It can be synthesized simply w/ 'cat >/dev/sdX' for one or two devices, as
demonstrated below (with a quirk to set phb->controller_ops.release_device
to 0x0123456789abcdef before kfree() on pcibios_free_controller() and some
printk() debug calls for clarity):

    # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r    # need to remove and re-add
    # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -a    # so phb->is_dynamic is true.

    # cat >/dev/sdz & pid=$!

    # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
    <...>
    pci_bus 0002:01: busn_res: [bus 01-ff] is released
    pcibios_free_controller() phb = c0000001f72ccc00
    pcibios_free_controller QUIRK! ptr = 0123456789abcdef
    rpadlpar_io: slot PHB 33 removed

    # kill -9 $pid
    pcibios_release_device() phb = c0000001f72ccc00
    Unable to handle kernel paging request for instruction fetch
    Faulting instruction address: 0x123456789abcdef
    Oops: Kernel access of bad area, sig: 11 [#1]
    <...>
    CPU: 23 PID: 14878 Comm: cat Tainted: G        W       4.7.0-rc6 #2
    <...>
    NIP [0123456789abcdef] 0x123456789abcdef
    LR [c00000000003f0a0] pcibios_release_device+0x70/0x90
    Call Trace:
    [c0000001fa45b5a0] [c00000000003f07c] pcibios_release_device+0x4c/0x90 (unreliable)
    [c0000001fa45b610] [c0000000004e66b0] pci_release_dev+0x50/0xa0
    [c0000001fa45b640] [c000000000582d48] device_release+0x58/0xf0
    [c0000001fa45b6c0] [c0000000004aeb58] kobject_cleanup+0x78/0xe0
    [c0000001fa45b700] [c000000000583374] put_device+0x24/0x40
    [c0000001fa45b720] [c0000000005d61c8] scsi_host_dev_release+0x138/0x1c0
    [c0000001fa45b760] [c000000000582d48] device_release+0x58/0xf0
    [c0000001fa45b7e0] [c0000000004aeb58] kobject_cleanup+0x78/0xe0
    [c0000001fa45b820] [c000000000583374] put_device+0x24/0x40
    [c0000001fa45b840] [c0000000005f38d4] fc_rport_dev_release+0x24/0x50
    [c0000001fa45b870] [c000000000582d48] device_release+0x58/0xf0
    [c0000001fa45b8f0] [c0000000004aeb58] kobject_cleanup+0x78/0xe0
    [c0000001fa45b930] [c000000000583374] put_device+0x24/0x40
    [c0000001fa45b950] [c0000000005e0c20] scsi_target_dev_release+0x30/0x50
    [c0000001fa45b980] [c000000000582d48] device_release+0x58/0xf0
    [c0000001fa45ba00] [c0000000004aeb58] kobject_cleanup+0x78/0xe0
    [c0000001fa45ba40] [c000000000583374] put_device+0x24/0x40
    [c0000001fa45ba60] [c0000000005e4cb8] scsi_device_dev_release_usercontext+0x178/0x1b0
    [c0000001fa45bac0] [c0000000000cac34] execute_in_process_context+0x94/0xb0
    [c0000001fa45bae0] [c0000000005e4b24] scsi_device_dev_release+0x24/0x40
    [c0000001fa45bb00] [c000000000582d48] device_release+0x58/0xf0
    [c0000001fa45bb80] [c0000000004aeb58] kobject_cleanup+0x78/0xe0
    [c0000001fa45bbc0] [c000000000583374] put_device+0x24/0x40
    [c0000001fa45bbe0] [c0000000005d3f08] scsi_device_put+0x38/0x50
    [c0000001fa45bc10] [c00000000062dba0] scsi_disk_put+0x50/0x80
    [c0000001fa45bc50] [c0000000002ca378] __blkdev_put+0x2f8/0x340
    [c0000001fa45bd40] [c0000000002ca588] blkdev_close+0x28/0x40
    [c0000001fa45bd60] [c00000000027e9ec] __fput+0xbc/0x260
    [c0000001fa45bdb0] [c0000000000d1280] task_work_run+0xf0/0x130
    [c0000001fa45be00] [c0000000000172a4] do_notify_resume+0x84/0x90
    [c0000001fa45be30] [c000000000009844] ret_from_except_lite+0x70/0x74
    Instruction dump:
    XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
    XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
    ---[ end trace fc3730d9babb2e31 ]---

With the patch applied:

    # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
    <...>
    pci_bus 0001:01: busn_res: [bus 01-ff] is released
    pcibios_free_controller() phb = c0000001dea2d400
    pcibios_free_controller QUIRK! ptr = 0123456789abcdef
    rpadlpar_io: slot PHB 33 removed

    # kill -9 $pid
    pcibios_release_device() phb = c0000001dea2d400, ptr = 0123456789abcdef, found 0

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Tested on 4.7.0-rc6.
---
 arch/powerpc/kernel/pci-common.c  |  5 +++--
 arch/powerpc/kernel/pci-hotplug.c | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..00a22e7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -41,7 +41,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/eeh.h>
 
-static DEFINE_SPINLOCK(hose_spinlock);
+DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
 /* XXX kill that some day ... */
@@ -95,10 +95,11 @@ void pcibios_free_controller(struct pci_controller *phb)
 {
 	spin_lock(&hose_spinlock);
 	list_del(&phb->list_node);
-	spin_unlock(&hose_spinlock);
 
 	if (phb->is_dynamic)
 		kfree(phb);
+
+	spin_unlock(&hose_spinlock);
 }
 EXPORT_SYMBOL_GPL(pcibios_free_controller);
 
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 2d71269..49b5388 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -21,6 +21,9 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+extern spinlock_t hose_spinlock;
+extern struct list_head hose_list;
+
 static struct pci_bus *find_bus_among_children(struct pci_bus *bus,
 					       struct device_node *dn)
 {
@@ -58,12 +61,27 @@ EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
  */
 void pcibios_release_device(struct pci_dev *dev)
 {
-	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+	struct pci_controller *phb = pci_bus_to_host(dev->bus), *e;
+	int found = 0;
 
 	eeh_remove_device(dev);
 
-	if (phb->controller_ops.release_device)
+	/*
+	 * Only access phb if it's still in hose_list; otherwise
+	 * it's been freed and may contain corrupt data and oops.
+	 */
+	spin_lock(&hose_spinlock);
+	list_for_each_entry(e, &hose_list, list_node) {
+		if (e == phb) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found && phb->controller_ops.release_device)
 		phb->controller_ops.release_device(dev);
+
+	spin_unlock(&hose_spinlock);
 }
 
 /**
-- 
1.8.3.1
