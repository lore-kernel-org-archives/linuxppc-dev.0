Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36AEBDDECB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:05:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0ML5Cpv031485
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:05:12 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0ML5CHw161836
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:05:12 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0ML5C5l012053
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:05:12 -0500
Message-ID: <47965A85.3000808@austin.ibm.com>
Date: Tue, 22 Jan 2008 15:05:09 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
Subject: [PATCH 6/8] pseries: phyp dump: Unregister and print dump areas.
References: <4796401D.5010907@austin.ibm.com>
In-Reply-To: <4796401D.5010907@austin.ibm.com>
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


Routines to invalidate and unregister dump routines. 
Unregister has not been used yet, I will release another
patch for that at a later stage with the kdump integration patches.

There is also a routine which calculates the regions to be
freed and exports that through sysfs.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
-----

---
 arch/powerpc/platforms/pseries/phyp_dump.c |  101 +++++++++++++++++++++++++----
 include/asm/phyp_dump.h                    |    3 
 2 files changed, 93 insertions(+), 11 deletions(-)

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 23:06:20.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 23:49:10.000000000 -0600
@@ -69,6 +69,10 @@ static struct phyp_dump_header phdr;
 #define DUMP_SOURCE_CPU 0x0001
 #define DUMP_SOURCE_HPTE 0x0002
 #define DUMP_SOURCE_RMO  0x0011
+#define DUMP_ERROR_FLAG 0x2000
+#define DUMP_TRIGGERED 0x4000
+#define DUMP_PERFORMED 0x8000
+
 
 /**
  * init_dump_header() - initialize the header declaring a dump
@@ -180,9 +184,15 @@ static void print_dump_header(const stru
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
@@ -195,6 +205,46 @@ static void register_dump_area(struct ph
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
+		               2, ph, sizeof(struct phyp_dump_header));
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		printk (KERN_ERR "phyp-dump: unexpected error (%d) "
+						"on invalidate\n", rc);
+		print_dump_header(ph);
+	}
+}
+
+static void unregister_dump_area(struct phyp_dump_header *ph)
+{
+	int rc;
+
+	do {
+		rc = rtas_call(ibm_configure_kernel_dump, 3, 1, NULL,
+		               3, ph, sizeof(struct phyp_dump_header));
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		printk (KERN_ERR "phyp-dump: unexpected error (%d) "
+						"on unregister\n", rc);
+		print_dump_header(ph);
+	}
+}
+
 /* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
@@ -205,8 +255,8 @@ static void register_dump_area(struct ph
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
@@ -237,8 +287,8 @@ release_memory_range(unsigned long start
  *
  * will release 256MB starting at 1GB.
  */
-static ssize_t
-store_release_region(struct kset *kset, const char *buf, size_t count)
+static
+ssize_t store_release_region(struct kset *kset, const char *buf, size_t count)
 {
 	unsigned long start_addr, length, end_addr;
 	unsigned long start_pfn, nr_pages;
@@ -266,10 +316,23 @@ store_release_region(struct kset *kset, 
 	return count;
 }
 
-static ssize_t
-show_release_region(struct kset * kset, char *buf)
+static ssize_t show_release_region(struct kset * kset, char *buf)
 {
-	return sprintf(buf, "ola\n");
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
 }
 
 static struct subsys_attribute rr = __ATTR(release_region, 0600,
@@ -307,7 +370,6 @@ static int __init phyp_dump_setup(void)
 		release_all();
 		return -ENOSYS;
 	}
-	print_dump_header(dump_header);
 
 	/* Is there dump data waiting for us? If there isn't,
 	 * then register a new dump area, and release all of
@@ -319,6 +381,7 @@ static int __init phyp_dump_setup(void)
 	rtas = of_find_node_by_path("/rtas");
 	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
 	of_node_put(rtas);
+	print_dump_header(dump_header);
 
 	dump_area_length = init_dump_header(&phdr);
 	dump_area_start = phyp_dump_info->init_reserve_start & PAGE_MASK; /* align down */
@@ -328,6 +391,22 @@ static int __init phyp_dump_setup(void)
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
 	rc = subsys_create_file(&kernel_subsys, &rr);
 	if (rc)
Index: 2.6.24-rc5/include/asm/phyp_dump.h
===================================================================
--- 2.6.24-rc5.orig/include/asm/phyp_dump.h	2008-01-21 22:21:01.000000000 -0600
+++ 2.6.24-rc5/include/asm/phyp_dump.h	2008-01-21 23:29:05.000000000 -0600
@@ -29,6 +29,9 @@ struct phyp_dump {
 	/* store cpu & hpte size */
 	unsigned long cpu_state_size;
 	unsigned long hpte_region_size;
+	/* previous scratch area values */
+	unsigned long reserved_scratch_addr;
+	unsigned long reserved_scratch_size;
 };
 
 extern struct phyp_dump *phyp_dump_info;
