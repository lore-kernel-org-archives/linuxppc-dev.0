Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18272.49134.707719.50599@cargo.ozlabs.ibm.com>
Date: Thu, 13 Dec 2007 16:15:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Do ioremap and allocation for sleep on 3400 once at boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the sleep code on the old powerbook 3400 does an ioremap and
a kmalloc on each sleep/wakeup cycle.  This moves the ioremap and
kmalloc to boot-time code (via_pmu_start) so that they only need to be
done once.  This will be more convenient when we change to using the
generic suspend code, since it will avoid the need to do the
ioremap/kmalloc after devices have been suspended.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 35e1f22..0e84cb8 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -203,6 +203,12 @@ static int proc_read_options(char *page, char **start, off_t off,
 static int proc_write_options(struct file *file, const char __user *buffer,
 			unsigned long count, void *data);
 
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+static void powerbook_sleep_init_3400(void);
+#else
+#define powerbook_sleep_init_3400()	do { } while (0)
+#endif
+
 #ifdef CONFIG_ADB
 struct adb_driver via_pmu_driver = {
 	"PMU",
@@ -450,6 +456,10 @@ static int __init via_pmu_start(void)
 		pmu_poll();
 	} while (pmu_state != idle);
 
+	/* Do allocations and ioremaps that will be needed for sleep */
+	if (pmu_kind == PMU_OHARE_BASED)
+		powerbook_sleep_init_3400();
+
 	return 0;
 }
 
@@ -2271,26 +2281,30 @@ powerbook_sleep_Core99(void)
 #define PB3400_MEM_CTRL		0xf8000000
 #define PB3400_MEM_CTRL_SLEEP	0x70
 
-static int
-powerbook_sleep_3400(void)
+static void __iomem *pb3400_mem_ctrl;
+
+static void powerbook_sleep_init_3400(void)
+{
+	/* map in the memory controller registers */
+	pb3400_mem_ctrl = ioremap(PB3400_MEM_CTRL, 0x100);
+	if (pb3400_mem_ctrl == NULL)
+		printk(KERN_WARNING "ioremap failed: sleep won't be possible");
+
+	/* Allocate room for PCI save */
+	pbook_alloc_pci_save();
+}
+
+static int powerbook_sleep_3400(void)
 {
 	int ret, i, x;
 	unsigned int hid0;
 	unsigned long p;
 	struct adb_request sleep_req;
-	void __iomem *mem_ctrl;
 	unsigned int __iomem *mem_ctrl_sleep;
 
-	/* first map in the memory controller registers */
-	mem_ctrl = ioremap(PB3400_MEM_CTRL, 0x100);
-	if (mem_ctrl == NULL) {
-		printk("powerbook_sleep_3400: ioremap failed\n");
+	if (pb3400_mem_ctrl == NULL)
 		return -ENOMEM;
-	}
-	mem_ctrl_sleep = mem_ctrl + PB3400_MEM_CTRL_SLEEP;
-
-	/* Allocate room for PCI save */
-	pbook_alloc_pci_save();
+	mem_ctrl_sleep = pb3400_mem_ctrl + PB3400_MEM_CTRL_SLEEP;
 
 	ret = pmac_suspend_devices();
 	if (ret) {
@@ -2343,8 +2357,6 @@ powerbook_sleep_3400(void)
 		mb();
 
 	pmac_wakeup_devices();
-	pbook_free_pci_save();
-	iounmap(mem_ctrl);
 
 	return 0;
 }
