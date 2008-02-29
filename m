Return-Path: <ahuja@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0F28DDE98
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 11:32:23 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1T0YIkI018024
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:34:18 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1T0WJXX311720
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:32:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1T0WJ2W009279
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:32:19 -0500
Message-ID: <47C75292.6000705@austin.ibm.com>
Date: Thu, 28 Feb 2008 18:32:18 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH 6/8] pseries: phyp dump: Invalidate and print dump areas.
References: <47B90F55.2080606@austin.ibm.com>	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com>
In-Reply-To: <47C74A66.1060105@austin.ibm.com>
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


Routines to 
a. invalidate dump 
b. Calculate region that is reserved and needs to be freed. This is 
   exported through sysfs interface.

Unregister has been removed for now as it wasn't being used.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
-----

---
 arch/powerpc/platforms/pseries/phyp_dump.c |   83 ++++++++++++++++++++++++++---
 include/asm-powerpc/phyp_dump.h            |    3 +
 2 files changed, 80 insertions(+), 6 deletions(-)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-28 23:36:45.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-28 23:36:47.000000000 -0600
@@ -71,6 +71,10 @@ static struct phyp_dump_header phdr;
 #define DUMP_SOURCE_CPU 0x0001
 #define DUMP_SOURCE_HPTE 0x0002
 #define DUMP_SOURCE_RMO  0x0011
+#define DUMP_ERROR_FLAG 0x2000
+#define DUMP_TRIGGERED 0x4000
+#define DUMP_PERFORMED 0x8000
+
 
 /**
  * init_dump_header() - initialize the header declaring a dump
@@ -182,9 +186,15 @@ static void print_dump_header(const stru
 static void register_dump_area(struct phyp_dump_header *ph, unsigned long addr)
 {
 	int rc;
-	ph->cpu_data.destination_address += addr;
-	ph->hpte_data.destination_address += addr;
-	ph->kernel_data.destination_address += addr;
+
+	/* Add addr value if not initialized before */
+	if (ph->cpu_data.destination_address == 0) {
+		ph->cpu_data.destination_address += addr;
+		ph->hpte_data.destination_address += addr;
+		ph->kernel_data.destination_address += addr;
+	}
+
+	/* ToDo Invalidate kdump and free memory range. */
 
 	do {
 		rc = rtas_call(ibm_configure_kernel_dump, 3, 1, NULL,
@@ -198,6 +208,30 @@ static void register_dump_area(struct ph
 	}
 }
 
+static
+void invalidate_last_dump(struct phyp_dump_header *ph, unsigned long addr)
+{
+	int rc;
+
+	/* Add addr value if not initialized before */
+	if (ph->cpu_data.destination_address == 0) {
+		ph->cpu_data.destination_address += addr;
+		ph->hpte_data.destination_address += addr;
+		ph->kernel_data.destination_address += addr;
+	}
+
+	do {
+		rc = rtas_call(ibm_configure_kernel_dump, 3, 1, NULL,
+				2, ph, sizeof(struct phyp_dump_header));
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		printk(KERN_ERR "phyp-dump: unexpected error (%d) "
+						"on invalidate\n", rc);
+		print_dump_header(ph);
+	}
+}
+
 /* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
@@ -208,8 +242,8 @@ static void register_dump_area(struct ph
  * lmb_reserved in early boot. The released memory becomes
  * available for genreal use.
  */
-static void
-release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
+static
+void release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct page *rpage;
 	unsigned long end_pfn;
@@ -270,8 +304,29 @@ static ssize_t store_release_region(stru
 	return count;
 }
 
+static ssize_t show_release_region(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	u64 second_addr_range;
+
+	/* total reserved size - start of scratch area */
+	second_addr_range = phyp_dump_info->init_reserve_size -
+				phyp_dump_info->reserved_scratch_size;
+	return sprintf(buf, "CPU:0x%lx-0x%lx: HPTE:0x%lx-0x%lx:"
+			    " DUMP:0x%lx-0x%lx, 0x%lx-0x%lx:\n",
+		phdr.cpu_data.destination_address,
+		phdr.cpu_data.length_copied,
+		phdr.hpte_data.destination_address,
+		phdr.hpte_data.length_copied,
+		phdr.kernel_data.destination_address,
+		phdr.kernel_data.length_copied,
+		phyp_dump_info->init_reserve_start,
+		second_addr_range);
+}
+
 static struct kobj_attribute rr = __ATTR(release_region, 0600,
-					 NULL, store_release_region);
+					show_release_region,
+					store_release_region);
 
 static int __init phyp_dump_setup(void)
 {
@@ -314,6 +369,22 @@ static int __init phyp_dump_setup(void)
 		return 0;
 	}
 
+	/* re-register the dump area, if old dump was invalid */
+	if ((dump_header) && (dump_header->status & DUMP_ERROR_FLAG)) {
+		invalidate_last_dump(&phdr, dump_area_start);
+		register_dump_area(&phdr, dump_area_start);
+		return 0;
+	}
+
+	if (dump_header) {
+		phyp_dump_info->reserved_scratch_addr =
+				dump_header->cpu_data.destination_address;
+		phyp_dump_info->reserved_scratch_size =
+				dump_header->cpu_data.source_length +
+				dump_header->hpte_data.source_length +
+				dump_header->kernel_data.source_length;
+	}
+
 	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
 	rc = sysfs_create_file(kernel_kobj, &rr.attr);
 	if (rc)
Index: 2.6.25-rc1/include/asm-powerpc/phyp_dump.h
===================================================================
--- 2.6.25-rc1.orig/include/asm-powerpc/phyp_dump.h	2008-02-28 22:05:25.000000000 -0600
+++ 2.6.25-rc1/include/asm-powerpc/phyp_dump.h	2008-02-28 23:36:47.000000000 -0600
@@ -30,6 +30,9 @@ struct phyp_dump {
 	/* store cpu & hpte size */
 	unsigned long cpu_state_size;
 	unsigned long hpte_region_size;
+	/* previous scratch area values */
+	unsigned long reserved_scratch_addr;
+	unsigned long reserved_scratch_size;
 };
 
 extern struct phyp_dump *phyp_dump_info;
