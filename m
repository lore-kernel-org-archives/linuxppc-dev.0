Message-ID: <3E1BECD2.9060909@intracom.gr>
Date: Wed, 08 Jan 2003 11:18:10 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Status of linuxppc_2.5
Content-Type: multipart/mixed;
 boundary="------------060402080104060005050500"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060402080104060005050500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I'm trying to compile linuxppc_2.5
and the following patch is needed to
make it compile.

The configuration is from
make pmac_config.

I didn't test it though, I don't have
a test pmac system, my intention is to
test it on a 8xx system.

BTW, are there any gotchas, or anything
I should pay attention moving
from 2.4 -> 2.5?

Regards

Pantelis


--------------060402080104060005050500
Content-Type: text/plain; name="compile-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="compile-2.5.diff"

===== arch/ppc/kernel/traps.c 1.21 vs edited =====
--- 1.21/arch/ppc/kernel/traps.c        Mon Jan  6 09:02:42 2003
+++ edited/arch/ppc/kernel/traps.c      Wed Jan  8 09:23:43 2003
@@ -174,7 +174,7 @@
                               (*nip & 0x100)? "OUT to": "IN from",
                               regs->gpr[rb] - _IO_BASE, nip);
                        regs->msr |= MSR_RI;
-                       regs->nip = fixup;
+                       regs->nip = entry->fixup;
                        return;
                }
        }
===== drivers/block/swim3.c 1.22 vs edited =====
--- 1.22/drivers/block/swim3.c  Fri Dec  6 03:10:45 2002
+++ edited/drivers/block/swim3.c        Wed Jan  8 10:40:20 2003
@@ -26,6 +26,7 @@
 #include <linux/ioctl.h>
 #include <linux/blk.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
===== drivers/macintosh/mediabay.c 1.10 vs edited =====
--- 1.10/drivers/macintosh/mediabay.c   Tue Nov 12 01:47:53 2002
+++ edited/drivers/macintosh/mediabay.c Wed Jan  8 10:53:47 2003
@@ -36,6 +36,7 @@
 #include <asm/keylargo.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/ide.h>

 #ifdef CONFIG_PMAC_PBOOK
 static int mb_notify_sleep(struct pmu_sleep_notifier *self, int when);
@@ -599,7 +600,7 @@
                if (bay->cd_index >= 0) {
                        printk(KERN_DEBUG "Unregistering mb %d ide, index:%d\n", i,
                               bay->cd_index);
-                       ide_unregister(&ide_hwifs[bay->cd_index]);
+                       ide_unregister(bay->cd_index);
                        bay->cd_index = -1;
                }
                if (bay->cd_retry) {
===== drivers/usb/host/ohci-pci.c 1.6 vs edited =====
--- 1.6/drivers/usb/host/ohci-pci.c     Sun Dec  1 04:21:11 2002
+++ edited/drivers/usb/host/ohci-pci.c  Wed Jan  8 10:49:46 2003
@@ -18,6 +18,7 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/pci-bridge.h>
+#include <asm/prom.h>
 #ifndef CONFIG_PM
 #      define CONFIG_PM
 #endif
===== fs/nfs/write.c 1.36 vs edited =====
--- 1.36/fs/nfs/write.c Sat Dec 21 08:29:02 2002
+++ edited/fs/nfs/write.c       Wed Jan  8 10:38:32 2003
@@ -828,7 +828,9 @@
        struct nfs_write_data   *data = (struct nfs_write_data *) task->tk_calldata;
        struct nfs_writeargs    *argp = &data->args;
        struct nfs_writeres     *resp = &data->res;
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
        struct inode            *inode = data->inode;
+#endif
        struct nfs_page         *req;
        struct page             *page;

===== include/linux/ide.h 1.32 vs edited =====
--- 1.32/include/linux/ide.h    Sat Dec 28 21:09:38 2002
+++ edited/include/linux/ide.h  Wed Jan  8 10:47:16 2003
@@ -334,6 +334,9 @@
  */
 int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);

+/* XXX panto */
+void ide_unregister (unsigned int index);
+
 /*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
  */

--------------060402080104060005050500--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
