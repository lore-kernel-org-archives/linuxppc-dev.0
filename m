Return-Path: <ahuja@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0965DDE99
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:22:01 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080LwTF023713
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:21:58 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080LwA6109368
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:21:58 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080LwRb016850
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:21:58 -0500
Message-ID: <4782C225.3060305@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:21:57 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] pseries: phyp dump: use sysfs to release reserved mem
References: <4782B985.2090508@austin.ibm.com>
In-Reply-To: <4782B985.2090508@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com, lkessler@us.ibm.com,
	strosake@us.ibm.com
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

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

------
 arch/powerpc/platforms/pseries/phyp_dump.c |  101 +++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 5 deletions(-)

Index: linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- linux-2.6.24-rc3-git1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2007-11-21 13:15:05.000000000 -0600
+++ linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/phyp_dump.c	2007-11-21 13:24:30.000000000 -0600
@@ -12,17 +12,24 @@
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
+#include <asm/rtas.h>
 
 /* Global, used to communicate data between early boot and late boot */
 static struct phyp_dump phyp_dump_global;
 struct phyp_dump *phyp_dump_info = &phyp_dump_global;
 
+static int ibm_configure_kernel_dump;
+
+/* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
  * @start_pfn: starting physical frame number
@@ -52,18 +59,102 @@ release_memory_range(unsigned long start
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
+static ssize_t
+store_release_region(struct kset *kset, const char *buf, size_t count)
 {
+	unsigned long start_addr, length, end_addr;
 	unsigned long start_pfn, nr_pages;
+	ssize_t ret;
 
-	/* If no memory was reserved in early boot, there is nothing to do */
-	if (phyp_dump_info->init_reserve_size == 0)
-		return 0;
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
+	release_memory_range (start_pfn, nr_pages);
+
+	return count;
+}
+
+static ssize_t
+show_release_region(struct kset * kset, char *buf)
+{
+	return sprintf(buf, "ola\n");
+}
+
+static struct subsys_attribute rr = __ATTR(release_region, 0600,
+					 show_release_region,
+					 store_release_region);
+
+/* ------------------------------------------------- */
+
+static void release_all (void)
+{
+	unsigned long start_pfn, nr_pages;
 
-	/* Release memory that was reserved in early boot */
+	/* Release all memory that was reserved in early boot */
 	start_pfn = PFN_DOWN(phyp_dump_info->init_reserve_start);
 	nr_pages = PFN_DOWN(phyp_dump_info->init_reserve_size);
 	release_memory_range(start_pfn, nr_pages);
+}
+
+static int __init phyp_dump_setup(void)
+{
+	struct device_node *rtas;
+	const int *dump_header;
+	int header_len = 0;
+	int rc;
+
+	/* If no memory was reserved in early boot, there is nothing to do */
+	if (phyp_dump_info->init_reserve_size == 0)
+		return 0;
+
+	/* Return if phyp dump not supported */
+	ibm_configure_kernel_dump = rtas_token("ibm,configure-kernel-dump");
+	if (ibm_configure_kernel_dump == RTAS_UNKNOWN_SERVICE) {
+		release_all();
+		return -ENOSYS;
+	}
+
+	/* Is there dump data waiting for us? */
+	rtas = of_find_node_by_path("/rtas");
+	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
+	if (dump_header == NULL) {
+		release_all();
+		return 0;
+	}
+
+	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
+	rc = subsys_create_file(&kernel_subsys, &rr);
+	if (rc) {
+		printk (KERN_ERR "phyp-dump: unable to create sysfs file (%d)\n", rc);
+		release_all();
+		return 0;
+	}
 
 	return 0;
 }
