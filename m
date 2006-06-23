Return-Path: <haren@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C34E9679F0
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 16:36:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5N6aYru020127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 02:36:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5N6akDG091440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 00:36:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5N6aXiC000858
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 00:36:33 -0600
Message-ID: <449B8B9E.2050802@us.ibm.com>
Date: Thu, 22 Jun 2006 23:35:10 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH] powerpc: kdump: Reserve the existing TCE mappings left by
	the first kernel
Content-Type: multipart/mixed; boundary="------------000401070901050505010604"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000401070901050505010604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul, Olof,

tce_union got removed in powerpc.git tree. Hence reposting the patch 
created against this tree. This patch is implemented based on Olof's 
suggestion of reserving TCE entries and use only available ones in the 
kdump boot and tested on P5, P4, JS20 and JS21 machines.

If you are OK with this patch, please send it to upstream.

Thanks
Haren

During kdump boot, noticed some machines checkstop on dma protection 
fault for ongoing DMA left in the first kernel. Instead of initializing 
TCE entries in iommu_init() for the kdump boot, this patch fixes this 
issue by walking through the each TCE table and checks whether the 
entries are in use by the first kernel. If so, reserve those entries by 
setting the corresponding bit in tbl->it_map such that these entries 
will not be available for the kdump boot.

However it could be possible that all TCE entries might be used up due 
to the driver bug that does continuous mapping. My observation is around 
1700 TCE  entries are used on some systems (Ex: P4) at some point of 
time during kdump boot and saving dump (either write into the disk or 
sending to remote machine). Hence, this patch will make sure that 
minimum of 2048 entries will be available such that kdump boot could be 
successful in some cases.

Signed-off-by: Haren Myneni <haren@us.ibm.com>



--------------000401070901050505010604
Content-Type: text/x-patch;
 name="ppc64-kdump-checkstop-DMA-fault-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-kdump-checkstop-DMA-fault-fix.patch"

diff -Naurp powerpc.git.orig/arch/powerpc/kernel/iommu.c powerpc.git/arch/powerpc/kernel/iommu.c
--- powerpc.git.orig/arch/powerpc/kernel/iommu.c	2006-06-19 00:54:37.000000000 -0500
+++ powerpc.git/arch/powerpc/kernel/iommu.c	2006-06-19 00:52:31.000000000 -0500
@@ -38,6 +38,7 @@
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
+#include <asm/kdump.h>
 
 #define DBG(...)
 
@@ -440,8 +441,37 @@ struct iommu_table *iommu_init_table(str
 	tbl->it_largehint = tbl->it_halfpoint;
 	spin_lock_init(&tbl->it_lock);
 
+#ifdef CONFIG_CRASH_DUMP
+	if (ppc_md.tce_get) {
+		unsigned long index, tceval;
+		unsigned long tcecount = 0;
+
+		/*
+		 * Reserve the existing mappings left by the first kernel.
+		 */
+		for (index = 0; index < tbl->it_size; index++) {
+			tceval = ppc_md.tce_get(tbl, index + tbl->it_offset);
+			/*
+			 * Freed TCE entry contains 0x7fffffffffffffff on JS20
+			 */
+			if (tceval && (tceval != 0x7fffffffffffffffUL)) {
+				__set_bit(index, tbl->it_map);
+				tcecount++;
+			}
+		}
+		if ((tbl->it_size - tcecount) < KDUMP_MIN_TCE_ENTRIES) {
+			printk(KERN_WARNING "TCE table is full; ");
+			printk(KERN_WARNING "freeing %d entries for the kdump boot\n",
+				KDUMP_MIN_TCE_ENTRIES);
+			for (index = tbl->it_size - KDUMP_MIN_TCE_ENTRIES;
+				index < tbl->it_size; index++) 
+				__clear_bit(index, tbl->it_map);
+		}
+	}
+#else
 	/* Clear the hardware table in case firmware left allocations in it */
 	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
+#endif
 
 	if (!welcomed) {
 		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
diff -Naurp powerpc.git.orig/arch/powerpc/platforms/pseries/iommu.c powerpc.git/arch/powerpc/platforms/pseries/iommu.c
--- powerpc.git.orig/arch/powerpc/platforms/pseries/iommu.c	2006-06-19 00:54:27.000000000 -0500
+++ powerpc.git/arch/powerpc/platforms/pseries/iommu.c	2006-06-19 00:52:44.000000000 -0500
@@ -92,6 +92,15 @@ static void tce_free_pSeries(struct iomm
 		*(tcep++) = 0;
 }
 
+static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
+{
+	u64 *tcep;
+
+	index <<= TCE_PAGE_FACTOR;
+	tcep = ((u64 *)tbl->it_base) + index;
+
+	return *tcep;
+}
 
 static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
@@ -235,6 +244,25 @@ static void tce_freemulti_pSeriesLP(stru
 	}
 }
 
+static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
+{
+	u64 rc;
+	unsigned long tce_ret;
+
+	tcenum <<= TCE_PAGE_FACTOR;
+	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
+	
+	if (rc && printk_ratelimit()) {
+		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%ld\n",
+			rc);
+		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
+		printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
+		show_stack(current, (unsigned long *)__get_SP());
+	}
+	
+	return tce_ret;
+}
+
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
 				 struct iommu_table *tbl)
@@ -254,7 +282,10 @@ static void iommu_table_setparms(struct 
 	}
 
 	tbl->it_base = (unsigned long)__va(*basep);
+
+#ifndef CONFIG_CRASH_DUMP
 	memset((void *)tbl->it_base, 0, *sizep);
+#endif
 
 	tbl->it_busno = phb->bus->number;
 
@@ -564,11 +595,13 @@ void iommu_init_early_pSeries(void)
 			ppc_md.tce_build = tce_build_pSeriesLP;
 			ppc_md.tce_free	 = tce_free_pSeriesLP;
 		}
+		ppc_md.tce_get   = tce_get_pSeriesLP;
 		ppc_md.iommu_bus_setup = iommu_bus_setup_pSeriesLP;
 		ppc_md.iommu_dev_setup = iommu_dev_setup_pSeriesLP;
 	} else {
 		ppc_md.tce_build = tce_build_pSeries;
 		ppc_md.tce_free  = tce_free_pSeries;
+		ppc_md.tce_get   = tce_get_pseries;
 		ppc_md.iommu_bus_setup = iommu_bus_setup_pSeries;
 		ppc_md.iommu_dev_setup = iommu_dev_setup_pSeries;
 	}
diff -Naurp powerpc.git.orig/include/asm-powerpc/kdump.h powerpc.git/include/asm-powerpc/kdump.h
--- powerpc.git.orig/include/asm-powerpc/kdump.h	2006-06-19 00:55:11.000000000 -0500
+++ powerpc.git/include/asm-powerpc/kdump.h	2006-06-22 02:48:15.000000000 -0500
@@ -15,6 +15,8 @@
 #define KDUMP_TRAMPOLINE_START	0x0100
 #define KDUMP_TRAMPOLINE_END	0x3000
 
+#define KDUMP_MIN_TCE_ENTRIES	2048
+
 #else /* !CONFIG_CRASH_DUMP */
 
 #define PHYSICAL_START	0x0
diff -Naurp powerpc.git.orig/include/asm-powerpc/machdep.h powerpc.git/include/asm-powerpc/machdep.h
--- powerpc.git.orig/include/asm-powerpc/machdep.h	2006-06-19 00:54:58.000000000 -0500
+++ powerpc.git/include/asm-powerpc/machdep.h	2006-06-19 00:53:05.000000000 -0500
@@ -82,6 +82,8 @@ struct machdep_calls {
 	void		(*tce_free)(struct iommu_table *tbl,
 				    long index,
 				    long npages);
+	unsigned long	(*tce_get)(struct iommu_table *tbl,
+				    long index);
 	void		(*tce_flush)(struct iommu_table *tbl);
 	void		(*iommu_dev_setup)(struct pci_dev *dev);
 	void		(*iommu_bus_setup)(struct pci_bus *bus);

--------------000401070901050505010604--
