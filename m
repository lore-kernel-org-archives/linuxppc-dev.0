Return-Path: <haren@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AE8167B5F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 14:03:08 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5F431L6004517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 00:03:01 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5F437IN117294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 22:03:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5F431PK022339
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 22:03:01 -0600
Message-ID: <4490DBB7.7000500@us.ibm.com>
Date: Wed, 14 Jun 2006 21:01:59 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH] powerpc: kdump:  Reserve the existing TCE mappings left by
	the first kernel
Content-Type: multipart/mixed; boundary="------------040202000904050305090205"
Cc: linuxppc-dev@ozlabs.org, Milton Miller II <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040202000904050305090205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Olof,
    Posting the modified patch based on your suggestion of reserving 
in-use TCE entries and use only available ones in the kdump boot. Please 
let me know your comments.

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
to the driver bug that does continuous mapping. This patch will make 
sure that minimum of 10 entries will be available such that kdump boot 
could be successful in some cases.

Signed-off-by: Haren Myneni <haren@us.ibm.com>




--------------040202000904050305090205
Content-Type: text/x-patch;
 name="ppc64-kdump-checkstop-DMA-fault-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-kdump-checkstop-DMA-fault-fix.patch"

diff -Naurp 2617-rc6-git5.orig/arch/powerpc/kernel/iommu.c 2617-rc6-git5/arch/powerpc/kernel/iommu.c
--- 2617-rc6-git5.orig/arch/powerpc/kernel/iommu.c	2006-06-13 19:46:43.000000000 -0700
+++ 2617-rc6-git5/arch/powerpc/kernel/iommu.c	2006-06-14 20:50:33.000000000 -0700
@@ -38,6 +38,7 @@
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
+#include <asm/kdump.h>
 
 #define DBG(...)
 
@@ -439,8 +440,36 @@ struct iommu_table *iommu_init_table(str
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
+			for (index = 0; index < KDUMP_MIN_TCE_ENTRIES; index++)
+				__clear_bit(index, tbl->it_map);
+		}
+	}
+#else
 	/* Clear the hardware table in case firmware left allocations in it */
 	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
+#endif
 
 	if (!welcomed) {
 		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
diff -Naurp 2617-rc6-git5.orig/arch/powerpc/platforms/pseries/iommu.c 2617-rc6-git5/arch/powerpc/platforms/pseries/iommu.c
--- 2617-rc6-git5.orig/arch/powerpc/platforms/pseries/iommu.c	2006-06-13 19:46:38.000000000 -0700
+++ 2617-rc6-git5/arch/powerpc/platforms/pseries/iommu.c	2006-06-13 19:48:51.000000000 -0700
@@ -97,6 +97,14 @@ static void tce_free_pSeries(struct iomm
 	}
 }
 
+static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
+{
+	union tce_entry *tp;
+
+	index <<= TCE_PAGE_FACTOR;
+	tp  = ((union tce_entry *)tbl->it_base) + index;
+	return tp->te_word;
+}
 
 static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
@@ -253,6 +261,25 @@ static void tce_freemulti_pSeriesLP(stru
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
@@ -272,7 +299,10 @@ static void iommu_table_setparms(struct 
 	}
 
 	tbl->it_base = (unsigned long)__va(*basep);
+
+#ifndef CONFIG_CRASH_DUMP
 	memset((void *)tbl->it_base, 0, *sizep);
+#endif
 
 	tbl->it_busno = phb->bus->number;
 	
@@ -588,11 +618,13 @@ void iommu_init_early_pSeries(void)
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
diff -Naurp 2617-rc6-git5.orig/include/asm-powerpc/kdump.h 2617-rc6-git5/include/asm-powerpc/kdump.h
--- 2617-rc6-git5.orig/include/asm-powerpc/kdump.h	2006-06-13 19:47:27.000000000 -0700
+++ 2617-rc6-git5/include/asm-powerpc/kdump.h	2006-06-13 19:48:15.000000000 -0700
@@ -8,6 +8,8 @@
 #define KDUMP_TRAMPOLINE_START	0x0100
 #define KDUMP_TRAMPOLINE_END	0x3000
 
+#define KDUMP_MIN_TCE_ENTRIES	10
+
 extern void kdump_setup(void);
 
 #endif /* __PPC64_KDUMP_H */
diff -Naurp 2617-rc6-git5.orig/include/asm-powerpc/machdep.h 2617-rc6-git5/include/asm-powerpc/machdep.h
--- 2617-rc6-git5.orig/include/asm-powerpc/machdep.h	2006-06-13 19:47:15.000000000 -0700
+++ 2617-rc6-git5/include/asm-powerpc/machdep.h	2006-06-13 19:48:02.000000000 -0700
@@ -82,6 +82,8 @@ struct machdep_calls {
 	void		(*tce_free)(struct iommu_table *tbl,
 				    long index,
 				    long npages);
+	unsigned long	(*tce_get)(struct iommu_table *tbl,
+				    long index);
 	void		(*tce_flush)(struct iommu_table *tbl);
 	void		(*iommu_dev_setup)(struct pci_dev *dev);
 	void		(*iommu_bus_setup)(struct pci_bus *bus);

--------------040202000904050305090205--
