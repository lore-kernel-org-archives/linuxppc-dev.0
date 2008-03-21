Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67A46DDEF2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 10:39:21 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2LNdIaW020837
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:39:18 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2LNdIJ1277322
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:39:18 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2LNdIUE024689
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:39:18 -0400
Message-ID: <47E44725.4020608@austin.ibm.com>
Date: Fri, 21 Mar 2008 18:39:17 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
References: <47E439C3.6050904@austin.ibm.com>
In-Reply-To: <47E439C3.6050904@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Check to see if there actually is data from a previously
crashed kernel waiting. If so, Allow user-sapce tools to
grab the data (by reading /proc/kcore). When user-space 
finishes dumping a section, it must release that memory
by writing to sysfs. For example,

  echo "0x40000000 0x10000000" > /sys/kernel/release_region

will release 256MB starting at the 1GB.  The released memory
becomes free for general use.

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

---
 arch/powerpc/platforms/pseries/phyp_dump.c |   81 +++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-03-21 00:10:15.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-03-21 22:39:21.000000000 -0500
@@ -12,19 +12,24 @@
  */
 
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
+#include <linux/of.h>
 #include <linux/pfn.h>
 #include <linux/swap.h>
+#include <linux/sysfs.h>
 
 #include <asm/page.h>
 #include <asm/phyp_dump.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
+#include <asm/rtas.h>
 
 /* Variables, used to communicate data between early boot and late boot */
 static struct phyp_dump phyp_dump_vars;
 struct phyp_dump *phyp_dump_info = &phyp_dump_vars;
 
+/* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
  * @start_pfn: starting physical frame number
@@ -54,18 +59,84 @@ release_memory_range(unsigned long start
 	}
 }
 
-static int __init phyp_dump_setup(void)
+/* ------------------------------------------------- */
+/**
+ * sysfs_release_region -- sysfs interface to release memory range.
+ *
+ * Usage:
+ *   "echo <start addr> <length> > /sys/kernel/release_region"
+ *
+ * Example:
+ *   "echo 0x40000000 0x10000000 > /sys/kernel/release_region"
+ *
+ * will release 256MB starting at 1GB.
+ */
+static ssize_t store_release_region(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
 {
+	unsigned long start_addr, length, end_addr;
 	unsigned long start_pfn, nr_pages;
+	ssize_t ret;
+
+	ret = sscanf(buf, "%lx %lx", &start_addr, &length);
+	if (ret != 2)
+		return -EINVAL;
+
+	/* Range-check - don't free any reserved memory that
+	 * wasn't reserved for phyp-dump */
+	if (start_addr < phyp_dump_info->init_reserve_start)
+		start_addr = phyp_dump_info->init_reserve_start;
+
+	end_addr = phyp_dump_info->init_reserve_start +
+			phyp_dump_info->init_reserve_size;
+	if (start_addr+length > end_addr)
+		length = end_addr - start_addr;
+
+	/* Release the region of memory assed in by user */
+	start_pfn = PFN_DOWN(start_addr);
+	nr_pages = PFN_DOWN(length);
+	release_memory_range(start_pfn, nr_pages);
+
+	return count;
+}
+
+static struct kobj_attribute rr = __ATTR(release_region, 0600,
+					 NULL, store_release_region);
+
+static int __init phyp_dump_setup(void)
+{
+	struct device_node *rtas;
+	const int *dump_header = NULL;
+	int header_len = 0;
+	int rc;
 
 	/* If no memory was reserved in early boot, there is nothing to do */
 	if (phyp_dump_info->init_reserve_size == 0)
 		return 0;
 
-	/* Release memory that was reserved in early boot */
-	start_pfn = PFN_DOWN(phyp_dump_info->init_reserve_start);
-	nr_pages = PFN_DOWN(phyp_dump_info->init_reserve_size);
-	release_memory_range(start_pfn, nr_pages);
+	/* Return if phyp dump not supported */
+	if (!phyp_dump_info->phyp_dump_configured)
+		return -ENOSYS;
+
+	/* Is there dump data waiting for us? */
+	rtas = of_find_node_by_path("/rtas");
+	if (rtas) {
+		dump_header = of_get_property(rtas, "ibm,kernel-dump",
+						&header_len);
+		of_node_put(rtas);
+	}
+
+	if (dump_header == NULL)
+		return 0;
+
+	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
+	rc = sysfs_create_file(kernel_kobj, &rr.attr);
+	if (rc) {
+		printk(KERN_ERR "phyp-dump: unable to create sysfs file (%d)\n",
+									rc);
+		return 0;
+	}
 
 	return 0;
 }
