Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A1952C013D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:37:59 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 00:37:57 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1FAA838C804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 02:37:53 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J6brLA133924
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 02:37:53 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6bq7t002197
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 00:37:53 -0600
Date: Wed, 19 Jun 2013 14:37:47 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/31] powerpc/eeh: Cleanup for EEH core
Message-ID: <20130619063747.GA14130@shangw.(null)>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371544435-4943-3-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
In-Reply-To: <1371544435-4943-3-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2013 at 04:33:26PM +0800, Gavin Shan wrote:
>While moving EEH core around from pSeries platform directory to
>arch/powerpc/kernel (in previous one patch), there has lots of
>complaints for coding style from "git show". The patch is going
>to fix them.
>
>Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>

Please use the updated [2/31] in the attachment.

Thanks,
Gavin


--vkogqOf2sHV7VnPd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-powerpc-eeh-Move-common-part-to-kernel-directory.patch"

>From e6b677059b83c5ae96a7d8ad495c427a82ecd4b4 Mon Sep 17 00:00:00 2001
From: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 13:53:12 +0800
Subject: [PATCH 02/31] powerpc/eeh: Move common part to kernel directory

The patch moves the common part of EEH core into arch/powerpc/kernel
directory so that we needn't PPC_PSERIES while compiling POWERNV
platform:

        * Move the EEH common part into arch/powerpc/kernel
        * Move the functions for PCI hotplug from pSeries platform to
          arch/powerpc/kernel/pci_hotplug.c
        * Move CONFIG_EEH from arch/powerpc/platforms/pseries/Kconfig to
          arch/powerpc/platforms/Kconfig
        * Adjust makefile accordingly

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/Makefile                |    4 +-
 arch/powerpc/kernel/eeh.c                   |  942 +++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh_cache.c             |  318 +++++++++
 arch/powerpc/kernel/eeh_dev.c               |  112 ++++
 arch/powerpc/kernel/eeh_driver.c            |  551 ++++++++++++++++
 arch/powerpc/kernel/eeh_event.c             |  142 ++++
 arch/powerpc/kernel/eeh_pe.c                |  653 +++++++++++++++++++
 arch/powerpc/kernel/eeh_sysfs.c             |   74 +++
 arch/powerpc/kernel/pci_hotplug.c           |  111 ++++
 arch/powerpc/platforms/Kconfig              |    5 +
 arch/powerpc/platforms/pseries/Kconfig      |    5 -
 arch/powerpc/platforms/pseries/Makefile     |    4 +-
 arch/powerpc/platforms/pseries/eeh.c        |  942 ---------------------------
 arch/powerpc/platforms/pseries/eeh_cache.c  |  319 ---------
 arch/powerpc/platforms/pseries/eeh_dev.c    |  112 ----
 arch/powerpc/platforms/pseries/eeh_driver.c |  552 ----------------
 arch/powerpc/platforms/pseries/eeh_event.c  |  142 ----
 arch/powerpc/platforms/pseries/eeh_pe.c     |  653 -------------------
 arch/powerpc/platforms/pseries/eeh_sysfs.c  |   75 ---
 arch/powerpc/platforms/pseries/pci_dlpar.c  |   85 ---
 20 files changed, 2912 insertions(+), 2889 deletions(-)
 create mode 100644 arch/powerpc/kernel/eeh.c
 create mode 100644 arch/powerpc/kernel/eeh_cache.c
 create mode 100644 arch/powerpc/kernel/eeh_dev.c
 create mode 100644 arch/powerpc/kernel/eeh_driver.c
 create mode 100644 arch/powerpc/kernel/eeh_event.c
 create mode 100644 arch/powerpc/kernel/eeh_pe.c
 create mode 100644 arch/powerpc/kernel/eeh_sysfs.c
 create mode 100644 arch/powerpc/kernel/pci_hotplug.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh_cache.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh_dev.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh_driver.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh_event.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh_pe.c
 delete mode 100644 arch/powerpc/platforms/pseries/eeh_sysfs.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f960a79..b92bf5a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -58,6 +58,8 @@ obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
 obj-$(CONFIG_LPARCFG)		+= lparcfg.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)           += ibmebus.o
+obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
+				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_FA_DUMP)		+= fadump.o
@@ -100,7 +102,7 @@ obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
-pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
+pci64-$(CONFIG_PPC64)		+= pci_dn.o pci_hotplug.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
 				   pci-common.o pci_of_scan.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
new file mode 100644
index 0000000..8a83451
--- /dev/null
+++ b/arch/powerpc/kernel/eeh.c
@@ -0,0 +1,942 @@
+/*
+ * Copyright IBM Corporation 2001, 2005, 2006
+ * Copyright Dave Engebretsen & Todd Inglett 2001
+ * Copyright Linas Vepstas 2005, 2006
+ * Copyright 2001-2012 IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Please address comments and feedback to Linas Vepstas <linas@austin.ibm.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/rbtree.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/export.h>
+#include <linux/of.h>
+
+#include <linux/atomic.h>
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ppc-pci.h>
+#include <asm/rtas.h>
+
+
+/** Overview:
+ *  EEH, or "Extended Error Handling" is a PCI bridge technology for
+ *  dealing with PCI bus errors that can't be dealt with within the
+ *  usual PCI framework, except by check-stopping the CPU.  Systems
+ *  that are designed for high-availability/reliability cannot afford
+ *  to crash due to a "mere" PCI error, thus the need for EEH.
+ *  An EEH-capable bridge operates by converting a detected error
+ *  into a "slot freeze", taking the PCI adapter off-line, making
+ *  the slot behave, from the OS'es point of view, as if the slot
+ *  were "empty": all reads return 0xff's and all writes are silently
+ *  ignored.  EEH slot isolation events can be triggered by parity
+ *  errors on the address or data busses (e.g. during posted writes),
+ *  which in turn might be caused by low voltage on the bus, dust,
+ *  vibration, humidity, radioactivity or plain-old failed hardware.
+ *
+ *  Note, however, that one of the leading causes of EEH slot
+ *  freeze events are buggy device drivers, buggy device microcode,
+ *  or buggy device hardware.  This is because any attempt by the
+ *  device to bus-master data to a memory address that is not
+ *  assigned to the device will trigger a slot freeze.   (The idea
+ *  is to prevent devices-gone-wild from corrupting system memory).
+ *  Buggy hardware/drivers will have a miserable time co-existing
+ *  with EEH.
+ *
+ *  Ideally, a PCI device driver, when suspecting that an isolation
+ *  event has occurred (e.g. by reading 0xff's), will then ask EEH
+ *  whether this is the case, and then take appropriate steps to
+ *  reset the PCI slot, the PCI device, and then resume operations.
+ *  However, until that day,  the checking is done here, with the
+ *  eeh_check_failure() routine embedded in the MMIO macros.  If
+ *  the slot is found to be isolated, an "EEH Event" is synthesized
+ *  and sent out for processing.
+ */
+
+/* If a device driver keeps reading an MMIO register in an interrupt
+ * handler after a slot isolation event, it might be broken.
+ * This sets the threshold for how many read attempts we allow
+ * before printing an error message.
+ */
+#define EEH_MAX_FAILS	2100000
+
+/* Time to wait for a PCI slot to report status, in milliseconds */
+#define PCI_BUS_RESET_WAIT_MSEC (60*1000)
+
+/* Platform dependent EEH operations */
+struct eeh_ops *eeh_ops = NULL;
+
+int eeh_subsystem_enabled;
+EXPORT_SYMBOL(eeh_subsystem_enabled);
+
+/*
+ * EEH probe mode support. The intention is to support multiple
+ * platforms for EEH. Some platforms like pSeries do PCI emunation
+ * based on device tree. However, other platforms like powernv probe
+ * PCI devices from hardware. The flag is used to distinguish that.
+ * In addition, struct eeh_ops::probe would be invoked for particular
+ * OF node or PCI device so that the corresponding PE would be created
+ * there.
+ */
+int eeh_probe_mode;
+
+/* Global EEH mutex */
+DEFINE_MUTEX(eeh_mutex);
+
+/* Lock to avoid races due to multiple reports of an error */
+static DEFINE_RAW_SPINLOCK(confirm_error_lock);
+
+/* Buffer for reporting pci register dumps. Its here in BSS, and
+ * not dynamically alloced, so that it ends up in RMO where RTAS
+ * can access it.
+ */
+#define EEH_PCI_REGS_LOG_LEN 4096
+static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
+
+/*
+ * The struct is used to maintain the EEH global statistic
+ * information. Besides, the EEH global statistics will be
+ * exported to user space through procfs
+ */
+struct eeh_stats {
+	u64 no_device;		/* PCI device not found		*/
+	u64 no_dn;		/* OF node not found		*/
+	u64 no_cfg_addr;	/* Config address not found	*/
+	u64 ignored_check;	/* EEH check skipped		*/
+	u64 total_mmio_ffs;	/* Total EEH checks		*/
+	u64 false_positives;	/* Unnecessary EEH checks	*/
+	u64 slot_resets;	/* PE reset			*/
+};
+
+static struct eeh_stats eeh_stats;
+
+#define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
+
+/**
+ * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
+ * @edev: device to report data for
+ * @buf: point to buffer in which to log
+ * @len: amount of room in buffer
+ *
+ * This routine captures assorted PCI configuration space data,
+ * and puts them into a buffer for RTAS error logging.
+ */
+static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
+{
+	struct device_node *dn = eeh_dev_to_of_node(edev);
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	u32 cfg;
+	int cap, i;
+	int n = 0;
+
+	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
+	printk(KERN_WARNING "EEH: of node=%s\n", dn->full_name);
+
+	eeh_ops->read_config(dn, PCI_VENDOR_ID, 4, &cfg);
+	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
+	printk(KERN_WARNING "EEH: PCI device/vendor: %08x\n", cfg);
+
+	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cfg);
+	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
+	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
+
+	if (!dev) {
+		printk(KERN_WARNING "EEH: no PCI device for this of node\n");
+		return n;
+	}
+
+	/* Gather bridge-specific registers */
+	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
+		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
+		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
+		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
+
+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &cfg);
+		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
+		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
+	}
+
+	/* Dump out the PCI-X command and status regs */
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (cap) {
+		eeh_ops->read_config(dn, cap, 4, &cfg);
+		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
+		printk(KERN_WARNING "EEH: PCI-X cmd: %08x\n", cfg);
+
+		eeh_ops->read_config(dn, cap+4, 4, &cfg);
+		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
+		printk(KERN_WARNING "EEH: PCI-X status: %08x\n", cfg);
+	}
+
+	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
+	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (cap) {
+		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
+		printk(KERN_WARNING
+		       "EEH: PCI-E capabilities and status follow:\n");
+
+		for (i=0; i<=8; i++) {
+			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
+			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
+			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
+		}
+
+		cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+		if (cap) {
+			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
+			printk(KERN_WARNING
+			       "EEH: PCI-E AER capability register set follows:\n");
+
+			for (i=0; i<14; i++) {
+				eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
+				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
+				printk(KERN_WARNING "EEH: PCI-E AER %02x: %08x\n", i, cfg);
+			}
+		}
+	}
+
+	return n;
+}
+
+/**
+ * eeh_slot_error_detail - Generate combined log including driver log and error log
+ * @pe: EEH PE
+ * @severity: temporary or permanent error log
+ *
+ * This routine should be called to generate the combined log, which
+ * is comprised of driver log and error log. The driver log is figured
+ * out from the config space of the corresponding PCI device, while
+ * the error log is fetched through platform dependent function call.
+ */
+void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
+{
+	size_t loglen = 0;
+	struct eeh_dev *edev;
+
+	eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+	eeh_ops->configure_bridge(pe);
+	eeh_pe_restore_bars(pe);
+
+	pci_regs_buf[0] = 0;
+	eeh_pe_for_each_dev(pe, edev) {
+		loglen += eeh_gather_pci_data(edev, pci_regs_buf,
+				EEH_PCI_REGS_LOG_LEN);
+        }
+
+	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
+}
+
+/**
+ * eeh_token_to_phys - Convert EEH address token to phys address
+ * @token: I/O token, should be address in the form 0xA....
+ *
+ * This routine should be called to convert virtual I/O address
+ * to physical one.
+ */
+static inline unsigned long eeh_token_to_phys(unsigned long token)
+{
+	pte_t *ptep;
+	unsigned long pa;
+
+	ptep = find_linux_pte(init_mm.pgd, token);
+	if (!ptep)
+		return token;
+	pa = pte_pfn(*ptep) << PAGE_SHIFT;
+
+	return pa | (token & (PAGE_SIZE-1));
+}
+
+/**
+ * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
+ * @edev: eeh device
+ *
+ * Check for an EEH failure for the given device node.  Call this
+ * routine if the result of a read was all 0xff's and you want to
+ * find out if this is due to an EEH slot freeze.  This routine
+ * will query firmware for the EEH status.
+ *
+ * Returns 0 if there has not been an EEH error; otherwise returns
+ * a non-zero value and queues up a slot isolation event notification.
+ *
+ * It is safe to call this routine in an interrupt context.
+ */
+int eeh_dev_check_failure(struct eeh_dev *edev)
+{
+	int ret;
+	unsigned long flags;
+	struct device_node *dn;
+	struct pci_dev *dev;
+	struct eeh_pe *pe;
+	int rc = 0;
+	const char *location;
+
+	eeh_stats.total_mmio_ffs++;
+
+	if (!eeh_subsystem_enabled)
+		return 0;
+
+	if (!edev) {
+		eeh_stats.no_dn++;
+		return 0;
+	}
+	dn = eeh_dev_to_of_node(edev);
+	dev = eeh_dev_to_pci_dev(edev);
+	pe = edev->pe;
+
+	/* Access to IO BARs might get this far and still not want checking. */
+	if (!pe) {
+		eeh_stats.ignored_check++;
+		pr_debug("EEH: Ignored check for %s %s\n",
+			eeh_pci_name(dev), dn->full_name);
+		return 0;
+	}
+
+	if (!pe->addr && !pe->config_addr) {
+		eeh_stats.no_cfg_addr++;
+		return 0;
+	}
+
+	/* If we already have a pending isolation event for this
+	 * slot, we know it's bad already, we don't need to check.
+	 * Do this checking under a lock; as multiple PCI devices
+	 * in one slot might report errors simultaneously, and we
+	 * only want one error recovery routine running.
+	 */
+	raw_spin_lock_irqsave(&confirm_error_lock, flags);
+	rc = 1;
+	if (pe->state & EEH_PE_ISOLATED) {
+		pe->check_count++;
+		if (pe->check_count % EEH_MAX_FAILS == 0) {
+			location = of_get_property(dn, "ibm,loc-code", NULL);
+			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
+				"location=%s driver=%s pci addr=%s\n",
+				pe->check_count, location,
+				eeh_driver_name(dev), eeh_pci_name(dev));
+			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
+				eeh_driver_name(dev));
+			dump_stack();
+		}
+		goto dn_unlock;
+	}
+
+	/*
+	 * Now test for an EEH failure.  This is VERY expensive.
+	 * Note that the eeh_config_addr may be a parent device
+	 * in the case of a device behind a bridge, or it may be
+	 * function zero of a multi-function device.
+	 * In any case they must share a common PHB.
+	 */
+	ret = eeh_ops->get_state(pe, NULL);
+
+	/* Note that config-io to empty slots may fail;
+	 * they are empty when they don't have children.
+	 * We will punt with the following conditions: Failure to get
+	 * PE's state, EEH not support and Permanently unavailable
+	 * state, PE is in good state.
+	 */
+	if ((ret < 0) ||
+	    (ret == EEH_STATE_NOT_SUPPORT) ||
+	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
+	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
+		eeh_stats.false_positives++;
+		pe->false_positives++;
+		rc = 0;
+		goto dn_unlock;
+	}
+
+	eeh_stats.slot_resets++;
+
+	/* Avoid repeated reports of this failure, including problems
+	 * with other functions on this device, and functions under
+	 * bridges.
+	 */
+	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+
+	eeh_send_failure_event(pe);
+
+	/* Most EEH events are due to device driver bugs.  Having
+	 * a stack trace will help the device-driver authors figure
+	 * out what happened.  So print that out.
+	 */
+	WARN(1, "EEH: failure detected\n");
+	return 1;
+
+dn_unlock:
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(eeh_dev_check_failure);
+
+/**
+ * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
+ * @token: I/O token, should be address in the form 0xA....
+ * @val: value, should be all 1's (XXX why do we need this arg??)
+ *
+ * Check for an EEH failure at the given token address.  Call this
+ * routine if the result of a read was all 0xff's and you want to
+ * find out if this is due to an EEH slot freeze event.  This routine
+ * will query firmware for the EEH status.
+ *
+ * Note this routine is safe to call in an interrupt context.
+ */
+unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
+{
+	unsigned long addr;
+	struct eeh_dev *edev;
+
+	/* Finding the phys addr + pci device; this is pretty quick. */
+	addr = eeh_token_to_phys((unsigned long __force) token);
+	edev = eeh_addr_cache_get_dev(addr);
+	if (!edev) {
+		eeh_stats.no_device++;
+		return val;
+	}
+
+	eeh_dev_check_failure(edev);
+
+	pci_dev_put(eeh_dev_to_pci_dev(edev));
+	return val;
+}
+
+EXPORT_SYMBOL(eeh_check_failure);
+
+
+/**
+ * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
+ * @pe: EEH PE
+ *
+ * This routine should be called to reenable frozen MMIO or DMA
+ * so that it would work correctly again. It's useful while doing
+ * recovery or log collection on the indicated device.
+ */
+int eeh_pci_enable(struct eeh_pe *pe, int function)
+{
+	int rc;
+
+	rc = eeh_ops->set_option(pe, function);
+	if (rc)
+		pr_warning("%s: Unexpected state change %d on PHB#%d-PE#%x, err=%d\n",
+			__func__, function, pe->phb->global_number, pe->addr, rc);
+
+	rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
+	   (function == EEH_OPT_THAW_MMIO))
+		return 0;
+
+	return rc;
+}
+
+/**
+ * pcibios_set_pcie_slot_reset - Set PCI-E reset state
+ * @dev: pci device struct
+ * @state: reset state to enter
+ *
+ * Return value:
+ * 	0 if success
+ */
+int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+{
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
+	struct eeh_pe *pe = edev->pe;
+
+	if (!pe) {
+		pr_err("%s: No PE found on PCI device %s\n",
+			__func__, pci_name(dev));
+		return -EINVAL;
+	}
+
+	switch (state) {
+	case pcie_deassert_reset:
+		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+		break;
+	case pcie_hot_reset:
+		eeh_ops->reset(pe, EEH_RESET_HOT);
+		break;
+	case pcie_warm_reset:
+		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return 0;
+}
+
+/**
+ * eeh_set_pe_freset - Check the required reset for the indicated device
+ * @data: EEH device
+ * @flag: return value
+ *
+ * Each device might have its preferred reset type: fundamental or
+ * hot reset. The routine is used to collected the information for
+ * the indicated device and its children so that the bunch of the
+ * devices could be reset properly.
+ */
+static void *eeh_set_dev_freset(void *data, void *flag)
+{
+	struct pci_dev *dev;
+	unsigned int *freset = (unsigned int *)flag;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+
+	dev = eeh_dev_to_pci_dev(edev);
+	if (dev)
+		*freset |= dev->needs_freset;
+
+	return NULL;
+}
+
+/**
+ * eeh_reset_pe_once - Assert the pci #RST line for 1/4 second
+ * @pe: EEH PE
+ *
+ * Assert the PCI #RST line for 1/4 second.
+ */
+static void eeh_reset_pe_once(struct eeh_pe *pe)
+{
+	unsigned int freset = 0;
+
+	/* Determine type of EEH reset required for
+	 * Partitionable Endpoint, a hot-reset (1)
+	 * or a fundamental reset (3).
+	 * A fundamental reset required by any device under
+	 * Partitionable Endpoint trumps hot-reset.
+	 */
+	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
+
+	if (freset)
+		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
+	else
+		eeh_ops->reset(pe, EEH_RESET_HOT);
+
+	/* The PCI bus requires that the reset be held high for at least
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.
+	 */
+#define PCI_BUS_RST_HOLD_TIME_MSEC 250
+	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
+
+	/* We might get hit with another EEH freeze as soon as the
+	 * pci slot reset line is dropped. Make sure we don't miss
+	 * these, and clear the flag now.
+	 */
+	eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+
+	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+
+	/* After a PCI slot has been reset, the PCI Express spec requires
+	 * a 1.5 second idle time for the bus to stabilize, before starting
+	 * up traffic.
+	 */
+#define PCI_BUS_SETTLE_TIME_MSEC 1800
+	msleep(PCI_BUS_SETTLE_TIME_MSEC);
+}
+
+/**
+ * eeh_reset_pe - Reset the indicated PE
+ * @pe: EEH PE
+ *
+ * This routine should be called to reset indicated device, including
+ * PE. A PE might include multiple PCI devices and sometimes PCI bridges
+ * might be involved as well.
+ */
+int eeh_reset_pe(struct eeh_pe *pe)
+{
+	int i, rc;
+
+	/* Take three shots at resetting the bus */
+	for (i=0; i<3; i++) {
+		eeh_reset_pe_once(pe);
+
+		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
+			return 0;
+
+		if (rc < 0) {
+			pr_err("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
+				__func__, pe->phb->global_number, pe->addr);
+			return -1;
+		}
+		pr_err("EEH: bus reset %d failed on PHB#%d-PE#%x, rc=%d\n",
+			i+1, pe->phb->global_number, pe->addr, rc);
+	}
+
+	return -1;
+}
+
+/**
+ * eeh_save_bars - Save device bars
+ * @edev: PCI device associated EEH device
+ *
+ * Save the values of the device bars. Unlike the restore
+ * routine, this routine is *not* recursive. This is because
+ * PCI devices are added individually; but, for the restore,
+ * an entire slot is reset at a time.
+ */
+void eeh_save_bars(struct eeh_dev *edev)
+{
+	int i;
+	struct device_node *dn;
+
+	if (!edev)
+		return;
+	dn = eeh_dev_to_of_node(edev);
+
+	for (i = 0; i < 16; i++)
+		eeh_ops->read_config(dn, i * 4, 4, &edev->config_space[i]);
+}
+
+/**
+ * eeh_ops_register - Register platform dependent EEH operations
+ * @ops: platform dependent EEH operations
+ *
+ * Register the platform dependent EEH operation callback
+ * functions. The platform should call this function before
+ * any other EEH operations.
+ */
+int __init eeh_ops_register(struct eeh_ops *ops)
+{
+	if (!ops->name) {
+		pr_warning("%s: Invalid EEH ops name for %p\n",
+			__func__, ops);
+		return -EINVAL;
+	}
+
+	if (eeh_ops && eeh_ops != ops) {
+		pr_warning("%s: EEH ops of platform %s already existing (%s)\n",
+			__func__, eeh_ops->name, ops->name);
+		return -EEXIST;
+	}
+
+	eeh_ops = ops;
+
+	return 0;
+}
+
+/**
+ * eeh_ops_unregister - Unreigster platform dependent EEH operations
+ * @name: name of EEH platform operations
+ *
+ * Unregister the platform dependent EEH operation callback
+ * functions.
+ */
+int __exit eeh_ops_unregister(const char *name)
+{
+	if (!name || !strlen(name)) {
+		pr_warning("%s: Invalid EEH ops name\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (eeh_ops && !strcmp(eeh_ops->name, name)) {
+		eeh_ops = NULL;
+		return 0;
+	}
+
+	return -EEXIST;
+}
+
+/**
+ * eeh_init - EEH initialization
+ *
+ * Initialize EEH by trying to enable it for all of the adapters in the system.
+ * As a side effect we can determine here if eeh is supported at all.
+ * Note that we leave EEH on so failed config cycles won't cause a machine
+ * check.  If a user turns off EEH for a particular adapter they are really
+ * telling Linux to ignore errors.  Some hardware (e.g. POWER5) won't
+ * grant access to a slot if EEH isn't enabled, and so we always enable
+ * EEH for all slots/all devices.
+ *
+ * The eeh-force-off option disables EEH checking globally, for all slots.
+ * Even if force-off is set, the EEH hardware is still enabled, so that
+ * newer systems can boot.
+ */
+static int __init eeh_init(void)
+{
+	struct pci_controller *hose, *tmp;
+	struct device_node *phb;
+	int ret;
+
+	/* call platform initialization function */
+	if (!eeh_ops) {
+		pr_warning("%s: Platform EEH operation not found\n",
+			__func__);
+		return -EEXIST;
+	} else if ((ret = eeh_ops->init())) {
+		pr_warning("%s: Failed to call platform init function (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	raw_spin_lock_init(&confirm_error_lock);
+
+	/* Enable EEH for all adapters */
+	if (eeh_probe_mode_devtree()) {
+		list_for_each_entry_safe(hose, tmp,
+			&hose_list, list_node) {
+			phb = hose->dn;
+			traverse_pci_devices(phb, eeh_ops->of_probe, NULL);
+		}
+	}
+
+	if (eeh_subsystem_enabled)
+		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
+	else
+		pr_warning("EEH: No capable adapters found\n");
+
+	return ret;
+}
+
+core_initcall_sync(eeh_init);
+
+/**
+ * eeh_add_device_early - Enable EEH for the indicated device_node
+ * @dn: device node for which to set up EEH
+ *
+ * This routine must be used to perform EEH initialization for PCI
+ * devices that were added after system boot (e.g. hotplug, dlpar).
+ * This routine must be called before any i/o is performed to the
+ * adapter (inluding any config-space i/o).
+ * Whether this actually enables EEH or not for this device depends
+ * on the CEC architecture, type of the device, on earlier boot
+ * command-line arguments & etc.
+ */
+static void eeh_add_device_early(struct device_node *dn)
+{
+	struct pci_controller *phb;
+
+	if (!of_node_to_eeh_dev(dn))
+		return;
+	phb = of_node_to_eeh_dev(dn)->phb;
+
+	/* USB Bus children of PCI devices will not have BUID's */
+	if (NULL == phb || 0 == phb->buid)
+		return;
+
+	/* FIXME: hotplug support on POWERNV */
+	eeh_ops->of_probe(dn, NULL);
+}
+
+/**
+ * eeh_add_device_tree_early - Enable EEH for the indicated device
+ * @dn: device node
+ *
+ * This routine must be used to perform EEH initialization for the
+ * indicated PCI device that was added after system boot (e.g.
+ * hotplug, dlpar).
+ */
+void eeh_add_device_tree_early(struct device_node *dn)
+{
+	struct device_node *sib;
+
+	for_each_child_of_node(dn, sib)
+		eeh_add_device_tree_early(sib);
+	eeh_add_device_early(dn);
+}
+EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
+
+/**
+ * eeh_add_device_late - Perform EEH initialization for the indicated pci device
+ * @dev: pci device for which to set up EEH
+ *
+ * This routine must be used to complete EEH initialization for PCI
+ * devices that were added after system boot (e.g. hotplug, dlpar).
+ */
+static void eeh_add_device_late(struct pci_dev *dev)
+{
+	struct device_node *dn;
+	struct eeh_dev *edev;
+
+	if (!dev || !eeh_subsystem_enabled)
+		return;
+
+	pr_debug("EEH: Adding device %s\n", pci_name(dev));
+
+	dn = pci_device_to_OF_node(dev);
+	edev = of_node_to_eeh_dev(dn);
+	if (edev->pdev == dev) {
+		pr_debug("EEH: Already referenced !\n");
+		return;
+	}
+	WARN_ON(edev->pdev);
+
+	pci_dev_get(dev);
+	edev->pdev = dev;
+	dev->dev.archdata.edev = edev;
+
+	eeh_addr_cache_insert_dev(dev);
+}
+
+/**
+ * eeh_add_device_tree_late - Perform EEH initialization for the indicated PCI bus
+ * @bus: PCI bus
+ *
+ * This routine must be used to perform EEH initialization for PCI
+ * devices which are attached to the indicated PCI bus. The PCI bus
+ * is added after system boot through hotplug or dlpar.
+ */
+void eeh_add_device_tree_late(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_add_device_late(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (subbus)
+				eeh_add_device_tree_late(subbus);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
+
+/**
+ * eeh_add_sysfs_files - Add EEH sysfs files for the indicated PCI bus
+ * @bus: PCI bus
+ *
+ * This routine must be used to add EEH sysfs files for PCI
+ * devices which are attached to the indicated PCI bus. The PCI bus
+ * is added after system boot through hotplug or dlpar.
+ */
+void eeh_add_sysfs_files(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_sysfs_add_device(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (subbus)
+				eeh_add_sysfs_files(subbus);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
+
+/**
+ * eeh_remove_device - Undo EEH setup for the indicated pci device
+ * @dev: pci device to be removed
+ * @purge_pe: remove the PE or not
+ *
+ * This routine should be called when a device is removed from
+ * a running system (e.g. by hotplug or dlpar).  It unregisters
+ * the PCI device from the EEH subsystem.  I/O errors affecting
+ * this device will no longer be detected after this call; thus,
+ * i/o errors affecting this slot may leave this device unusable.
+ */
+static void eeh_remove_device(struct pci_dev *dev, int purge_pe)
+{
+	struct eeh_dev *edev;
+
+	if (!dev || !eeh_subsystem_enabled)
+		return;
+	edev = pci_dev_to_eeh_dev(dev);
+
+	/* Unregister the device with the EEH/PCI address search system */
+	pr_debug("EEH: Removing device %s\n", pci_name(dev));
+
+	if (!edev || !edev->pdev) {
+		pr_debug("EEH: Not referenced !\n");
+		return;
+	}
+	edev->pdev = NULL;
+	dev->dev.archdata.edev = NULL;
+	pci_dev_put(dev);
+
+	eeh_rmv_from_parent_pe(edev, purge_pe);
+	eeh_addr_cache_rmv_dev(dev);
+	eeh_sysfs_remove_device(dev);
+}
+
+/**
+ * eeh_remove_bus_device - Undo EEH setup for the indicated PCI device
+ * @dev: PCI device
+ * @purge_pe: remove the corresponding PE or not
+ *
+ * This routine must be called when a device is removed from the
+ * running system through hotplug or dlpar. The corresponding
+ * PCI address cache will be removed.
+ */
+void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe)
+{
+	struct pci_bus *bus = dev->subordinate;
+	struct pci_dev *child, *tmp;
+
+	eeh_remove_device(dev, purge_pe);
+
+	if (bus && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+			 eeh_remove_bus_device(child, purge_pe);
+	}
+}
+EXPORT_SYMBOL_GPL(eeh_remove_bus_device);
+
+static int proc_eeh_show(struct seq_file *m, void *v)
+{
+	if (0 == eeh_subsystem_enabled) {
+		seq_printf(m, "EEH Subsystem is globally disabled\n");
+		seq_printf(m, "eeh_total_mmio_ffs=%llu\n", eeh_stats.total_mmio_ffs);
+	} else {
+		seq_printf(m, "EEH Subsystem is enabled\n");
+		seq_printf(m,
+				"no device=%llu\n"
+				"no device node=%llu\n"
+				"no config address=%llu\n"
+				"check not wanted=%llu\n"
+				"eeh_total_mmio_ffs=%llu\n"
+				"eeh_false_positives=%llu\n"
+				"eeh_slot_resets=%llu\n",
+				eeh_stats.no_device,
+				eeh_stats.no_dn,
+				eeh_stats.no_cfg_addr,
+				eeh_stats.ignored_check,
+				eeh_stats.total_mmio_ffs,
+				eeh_stats.false_positives,
+				eeh_stats.slot_resets);
+	}
+
+	return 0;
+}
+
+static int proc_eeh_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_eeh_show, NULL);
+}
+
+static const struct file_operations proc_eeh_operations = {
+	.open      = proc_eeh_open,
+	.read      = seq_read,
+	.llseek    = seq_lseek,
+	.release   = single_release,
+};
+
+static int __init eeh_init_proc(void)
+{
+	if (machine_is(pseries))
+		proc_create("powerpc/eeh", 0, NULL, &proc_eeh_operations);
+	return 0;
+}
+__initcall(eeh_init_proc);
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
new file mode 100644
index 0000000..1d5d9a6
--- /dev/null
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -0,0 +1,318 @@
+/*
+ * PCI address cache; allows the lookup of PCI devices based on I/O address
+ *
+ * Copyright IBM Corporation 2004
+ * Copyright Linas Vepstas <linas@austin.ibm.com> 2004
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+
+/**
+ * The pci address cache subsystem.  This subsystem places
+ * PCI device address resources into a red-black tree, sorted
+ * according to the address range, so that given only an i/o
+ * address, the corresponding PCI device can be **quickly**
+ * found. It is safe to perform an address lookup in an interrupt
+ * context; this ability is an important feature.
+ *
+ * Currently, the only customer of this code is the EEH subsystem;
+ * thus, this code has been somewhat tailored to suit EEH better.
+ * In particular, the cache does *not* hold the addresses of devices
+ * for which EEH is not enabled.
+ *
+ * (Implementation Note: The RB tree seems to be better/faster
+ * than any hash algo I could think of for this problem, even
+ * with the penalty of slow pointer chases for d-cache misses).
+ */
+struct pci_io_addr_range {
+	struct rb_node rb_node;
+	unsigned long addr_lo;
+	unsigned long addr_hi;
+	struct eeh_dev *edev;
+	struct pci_dev *pcidev;
+	unsigned int flags;
+};
+
+static struct pci_io_addr_cache {
+	struct rb_root rb_root;
+	spinlock_t piar_lock;
+} pci_io_addr_cache_root;
+
+static inline struct eeh_dev *__eeh_addr_cache_get_device(unsigned long addr)
+{
+	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
+
+	while (n) {
+		struct pci_io_addr_range *piar;
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+
+		if (addr < piar->addr_lo) {
+			n = n->rb_left;
+		} else {
+			if (addr > piar->addr_hi) {
+				n = n->rb_right;
+			} else {
+				pci_dev_get(piar->pcidev);
+				return piar->edev;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_addr_cache_get_dev - Get device, given only address
+ * @addr: mmio (PIO) phys address or i/o port number
+ *
+ * Given an mmio phys address, or a port number, find a pci device
+ * that implements this address.  Be sure to pci_dev_put the device
+ * when finished.  I/O port numbers are assumed to be offset
+ * from zero (that is, they do *not* have pci_io_addr added in).
+ * It is safe to call this function within an interrupt.
+ */
+struct eeh_dev *eeh_addr_cache_get_dev(unsigned long addr)
+{
+	struct eeh_dev *edev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
+	edev = __eeh_addr_cache_get_device(addr);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
+	return edev;
+}
+
+#ifdef DEBUG
+/*
+ * Handy-dandy debug print routine, does nothing more
+ * than print out the contents of our addr cache.
+ */
+static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
+{
+	struct rb_node *n;
+	int cnt = 0;
+
+	n = rb_first(&cache->rb_root);
+	while (n) {
+		struct pci_io_addr_range *piar;
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+		pr_debug("PCI: %s addr range %d [%lx-%lx]: %s\n",
+		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
+		       piar->addr_lo, piar->addr_hi, pci_name(piar->pcidev));
+		cnt++;
+		n = rb_next(n);
+	}
+}
+#endif
+
+/* Insert address range into the rb tree. */
+static struct pci_io_addr_range *
+eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
+		      unsigned long ahi, unsigned int flags)
+{
+	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct pci_io_addr_range *piar;
+
+	/* Walk tree, find a place to insert into tree */
+	while (*p) {
+		parent = *p;
+		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
+		if (ahi < piar->addr_lo) {
+			p = &parent->rb_left;
+		} else if (alo > piar->addr_hi) {
+			p = &parent->rb_right;
+		} else {
+			if (dev != piar->pcidev ||
+			    alo != piar->addr_lo || ahi != piar->addr_hi) {
+				pr_warning("PIAR: overlapping address range\n");
+			}
+			return piar;
+		}
+	}
+	piar = kzalloc(sizeof(struct pci_io_addr_range), GFP_ATOMIC);
+	if (!piar)
+		return NULL;
+
+	pci_dev_get(dev);
+	piar->addr_lo = alo;
+	piar->addr_hi = ahi;
+	piar->edev = pci_dev_to_eeh_dev(dev);
+	piar->pcidev = dev;
+	piar->flags = flags;
+
+#ifdef DEBUG
+	pr_debug("PIAR: insert range=[%lx:%lx] dev=%s\n",
+	                  alo, ahi, pci_name(dev));
+#endif
+
+	rb_link_node(&piar->rb_node, parent, p);
+	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
+
+	return piar;
+}
+
+static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
+{
+	struct device_node *dn;
+	struct eeh_dev *edev;
+	int i;
+
+	dn = pci_device_to_OF_node(dev);
+	if (!dn) {
+		pr_warning("PCI: no pci dn found for dev=%s\n", pci_name(dev));
+		return;
+	}
+
+	edev = of_node_to_eeh_dev(dn);
+	if (!edev) {
+		pr_warning("PCI: no EEH dev found for dn=%s\n",
+			dn->full_name);
+		return;
+	}
+
+	/* Skip any devices for which EEH is not enabled. */
+	if (!edev->pe) {
+#ifdef DEBUG
+		pr_info("PCI: skip building address cache for=%s - %s\n",
+			pci_name(dev), dn->full_name);
+#endif
+		return;
+	}
+
+	/* Walk resources on this device, poke them into the tree */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		unsigned long start = pci_resource_start(dev,i);
+		unsigned long end = pci_resource_end(dev,i);
+		unsigned int flags = pci_resource_flags(dev,i);
+
+		/* We are interested only bus addresses, not dma or other stuff */
+		if (0 == (flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
+			 continue;
+		eeh_addr_cache_insert(dev, start, end, flags);
+	}
+}
+
+/**
+ * eeh_addr_cache_insert_dev - Add a device to the address cache
+ * @dev: PCI device whose I/O addresses we are interested in.
+ *
+ * In order to support the fast lookup of devices based on addresses,
+ * we maintain a cache of devices that can be quickly searched.
+ * This routine adds a device to that cache.
+ */
+void eeh_addr_cache_insert_dev(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	/* Ignore PCI bridges */
+	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+		return;
+
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
+	__eeh_addr_cache_insert_dev(dev);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
+}
+
+static inline void __eeh_addr_cache_rmv_dev(struct pci_dev *dev)
+{
+	struct rb_node *n;
+
+restart:
+	n = rb_first(&pci_io_addr_cache_root.rb_root);
+	while (n) {
+		struct pci_io_addr_range *piar;
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+
+		if (piar->pcidev == dev) {
+			rb_erase(n, &pci_io_addr_cache_root.rb_root);
+			pci_dev_put(piar->pcidev);
+			kfree(piar);
+			goto restart;
+		}
+		n = rb_next(n);
+	}
+}
+
+/**
+ * eeh_addr_cache_rmv_dev - remove pci device from addr cache
+ * @dev: device to remove
+ *
+ * Remove a device from the addr-cache tree.
+ * This is potentially expensive, since it will walk
+ * the tree multiple times (once per resource).
+ * But so what; device removal doesn't need to be that fast.
+ */
+void eeh_addr_cache_rmv_dev(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
+	__eeh_addr_cache_rmv_dev(dev);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
+}
+
+/**
+ * eeh_addr_cache_build - Build a cache of I/O addresses
+ *
+ * Build a cache of pci i/o addresses.  This cache will be used to
+ * find the pci device that corresponds to a given address.
+ * This routine scans all pci busses to build the cache.
+ * Must be run late in boot process, after the pci controllers
+ * have been scanned for devices (after all device resources are known).
+ */
+void __init eeh_addr_cache_build(void)
+{
+	struct device_node *dn;
+	struct eeh_dev *edev;
+	struct pci_dev *dev = NULL;
+
+	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
+
+	for_each_pci_dev(dev) {
+		eeh_addr_cache_insert_dev(dev);
+
+		dn = pci_device_to_OF_node(dev);
+		if (!dn)
+			continue;
+
+		edev = of_node_to_eeh_dev(dn);
+		if (!edev)
+			continue;
+
+		pci_dev_get(dev);  /* matching put is in eeh_remove_device() */
+		dev->dev.archdata.edev = edev;
+		edev->pdev = dev;
+
+		eeh_sysfs_add_device(dev);
+	}
+
+#ifdef DEBUG
+	/* Verify tree built up above, echo back the list of addrs. */
+	eeh_addr_cache_print(&pci_io_addr_cache_root);
+#endif
+}
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
new file mode 100644
index 0000000..1efa28f
--- /dev/null
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -0,0 +1,112 @@
+/*
+ * The file intends to implement dynamic creation of EEH device, which will
+ * be bound with OF node and PCI device simutaneously. The EEH devices would
+ * be foundamental information for EEH core components to work proerly. Besides,
+ * We have to support multiple situations where dynamic creation of EEH device
+ * is required:
+ *
+ * 1) Before PCI emunation starts, we need create EEH devices according to the
+ *    PCI sensitive OF nodes.
+ * 2) When PCI emunation is done, we need do the binding between PCI device and
+ *    the associated EEH device.
+ * 3) DR (Dynamic Reconfiguration) would create PCI sensitive OF node. EEH device
+ *    will be created while PCI sensitive OF node is detected from DR.
+ * 4) PCI hotplug needs redoing the binding between PCI device and EEH device. If
+ *    PHB is newly inserted, we also need create EEH devices accordingly.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2012.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+/**
+ * eeh_dev_init - Create EEH device according to OF node
+ * @dn: device node
+ * @data: PHB
+ *
+ * It will create EEH device according to the given OF node. The function
+ * might be called by PCI emunation, DR, PHB hotplug.
+ */
+void *eeh_dev_init(struct device_node *dn, void *data)
+{
+	struct pci_controller *phb = data;
+	struct eeh_dev *edev;
+
+	/* Allocate EEH device */
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	if (!edev) {
+		pr_warning("%s: out of memory\n", __func__);
+		return NULL;
+	}
+
+	/* Associate EEH device with OF node */
+	PCI_DN(dn)->edev = edev;
+	edev->dn  = dn;
+	edev->phb = phb;
+	INIT_LIST_HEAD(&edev->list);
+
+	return NULL;
+}
+
+/**
+ * eeh_dev_phb_init_dynamic - Create EEH devices for devices included in PHB
+ * @phb: PHB
+ *
+ * Scan the PHB OF node and its child association, then create the
+ * EEH devices accordingly
+ */
+void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
+{
+	struct device_node *dn = phb->dn;
+
+	/* EEH PE for PHB */
+	eeh_phb_pe_create(phb);
+
+	/* EEH device for PHB */
+	eeh_dev_init(dn, phb);
+
+	/* EEH devices for children OF nodes */
+	traverse_pci_devices(dn, eeh_dev_init, phb);
+}
+
+/**
+ * eeh_dev_phb_init - Create EEH devices for devices included in existing PHBs
+ *
+ * Scan all the existing PHBs and create EEH devices for their OF
+ * nodes and their children OF nodes
+ */
+static int __init eeh_dev_phb_init(void)
+{
+	struct pci_controller *phb, *tmp;
+
+	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
+		eeh_dev_phb_init_dynamic(phb);
+
+	pr_info("EEH: devices created\n");
+
+	return 0;
+}
+
+core_initcall(eeh_dev_phb_init);
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
new file mode 100644
index 0000000..fb927af
--- /dev/null
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -0,0 +1,551 @@
+/*
+ * PCI Error Recovery Driver for RPA-compliant PPC64 platform.
+ * Copyright IBM Corp. 2004 2005
+ * Copyright Linas Vepstas <linas@linas.org> 2004, 2005
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/ppc-pci.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+
+/**
+ * eeh_pcid_name - Retrieve name of PCI device driver
+ * @pdev: PCI device
+ *
+ * This routine is used to retrieve the name of PCI device driver
+ * if that's valid.
+ */
+static inline const char *eeh_pcid_name(struct pci_dev *pdev)
+{
+	if (pdev && pdev->dev.driver)
+		return pdev->dev.driver->name;
+	return "";
+}
+
+/**
+ * eeh_pcid_get - Get the PCI device driver
+ * @pdev: PCI device
+ *
+ * The function is used to retrieve the PCI device driver for
+ * the indicated PCI device. Besides, we will increase the reference
+ * of the PCI device driver to prevent that being unloaded on
+ * the fly. Otherwise, kernel crash would be seen.
+ */
+static inline struct pci_driver *eeh_pcid_get(struct pci_dev *pdev)
+{
+	if (!pdev || !pdev->driver)
+		return NULL;
+
+	if (!try_module_get(pdev->driver->driver.owner))
+		return NULL;
+
+	return pdev->driver;
+}
+
+/**
+ * eeh_pcid_put - Dereference on the PCI device driver
+ * @pdev: PCI device
+ *
+ * The function is called to do dereference on the PCI device
+ * driver of the indicated PCI device.
+ */
+static inline void eeh_pcid_put(struct pci_dev *pdev)
+{
+	if (!pdev || !pdev->driver)
+		return;
+
+	module_put(pdev->driver->driver.owner);
+}
+
+#if 0
+static void print_device_node_tree(struct pci_dn *pdn, int dent)
+{
+	int i;
+	struct device_node *pc;
+
+	if (!pdn)
+		return;
+	for (i = 0; i < dent; i++)
+		printk(" ");
+	printk("dn=%s mode=%x \tcfg_addr=%x pe_addr=%x \tfull=%s\n",
+		pdn->node->name, pdn->eeh_mode, pdn->eeh_config_addr,
+		pdn->eeh_pe_config_addr, pdn->node->full_name);
+	dent += 3;
+	pc = pdn->node->child;
+	while (pc) {
+		print_device_node_tree(PCI_DN(pc), dent);
+		pc = pc->sibling;
+	}
+}
+#endif
+
+/**
+ * eeh_disable_irq - Disable interrupt for the recovering device
+ * @dev: PCI device
+ *
+ * This routine must be called when reporting temporary or permanent
+ * error to the particular PCI device to disable interrupt of that
+ * device. If the device has enabled MSI or MSI-X interrupt, we needn't
+ * do real work because EEH should freeze DMA transfers for those PCI
+ * devices encountering EEH errors, which includes MSI or MSI-X.
+ */
+static void eeh_disable_irq(struct pci_dev *dev)
+{
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
+
+	/* Don't disable MSI and MSI-X interrupts. They are
+	 * effectively disabled by the DMA Stopped state
+	 * when an EEH error occurs.
+	 */
+	if (dev->msi_enabled || dev->msix_enabled)
+		return;
+
+	if (!irq_has_action(dev->irq))
+		return;
+
+	edev->mode |= EEH_DEV_IRQ_DISABLED;
+	disable_irq_nosync(dev->irq);
+}
+
+/**
+ * eeh_enable_irq - Enable interrupt for the recovering device
+ * @dev: PCI device
+ *
+ * This routine must be called to enable interrupt while failed
+ * device could be resumed.
+ */
+static void eeh_enable_irq(struct pci_dev *dev)
+{
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
+
+	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
+		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
+		enable_irq(dev->irq);
+	}
+}
+
+/**
+ * eeh_report_error - Report pci error to each device driver
+ * @data: eeh device
+ * @userdata: return value
+ *
+ * Report an EEH error to each device driver, collect up and
+ * merge the device driver responses. Cumulative response
+ * passed back in "userdata".
+ */
+static void *eeh_report_error(void *data, void *userdata)
+{
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	enum pci_ers_result rc, *res = userdata;
+	struct pci_driver *driver;
+
+	/* We might not have the associated PCI device,
+	 * then we should continue for next one.
+	 */
+	if (!dev) return NULL;
+	dev->error_state = pci_channel_io_frozen;
+
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
+
+	eeh_disable_irq(dev);
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->error_detected) {
+		eeh_pcid_put(dev);
+		return NULL;
+	}
+
+	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
+
+	/* A driver that needs a reset trumps all others */
+	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
+	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
+
+	eeh_pcid_put(dev);
+	return NULL;
+}
+
+/**
+ * eeh_report_mmio_enabled - Tell drivers that MMIO has been enabled
+ * @data: eeh device
+ * @userdata: return value
+ *
+ * Tells each device driver that IO ports, MMIO and config space I/O
+ * are now enabled. Collects up and merges the device driver responses.
+ * Cumulative response passed back in "userdata".
+ */
+static void *eeh_report_mmio_enabled(void *data, void *userdata)
+{
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	enum pci_ers_result rc, *res = userdata;
+	struct pci_driver *driver;
+
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->mmio_enabled) {
+		eeh_pcid_put(dev);
+		return NULL;
+	}
+
+	rc = driver->err_handler->mmio_enabled(dev);
+
+	/* A driver that needs a reset trumps all others */
+	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
+	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
+
+	eeh_pcid_put(dev);
+	return NULL;
+}
+
+/**
+ * eeh_report_reset - Tell device that slot has been reset
+ * @data: eeh device
+ * @userdata: return value
+ *
+ * This routine must be called while EEH tries to reset particular
+ * PCI device so that the associated PCI device driver could take
+ * some actions, usually to save data the driver needs so that the
+ * driver can work again while the device is recovered.
+ */
+static void *eeh_report_reset(void *data, void *userdata)
+{
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	enum pci_ers_result rc, *res = userdata;
+	struct pci_driver *driver;
+
+	if (!dev) return NULL;
+	dev->error_state = pci_channel_io_normal;
+
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
+
+	eeh_enable_irq(dev);
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->slot_reset) {
+		eeh_pcid_put(dev);
+		return NULL;
+	}
+
+	rc = driver->err_handler->slot_reset(dev);
+	if ((*res == PCI_ERS_RESULT_NONE) ||
+	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
+	if (*res == PCI_ERS_RESULT_DISCONNECT &&
+	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
+
+	eeh_pcid_put(dev);
+	return NULL;
+}
+
+/**
+ * eeh_report_resume - Tell device to resume normal operations
+ * @data: eeh device
+ * @userdata: return value
+ *
+ * This routine must be called to notify the device driver that it
+ * could resume so that the device driver can do some initialization
+ * to make the recovered device work again.
+ */
+static void *eeh_report_resume(void *data, void *userdata)
+{
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_driver *driver;
+
+	if (!dev) return NULL;
+	dev->error_state = pci_channel_io_normal;
+
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
+
+	eeh_enable_irq(dev);
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->resume) {
+		eeh_pcid_put(dev);
+		return NULL;
+	}
+
+	driver->err_handler->resume(dev);
+
+	eeh_pcid_put(dev);
+	return NULL;
+}
+
+/**
+ * eeh_report_failure - Tell device driver that device is dead.
+ * @data: eeh device
+ * @userdata: return value
+ *
+ * This informs the device driver that the device is permanently
+ * dead, and that no further recovery attempts will be made on it.
+ */
+static void *eeh_report_failure(void *data, void *userdata)
+{
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_driver *driver;
+
+	if (!dev) return NULL;
+	dev->error_state = pci_channel_io_perm_failure;
+
+	driver = eeh_pcid_get(dev);
+	if (!driver) return NULL;
+
+	eeh_disable_irq(dev);
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->error_detected) {
+		eeh_pcid_put(dev);
+		return NULL;
+	}
+
+	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
+
+	eeh_pcid_put(dev);
+	return NULL;
+}
+
+/**
+ * eeh_reset_device - Perform actual reset of a pci slot
+ * @pe: EEH PE
+ * @bus: PCI bus corresponding to the isolcated slot
+ *
+ * This routine must be called to do reset on the indicated PE.
+ * During the reset, udev might be invoked because those affected
+ * PCI devices will be removed and then added.
+ */
+static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
+{
+	int cnt, rc;
+
+	/* pcibios will clear the counter; save the value */
+	cnt = pe->freeze_count;
+
+	/*
+	 * We don't remove the corresponding PE instances because
+	 * we need the information afterwords. The attached EEH
+	 * devices are expected to be attached soon when calling
+	 * into pcibios_add_pci_devices().
+	 */
+	if (bus)
+		__pcibios_remove_pci_devices(bus, 0);
+
+	/* Reset the pci controller. (Asserts RST#; resets config space).
+	 * Reconfigure bridges and devices. Don't try to bring the system
+	 * up if the reset failed for some reason.
+	 */
+	rc = eeh_reset_pe(pe);
+	if (rc)
+		return rc;
+
+	/* Restore PE */
+	eeh_ops->configure_bridge(pe);
+	eeh_pe_restore_bars(pe);
+
+	/* Give the system 5 seconds to finish running the user-space
+	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
+	 * this is a hack, but if we don't do this, and try to bring
+	 * the device up before the scripts have taken it down,
+	 * potentially weird things happen.
+	 */
+	if (bus) {
+		ssleep(5);
+		pcibios_add_pci_devices(bus);
+	}
+	pe->freeze_count = cnt;
+
+	return 0;
+}
+
+/* The longest amount of time to wait for a pci device
+ * to come back on line, in seconds.
+ */
+#define MAX_WAIT_FOR_RECOVERY 150
+
+/**
+ * eeh_handle_event - Reset a PCI device after hard lockup.
+ * @pe: EEH PE
+ *
+ * While PHB detects address or data parity errors on particular PCI
+ * slot, the associated PE will be frozen. Besides, DMA's occurring
+ * to wild addresses (which usually happen due to bugs in device
+ * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
+ * #PERR or other misc PCI-related errors also can trigger EEH errors.
+ *
+ * Recovery process consists of unplugging the device driver (which
+ * generated hotplug events to userspace), then issuing a PCI #RST to
+ * the device, then reconfiguring the PCI config space for all bridges
+ * & devices under this slot, and then finally restarting the device
+ * drivers (which cause a second set of hotplug events to go out to
+ * userspace).
+ */
+void eeh_handle_event(struct eeh_pe *pe)
+{
+	struct pci_bus *frozen_bus;
+	int rc = 0;
+	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
+
+	frozen_bus = eeh_pe_bus_get(pe);
+	if (!frozen_bus) {
+		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
+			__func__, pe->phb->global_number, pe->addr);
+		return;
+	}
+
+	pe->freeze_count++;
+	if (pe->freeze_count > EEH_MAX_ALLOWED_FREEZES)
+		goto excess_failures;
+	pr_warning("EEH: This PCI device has failed %d times in the last hour\n",
+		pe->freeze_count);
+
+	/* Walk the various device drivers attached to this slot through
+	 * a reset sequence, giving each an opportunity to do what it needs
+	 * to accomplish the reset.  Each child gets a report of the
+	 * status ... if any child can't handle the reset, then the entire
+	 * slot is dlpar removed and added.
+	 */
+	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
+
+	/* Get the current PCI slot state. This can take a long time,
+	 * sometimes over 3 seconds for certain systems.
+	 */
+	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
+	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
+		printk(KERN_WARNING "EEH: Permanent failure\n");
+		goto hard_fail;
+	}
+
+	/* Since rtas may enable MMIO when posting the error log,
+	 * don't post the error log until after all dev drivers
+	 * have been informed.
+	 */
+	eeh_slot_error_detail(pe, EEH_LOG_TEMP);
+
+	/* If all device drivers were EEH-unaware, then shut
+	 * down all of the device drivers, and hope they
+	 * go down willingly, without panicing the system.
+	 */
+	if (result == PCI_ERS_RESULT_NONE) {
+		rc = eeh_reset_device(pe, frozen_bus);
+		if (rc) {
+			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
+			goto hard_fail;
+		}
+	}
+
+	/* If all devices reported they can proceed, then re-enable MMIO */
+	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
+		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+
+		if (rc < 0)
+			goto hard_fail;
+		if (rc) {
+			result = PCI_ERS_RESULT_NEED_RESET;
+		} else {
+			result = PCI_ERS_RESULT_NONE;
+			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
+		}
+	}
+
+	/* If all devices reported they can proceed, then re-enable DMA */
+	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
+		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
+
+		if (rc < 0)
+			goto hard_fail;
+		if (rc)
+			result = PCI_ERS_RESULT_NEED_RESET;
+		else
+			result = PCI_ERS_RESULT_RECOVERED;
+	}
+
+	/* If any device has a hard failure, then shut off everything. */
+	if (result == PCI_ERS_RESULT_DISCONNECT) {
+		printk(KERN_WARNING "EEH: Device driver gave up\n");
+		goto hard_fail;
+	}
+
+	/* If any device called out for a reset, then reset the slot */
+	if (result == PCI_ERS_RESULT_NEED_RESET) {
+		rc = eeh_reset_device(pe, NULL);
+		if (rc) {
+			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
+			goto hard_fail;
+		}
+		result = PCI_ERS_RESULT_NONE;
+		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
+	}
+
+	/* All devices should claim they have recovered by now. */
+	if ((result != PCI_ERS_RESULT_RECOVERED) &&
+	    (result != PCI_ERS_RESULT_NONE)) {
+		printk(KERN_WARNING "EEH: Not recovered\n");
+		goto hard_fail;
+	}
+
+	/* Tell all device drivers that they can resume operations */
+	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
+
+	return;
+
+excess_failures:
+	/*
+	 * About 90% of all real-life EEH failures in the field
+	 * are due to poorly seated PCI cards. Only 10% or so are
+	 * due to actual, failed cards.
+	 */
+	pr_err("EEH: PHB#%d-PE#%x has failed %d times in the\n"
+	       "last hour and has been permanently disabled.\n"
+	       "Please try reseating or replacing it.\n",
+		pe->phb->global_number, pe->addr,
+		pe->freeze_count);
+	goto perm_error;
+
+hard_fail:
+	pr_err("EEH: Unable to recover from failure from PHB#%d-PE#%x.\n"
+	       "Please try reseating or replacing it\n",
+		pe->phb->global_number, pe->addr);
+
+perm_error:
+	eeh_slot_error_detail(pe, EEH_LOG_PERM);
+
+	/* Notify all devices that they're about to go down. */
+	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
+
+	/* Shut down the device drivers for good. */
+	if (frozen_bus)
+		pcibios_remove_pci_devices(frozen_bus);
+}
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
new file mode 100644
index 0000000..185bedd
--- /dev/null
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -0,0 +1,142 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include <asm/eeh_event.h>
+#include <asm/ppc-pci.h>
+
+/** Overview:
+ *  EEH error states may be detected within exception handlers;
+ *  however, the recovery processing needs to occur asynchronously
+ *  in a normal kernel context and not an interrupt context.
+ *  This pair of routines creates an event and queues it onto a
+ *  work-queue, where a worker thread can drive recovery.
+ */
+
+/* EEH event workqueue setup. */
+static DEFINE_SPINLOCK(eeh_eventlist_lock);
+LIST_HEAD(eeh_eventlist);
+static void eeh_thread_launcher(struct work_struct *);
+DECLARE_WORK(eeh_event_wq, eeh_thread_launcher);
+
+/* Serialize reset sequences for a given pci device */
+DEFINE_MUTEX(eeh_event_mutex);
+
+/**
+ * eeh_event_handler - Dispatch EEH events.
+ * @dummy - unused
+ *
+ * The detection of a frozen slot can occur inside an interrupt,
+ * where it can be hard to do anything about it.  The goal of this
+ * routine is to pull these detection events out of the context
+ * of the interrupt handler, and re-dispatch them for processing
+ * at a later time in a normal context.
+ */
+static int eeh_event_handler(void * dummy)
+{
+	unsigned long flags;
+	struct eeh_event *event;
+	struct eeh_pe *pe;
+
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	event = NULL;
+
+	/* Unqueue the event, get ready to process. */
+	if (!list_empty(&eeh_eventlist)) {
+		event = list_entry(eeh_eventlist.next, struct eeh_event, list);
+		list_del(&event->list);
+	}
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
+	if (event == NULL)
+		return 0;
+
+	/* Serialize processing of EEH events */
+	mutex_lock(&eeh_event_mutex);
+	pe = event->pe;
+	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
+	pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
+		pe->phb->global_number, pe->addr);
+
+	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
+	eeh_handle_event(pe);
+	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+
+	kfree(event);
+	mutex_unlock(&eeh_event_mutex);
+
+	/* If there are no new errors after an hour, clear the counter. */
+	if (pe && pe->freeze_count > 0) {
+		msleep_interruptible(3600*1000);
+		if (pe->freeze_count > 0)
+			pe->freeze_count--;
+
+	}
+
+	return 0;
+}
+
+/**
+ * eeh_thread_launcher - Start kernel thread to handle EEH events
+ * @dummy - unused
+ *
+ * This routine is called to start the kernel thread for processing
+ * EEH event.
+ */
+static void eeh_thread_launcher(struct work_struct *dummy)
+{
+	if (IS_ERR(kthread_run(eeh_event_handler, NULL, "eehd")))
+		printk(KERN_ERR "Failed to start EEH daemon\n");
+}
+
+/**
+ * eeh_send_failure_event - Generate a PCI error event
+ * @pe: EEH PE
+ *
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).
+ */
+int eeh_send_failure_event(struct eeh_pe *pe)
+{
+	unsigned long flags;
+	struct eeh_event *event;
+
+	event = kzalloc(sizeof(*event), GFP_ATOMIC);
+	if (!event) {
+		pr_err("EEH: out of memory, event not handled\n");
+		return -ENOMEM;
+	}
+	event->pe = pe;
+
+	/* We may or may not be called in an interrupt context */
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	list_add(&event->list, &eeh_eventlist);
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
+	schedule_work(&eeh_event_wq);
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
new file mode 100644
index 0000000..9d4a9e8
--- /dev/null
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -0,0 +1,653 @@
+/*
+ * The file intends to implement PE based on the information from
+ * platforms. Basically, there have 3 types of PEs: PHB/Bus/Device.
+ * All the PEs should be organized as hierarchy tree. The first level
+ * of the tree will be associated to existing PHBs since the particular
+ * PE is only meaningful in one PHB domain.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2012.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+static LIST_HEAD(eeh_phb_pe);
+
+/**
+ * eeh_pe_alloc - Allocate PE
+ * @phb: PCI controller
+ * @type: PE type
+ *
+ * Allocate PE instance dynamically.
+ */
+static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
+{
+	struct eeh_pe *pe;
+
+	/* Allocate PHB PE */
+	pe = kzalloc(sizeof(struct eeh_pe), GFP_KERNEL);
+	if (!pe) return NULL;
+
+	/* Initialize PHB PE */
+	pe->type = type;
+	pe->phb = phb;
+	INIT_LIST_HEAD(&pe->child_list);
+	INIT_LIST_HEAD(&pe->child);
+	INIT_LIST_HEAD(&pe->edevs);
+
+	return pe;
+}
+
+/**
+ * eeh_phb_pe_create - Create PHB PE
+ * @phb: PCI controller
+ *
+ * The function should be called while the PHB is detected during
+ * system boot or PCI hotplug in order to create PHB PE.
+ */
+int eeh_phb_pe_create(struct pci_controller *phb)
+{
+	struct eeh_pe *pe;
+
+	/* Allocate PHB PE */
+	pe = eeh_pe_alloc(phb, EEH_PE_PHB);
+	if (!pe) {
+		pr_err("%s: out of memory!\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* Put it into the list */
+	eeh_lock();
+	list_add_tail(&pe->child, &eeh_phb_pe);
+	eeh_unlock();
+
+	pr_debug("EEH: Add PE for PHB#%d\n", phb->global_number);
+
+	return 0;
+}
+
+/**
+ * eeh_phb_pe_get - Retrieve PHB PE based on the given PHB
+ * @phb: PCI controller
+ *
+ * The overall PEs form hierarchy tree. The first layer of the
+ * hierarchy tree is composed of PHB PEs. The function is used
+ * to retrieve the corresponding PHB PE according to the given PHB.
+ */
+static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
+{
+	struct eeh_pe *pe;
+
+	list_for_each_entry(pe, &eeh_phb_pe, child) {
+		/*
+		 * Actually, we needn't check the type since
+		 * the PE for PHB has been determined when that
+		 * was created.
+		 */
+		if ((pe->type & EEH_PE_PHB) && pe->phb == phb)
+			return pe;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_next - Retrieve the next PE in the tree
+ * @pe: current PE
+ * @root: root PE
+ *
+ * The function is used to retrieve the next PE in the
+ * hierarchy PE tree.
+ */
+static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
+				  struct eeh_pe *root)
+{
+	struct list_head *next = pe->child_list.next;
+
+	if (next == &pe->child_list) {
+		while (1) {
+			if (pe == root)
+				return NULL;
+			next = pe->child.next;
+			if (next != &pe->parent->child_list)
+				break;
+			pe = pe->parent;
+		}
+	}
+
+	return list_entry(next, struct eeh_pe, child);
+}
+
+/**
+ * eeh_pe_traverse - Traverse PEs in the specified PHB
+ * @root: root PE
+ * @fn: callback
+ * @flag: extra parameter to callback
+ *
+ * The function is used to traverse the specified PE and its
+ * child PEs. The traversing is to be terminated once the
+ * callback returns something other than NULL, or no more PEs
+ * to be traversed.
+ */
+static void *eeh_pe_traverse(struct eeh_pe *root,
+			eeh_traverse_func fn, void *flag)
+{
+	struct eeh_pe *pe;
+	void *ret;
+
+	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+		ret = fn(pe, flag);
+		if (ret) return ret;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_dev_traverse - Traverse the devices from the PE
+ * @root: EEH PE
+ * @fn: function callback
+ * @flag: extra parameter to callback
+ *
+ * The function is used to traverse the devices of the specified
+ * PE and its child PEs.
+ */
+void *eeh_pe_dev_traverse(struct eeh_pe *root,
+		eeh_traverse_func fn, void *flag)
+{
+	struct eeh_pe *pe;
+	struct eeh_dev *edev;
+	void *ret;
+
+	if (!root) {
+		pr_warning("%s: Invalid PE %p\n", __func__, root);
+		return NULL;
+	}
+
+	eeh_lock();
+
+	/* Traverse root PE */
+	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+		eeh_pe_for_each_dev(pe, edev) {
+			ret = fn(edev, flag);
+			if (ret) {
+				eeh_unlock();
+				return ret;
+			}
+		}
+	}
+
+	eeh_unlock();
+
+	return NULL;
+}
+
+/**
+ * __eeh_pe_get - Check the PE address
+ * @data: EEH PE
+ * @flag: EEH device
+ *
+ * For one particular PE, it can be identified by PE address
+ * or tranditional BDF address. BDF address is composed of
+ * Bus/Device/Function number. The extra data referred by flag
+ * indicates which type of address should be used.
+ */
+static void *__eeh_pe_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_dev *edev = (struct eeh_dev *)flag;
+
+	/* Unexpected PHB PE */
+	if (pe->type & EEH_PE_PHB)
+		return NULL;
+
+	/* We prefer PE address */
+	if (edev->pe_config_addr &&
+	   (edev->pe_config_addr == pe->addr))
+		return pe;
+
+	/* Try BDF address */
+	if (edev->pe_config_addr &&
+	   (edev->config_addr == pe->config_addr))
+		return pe;
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_get - Search PE based on the given address
+ * @edev: EEH device
+ *
+ * Search the corresponding PE based on the specified address which
+ * is included in the eeh device. The function is used to check if
+ * the associated PE has been created against the PE address. It's
+ * notable that the PE address has 2 format: traditional PE address
+ * which is composed of PCI bus/device/function number, or unified
+ * PE address.
+ */
+static struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
+{
+	struct eeh_pe *root = eeh_phb_pe_get(edev->phb);
+	struct eeh_pe *pe;
+
+	pe = eeh_pe_traverse(root, __eeh_pe_get, edev);
+
+	return pe;
+}
+
+/**
+ * eeh_pe_get_parent - Retrieve the parent PE
+ * @edev: EEH device
+ *
+ * The whole PEs existing in the system are organized as hierarchy
+ * tree. The function is used to retrieve the parent PE according
+ * to the parent EEH device.
+ */
+static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
+{
+	struct device_node *dn;
+	struct eeh_dev *parent;
+
+	/*
+	 * It might have the case for the indirect parent
+	 * EEH device already having associated PE, but
+	 * the direct parent EEH device doesn't have yet.
+	 */
+	dn = edev->dn->parent;
+	while (dn) {
+		/* We're poking out of PCI territory */
+		if (!PCI_DN(dn)) return NULL;
+
+		parent = of_node_to_eeh_dev(dn);
+		/* We're poking out of PCI territory */
+		if (!parent) return NULL;
+
+		if (parent->pe)
+			return parent->pe;
+
+		dn = dn->parent;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_add_to_parent_pe - Add EEH device to parent PE
+ * @edev: EEH device
+ *
+ * Add EEH device to the parent PE. If the parent PE already
+ * exists, the PE type will be changed to EEH_PE_BUS. Otherwise,
+ * we have to create new PE to hold the EEH device and the new
+ * PE will be linked to its parent PE as well.
+ */
+int eeh_add_to_parent_pe(struct eeh_dev *edev)
+{
+	struct eeh_pe *pe, *parent;
+
+	eeh_lock();
+
+	/*
+	 * Search the PE has been existing or not according
+	 * to the PE address. If that has been existing, the
+	 * PE should be composed of PCI bus and its subordinate
+	 * components.
+	 */
+	pe = eeh_pe_get(edev);
+	if (pe && !(pe->type & EEH_PE_INVALID)) {
+		if (!edev->pe_config_addr) {
+			eeh_unlock();
+			pr_err("%s: PE with addr 0x%x already exists\n",
+				__func__, edev->config_addr);
+			return -EEXIST;
+		}
+
+		/* Mark the PE as type of PCI bus */
+		pe->type = EEH_PE_BUS;
+		edev->pe = pe;
+
+		/* Put the edev to PE */
+		list_add_tail(&edev->list, &pe->edevs);
+		eeh_unlock();
+		pr_debug("EEH: Add %s to Bus PE#%x\n",
+			edev->dn->full_name, pe->addr);
+
+		return 0;
+	} else if (pe && (pe->type & EEH_PE_INVALID)) {
+		list_add_tail(&edev->list, &pe->edevs);
+		edev->pe = pe;
+		/*
+		 * We're running to here because of PCI hotplug caused by
+		 * EEH recovery. We need clear EEH_PE_INVALID until the top.
+		 */
+		parent = pe;
+		while (parent) {
+			if (!(parent->type & EEH_PE_INVALID))
+				break;
+			parent->type &= ~EEH_PE_INVALID;
+			parent = parent->parent;
+		}
+		eeh_unlock();
+		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
+			edev->dn->full_name, pe->addr, pe->parent->addr);
+
+		return 0;
+	}
+
+	/* Create a new EEH PE */
+	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+	if (!pe) {
+		eeh_unlock();
+		pr_err("%s: out of memory!\n", __func__);
+		return -ENOMEM;
+	}
+	pe->addr	= edev->pe_config_addr;
+	pe->config_addr	= edev->config_addr;
+
+	/*
+	 * Put the new EEH PE into hierarchy tree. If the parent
+	 * can't be found, the newly created PE will be attached
+	 * to PHB directly. Otherwise, we have to associate the
+	 * PE with its parent.
+	 */
+	parent = eeh_pe_get_parent(edev);
+	if (!parent) {
+		parent = eeh_phb_pe_get(edev->phb);
+		if (!parent) {
+			eeh_unlock();
+			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
+				__func__, edev->phb->global_number);
+			edev->pe = NULL;
+			kfree(pe);
+			return -EEXIST;
+		}
+	}
+	pe->parent = parent;
+
+	/*
+	 * Put the newly created PE into the child list and
+	 * link the EEH device accordingly.
+	 */
+	list_add_tail(&pe->child, &parent->child_list);
+	list_add_tail(&edev->list, &pe->edevs);
+	edev->pe = pe;
+	eeh_unlock();
+	pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
+		edev->dn->full_name, pe->addr, pe->parent->addr);
+
+	return 0;
+}
+
+/**
+ * eeh_rmv_from_parent_pe - Remove one EEH device from the associated PE
+ * @edev: EEH device
+ * @purge_pe: remove PE or not
+ *
+ * The PE hierarchy tree might be changed when doing PCI hotplug.
+ * Also, the PCI devices or buses could be removed from the system
+ * during EEH recovery. So we have to call the function remove the
+ * corresponding PE accordingly if necessary.
+ */
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
+{
+	struct eeh_pe *pe, *parent, *child;
+	int cnt;
+
+	if (!edev->pe) {
+		pr_warning("%s: No PE found for EEH device %s\n",
+			__func__, edev->dn->full_name);
+		return -EEXIST;
+	}
+
+	eeh_lock();
+
+	/* Remove the EEH device */
+	pe = edev->pe;
+	edev->pe = NULL;
+	list_del(&edev->list);
+
+	/*
+	 * Check if the parent PE includes any EEH devices.
+	 * If not, we should delete that. Also, we should
+	 * delete the parent PE if it doesn't have associated
+	 * child PEs and EEH devices.
+	 */
+	while (1) {
+		parent = pe->parent;
+		if (pe->type & EEH_PE_PHB)
+			break;
+
+		if (purge_pe) {
+			if (list_empty(&pe->edevs) &&
+			    list_empty(&pe->child_list)) {
+				list_del(&pe->child);
+				kfree(pe);
+			} else {
+				break;
+			}
+		} else {
+			if (list_empty(&pe->edevs)) {
+				cnt = 0;
+				list_for_each_entry(child, &pe->child_list, child) {
+					if (!(child->type & EEH_PE_INVALID)) {
+						cnt++;
+						break;
+					}
+				}
+
+				if (!cnt)
+					pe->type |= EEH_PE_INVALID;
+				else
+					break;
+			}
+		}
+
+		pe = parent;
+	}
+
+	eeh_unlock();
+
+	return 0;
+}
+
+/**
+ * __eeh_pe_state_mark - Mark the state for the PE
+ * @data: EEH PE
+ * @flag: state
+ *
+ * The function is used to mark the indicated state for the given
+ * PE. Also, the associated PCI devices will be put into IO frozen
+ * state as well.
+ */
+static void *__eeh_pe_state_mark(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	int state = *((int *)flag);
+	struct eeh_dev *tmp;
+	struct pci_dev *pdev;
+
+	/*
+	 * Mark the PE with the indicated state. Also,
+	 * the associated PCI device will be put into
+	 * I/O frozen state to avoid I/O accesses from
+	 * the PCI device driver.
+	 */
+	pe->state |= state;
+	eeh_pe_for_each_dev(pe, tmp) {
+		pdev = eeh_dev_to_pci_dev(tmp);
+		if (pdev)
+			pdev->error_state = pci_channel_io_frozen;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_state_mark - Mark specified state for PE and its associated device
+ * @pe: EEH PE
+ *
+ * EEH error affects the current PE and its child PEs. The function
+ * is used to mark appropriate state for the affected PEs and the
+ * associated devices.
+ */
+void eeh_pe_state_mark(struct eeh_pe *pe, int state)
+{
+	eeh_lock();
+	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
+	eeh_unlock();
+}
+
+/**
+ * __eeh_pe_state_clear - Clear state for the PE
+ * @data: EEH PE
+ * @flag: state
+ *
+ * The function is used to clear the indicated state from the
+ * given PE. Besides, we also clear the check count of the PE
+ * as well.
+ */
+static void *__eeh_pe_state_clear(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	int state = *((int *)flag);
+
+	pe->state &= ~state;
+	pe->check_count = 0;
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_state_clear - Clear state for the PE and its children
+ * @pe: PE
+ * @state: state to be cleared
+ *
+ * When the PE and its children has been recovered from error,
+ * we need clear the error state for that. The function is used
+ * for the purpose.
+ */
+void eeh_pe_state_clear(struct eeh_pe *pe, int state)
+{
+	eeh_lock();
+	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
+	eeh_unlock();
+}
+
+/**
+ * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
+ * @data: EEH device
+ * @flag: Unused
+ *
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static void *eeh_restore_one_device_bars(void *data, void *flag)
+{
+	int i;
+	u32 cmd;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct device_node *dn = eeh_dev_to_of_node(edev);
+
+	for (i = 4; i < 10; i++)
+		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
+	/* 12 == Expansion ROM Address */
+	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
+
+#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
+#define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
+
+	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
+		SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
+		SAVED_BYTE(PCI_LATENCY_TIMER));
+
+	/* max latency, min grant, interrupt pin and line */
+	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
+
+	/*
+	 * Restore PERR & SERR bits, some devices require it,
+	 * don't touch the other command bits
+	 */
+	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
+	if (edev->config_space[1] & PCI_COMMAND_PARITY)
+		cmd |= PCI_COMMAND_PARITY;
+	else
+		cmd &= ~PCI_COMMAND_PARITY;
+	if (edev->config_space[1] & PCI_COMMAND_SERR)
+		cmd |= PCI_COMMAND_SERR;
+	else
+		cmd &= ~PCI_COMMAND_SERR;
+	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_restore_bars - Restore the PCI config space info
+ * @pe: EEH PE
+ *
+ * This routine performs a recursive walk to the children
+ * of this device as well.
+ */
+void eeh_pe_restore_bars(struct eeh_pe *pe)
+{
+	/*
+	 * We needn't take the EEH lock since eeh_pe_dev_traverse()
+	 * will take that.
+	 */
+	eeh_pe_dev_traverse(pe, eeh_restore_one_device_bars, NULL);
+}
+
+/**
+ * eeh_pe_bus_get - Retrieve PCI bus according to the given PE
+ * @pe: EEH PE
+ *
+ * Retrieve the PCI bus according to the given PE. Basically,
+ * there're 3 types of PEs: PHB/Bus/Device. For PHB PE, the
+ * primary PCI bus will be retrieved. The parent bus will be
+ * returned for BUS PE. However, we don't have associated PCI
+ * bus for DEVICE PE.
+ */
+struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
+{
+	struct pci_bus *bus = NULL;
+	struct eeh_dev *edev;
+	struct pci_dev *pdev;
+
+	eeh_lock();
+
+	if (pe->type & EEH_PE_PHB) {
+		bus = pe->phb->bus;
+	} else if (pe->type & EEH_PE_BUS ||
+		   pe->type & EEH_PE_DEVICE) {
+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (pdev)
+			bus = pdev->bus;
+	}
+
+	eeh_unlock();
+
+	return bus;
+}
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
new file mode 100644
index 0000000..e7ae348
--- /dev/null
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -0,0 +1,74 @@
+/*
+ * Sysfs entries for PCI Error Recovery for PAPR-compliant platform.
+ * Copyright IBM Corporation 2007
+ * Copyright Linas Vepstas <linas@austin.ibm.com> 2007
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
+ */
+#include <linux/pci.h>
+#include <linux/stat.h>
+#include <asm/ppc-pci.h>
+#include <asm/pci-bridge.h>
+
+/**
+ * EEH_SHOW_ATTR -- Create sysfs entry for eeh statistic
+ * @_name: name of file in sysfs directory
+ * @_memb: name of member in struct pci_dn to access
+ * @_format: printf format for display
+ *
+ * All of the attributes look very similar, so just
+ * auto-gen a cut-n-paste routine to display them.
+ */
+#define EEH_SHOW_ATTR(_name,_memb,_format)               \
+static ssize_t eeh_show_##_name(struct device *dev,      \
+		struct device_attribute *attr, char *buf)          \
+{                                                        \
+	struct pci_dev *pdev = to_pci_dev(dev);               \
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);      \
+	                                                      \
+	if (!edev)                                            \
+		return 0;                                     \
+	                                                      \
+	return sprintf(buf, _format "\n", edev->_memb);       \
+}                                                        \
+static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
+
+EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
+EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
+EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
+
+void eeh_sysfs_add_device(struct pci_dev *pdev)
+{
+	int rc=0;
+
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+
+	if (rc)
+		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");
+}
+
+void eeh_sysfs_remove_device(struct pci_dev *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+}
diff --git a/arch/powerpc/kernel/pci_hotplug.c b/arch/powerpc/kernel/pci_hotplug.c
new file mode 100644
index 0000000..3f60880
--- /dev/null
+++ b/arch/powerpc/kernel/pci_hotplug.c
@@ -0,0 +1,111 @@
+/*
+ * Derived from "arch/powerpc/platforms/pseries/pci_dlpar.c"
+ *
+ * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
+ * Copyright (C) 2005 International Business Machines
+ *
+ * Updates, 2005, John Rose <johnrose@austin.ibm.com>
+ * Updates, 2005, Linas Vepstas <linas@austin.ibm.com>
+ * Updates, 2013, Gavin Shan <shangw@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <linux/export.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+#include <asm/firmware.h>
+#include <asm/eeh.h>
+
+/**
+ * __pcibios_remove_pci_devices - remove all devices under this bus
+ * @bus: the indicated PCI bus
+ * @purge_pe: destroy the PE on removal of PCI devices
+ *
+ * Remove all of the PCI devices under this bus both from the
+ * linux pci device tree, and from the powerpc EEH address cache.
+ * By default, the corresponding PE will be destroied during the
+ * normal PCI hotplug path. For PCI hotplug during EEH recovery,
+ * the corresponding PE won't be destroied and deallocated.
+ */
+void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe)
+{
+	struct pci_dev *dev, *tmp;
+	struct pci_bus *child_bus;
+
+	/* First go down child busses */
+	list_for_each_entry(child_bus, &bus->children, node)
+		__pcibios_remove_pci_devices(child_bus, purge_pe);
+
+	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
+		 pci_domain_nr(bus),  bus->number);
+	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+		pr_debug("     * Removing %s...\n", pci_name(dev));
+		eeh_remove_bus_device(dev, purge_pe);
+		pci_stop_and_remove_bus_device(dev);
+	}
+}
+
+/**
+ * pcibios_remove_pci_devices - remove all devices under this bus
+ * @bus: the indicated PCI bus
+ *
+ * Remove all of the PCI devices under this bus both from the
+ * linux pci device tree, and from the powerpc EEH address cache.
+ */
+void pcibios_remove_pci_devices(struct pci_bus *bus)
+{
+	__pcibios_remove_pci_devices(bus, 1);
+}
+EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
+
+/**
+ * pcibios_add_pci_devices - adds new pci devices to bus
+ * @bus: the indicated PCI bus
+ *
+ * This routine will find and fixup new pci devices under
+ * the indicated bus. This routine presumes that there
+ * might already be some devices under this bridge, so
+ * it carefully tries to add only new devices.  (And that
+ * is how this routine differs from other, similar pcibios
+ * routines.)
+ */
+void pcibios_add_pci_devices(struct pci_bus * bus)
+{
+	int slotno, num, mode, pass, max;
+	struct pci_dev *dev;
+	struct device_node *dn = pci_bus_to_OF_node(bus);
+
+	eeh_add_device_tree_early(dn);
+
+	mode = PCI_PROBE_NORMAL;
+	if (ppc_md.pci_probe_mode)
+		mode = ppc_md.pci_probe_mode(bus);
+
+	if (mode == PCI_PROBE_DEVTREE) {
+		/* use ofdt-based probe */
+		of_rescan_bus(dn, bus);
+	} else if (mode == PCI_PROBE_NORMAL) {
+		/* use legacy probe */
+		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
+		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
+		if (!num)
+			return;
+		pcibios_setup_bus_devices(bus);
+		max = bus->busn_res.start;
+		for (pass = 0; pass < 2; pass++) {
+			list_for_each_entry(dev, &bus->devices, bus_list) {
+				if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+				    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+					max = pci_scan_bridge(bus, dev,
+							      max, pass);
+			}
+		}
+	}
+	pcibios_finish_adding_to_bus(bus);
+}
+EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b62aab3..bed8c60 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -164,6 +164,11 @@ config IBMEBUS
 	help
 	  Bus device driver for GX bus based adapters.
 
+config EEH
+	bool
+	depends on (PPC_POWERNV || PPC_PSERIES) && PCI
+	default y
+
 config PPC_MPC106
 	bool
 	default n
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 4459eff..1bd3399 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -33,11 +33,6 @@ config PPC_SPLPAR
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
-config EEH
-	bool
-	depends on PPC_PSERIES && PCI
-	default y
-
 config PSERIES_MSI
        bool
        depends on PCI_MSI && EEH
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 53866e5..8ae0103 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -6,9 +6,7 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   firmware.o power.o dlpar.o mobility.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_EEH)	+= eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
-			   eeh_driver.o eeh_event.o eeh_sysfs.o \
-			   eeh_pseries.o
+obj-$(CONFIG_EEH)	+= eeh_pseries.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PSERIES_MSI)	+= msi.o
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
deleted file mode 100644
index 8a83451..0000000
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ /dev/null
@@ -1,942 +0,0 @@
-/*
- * Copyright IBM Corporation 2001, 2005, 2006
- * Copyright Dave Engebretsen & Todd Inglett 2001
- * Copyright Linas Vepstas 2005, 2006
- * Copyright 2001-2012 IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- * Please address comments and feedback to Linas Vepstas <linas@austin.ibm.com>
- */
-
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/pci.h>
-#include <linux/proc_fs.h>
-#include <linux/rbtree.h>
-#include <linux/seq_file.h>
-#include <linux/spinlock.h>
-#include <linux/export.h>
-#include <linux/of.h>
-
-#include <linux/atomic.h>
-#include <asm/eeh.h>
-#include <asm/eeh_event.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/ppc-pci.h>
-#include <asm/rtas.h>
-
-
-/** Overview:
- *  EEH, or "Extended Error Handling" is a PCI bridge technology for
- *  dealing with PCI bus errors that can't be dealt with within the
- *  usual PCI framework, except by check-stopping the CPU.  Systems
- *  that are designed for high-availability/reliability cannot afford
- *  to crash due to a "mere" PCI error, thus the need for EEH.
- *  An EEH-capable bridge operates by converting a detected error
- *  into a "slot freeze", taking the PCI adapter off-line, making
- *  the slot behave, from the OS'es point of view, as if the slot
- *  were "empty": all reads return 0xff's and all writes are silently
- *  ignored.  EEH slot isolation events can be triggered by parity
- *  errors on the address or data busses (e.g. during posted writes),
- *  which in turn might be caused by low voltage on the bus, dust,
- *  vibration, humidity, radioactivity or plain-old failed hardware.
- *
- *  Note, however, that one of the leading causes of EEH slot
- *  freeze events are buggy device drivers, buggy device microcode,
- *  or buggy device hardware.  This is because any attempt by the
- *  device to bus-master data to a memory address that is not
- *  assigned to the device will trigger a slot freeze.   (The idea
- *  is to prevent devices-gone-wild from corrupting system memory).
- *  Buggy hardware/drivers will have a miserable time co-existing
- *  with EEH.
- *
- *  Ideally, a PCI device driver, when suspecting that an isolation
- *  event has occurred (e.g. by reading 0xff's), will then ask EEH
- *  whether this is the case, and then take appropriate steps to
- *  reset the PCI slot, the PCI device, and then resume operations.
- *  However, until that day,  the checking is done here, with the
- *  eeh_check_failure() routine embedded in the MMIO macros.  If
- *  the slot is found to be isolated, an "EEH Event" is synthesized
- *  and sent out for processing.
- */
-
-/* If a device driver keeps reading an MMIO register in an interrupt
- * handler after a slot isolation event, it might be broken.
- * This sets the threshold for how many read attempts we allow
- * before printing an error message.
- */
-#define EEH_MAX_FAILS	2100000
-
-/* Time to wait for a PCI slot to report status, in milliseconds */
-#define PCI_BUS_RESET_WAIT_MSEC (60*1000)
-
-/* Platform dependent EEH operations */
-struct eeh_ops *eeh_ops = NULL;
-
-int eeh_subsystem_enabled;
-EXPORT_SYMBOL(eeh_subsystem_enabled);
-
-/*
- * EEH probe mode support. The intention is to support multiple
- * platforms for EEH. Some platforms like pSeries do PCI emunation
- * based on device tree. However, other platforms like powernv probe
- * PCI devices from hardware. The flag is used to distinguish that.
- * In addition, struct eeh_ops::probe would be invoked for particular
- * OF node or PCI device so that the corresponding PE would be created
- * there.
- */
-int eeh_probe_mode;
-
-/* Global EEH mutex */
-DEFINE_MUTEX(eeh_mutex);
-
-/* Lock to avoid races due to multiple reports of an error */
-static DEFINE_RAW_SPINLOCK(confirm_error_lock);
-
-/* Buffer for reporting pci register dumps. Its here in BSS, and
- * not dynamically alloced, so that it ends up in RMO where RTAS
- * can access it.
- */
-#define EEH_PCI_REGS_LOG_LEN 4096
-static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
-
-/*
- * The struct is used to maintain the EEH global statistic
- * information. Besides, the EEH global statistics will be
- * exported to user space through procfs
- */
-struct eeh_stats {
-	u64 no_device;		/* PCI device not found		*/
-	u64 no_dn;		/* OF node not found		*/
-	u64 no_cfg_addr;	/* Config address not found	*/
-	u64 ignored_check;	/* EEH check skipped		*/
-	u64 total_mmio_ffs;	/* Total EEH checks		*/
-	u64 false_positives;	/* Unnecessary EEH checks	*/
-	u64 slot_resets;	/* PE reset			*/
-};
-
-static struct eeh_stats eeh_stats;
-
-#define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
-
-/**
- * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
- * @edev: device to report data for
- * @buf: point to buffer in which to log
- * @len: amount of room in buffer
- *
- * This routine captures assorted PCI configuration space data,
- * and puts them into a buffer for RTAS error logging.
- */
-static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
-{
-	struct device_node *dn = eeh_dev_to_of_node(edev);
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	u32 cfg;
-	int cap, i;
-	int n = 0;
-
-	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
-	printk(KERN_WARNING "EEH: of node=%s\n", dn->full_name);
-
-	eeh_ops->read_config(dn, PCI_VENDOR_ID, 4, &cfg);
-	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
-	printk(KERN_WARNING "EEH: PCI device/vendor: %08x\n", cfg);
-
-	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cfg);
-	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
-	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
-
-	if (!dev) {
-		printk(KERN_WARNING "EEH: no PCI device for this of node\n");
-		return n;
-	}
-
-	/* Gather bridge-specific registers */
-	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
-		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
-		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
-
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &cfg);
-		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
-		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
-	}
-
-	/* Dump out the PCI-X command and status regs */
-	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (cap) {
-		eeh_ops->read_config(dn, cap, 4, &cfg);
-		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
-		printk(KERN_WARNING "EEH: PCI-X cmd: %08x\n", cfg);
-
-		eeh_ops->read_config(dn, cap+4, 4, &cfg);
-		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
-		printk(KERN_WARNING "EEH: PCI-X status: %08x\n", cfg);
-	}
-
-	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
-	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (cap) {
-		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
-		printk(KERN_WARNING
-		       "EEH: PCI-E capabilities and status follow:\n");
-
-		for (i=0; i<=8; i++) {
-			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
-			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
-		}
-
-		cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-		if (cap) {
-			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
-			printk(KERN_WARNING
-			       "EEH: PCI-E AER capability register set follows:\n");
-
-			for (i=0; i<14; i++) {
-				eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
-				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-				printk(KERN_WARNING "EEH: PCI-E AER %02x: %08x\n", i, cfg);
-			}
-		}
-	}
-
-	return n;
-}
-
-/**
- * eeh_slot_error_detail - Generate combined log including driver log and error log
- * @pe: EEH PE
- * @severity: temporary or permanent error log
- *
- * This routine should be called to generate the combined log, which
- * is comprised of driver log and error log. The driver log is figured
- * out from the config space of the corresponding PCI device, while
- * the error log is fetched through platform dependent function call.
- */
-void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
-{
-	size_t loglen = 0;
-	struct eeh_dev *edev;
-
-	eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
-	eeh_ops->configure_bridge(pe);
-	eeh_pe_restore_bars(pe);
-
-	pci_regs_buf[0] = 0;
-	eeh_pe_for_each_dev(pe, edev) {
-		loglen += eeh_gather_pci_data(edev, pci_regs_buf,
-				EEH_PCI_REGS_LOG_LEN);
-        }
-
-	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
-}
-
-/**
- * eeh_token_to_phys - Convert EEH address token to phys address
- * @token: I/O token, should be address in the form 0xA....
- *
- * This routine should be called to convert virtual I/O address
- * to physical one.
- */
-static inline unsigned long eeh_token_to_phys(unsigned long token)
-{
-	pte_t *ptep;
-	unsigned long pa;
-
-	ptep = find_linux_pte(init_mm.pgd, token);
-	if (!ptep)
-		return token;
-	pa = pte_pfn(*ptep) << PAGE_SHIFT;
-
-	return pa | (token & (PAGE_SIZE-1));
-}
-
-/**
- * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
- * @edev: eeh device
- *
- * Check for an EEH failure for the given device node.  Call this
- * routine if the result of a read was all 0xff's and you want to
- * find out if this is due to an EEH slot freeze.  This routine
- * will query firmware for the EEH status.
- *
- * Returns 0 if there has not been an EEH error; otherwise returns
- * a non-zero value and queues up a slot isolation event notification.
- *
- * It is safe to call this routine in an interrupt context.
- */
-int eeh_dev_check_failure(struct eeh_dev *edev)
-{
-	int ret;
-	unsigned long flags;
-	struct device_node *dn;
-	struct pci_dev *dev;
-	struct eeh_pe *pe;
-	int rc = 0;
-	const char *location;
-
-	eeh_stats.total_mmio_ffs++;
-
-	if (!eeh_subsystem_enabled)
-		return 0;
-
-	if (!edev) {
-		eeh_stats.no_dn++;
-		return 0;
-	}
-	dn = eeh_dev_to_of_node(edev);
-	dev = eeh_dev_to_pci_dev(edev);
-	pe = edev->pe;
-
-	/* Access to IO BARs might get this far and still not want checking. */
-	if (!pe) {
-		eeh_stats.ignored_check++;
-		pr_debug("EEH: Ignored check for %s %s\n",
-			eeh_pci_name(dev), dn->full_name);
-		return 0;
-	}
-
-	if (!pe->addr && !pe->config_addr) {
-		eeh_stats.no_cfg_addr++;
-		return 0;
-	}
-
-	/* If we already have a pending isolation event for this
-	 * slot, we know it's bad already, we don't need to check.
-	 * Do this checking under a lock; as multiple PCI devices
-	 * in one slot might report errors simultaneously, and we
-	 * only want one error recovery routine running.
-	 */
-	raw_spin_lock_irqsave(&confirm_error_lock, flags);
-	rc = 1;
-	if (pe->state & EEH_PE_ISOLATED) {
-		pe->check_count++;
-		if (pe->check_count % EEH_MAX_FAILS == 0) {
-			location = of_get_property(dn, "ibm,loc-code", NULL);
-			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
-				"location=%s driver=%s pci addr=%s\n",
-				pe->check_count, location,
-				eeh_driver_name(dev), eeh_pci_name(dev));
-			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
-				eeh_driver_name(dev));
-			dump_stack();
-		}
-		goto dn_unlock;
-	}
-
-	/*
-	 * Now test for an EEH failure.  This is VERY expensive.
-	 * Note that the eeh_config_addr may be a parent device
-	 * in the case of a device behind a bridge, or it may be
-	 * function zero of a multi-function device.
-	 * In any case they must share a common PHB.
-	 */
-	ret = eeh_ops->get_state(pe, NULL);
-
-	/* Note that config-io to empty slots may fail;
-	 * they are empty when they don't have children.
-	 * We will punt with the following conditions: Failure to get
-	 * PE's state, EEH not support and Permanently unavailable
-	 * state, PE is in good state.
-	 */
-	if ((ret < 0) ||
-	    (ret == EEH_STATE_NOT_SUPPORT) ||
-	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
-	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
-		eeh_stats.false_positives++;
-		pe->false_positives++;
-		rc = 0;
-		goto dn_unlock;
-	}
-
-	eeh_stats.slot_resets++;
-
-	/* Avoid repeated reports of this failure, including problems
-	 * with other functions on this device, and functions under
-	 * bridges.
-	 */
-	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
-
-	eeh_send_failure_event(pe);
-
-	/* Most EEH events are due to device driver bugs.  Having
-	 * a stack trace will help the device-driver authors figure
-	 * out what happened.  So print that out.
-	 */
-	WARN(1, "EEH: failure detected\n");
-	return 1;
-
-dn_unlock:
-	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
-	return rc;
-}
-
-EXPORT_SYMBOL_GPL(eeh_dev_check_failure);
-
-/**
- * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
- * @token: I/O token, should be address in the form 0xA....
- * @val: value, should be all 1's (XXX why do we need this arg??)
- *
- * Check for an EEH failure at the given token address.  Call this
- * routine if the result of a read was all 0xff's and you want to
- * find out if this is due to an EEH slot freeze event.  This routine
- * will query firmware for the EEH status.
- *
- * Note this routine is safe to call in an interrupt context.
- */
-unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
-{
-	unsigned long addr;
-	struct eeh_dev *edev;
-
-	/* Finding the phys addr + pci device; this is pretty quick. */
-	addr = eeh_token_to_phys((unsigned long __force) token);
-	edev = eeh_addr_cache_get_dev(addr);
-	if (!edev) {
-		eeh_stats.no_device++;
-		return val;
-	}
-
-	eeh_dev_check_failure(edev);
-
-	pci_dev_put(eeh_dev_to_pci_dev(edev));
-	return val;
-}
-
-EXPORT_SYMBOL(eeh_check_failure);
-
-
-/**
- * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
- * @pe: EEH PE
- *
- * This routine should be called to reenable frozen MMIO or DMA
- * so that it would work correctly again. It's useful while doing
- * recovery or log collection on the indicated device.
- */
-int eeh_pci_enable(struct eeh_pe *pe, int function)
-{
-	int rc;
-
-	rc = eeh_ops->set_option(pe, function);
-	if (rc)
-		pr_warning("%s: Unexpected state change %d on PHB#%d-PE#%x, err=%d\n",
-			__func__, function, pe->phb->global_number, pe->addr, rc);
-
-	rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
-	   (function == EEH_OPT_THAW_MMIO))
-		return 0;
-
-	return rc;
-}
-
-/**
- * pcibios_set_pcie_slot_reset - Set PCI-E reset state
- * @dev: pci device struct
- * @state: reset state to enter
- *
- * Return value:
- * 	0 if success
- */
-int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
-{
-	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
-	struct eeh_pe *pe = edev->pe;
-
-	if (!pe) {
-		pr_err("%s: No PE found on PCI device %s\n",
-			__func__, pci_name(dev));
-		return -EINVAL;
-	}
-
-	switch (state) {
-	case pcie_deassert_reset:
-		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
-		break;
-	case pcie_hot_reset:
-		eeh_ops->reset(pe, EEH_RESET_HOT);
-		break;
-	case pcie_warm_reset:
-		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
-		break;
-	default:
-		return -EINVAL;
-	};
-
-	return 0;
-}
-
-/**
- * eeh_set_pe_freset - Check the required reset for the indicated device
- * @data: EEH device
- * @flag: return value
- *
- * Each device might have its preferred reset type: fundamental or
- * hot reset. The routine is used to collected the information for
- * the indicated device and its children so that the bunch of the
- * devices could be reset properly.
- */
-static void *eeh_set_dev_freset(void *data, void *flag)
-{
-	struct pci_dev *dev;
-	unsigned int *freset = (unsigned int *)flag;
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-
-	dev = eeh_dev_to_pci_dev(edev);
-	if (dev)
-		*freset |= dev->needs_freset;
-
-	return NULL;
-}
-
-/**
- * eeh_reset_pe_once - Assert the pci #RST line for 1/4 second
- * @pe: EEH PE
- *
- * Assert the PCI #RST line for 1/4 second.
- */
-static void eeh_reset_pe_once(struct eeh_pe *pe)
-{
-	unsigned int freset = 0;
-
-	/* Determine type of EEH reset required for
-	 * Partitionable Endpoint, a hot-reset (1)
-	 * or a fundamental reset (3).
-	 * A fundamental reset required by any device under
-	 * Partitionable Endpoint trumps hot-reset.
-	 */
-	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
-
-	if (freset)
-		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
-	else
-		eeh_ops->reset(pe, EEH_RESET_HOT);
-
-	/* The PCI bus requires that the reset be held high for at least
-	 * a 100 milliseconds. We wait a bit longer 'just in case'.
-	 */
-#define PCI_BUS_RST_HOLD_TIME_MSEC 250
-	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
-
-	/* We might get hit with another EEH freeze as soon as the
-	 * pci slot reset line is dropped. Make sure we don't miss
-	 * these, and clear the flag now.
-	 */
-	eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
-
-	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
-
-	/* After a PCI slot has been reset, the PCI Express spec requires
-	 * a 1.5 second idle time for the bus to stabilize, before starting
-	 * up traffic.
-	 */
-#define PCI_BUS_SETTLE_TIME_MSEC 1800
-	msleep(PCI_BUS_SETTLE_TIME_MSEC);
-}
-
-/**
- * eeh_reset_pe - Reset the indicated PE
- * @pe: EEH PE
- *
- * This routine should be called to reset indicated device, including
- * PE. A PE might include multiple PCI devices and sometimes PCI bridges
- * might be involved as well.
- */
-int eeh_reset_pe(struct eeh_pe *pe)
-{
-	int i, rc;
-
-	/* Take three shots at resetting the bus */
-	for (i=0; i<3; i++) {
-		eeh_reset_pe_once(pe);
-
-		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
-			return 0;
-
-		if (rc < 0) {
-			pr_err("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
-				__func__, pe->phb->global_number, pe->addr);
-			return -1;
-		}
-		pr_err("EEH: bus reset %d failed on PHB#%d-PE#%x, rc=%d\n",
-			i+1, pe->phb->global_number, pe->addr, rc);
-	}
-
-	return -1;
-}
-
-/**
- * eeh_save_bars - Save device bars
- * @edev: PCI device associated EEH device
- *
- * Save the values of the device bars. Unlike the restore
- * routine, this routine is *not* recursive. This is because
- * PCI devices are added individually; but, for the restore,
- * an entire slot is reset at a time.
- */
-void eeh_save_bars(struct eeh_dev *edev)
-{
-	int i;
-	struct device_node *dn;
-
-	if (!edev)
-		return;
-	dn = eeh_dev_to_of_node(edev);
-
-	for (i = 0; i < 16; i++)
-		eeh_ops->read_config(dn, i * 4, 4, &edev->config_space[i]);
-}
-
-/**
- * eeh_ops_register - Register platform dependent EEH operations
- * @ops: platform dependent EEH operations
- *
- * Register the platform dependent EEH operation callback
- * functions. The platform should call this function before
- * any other EEH operations.
- */
-int __init eeh_ops_register(struct eeh_ops *ops)
-{
-	if (!ops->name) {
-		pr_warning("%s: Invalid EEH ops name for %p\n",
-			__func__, ops);
-		return -EINVAL;
-	}
-
-	if (eeh_ops && eeh_ops != ops) {
-		pr_warning("%s: EEH ops of platform %s already existing (%s)\n",
-			__func__, eeh_ops->name, ops->name);
-		return -EEXIST;
-	}
-
-	eeh_ops = ops;
-
-	return 0;
-}
-
-/**
- * eeh_ops_unregister - Unreigster platform dependent EEH operations
- * @name: name of EEH platform operations
- *
- * Unregister the platform dependent EEH operation callback
- * functions.
- */
-int __exit eeh_ops_unregister(const char *name)
-{
-	if (!name || !strlen(name)) {
-		pr_warning("%s: Invalid EEH ops name\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	if (eeh_ops && !strcmp(eeh_ops->name, name)) {
-		eeh_ops = NULL;
-		return 0;
-	}
-
-	return -EEXIST;
-}
-
-/**
- * eeh_init - EEH initialization
- *
- * Initialize EEH by trying to enable it for all of the adapters in the system.
- * As a side effect we can determine here if eeh is supported at all.
- * Note that we leave EEH on so failed config cycles won't cause a machine
- * check.  If a user turns off EEH for a particular adapter they are really
- * telling Linux to ignore errors.  Some hardware (e.g. POWER5) won't
- * grant access to a slot if EEH isn't enabled, and so we always enable
- * EEH for all slots/all devices.
- *
- * The eeh-force-off option disables EEH checking globally, for all slots.
- * Even if force-off is set, the EEH hardware is still enabled, so that
- * newer systems can boot.
- */
-static int __init eeh_init(void)
-{
-	struct pci_controller *hose, *tmp;
-	struct device_node *phb;
-	int ret;
-
-	/* call platform initialization function */
-	if (!eeh_ops) {
-		pr_warning("%s: Platform EEH operation not found\n",
-			__func__);
-		return -EEXIST;
-	} else if ((ret = eeh_ops->init())) {
-		pr_warning("%s: Failed to call platform init function (%d)\n",
-			__func__, ret);
-		return ret;
-	}
-
-	raw_spin_lock_init(&confirm_error_lock);
-
-	/* Enable EEH for all adapters */
-	if (eeh_probe_mode_devtree()) {
-		list_for_each_entry_safe(hose, tmp,
-			&hose_list, list_node) {
-			phb = hose->dn;
-			traverse_pci_devices(phb, eeh_ops->of_probe, NULL);
-		}
-	}
-
-	if (eeh_subsystem_enabled)
-		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
-	else
-		pr_warning("EEH: No capable adapters found\n");
-
-	return ret;
-}
-
-core_initcall_sync(eeh_init);
-
-/**
- * eeh_add_device_early - Enable EEH for the indicated device_node
- * @dn: device node for which to set up EEH
- *
- * This routine must be used to perform EEH initialization for PCI
- * devices that were added after system boot (e.g. hotplug, dlpar).
- * This routine must be called before any i/o is performed to the
- * adapter (inluding any config-space i/o).
- * Whether this actually enables EEH or not for this device depends
- * on the CEC architecture, type of the device, on earlier boot
- * command-line arguments & etc.
- */
-static void eeh_add_device_early(struct device_node *dn)
-{
-	struct pci_controller *phb;
-
-	if (!of_node_to_eeh_dev(dn))
-		return;
-	phb = of_node_to_eeh_dev(dn)->phb;
-
-	/* USB Bus children of PCI devices will not have BUID's */
-	if (NULL == phb || 0 == phb->buid)
-		return;
-
-	/* FIXME: hotplug support on POWERNV */
-	eeh_ops->of_probe(dn, NULL);
-}
-
-/**
- * eeh_add_device_tree_early - Enable EEH for the indicated device
- * @dn: device node
- *
- * This routine must be used to perform EEH initialization for the
- * indicated PCI device that was added after system boot (e.g.
- * hotplug, dlpar).
- */
-void eeh_add_device_tree_early(struct device_node *dn)
-{
-	struct device_node *sib;
-
-	for_each_child_of_node(dn, sib)
-		eeh_add_device_tree_early(sib);
-	eeh_add_device_early(dn);
-}
-EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
-
-/**
- * eeh_add_device_late - Perform EEH initialization for the indicated pci device
- * @dev: pci device for which to set up EEH
- *
- * This routine must be used to complete EEH initialization for PCI
- * devices that were added after system boot (e.g. hotplug, dlpar).
- */
-static void eeh_add_device_late(struct pci_dev *dev)
-{
-	struct device_node *dn;
-	struct eeh_dev *edev;
-
-	if (!dev || !eeh_subsystem_enabled)
-		return;
-
-	pr_debug("EEH: Adding device %s\n", pci_name(dev));
-
-	dn = pci_device_to_OF_node(dev);
-	edev = of_node_to_eeh_dev(dn);
-	if (edev->pdev == dev) {
-		pr_debug("EEH: Already referenced !\n");
-		return;
-	}
-	WARN_ON(edev->pdev);
-
-	pci_dev_get(dev);
-	edev->pdev = dev;
-	dev->dev.archdata.edev = edev;
-
-	eeh_addr_cache_insert_dev(dev);
-}
-
-/**
- * eeh_add_device_tree_late - Perform EEH initialization for the indicated PCI bus
- * @bus: PCI bus
- *
- * This routine must be used to perform EEH initialization for PCI
- * devices which are attached to the indicated PCI bus. The PCI bus
- * is added after system boot through hotplug or dlpar.
- */
-void eeh_add_device_tree_late(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		eeh_add_device_late(dev);
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-			struct pci_bus *subbus = dev->subordinate;
-			if (subbus)
-				eeh_add_device_tree_late(subbus);
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
-
-/**
- * eeh_add_sysfs_files - Add EEH sysfs files for the indicated PCI bus
- * @bus: PCI bus
- *
- * This routine must be used to add EEH sysfs files for PCI
- * devices which are attached to the indicated PCI bus. The PCI bus
- * is added after system boot through hotplug or dlpar.
- */
-void eeh_add_sysfs_files(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		eeh_sysfs_add_device(dev);
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-			struct pci_bus *subbus = dev->subordinate;
-			if (subbus)
-				eeh_add_sysfs_files(subbus);
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
-
-/**
- * eeh_remove_device - Undo EEH setup for the indicated pci device
- * @dev: pci device to be removed
- * @purge_pe: remove the PE or not
- *
- * This routine should be called when a device is removed from
- * a running system (e.g. by hotplug or dlpar).  It unregisters
- * the PCI device from the EEH subsystem.  I/O errors affecting
- * this device will no longer be detected after this call; thus,
- * i/o errors affecting this slot may leave this device unusable.
- */
-static void eeh_remove_device(struct pci_dev *dev, int purge_pe)
-{
-	struct eeh_dev *edev;
-
-	if (!dev || !eeh_subsystem_enabled)
-		return;
-	edev = pci_dev_to_eeh_dev(dev);
-
-	/* Unregister the device with the EEH/PCI address search system */
-	pr_debug("EEH: Removing device %s\n", pci_name(dev));
-
-	if (!edev || !edev->pdev) {
-		pr_debug("EEH: Not referenced !\n");
-		return;
-	}
-	edev->pdev = NULL;
-	dev->dev.archdata.edev = NULL;
-	pci_dev_put(dev);
-
-	eeh_rmv_from_parent_pe(edev, purge_pe);
-	eeh_addr_cache_rmv_dev(dev);
-	eeh_sysfs_remove_device(dev);
-}
-
-/**
- * eeh_remove_bus_device - Undo EEH setup for the indicated PCI device
- * @dev: PCI device
- * @purge_pe: remove the corresponding PE or not
- *
- * This routine must be called when a device is removed from the
- * running system through hotplug or dlpar. The corresponding
- * PCI address cache will be removed.
- */
-void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe)
-{
-	struct pci_bus *bus = dev->subordinate;
-	struct pci_dev *child, *tmp;
-
-	eeh_remove_device(dev, purge_pe);
-
-	if (bus && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
-			 eeh_remove_bus_device(child, purge_pe);
-	}
-}
-EXPORT_SYMBOL_GPL(eeh_remove_bus_device);
-
-static int proc_eeh_show(struct seq_file *m, void *v)
-{
-	if (0 == eeh_subsystem_enabled) {
-		seq_printf(m, "EEH Subsystem is globally disabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%llu\n", eeh_stats.total_mmio_ffs);
-	} else {
-		seq_printf(m, "EEH Subsystem is enabled\n");
-		seq_printf(m,
-				"no device=%llu\n"
-				"no device node=%llu\n"
-				"no config address=%llu\n"
-				"check not wanted=%llu\n"
-				"eeh_total_mmio_ffs=%llu\n"
-				"eeh_false_positives=%llu\n"
-				"eeh_slot_resets=%llu\n",
-				eeh_stats.no_device,
-				eeh_stats.no_dn,
-				eeh_stats.no_cfg_addr,
-				eeh_stats.ignored_check,
-				eeh_stats.total_mmio_ffs,
-				eeh_stats.false_positives,
-				eeh_stats.slot_resets);
-	}
-
-	return 0;
-}
-
-static int proc_eeh_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_eeh_show, NULL);
-}
-
-static const struct file_operations proc_eeh_operations = {
-	.open      = proc_eeh_open,
-	.read      = seq_read,
-	.llseek    = seq_lseek,
-	.release   = single_release,
-};
-
-static int __init eeh_init_proc(void)
-{
-	if (machine_is(pseries))
-		proc_create("powerpc/eeh", 0, NULL, &proc_eeh_operations);
-	return 0;
-}
-__initcall(eeh_init_proc);
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
deleted file mode 100644
index 5a4c879..0000000
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ /dev/null
@@ -1,319 +0,0 @@
-/*
- * PCI address cache; allows the lookup of PCI devices based on I/O address
- *
- * Copyright IBM Corporation 2004
- * Copyright Linas Vepstas <linas@austin.ibm.com> 2004
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/list.h>
-#include <linux/pci.h>
-#include <linux/rbtree.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/atomic.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-
-
-/**
- * The pci address cache subsystem.  This subsystem places
- * PCI device address resources into a red-black tree, sorted
- * according to the address range, so that given only an i/o
- * address, the corresponding PCI device can be **quickly**
- * found. It is safe to perform an address lookup in an interrupt
- * context; this ability is an important feature.
- *
- * Currently, the only customer of this code is the EEH subsystem;
- * thus, this code has been somewhat tailored to suit EEH better.
- * In particular, the cache does *not* hold the addresses of devices
- * for which EEH is not enabled.
- *
- * (Implementation Note: The RB tree seems to be better/faster
- * than any hash algo I could think of for this problem, even
- * with the penalty of slow pointer chases for d-cache misses).
- */
-struct pci_io_addr_range {
-	struct rb_node rb_node;
-	unsigned long addr_lo;
-	unsigned long addr_hi;
-	struct eeh_dev *edev;
-	struct pci_dev *pcidev;
-	unsigned int flags;
-};
-
-static struct pci_io_addr_cache {
-	struct rb_root rb_root;
-	spinlock_t piar_lock;
-} pci_io_addr_cache_root;
-
-static inline struct eeh_dev *__eeh_addr_cache_get_device(unsigned long addr)
-{
-	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
-
-	while (n) {
-		struct pci_io_addr_range *piar;
-		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-
-		if (addr < piar->addr_lo) {
-			n = n->rb_left;
-		} else {
-			if (addr > piar->addr_hi) {
-				n = n->rb_right;
-			} else {
-				pci_dev_get(piar->pcidev);
-				return piar->edev;
-			}
-		}
-	}
-
-	return NULL;
-}
-
-/**
- * eeh_addr_cache_get_dev - Get device, given only address
- * @addr: mmio (PIO) phys address or i/o port number
- *
- * Given an mmio phys address, or a port number, find a pci device
- * that implements this address.  Be sure to pci_dev_put the device
- * when finished.  I/O port numbers are assumed to be offset
- * from zero (that is, they do *not* have pci_io_addr added in).
- * It is safe to call this function within an interrupt.
- */
-struct eeh_dev *eeh_addr_cache_get_dev(unsigned long addr)
-{
-	struct eeh_dev *edev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	edev = __eeh_addr_cache_get_device(addr);
-	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-	return edev;
-}
-
-#ifdef DEBUG
-/*
- * Handy-dandy debug print routine, does nothing more
- * than print out the contents of our addr cache.
- */
-static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
-{
-	struct rb_node *n;
-	int cnt = 0;
-
-	n = rb_first(&cache->rb_root);
-	while (n) {
-		struct pci_io_addr_range *piar;
-		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-		pr_debug("PCI: %s addr range %d [%lx-%lx]: %s\n",
-		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
-		       piar->addr_lo, piar->addr_hi, pci_name(piar->pcidev));
-		cnt++;
-		n = rb_next(n);
-	}
-}
-#endif
-
-/* Insert address range into the rb tree. */
-static struct pci_io_addr_range *
-eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
-		      unsigned long ahi, unsigned int flags)
-{
-	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct pci_io_addr_range *piar;
-
-	/* Walk tree, find a place to insert into tree */
-	while (*p) {
-		parent = *p;
-		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
-		if (ahi < piar->addr_lo) {
-			p = &parent->rb_left;
-		} else if (alo > piar->addr_hi) {
-			p = &parent->rb_right;
-		} else {
-			if (dev != piar->pcidev ||
-			    alo != piar->addr_lo || ahi != piar->addr_hi) {
-				pr_warning("PIAR: overlapping address range\n");
-			}
-			return piar;
-		}
-	}
-	piar = kzalloc(sizeof(struct pci_io_addr_range), GFP_ATOMIC);
-	if (!piar)
-		return NULL;
-
-	pci_dev_get(dev);
-	piar->addr_lo = alo;
-	piar->addr_hi = ahi;
-	piar->edev = pci_dev_to_eeh_dev(dev);
-	piar->pcidev = dev;
-	piar->flags = flags;
-
-#ifdef DEBUG
-	pr_debug("PIAR: insert range=[%lx:%lx] dev=%s\n",
-	                  alo, ahi, pci_name(dev));
-#endif
-
-	rb_link_node(&piar->rb_node, parent, p);
-	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
-
-	return piar;
-}
-
-static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
-{
-	struct device_node *dn;
-	struct eeh_dev *edev;
-	int i;
-
-	dn = pci_device_to_OF_node(dev);
-	if (!dn) {
-		pr_warning("PCI: no pci dn found for dev=%s\n", pci_name(dev));
-		return;
-	}
-
-	edev = of_node_to_eeh_dev(dn);
-	if (!edev) {
-		pr_warning("PCI: no EEH dev found for dn=%s\n",
-			dn->full_name);
-		return;
-	}
-
-	/* Skip any devices for which EEH is not enabled. */
-	if (!edev->pe) {
-#ifdef DEBUG
-		pr_info("PCI: skip building address cache for=%s - %s\n",
-			pci_name(dev), dn->full_name);
-#endif
-		return;
-	}
-
-	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long start = pci_resource_start(dev,i);
-		unsigned long end = pci_resource_end(dev,i);
-		unsigned int flags = pci_resource_flags(dev,i);
-
-		/* We are interested only bus addresses, not dma or other stuff */
-		if (0 == (flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
-			 continue;
-		eeh_addr_cache_insert(dev, start, end, flags);
-	}
-}
-
-/**
- * eeh_addr_cache_insert_dev - Add a device to the address cache
- * @dev: PCI device whose I/O addresses we are interested in.
- *
- * In order to support the fast lookup of devices based on addresses,
- * we maintain a cache of devices that can be quickly searched.
- * This routine adds a device to that cache.
- */
-void eeh_addr_cache_insert_dev(struct pci_dev *dev)
-{
-	unsigned long flags;
-
-	/* Ignore PCI bridges */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
-		return;
-
-	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	__eeh_addr_cache_insert_dev(dev);
-	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-}
-
-static inline void __eeh_addr_cache_rmv_dev(struct pci_dev *dev)
-{
-	struct rb_node *n;
-
-restart:
-	n = rb_first(&pci_io_addr_cache_root.rb_root);
-	while (n) {
-		struct pci_io_addr_range *piar;
-		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-
-		if (piar->pcidev == dev) {
-			rb_erase(n, &pci_io_addr_cache_root.rb_root);
-			pci_dev_put(piar->pcidev);
-			kfree(piar);
-			goto restart;
-		}
-		n = rb_next(n);
-	}
-}
-
-/**
- * eeh_addr_cache_rmv_dev - remove pci device from addr cache
- * @dev: device to remove
- *
- * Remove a device from the addr-cache tree.
- * This is potentially expensive, since it will walk
- * the tree multiple times (once per resource).
- * But so what; device removal doesn't need to be that fast.
- */
-void eeh_addr_cache_rmv_dev(struct pci_dev *dev)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	__eeh_addr_cache_rmv_dev(dev);
-	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-}
-
-/**
- * eeh_addr_cache_build - Build a cache of I/O addresses
- *
- * Build a cache of pci i/o addresses.  This cache will be used to
- * find the pci device that corresponds to a given address.
- * This routine scans all pci busses to build the cache.
- * Must be run late in boot process, after the pci controllers
- * have been scanned for devices (after all device resources are known).
- */
-void __init eeh_addr_cache_build(void)
-{
-	struct device_node *dn;
-	struct eeh_dev *edev;
-	struct pci_dev *dev = NULL;
-
-	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
-
-	for_each_pci_dev(dev) {
-		eeh_addr_cache_insert_dev(dev);
-
-		dn = pci_device_to_OF_node(dev);
-		if (!dn)
-			continue;
-
-		edev = of_node_to_eeh_dev(dn);
-		if (!edev)
-			continue;
-
-		pci_dev_get(dev);  /* matching put is in eeh_remove_device() */
-		dev->dev.archdata.edev = edev;
-		edev->pdev = dev;
-
-		eeh_sysfs_add_device(dev);
-	}
-
-#ifdef DEBUG
-	/* Verify tree built up above, echo back the list of addrs. */
-	eeh_addr_cache_print(&pci_io_addr_cache_root);
-#endif
-}
-
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
deleted file mode 100644
index 1efa28f..0000000
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * The file intends to implement dynamic creation of EEH device, which will
- * be bound with OF node and PCI device simutaneously. The EEH devices would
- * be foundamental information for EEH core components to work proerly. Besides,
- * We have to support multiple situations where dynamic creation of EEH device
- * is required:
- *
- * 1) Before PCI emunation starts, we need create EEH devices according to the
- *    PCI sensitive OF nodes.
- * 2) When PCI emunation is done, we need do the binding between PCI device and
- *    the associated EEH device.
- * 3) DR (Dynamic Reconfiguration) would create PCI sensitive OF node. EEH device
- *    will be created while PCI sensitive OF node is detected from DR.
- * 4) PCI hotplug needs redoing the binding between PCI device and EEH device. If
- *    PHB is newly inserted, we also need create EEH devices accordingly.
- *
- * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2012.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/export.h>
-#include <linux/gfp.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-
-/**
- * eeh_dev_init - Create EEH device according to OF node
- * @dn: device node
- * @data: PHB
- *
- * It will create EEH device according to the given OF node. The function
- * might be called by PCI emunation, DR, PHB hotplug.
- */
-void *eeh_dev_init(struct device_node *dn, void *data)
-{
-	struct pci_controller *phb = data;
-	struct eeh_dev *edev;
-
-	/* Allocate EEH device */
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
-	if (!edev) {
-		pr_warning("%s: out of memory\n", __func__);
-		return NULL;
-	}
-
-	/* Associate EEH device with OF node */
-	PCI_DN(dn)->edev = edev;
-	edev->dn  = dn;
-	edev->phb = phb;
-	INIT_LIST_HEAD(&edev->list);
-
-	return NULL;
-}
-
-/**
- * eeh_dev_phb_init_dynamic - Create EEH devices for devices included in PHB
- * @phb: PHB
- *
- * Scan the PHB OF node and its child association, then create the
- * EEH devices accordingly
- */
-void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
-{
-	struct device_node *dn = phb->dn;
-
-	/* EEH PE for PHB */
-	eeh_phb_pe_create(phb);
-
-	/* EEH device for PHB */
-	eeh_dev_init(dn, phb);
-
-	/* EEH devices for children OF nodes */
-	traverse_pci_devices(dn, eeh_dev_init, phb);
-}
-
-/**
- * eeh_dev_phb_init - Create EEH devices for devices included in existing PHBs
- *
- * Scan all the existing PHBs and create EEH devices for their OF
- * nodes and their children OF nodes
- */
-static int __init eeh_dev_phb_init(void)
-{
-	struct pci_controller *phb, *tmp;
-
-	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
-		eeh_dev_phb_init_dynamic(phb);
-
-	pr_info("EEH: devices created\n");
-
-	return 0;
-}
-
-core_initcall(eeh_dev_phb_init);
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
deleted file mode 100644
index 0acc5a2..0000000
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ /dev/null
@@ -1,552 +0,0 @@
-/*
- * PCI Error Recovery Driver for RPA-compliant PPC64 platform.
- * Copyright IBM Corp. 2004 2005
- * Copyright Linas Vepstas <linas@linas.org> 2004, 2005
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
- */
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <asm/eeh.h>
-#include <asm/eeh_event.h>
-#include <asm/ppc-pci.h>
-#include <asm/pci-bridge.h>
-#include <asm/prom.h>
-#include <asm/rtas.h>
-
-/**
- * eeh_pcid_name - Retrieve name of PCI device driver
- * @pdev: PCI device
- *
- * This routine is used to retrieve the name of PCI device driver
- * if that's valid.
- */
-static inline const char *eeh_pcid_name(struct pci_dev *pdev)
-{
-	if (pdev && pdev->dev.driver)
-		return pdev->dev.driver->name;
-	return "";
-}
-
-/**
- * eeh_pcid_get - Get the PCI device driver
- * @pdev: PCI device
- *
- * The function is used to retrieve the PCI device driver for
- * the indicated PCI device. Besides, we will increase the reference
- * of the PCI device driver to prevent that being unloaded on
- * the fly. Otherwise, kernel crash would be seen.
- */
-static inline struct pci_driver *eeh_pcid_get(struct pci_dev *pdev)
-{
-	if (!pdev || !pdev->driver)
-		return NULL;
-
-	if (!try_module_get(pdev->driver->driver.owner))
-		return NULL;
-
-	return pdev->driver;
-}
-
-/**
- * eeh_pcid_put - Dereference on the PCI device driver
- * @pdev: PCI device
- *
- * The function is called to do dereference on the PCI device
- * driver of the indicated PCI device.
- */
-static inline void eeh_pcid_put(struct pci_dev *pdev)
-{
-	if (!pdev || !pdev->driver)
-		return;
-
-	module_put(pdev->driver->driver.owner);
-}
-
-#if 0
-static void print_device_node_tree(struct pci_dn *pdn, int dent)
-{
-	int i;
-	struct device_node *pc;
-
-	if (!pdn)
-		return;
-	for (i = 0; i < dent; i++)
-		printk(" ");
-	printk("dn=%s mode=%x \tcfg_addr=%x pe_addr=%x \tfull=%s\n",
-		pdn->node->name, pdn->eeh_mode, pdn->eeh_config_addr,
-		pdn->eeh_pe_config_addr, pdn->node->full_name);
-	dent += 3;
-	pc = pdn->node->child;
-	while (pc) {
-		print_device_node_tree(PCI_DN(pc), dent);
-		pc = pc->sibling;
-	}
-}
-#endif
-
-/**
- * eeh_disable_irq - Disable interrupt for the recovering device
- * @dev: PCI device
- *
- * This routine must be called when reporting temporary or permanent
- * error to the particular PCI device to disable interrupt of that
- * device. If the device has enabled MSI or MSI-X interrupt, we needn't
- * do real work because EEH should freeze DMA transfers for those PCI
- * devices encountering EEH errors, which includes MSI or MSI-X.
- */
-static void eeh_disable_irq(struct pci_dev *dev)
-{
-	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
-
-	/* Don't disable MSI and MSI-X interrupts. They are
-	 * effectively disabled by the DMA Stopped state
-	 * when an EEH error occurs.
-	 */
-	if (dev->msi_enabled || dev->msix_enabled)
-		return;
-
-	if (!irq_has_action(dev->irq))
-		return;
-
-	edev->mode |= EEH_DEV_IRQ_DISABLED;
-	disable_irq_nosync(dev->irq);
-}
-
-/**
- * eeh_enable_irq - Enable interrupt for the recovering device
- * @dev: PCI device
- *
- * This routine must be called to enable interrupt while failed
- * device could be resumed.
- */
-static void eeh_enable_irq(struct pci_dev *dev)
-{
-	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
-
-	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
-		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
-		enable_irq(dev->irq);
-	}
-}
-
-/**
- * eeh_report_error - Report pci error to each device driver
- * @data: eeh device
- * @userdata: return value
- *
- * Report an EEH error to each device driver, collect up and
- * merge the device driver responses. Cumulative response
- * passed back in "userdata".
- */
-static void *eeh_report_error(void *data, void *userdata)
-{
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver;
-
-	/* We might not have the associated PCI device,
-	 * then we should continue for next one.
-	 */
-	if (!dev) return NULL;
-	dev->error_state = pci_channel_io_frozen;
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
-
-	eeh_disable_irq(dev);
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
-
-	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
-
-	/* A driver that needs a reset trumps all others */
-	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
-	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
-
-	eeh_pcid_put(dev);
-	return NULL;
-}
-
-/**
- * eeh_report_mmio_enabled - Tell drivers that MMIO has been enabled
- * @data: eeh device
- * @userdata: return value
- *
- * Tells each device driver that IO ports, MMIO and config space I/O
- * are now enabled. Collects up and merges the device driver responses.
- * Cumulative response passed back in "userdata".
- */
-static void *eeh_report_mmio_enabled(void *data, void *userdata)
-{
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver;
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->mmio_enabled) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
-
-	rc = driver->err_handler->mmio_enabled(dev);
-
-	/* A driver that needs a reset trumps all others */
-	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
-	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
-
-	eeh_pcid_put(dev);
-	return NULL;
-}
-
-/**
- * eeh_report_reset - Tell device that slot has been reset
- * @data: eeh device
- * @userdata: return value
- *
- * This routine must be called while EEH tries to reset particular
- * PCI device so that the associated PCI device driver could take
- * some actions, usually to save data the driver needs so that the
- * driver can work again while the device is recovered.
- */
-static void *eeh_report_reset(void *data, void *userdata)
-{
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver;
-
-	if (!dev) return NULL;
-	dev->error_state = pci_channel_io_normal;
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
-
-	eeh_enable_irq(dev);
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->slot_reset) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
-
-	rc = driver->err_handler->slot_reset(dev);
-	if ((*res == PCI_ERS_RESULT_NONE) ||
-	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
-	if (*res == PCI_ERS_RESULT_DISCONNECT &&
-	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
-
-	eeh_pcid_put(dev);
-	return NULL;
-}
-
-/**
- * eeh_report_resume - Tell device to resume normal operations
- * @data: eeh device
- * @userdata: return value
- *
- * This routine must be called to notify the device driver that it
- * could resume so that the device driver can do some initialization
- * to make the recovered device work again.
- */
-static void *eeh_report_resume(void *data, void *userdata)
-{
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_driver *driver;
-
-	if (!dev) return NULL;
-	dev->error_state = pci_channel_io_normal;
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
-
-	eeh_enable_irq(dev);
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->resume) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
-
-	driver->err_handler->resume(dev);
-
-	eeh_pcid_put(dev);
-	return NULL;
-}
-
-/**
- * eeh_report_failure - Tell device driver that device is dead.
- * @data: eeh device
- * @userdata: return value
- *
- * This informs the device driver that the device is permanently
- * dead, and that no further recovery attempts will be made on it.
- */
-static void *eeh_report_failure(void *data, void *userdata)
-{
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_driver *driver;
-
-	if (!dev) return NULL;
-	dev->error_state = pci_channel_io_perm_failure;
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
-
-	eeh_disable_irq(dev);
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
-
-	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
-
-	eeh_pcid_put(dev);
-	return NULL;
-}
-
-/**
- * eeh_reset_device - Perform actual reset of a pci slot
- * @pe: EEH PE
- * @bus: PCI bus corresponding to the isolcated slot
- *
- * This routine must be called to do reset on the indicated PE.
- * During the reset, udev might be invoked because those affected
- * PCI devices will be removed and then added.
- */
-static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
-{
-	int cnt, rc;
-
-	/* pcibios will clear the counter; save the value */
-	cnt = pe->freeze_count;
-
-	/*
-	 * We don't remove the corresponding PE instances because
-	 * we need the information afterwords. The attached EEH
-	 * devices are expected to be attached soon when calling
-	 * into pcibios_add_pci_devices().
-	 */
-	if (bus)
-		__pcibios_remove_pci_devices(bus, 0);
-
-	/* Reset the pci controller. (Asserts RST#; resets config space).
-	 * Reconfigure bridges and devices. Don't try to bring the system
-	 * up if the reset failed for some reason.
-	 */
-	rc = eeh_reset_pe(pe);
-	if (rc)
-		return rc;
-
-	/* Restore PE */
-	eeh_ops->configure_bridge(pe);
-	eeh_pe_restore_bars(pe);
-
-	/* Give the system 5 seconds to finish running the user-space
-	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
-	 * this is a hack, but if we don't do this, and try to bring
-	 * the device up before the scripts have taken it down,
-	 * potentially weird things happen.
-	 */
-	if (bus) {
-		ssleep(5);
-		pcibios_add_pci_devices(bus);
-	}
-	pe->freeze_count = cnt;
-
-	return 0;
-}
-
-/* The longest amount of time to wait for a pci device
- * to come back on line, in seconds.
- */
-#define MAX_WAIT_FOR_RECOVERY 150
-
-/**
- * eeh_handle_event - Reset a PCI device after hard lockup.
- * @pe: EEH PE
- *
- * While PHB detects address or data parity errors on particular PCI
- * slot, the associated PE will be frozen. Besides, DMA's occurring
- * to wild addresses (which usually happen due to bugs in device
- * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
- * #PERR or other misc PCI-related errors also can trigger EEH errors.
- *
- * Recovery process consists of unplugging the device driver (which
- * generated hotplug events to userspace), then issuing a PCI #RST to
- * the device, then reconfiguring the PCI config space for all bridges
- * & devices under this slot, and then finally restarting the device
- * drivers (which cause a second set of hotplug events to go out to
- * userspace).
- */
-void eeh_handle_event(struct eeh_pe *pe)
-{
-	struct pci_bus *frozen_bus;
-	int rc = 0;
-	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
-
-	frozen_bus = eeh_pe_bus_get(pe);
-	if (!frozen_bus) {
-		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
-			__func__, pe->phb->global_number, pe->addr);
-		return;
-	}
-
-	pe->freeze_count++;
-	if (pe->freeze_count > EEH_MAX_ALLOWED_FREEZES)
-		goto excess_failures;
-	pr_warning("EEH: This PCI device has failed %d times in the last hour\n",
-		pe->freeze_count);
-
-	/* Walk the various device drivers attached to this slot through
-	 * a reset sequence, giving each an opportunity to do what it needs
-	 * to accomplish the reset.  Each child gets a report of the
-	 * status ... if any child can't handle the reset, then the entire
-	 * slot is dlpar removed and added.
-	 */
-	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
-
-	/* Get the current PCI slot state. This can take a long time,
-	 * sometimes over 3 seconds for certain systems.
-	 */
-	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
-	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
-		printk(KERN_WARNING "EEH: Permanent failure\n");
-		goto hard_fail;
-	}
-
-	/* Since rtas may enable MMIO when posting the error log,
-	 * don't post the error log until after all dev drivers
-	 * have been informed.
-	 */
-	eeh_slot_error_detail(pe, EEH_LOG_TEMP);
-
-	/* If all device drivers were EEH-unaware, then shut
-	 * down all of the device drivers, and hope they
-	 * go down willingly, without panicing the system.
-	 */
-	if (result == PCI_ERS_RESULT_NONE) {
-		rc = eeh_reset_device(pe, frozen_bus);
-		if (rc) {
-			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
-			goto hard_fail;
-		}
-	}
-
-	/* If all devices reported they can proceed, then re-enable MMIO */
-	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
-
-		if (rc < 0)
-			goto hard_fail;
-		if (rc) {
-			result = PCI_ERS_RESULT_NEED_RESET;
-		} else {
-			result = PCI_ERS_RESULT_NONE;
-			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
-		}
-	}
-
-	/* If all devices reported they can proceed, then re-enable DMA */
-	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
-
-		if (rc < 0)
-			goto hard_fail;
-		if (rc)
-			result = PCI_ERS_RESULT_NEED_RESET;
-		else
-			result = PCI_ERS_RESULT_RECOVERED;
-	}
-
-	/* If any device has a hard failure, then shut off everything. */
-	if (result == PCI_ERS_RESULT_DISCONNECT) {
-		printk(KERN_WARNING "EEH: Device driver gave up\n");
-		goto hard_fail;
-	}
-
-	/* If any device called out for a reset, then reset the slot */
-	if (result == PCI_ERS_RESULT_NEED_RESET) {
-		rc = eeh_reset_device(pe, NULL);
-		if (rc) {
-			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
-			goto hard_fail;
-		}
-		result = PCI_ERS_RESULT_NONE;
-		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
-	}
-
-	/* All devices should claim they have recovered by now. */
-	if ((result != PCI_ERS_RESULT_RECOVERED) &&
-	    (result != PCI_ERS_RESULT_NONE)) {
-		printk(KERN_WARNING "EEH: Not recovered\n");
-		goto hard_fail;
-	}
-
-	/* Tell all device drivers that they can resume operations */
-	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
-
-	return;
-
-excess_failures:
-	/*
-	 * About 90% of all real-life EEH failures in the field
-	 * are due to poorly seated PCI cards. Only 10% or so are
-	 * due to actual, failed cards.
-	 */
-	pr_err("EEH: PHB#%d-PE#%x has failed %d times in the\n"
-	       "last hour and has been permanently disabled.\n"
-	       "Please try reseating or replacing it.\n",
-		pe->phb->global_number, pe->addr,
-		pe->freeze_count);
-	goto perm_error;
-
-hard_fail:
-	pr_err("EEH: Unable to recover from failure from PHB#%d-PE#%x.\n"
-	       "Please try reseating or replacing it\n",
-		pe->phb->global_number, pe->addr);
-
-perm_error:
-	eeh_slot_error_detail(pe, EEH_LOG_PERM);
-
-	/* Notify all devices that they're about to go down. */
-	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
-
-	/* Shut down the device drivers for good. */
-	if (frozen_bus)
-		pcibios_remove_pci_devices(frozen_bus);
-}
-
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
deleted file mode 100644
index 185bedd..0000000
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
- */
-
-#include <linux/delay.h>
-#include <linux/list.h>
-#include <linux/mutex.h>
-#include <linux/sched.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
-#include <linux/kthread.h>
-#include <asm/eeh_event.h>
-#include <asm/ppc-pci.h>
-
-/** Overview:
- *  EEH error states may be detected within exception handlers;
- *  however, the recovery processing needs to occur asynchronously
- *  in a normal kernel context and not an interrupt context.
- *  This pair of routines creates an event and queues it onto a
- *  work-queue, where a worker thread can drive recovery.
- */
-
-/* EEH event workqueue setup. */
-static DEFINE_SPINLOCK(eeh_eventlist_lock);
-LIST_HEAD(eeh_eventlist);
-static void eeh_thread_launcher(struct work_struct *);
-DECLARE_WORK(eeh_event_wq, eeh_thread_launcher);
-
-/* Serialize reset sequences for a given pci device */
-DEFINE_MUTEX(eeh_event_mutex);
-
-/**
- * eeh_event_handler - Dispatch EEH events.
- * @dummy - unused
- *
- * The detection of a frozen slot can occur inside an interrupt,
- * where it can be hard to do anything about it.  The goal of this
- * routine is to pull these detection events out of the context
- * of the interrupt handler, and re-dispatch them for processing
- * at a later time in a normal context.
- */
-static int eeh_event_handler(void * dummy)
-{
-	unsigned long flags;
-	struct eeh_event *event;
-	struct eeh_pe *pe;
-
-	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-	event = NULL;
-
-	/* Unqueue the event, get ready to process. */
-	if (!list_empty(&eeh_eventlist)) {
-		event = list_entry(eeh_eventlist.next, struct eeh_event, list);
-		list_del(&event->list);
-	}
-	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-
-	if (event == NULL)
-		return 0;
-
-	/* Serialize processing of EEH events */
-	mutex_lock(&eeh_event_mutex);
-	pe = event->pe;
-	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
-	pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
-		pe->phb->global_number, pe->addr);
-
-	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
-	eeh_handle_event(pe);
-	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
-
-	kfree(event);
-	mutex_unlock(&eeh_event_mutex);
-
-	/* If there are no new errors after an hour, clear the counter. */
-	if (pe && pe->freeze_count > 0) {
-		msleep_interruptible(3600*1000);
-		if (pe->freeze_count > 0)
-			pe->freeze_count--;
-
-	}
-
-	return 0;
-}
-
-/**
- * eeh_thread_launcher - Start kernel thread to handle EEH events
- * @dummy - unused
- *
- * This routine is called to start the kernel thread for processing
- * EEH event.
- */
-static void eeh_thread_launcher(struct work_struct *dummy)
-{
-	if (IS_ERR(kthread_run(eeh_event_handler, NULL, "eehd")))
-		printk(KERN_ERR "Failed to start EEH daemon\n");
-}
-
-/**
- * eeh_send_failure_event - Generate a PCI error event
- * @pe: EEH PE
- *
- * This routine can be called within an interrupt context;
- * the actual event will be delivered in a normal context
- * (from a workqueue).
- */
-int eeh_send_failure_event(struct eeh_pe *pe)
-{
-	unsigned long flags;
-	struct eeh_event *event;
-
-	event = kzalloc(sizeof(*event), GFP_ATOMIC);
-	if (!event) {
-		pr_err("EEH: out of memory, event not handled\n");
-		return -ENOMEM;
-	}
-	event->pe = pe;
-
-	/* We may or may not be called in an interrupt context */
-	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-	list_add(&event->list, &eeh_eventlist);
-	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-
-	schedule_work(&eeh_event_wq);
-
-	return 0;
-}
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
deleted file mode 100644
index 9d4a9e8..0000000
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ /dev/null
@@ -1,653 +0,0 @@
-/*
- * The file intends to implement PE based on the information from
- * platforms. Basically, there have 3 types of PEs: PHB/Bus/Device.
- * All the PEs should be organized as hierarchy tree. The first level
- * of the tree will be associated to existing PHBs since the particular
- * PE is only meaningful in one PHB domain.
- *
- * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2012.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/export.h>
-#include <linux/gfp.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-
-static LIST_HEAD(eeh_phb_pe);
-
-/**
- * eeh_pe_alloc - Allocate PE
- * @phb: PCI controller
- * @type: PE type
- *
- * Allocate PE instance dynamically.
- */
-static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
-{
-	struct eeh_pe *pe;
-
-	/* Allocate PHB PE */
-	pe = kzalloc(sizeof(struct eeh_pe), GFP_KERNEL);
-	if (!pe) return NULL;
-
-	/* Initialize PHB PE */
-	pe->type = type;
-	pe->phb = phb;
-	INIT_LIST_HEAD(&pe->child_list);
-	INIT_LIST_HEAD(&pe->child);
-	INIT_LIST_HEAD(&pe->edevs);
-
-	return pe;
-}
-
-/**
- * eeh_phb_pe_create - Create PHB PE
- * @phb: PCI controller
- *
- * The function should be called while the PHB is detected during
- * system boot or PCI hotplug in order to create PHB PE.
- */
-int eeh_phb_pe_create(struct pci_controller *phb)
-{
-	struct eeh_pe *pe;
-
-	/* Allocate PHB PE */
-	pe = eeh_pe_alloc(phb, EEH_PE_PHB);
-	if (!pe) {
-		pr_err("%s: out of memory!\n", __func__);
-		return -ENOMEM;
-	}
-
-	/* Put it into the list */
-	eeh_lock();
-	list_add_tail(&pe->child, &eeh_phb_pe);
-	eeh_unlock();
-
-	pr_debug("EEH: Add PE for PHB#%d\n", phb->global_number);
-
-	return 0;
-}
-
-/**
- * eeh_phb_pe_get - Retrieve PHB PE based on the given PHB
- * @phb: PCI controller
- *
- * The overall PEs form hierarchy tree. The first layer of the
- * hierarchy tree is composed of PHB PEs. The function is used
- * to retrieve the corresponding PHB PE according to the given PHB.
- */
-static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
-{
-	struct eeh_pe *pe;
-
-	list_for_each_entry(pe, &eeh_phb_pe, child) {
-		/*
-		 * Actually, we needn't check the type since
-		 * the PE for PHB has been determined when that
-		 * was created.
-		 */
-		if ((pe->type & EEH_PE_PHB) && pe->phb == phb)
-			return pe;
-	}
-
-	return NULL;
-}
-
-/**
- * eeh_pe_next - Retrieve the next PE in the tree
- * @pe: current PE
- * @root: root PE
- *
- * The function is used to retrieve the next PE in the
- * hierarchy PE tree.
- */
-static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
-				  struct eeh_pe *root)
-{
-	struct list_head *next = pe->child_list.next;
-
-	if (next == &pe->child_list) {
-		while (1) {
-			if (pe == root)
-				return NULL;
-			next = pe->child.next;
-			if (next != &pe->parent->child_list)
-				break;
-			pe = pe->parent;
-		}
-	}
-
-	return list_entry(next, struct eeh_pe, child);
-}
-
-/**
- * eeh_pe_traverse - Traverse PEs in the specified PHB
- * @root: root PE
- * @fn: callback
- * @flag: extra parameter to callback
- *
- * The function is used to traverse the specified PE and its
- * child PEs. The traversing is to be terminated once the
- * callback returns something other than NULL, or no more PEs
- * to be traversed.
- */
-static void *eeh_pe_traverse(struct eeh_pe *root,
-			eeh_traverse_func fn, void *flag)
-{
-	struct eeh_pe *pe;
-	void *ret;
-
-	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
-		ret = fn(pe, flag);
-		if (ret) return ret;
-	}
-
-	return NULL;
-}
-
-/**
- * eeh_pe_dev_traverse - Traverse the devices from the PE
- * @root: EEH PE
- * @fn: function callback
- * @flag: extra parameter to callback
- *
- * The function is used to traverse the devices of the specified
- * PE and its child PEs.
- */
-void *eeh_pe_dev_traverse(struct eeh_pe *root,
-		eeh_traverse_func fn, void *flag)
-{
-	struct eeh_pe *pe;
-	struct eeh_dev *edev;
-	void *ret;
-
-	if (!root) {
-		pr_warning("%s: Invalid PE %p\n", __func__, root);
-		return NULL;
-	}
-
-	eeh_lock();
-
-	/* Traverse root PE */
-	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
-		eeh_pe_for_each_dev(pe, edev) {
-			ret = fn(edev, flag);
-			if (ret) {
-				eeh_unlock();
-				return ret;
-			}
-		}
-	}
-
-	eeh_unlock();
-
-	return NULL;
-}
-
-/**
- * __eeh_pe_get - Check the PE address
- * @data: EEH PE
- * @flag: EEH device
- *
- * For one particular PE, it can be identified by PE address
- * or tranditional BDF address. BDF address is composed of
- * Bus/Device/Function number. The extra data referred by flag
- * indicates which type of address should be used.
- */
-static void *__eeh_pe_get(void *data, void *flag)
-{
-	struct eeh_pe *pe = (struct eeh_pe *)data;
-	struct eeh_dev *edev = (struct eeh_dev *)flag;
-
-	/* Unexpected PHB PE */
-	if (pe->type & EEH_PE_PHB)
-		return NULL;
-
-	/* We prefer PE address */
-	if (edev->pe_config_addr &&
-	   (edev->pe_config_addr == pe->addr))
-		return pe;
-
-	/* Try BDF address */
-	if (edev->pe_config_addr &&
-	   (edev->config_addr == pe->config_addr))
-		return pe;
-
-	return NULL;
-}
-
-/**
- * eeh_pe_get - Search PE based on the given address
- * @edev: EEH device
- *
- * Search the corresponding PE based on the specified address which
- * is included in the eeh device. The function is used to check if
- * the associated PE has been created against the PE address. It's
- * notable that the PE address has 2 format: traditional PE address
- * which is composed of PCI bus/device/function number, or unified
- * PE address.
- */
-static struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
-{
-	struct eeh_pe *root = eeh_phb_pe_get(edev->phb);
-	struct eeh_pe *pe;
-
-	pe = eeh_pe_traverse(root, __eeh_pe_get, edev);
-
-	return pe;
-}
-
-/**
- * eeh_pe_get_parent - Retrieve the parent PE
- * @edev: EEH device
- *
- * The whole PEs existing in the system are organized as hierarchy
- * tree. The function is used to retrieve the parent PE according
- * to the parent EEH device.
- */
-static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
-{
-	struct device_node *dn;
-	struct eeh_dev *parent;
-
-	/*
-	 * It might have the case for the indirect parent
-	 * EEH device already having associated PE, but
-	 * the direct parent EEH device doesn't have yet.
-	 */
-	dn = edev->dn->parent;
-	while (dn) {
-		/* We're poking out of PCI territory */
-		if (!PCI_DN(dn)) return NULL;
-
-		parent = of_node_to_eeh_dev(dn);
-		/* We're poking out of PCI territory */
-		if (!parent) return NULL;
-
-		if (parent->pe)
-			return parent->pe;
-
-		dn = dn->parent;
-	}
-
-	return NULL;
-}
-
-/**
- * eeh_add_to_parent_pe - Add EEH device to parent PE
- * @edev: EEH device
- *
- * Add EEH device to the parent PE. If the parent PE already
- * exists, the PE type will be changed to EEH_PE_BUS. Otherwise,
- * we have to create new PE to hold the EEH device and the new
- * PE will be linked to its parent PE as well.
- */
-int eeh_add_to_parent_pe(struct eeh_dev *edev)
-{
-	struct eeh_pe *pe, *parent;
-
-	eeh_lock();
-
-	/*
-	 * Search the PE has been existing or not according
-	 * to the PE address. If that has been existing, the
-	 * PE should be composed of PCI bus and its subordinate
-	 * components.
-	 */
-	pe = eeh_pe_get(edev);
-	if (pe && !(pe->type & EEH_PE_INVALID)) {
-		if (!edev->pe_config_addr) {
-			eeh_unlock();
-			pr_err("%s: PE with addr 0x%x already exists\n",
-				__func__, edev->config_addr);
-			return -EEXIST;
-		}
-
-		/* Mark the PE as type of PCI bus */
-		pe->type = EEH_PE_BUS;
-		edev->pe = pe;
-
-		/* Put the edev to PE */
-		list_add_tail(&edev->list, &pe->edevs);
-		eeh_unlock();
-		pr_debug("EEH: Add %s to Bus PE#%x\n",
-			edev->dn->full_name, pe->addr);
-
-		return 0;
-	} else if (pe && (pe->type & EEH_PE_INVALID)) {
-		list_add_tail(&edev->list, &pe->edevs);
-		edev->pe = pe;
-		/*
-		 * We're running to here because of PCI hotplug caused by
-		 * EEH recovery. We need clear EEH_PE_INVALID until the top.
-		 */
-		parent = pe;
-		while (parent) {
-			if (!(parent->type & EEH_PE_INVALID))
-				break;
-			parent->type &= ~EEH_PE_INVALID;
-			parent = parent->parent;
-		}
-		eeh_unlock();
-		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
-			edev->dn->full_name, pe->addr, pe->parent->addr);
-
-		return 0;
-	}
-
-	/* Create a new EEH PE */
-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
-	if (!pe) {
-		eeh_unlock();
-		pr_err("%s: out of memory!\n", __func__);
-		return -ENOMEM;
-	}
-	pe->addr	= edev->pe_config_addr;
-	pe->config_addr	= edev->config_addr;
-
-	/*
-	 * Put the new EEH PE into hierarchy tree. If the parent
-	 * can't be found, the newly created PE will be attached
-	 * to PHB directly. Otherwise, we have to associate the
-	 * PE with its parent.
-	 */
-	parent = eeh_pe_get_parent(edev);
-	if (!parent) {
-		parent = eeh_phb_pe_get(edev->phb);
-		if (!parent) {
-			eeh_unlock();
-			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
-				__func__, edev->phb->global_number);
-			edev->pe = NULL;
-			kfree(pe);
-			return -EEXIST;
-		}
-	}
-	pe->parent = parent;
-
-	/*
-	 * Put the newly created PE into the child list and
-	 * link the EEH device accordingly.
-	 */
-	list_add_tail(&pe->child, &parent->child_list);
-	list_add_tail(&edev->list, &pe->edevs);
-	edev->pe = pe;
-	eeh_unlock();
-	pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
-		edev->dn->full_name, pe->addr, pe->parent->addr);
-
-	return 0;
-}
-
-/**
- * eeh_rmv_from_parent_pe - Remove one EEH device from the associated PE
- * @edev: EEH device
- * @purge_pe: remove PE or not
- *
- * The PE hierarchy tree might be changed when doing PCI hotplug.
- * Also, the PCI devices or buses could be removed from the system
- * during EEH recovery. So we have to call the function remove the
- * corresponding PE accordingly if necessary.
- */
-int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
-{
-	struct eeh_pe *pe, *parent, *child;
-	int cnt;
-
-	if (!edev->pe) {
-		pr_warning("%s: No PE found for EEH device %s\n",
-			__func__, edev->dn->full_name);
-		return -EEXIST;
-	}
-
-	eeh_lock();
-
-	/* Remove the EEH device */
-	pe = edev->pe;
-	edev->pe = NULL;
-	list_del(&edev->list);
-
-	/*
-	 * Check if the parent PE includes any EEH devices.
-	 * If not, we should delete that. Also, we should
-	 * delete the parent PE if it doesn't have associated
-	 * child PEs and EEH devices.
-	 */
-	while (1) {
-		parent = pe->parent;
-		if (pe->type & EEH_PE_PHB)
-			break;
-
-		if (purge_pe) {
-			if (list_empty(&pe->edevs) &&
-			    list_empty(&pe->child_list)) {
-				list_del(&pe->child);
-				kfree(pe);
-			} else {
-				break;
-			}
-		} else {
-			if (list_empty(&pe->edevs)) {
-				cnt = 0;
-				list_for_each_entry(child, &pe->child_list, child) {
-					if (!(child->type & EEH_PE_INVALID)) {
-						cnt++;
-						break;
-					}
-				}
-
-				if (!cnt)
-					pe->type |= EEH_PE_INVALID;
-				else
-					break;
-			}
-		}
-
-		pe = parent;
-	}
-
-	eeh_unlock();
-
-	return 0;
-}
-
-/**
- * __eeh_pe_state_mark - Mark the state for the PE
- * @data: EEH PE
- * @flag: state
- *
- * The function is used to mark the indicated state for the given
- * PE. Also, the associated PCI devices will be put into IO frozen
- * state as well.
- */
-static void *__eeh_pe_state_mark(void *data, void *flag)
-{
-	struct eeh_pe *pe = (struct eeh_pe *)data;
-	int state = *((int *)flag);
-	struct eeh_dev *tmp;
-	struct pci_dev *pdev;
-
-	/*
-	 * Mark the PE with the indicated state. Also,
-	 * the associated PCI device will be put into
-	 * I/O frozen state to avoid I/O accesses from
-	 * the PCI device driver.
-	 */
-	pe->state |= state;
-	eeh_pe_for_each_dev(pe, tmp) {
-		pdev = eeh_dev_to_pci_dev(tmp);
-		if (pdev)
-			pdev->error_state = pci_channel_io_frozen;
-	}
-
-	return NULL;
-}
-
-/**
- * eeh_pe_state_mark - Mark specified state for PE and its associated device
- * @pe: EEH PE
- *
- * EEH error affects the current PE and its child PEs. The function
- * is used to mark appropriate state for the affected PEs and the
- * associated devices.
- */
-void eeh_pe_state_mark(struct eeh_pe *pe, int state)
-{
-	eeh_lock();
-	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
-	eeh_unlock();
-}
-
-/**
- * __eeh_pe_state_clear - Clear state for the PE
- * @data: EEH PE
- * @flag: state
- *
- * The function is used to clear the indicated state from the
- * given PE. Besides, we also clear the check count of the PE
- * as well.
- */
-static void *__eeh_pe_state_clear(void *data, void *flag)
-{
-	struct eeh_pe *pe = (struct eeh_pe *)data;
-	int state = *((int *)flag);
-
-	pe->state &= ~state;
-	pe->check_count = 0;
-
-	return NULL;
-}
-
-/**
- * eeh_pe_state_clear - Clear state for the PE and its children
- * @pe: PE
- * @state: state to be cleared
- *
- * When the PE and its children has been recovered from error,
- * we need clear the error state for that. The function is used
- * for the purpose.
- */
-void eeh_pe_state_clear(struct eeh_pe *pe, int state)
-{
-	eeh_lock();
-	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
-	eeh_unlock();
-}
-
-/**
- * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
- * @data: EEH device
- * @flag: Unused
- *
- * Loads the PCI configuration space base address registers,
- * the expansion ROM base address, the latency timer, and etc.
- * from the saved values in the device node.
- */
-static void *eeh_restore_one_device_bars(void *data, void *flag)
-{
-	int i;
-	u32 cmd;
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
-
-	for (i = 4; i < 10; i++)
-		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
-	/* 12 == Expansion ROM Address */
-	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
-
-#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
-#define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
-
-	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
-		SAVED_BYTE(PCI_CACHE_LINE_SIZE));
-	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
-		SAVED_BYTE(PCI_LATENCY_TIMER));
-
-	/* max latency, min grant, interrupt pin and line */
-	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
-
-	/*
-	 * Restore PERR & SERR bits, some devices require it,
-	 * don't touch the other command bits
-	 */
-	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
-	if (edev->config_space[1] & PCI_COMMAND_PARITY)
-		cmd |= PCI_COMMAND_PARITY;
-	else
-		cmd &= ~PCI_COMMAND_PARITY;
-	if (edev->config_space[1] & PCI_COMMAND_SERR)
-		cmd |= PCI_COMMAND_SERR;
-	else
-		cmd &= ~PCI_COMMAND_SERR;
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
-
-	return NULL;
-}
-
-/**
- * eeh_pe_restore_bars - Restore the PCI config space info
- * @pe: EEH PE
- *
- * This routine performs a recursive walk to the children
- * of this device as well.
- */
-void eeh_pe_restore_bars(struct eeh_pe *pe)
-{
-	/*
-	 * We needn't take the EEH lock since eeh_pe_dev_traverse()
-	 * will take that.
-	 */
-	eeh_pe_dev_traverse(pe, eeh_restore_one_device_bars, NULL);
-}
-
-/**
- * eeh_pe_bus_get - Retrieve PCI bus according to the given PE
- * @pe: EEH PE
- *
- * Retrieve the PCI bus according to the given PE. Basically,
- * there're 3 types of PEs: PHB/Bus/Device. For PHB PE, the
- * primary PCI bus will be retrieved. The parent bus will be
- * returned for BUS PE. However, we don't have associated PCI
- * bus for DEVICE PE.
- */
-struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
-{
-	struct pci_bus *bus = NULL;
-	struct eeh_dev *edev;
-	struct pci_dev *pdev;
-
-	eeh_lock();
-
-	if (pe->type & EEH_PE_PHB) {
-		bus = pe->phb->bus;
-	} else if (pe->type & EEH_PE_BUS ||
-		   pe->type & EEH_PE_DEVICE) {
-		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
-		pdev = eeh_dev_to_pci_dev(edev);
-		if (pdev)
-			bus = pdev->bus;
-	}
-
-	eeh_unlock();
-
-	return bus;
-}
diff --git a/arch/powerpc/platforms/pseries/eeh_sysfs.c b/arch/powerpc/platforms/pseries/eeh_sysfs.c
deleted file mode 100644
index d377083..0000000
--- a/arch/powerpc/platforms/pseries/eeh_sysfs.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Sysfs entries for PCI Error Recovery for PAPR-compliant platform.
- * Copyright IBM Corporation 2007
- * Copyright Linas Vepstas <linas@austin.ibm.com> 2007
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
- */
-#include <linux/pci.h>
-#include <linux/stat.h>
-#include <asm/ppc-pci.h>
-#include <asm/pci-bridge.h>
-
-/**
- * EEH_SHOW_ATTR -- Create sysfs entry for eeh statistic
- * @_name: name of file in sysfs directory
- * @_memb: name of member in struct pci_dn to access
- * @_format: printf format for display
- *
- * All of the attributes look very similar, so just
- * auto-gen a cut-n-paste routine to display them.
- */
-#define EEH_SHOW_ATTR(_name,_memb,_format)               \
-static ssize_t eeh_show_##_name(struct device *dev,      \
-		struct device_attribute *attr, char *buf)          \
-{                                                        \
-	struct pci_dev *pdev = to_pci_dev(dev);               \
-	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);      \
-	                                                      \
-	if (!edev)                                            \
-		return 0;                                     \
-	                                                      \
-	return sprintf(buf, _format "\n", edev->_memb);       \
-}                                                        \
-static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
-
-EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
-EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
-EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
-
-void eeh_sysfs_add_device(struct pci_dev *pdev)
-{
-	int rc=0;
-
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
-
-	if (rc)
-		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");
-}
-
-void eeh_sysfs_remove_device(struct pci_dev *pdev)
-{
-	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
-	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
-	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
-}
-
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index c91b22b..efe6137 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -64,91 +64,6 @@ pcibios_find_pci_bus(struct device_node *dn)
 }
 EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
 
-/**
- * __pcibios_remove_pci_devices - remove all devices under this bus
- * @bus: the indicated PCI bus
- * @purge_pe: destroy the PE on removal of PCI devices
- *
- * Remove all of the PCI devices under this bus both from the
- * linux pci device tree, and from the powerpc EEH address cache.
- * By default, the corresponding PE will be destroied during the
- * normal PCI hotplug path. For PCI hotplug during EEH recovery,
- * the corresponding PE won't be destroied and deallocated.
- */
-void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe)
-{
-	struct pci_dev *dev, *tmp;
-	struct pci_bus *child_bus;
-
-	/* First go down child busses */
-	list_for_each_entry(child_bus, &bus->children, node)
-		__pcibios_remove_pci_devices(child_bus, purge_pe);
-
-	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
-		pci_domain_nr(bus),  bus->number);
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-		pr_debug("     * Removing %s...\n", pci_name(dev));
-		eeh_remove_bus_device(dev, purge_pe);
-		pci_stop_and_remove_bus_device(dev);
-	}
-}
-
-/**
- * pcibios_remove_pci_devices - remove all devices under this bus
- *
- * Remove all of the PCI devices under this bus both from the
- * linux pci device tree, and from the powerpc EEH address cache.
- */
-void pcibios_remove_pci_devices(struct pci_bus *bus)
-{
-	__pcibios_remove_pci_devices(bus, 1);
-}
-EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
-
-/**
- * pcibios_add_pci_devices - adds new pci devices to bus
- *
- * This routine will find and fixup new pci devices under
- * the indicated bus. This routine presumes that there
- * might already be some devices under this bridge, so
- * it carefully tries to add only new devices.  (And that
- * is how this routine differs from other, similar pcibios
- * routines.)
- */
-void pcibios_add_pci_devices(struct pci_bus * bus)
-{
-	int slotno, num, mode, pass, max;
-	struct pci_dev *dev;
-	struct device_node *dn = pci_bus_to_OF_node(bus);
-
-	eeh_add_device_tree_early(dn);
-
-	mode = PCI_PROBE_NORMAL;
-	if (ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
-
-	if (mode == PCI_PROBE_DEVTREE) {
-		/* use ofdt-based probe */
-		of_rescan_bus(dn, bus);
-	} else if (mode == PCI_PROBE_NORMAL) {
-		/* use legacy probe */
-		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
-		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		if (!num)
-			return;
-		pcibios_setup_bus_devices(bus);
-		max = bus->busn_res.start;
-		for (pass=0; pass < 2; pass++)
-			list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
-				max = pci_scan_bridge(bus, dev, max, pass);
-		}
-	}
-	pcibios_finish_adding_to_bus(bus);
-}
-EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
-
 struct pci_controller *init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
-- 
1.7.5.4


--vkogqOf2sHV7VnPd--
