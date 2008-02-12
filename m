Return-Path: <ahuja@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58DAFDDF12
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 18:18:27 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1C7IOuB001189
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:18:24 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1C7IO6n178452
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 00:18:24 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1C7IO0i030452
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 00:18:24 -0700
Message-ID: <47B1483E.8040303@austin.ibm.com>
Date: Tue, 12 Feb 2008 01:18:22 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH 6/8] pseries: phyp dump: Invalidate and print dump areas.
References: <4782B985.2090508@austin.ibm.com> <47B13D2E.1070001@austin.ibm.com>
In-Reply-To: <47B13D2E.1070001@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
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
 arch/powerpc/platforms/pseries/phyp_dump.c |   85 +++++++++++++++++++++++++----
 include/asm/phyp_dump.h                    |    6 +-
 2 files changed, 79 insertions(+), 12 deletions(-)

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-12 06:13:06.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-12 06:13:17.000000000 -0600
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
@@ -195,6 +205,30 @@ static void register_dump_area(struct ph
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
 /* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
@@ -205,8 +239,8 @@ static void register_dump_area(struct ph
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
@@ -237,8 +271,8 @@ release_memory_range(unsigned long start
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
@@ -266,10 +300,23 @@ store_release_region(struct kset *kset, 
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
@@ -293,7 +340,6 @@ static int __init phyp_dump_setup(void)
 	if (!phyp_dump_info->phyp_dump_configured) {
 		return -ENOSYS;
 	}
-	print_dump_header(dump_header);
 
 	/* Is there dump data waiting for us? If there isn't,
 	 * then register a new dump area, and release all of
@@ -305,6 +351,7 @@ static int __init phyp_dump_setup(void)
 	rtas = of_find_node_by_path("/rtas");
 	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
 	of_node_put(rtas);
+	print_dump_header(dump_header);
 
 	dump_area_length = init_dump_header(&phdr);
 	dump_area_start = phyp_dump_info->init_reserve_start & PAGE_MASK; /* align down */
@@ -314,6 +361,22 @@ static int __init phyp_dump_setup(void)
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
--- 2.6.24-rc5.orig/include/asm/phyp_dump.h	2008-02-12 06:12:37.000000000 -0600
+++ 2.6.24-rc5/include/asm/phyp_dump.h	2008-02-12 06:13:17.000000000 -0600
@@ -18,7 +18,8 @@
 /* The RMR region will be saved for later dumping
  * whenever the kernel crashes. Set this to 256MB. */
 #define PHYP_DUMP_RMR_START 0x0
-#define PHYP_DUMP_RMR_END   (1UL<<28)
+/*#define PHYP_DUMP_RMR_END   (1UL<<28)*/
+#define PHYP_DUMP_RMR_END   (1UL<<27)
 
 struct phyp_dump {
 	/* Memory that is reserved during very early boot. */
@@ -30,6 +31,9 @@ struct phyp_dump {
 	/* store cpu & hpte size */
 	unsigned long cpu_state_size;
 	unsigned long hpte_region_size;
+	/* previous scratch area values */
+	unsigned long reserved_scratch_addr;
+	unsigned long reserved_scratch_size;
 };
 
 extern struct phyp_dump *phyp_dump_info;
