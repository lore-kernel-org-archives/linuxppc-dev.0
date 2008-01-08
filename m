Return-Path: <ahuja@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6DA0FDDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:37:36 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080dMhD010509
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:39:22 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080bXLI440930
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:37:33 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080bWpp012353
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:37:32 -0500
Message-ID: <4782C5CB.4080802@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:37:31 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] pseries: phyp dump: Unregister and print dump areas.
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


Routines to invalidate and unregister dump routines. 
Unregister has not been used yet, I will release another
patch for that at a later stage with the kdump integration patches.

There is also a routine which calculates the regions to be
freed and exports that through sysfs.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

---
 arch/powerpc/platforms/pseries/phyp_dump.c |   79 ++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-07 18:06:11.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-07 22:57:27.000000000 -0600
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
@@ -187,10 +191,15 @@ static void print_dump_header(const stru
 static void register_dump_area(struct phyp_dump_header *ph, unsigned long addr)
 {
 	int rc;
-	ph->cpu_data.destination_address += addr;
-	ph->hpte_data.destination_address += addr;
-	ph->kernel_data.destination_address += addr;
 
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
 		               1, ph, sizeof(struct phyp_dump_header));
@@ -205,6 +214,49 @@ static void register_dump_area(struct ph
 	}
 }
 
+static void invalidate_last_dump(struct phyp_dump_header *ph, unsigned long addr)
+{
+	int rc;
+
+	/* Add addr value if not initialized before */
+	if (ph->cpu_data.destination_address == 0) {
+		ph->cpu_data.destination_address = addr;
+		ph->hpte_data.destination_address += addr;
+		ph->kernel_data.destination_address += addr;
+	}
+
+	do {
+		rc = rtas_call(ibm_configure_kernel_dump, 3, 1, NULL,
+		               2, ph, sizeof(struct phyp_dump_header));
+	} while (rtas_busy_delay(rc));
+
+	if (rc)
+	{
+		printk (KERN_ERR "phyp-dump: unexpected error (%d) on invalidate\n", rc);
+#ifdef DEBUG
+		print_dump_header (ph);
+#endif
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
+	if (rc)
+	{
+		printk (KERN_ERR "phyp-dump: unexpected error (%d) on unregister\n", rc);
+#ifdef DEBUG
+		print_dump_header (ph);
+#endif
+	}
+}
+
 /* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
@@ -279,7 +331,17 @@ store_release_region(struct kset *kset, 
 static ssize_t
 show_release_region(struct kset * kset, char *buf)
 {
-	return sprintf(buf, "ola\n");
+	u64 second_addr_range;
+
+	/* total reserved size - start of scratch area */
+	second_addr_range = phdr.cpu_data.destination_address -
+				phyp_dump_info->init_reserve_size;
+	return sprintf(buf, "CPU:0x%lx-0x%lx: HPTE:0x%lx-0x%lx:"
+			    " DUMP:0x%lx-0x%lx, 0x%lx-0x%lx:\n",
+	  phdr.cpu_data.destination_address, phdr.cpu_data.length_copied,
+	  phdr.hpte_data.destination_address, phdr.hpte_data.length_copied,
+	  phdr.kernel_data.destination_address, phdr.kernel_data.length_copied,
+	  phyp_dump_info->init_reserve_start, second_addr_range);
 }
 
 static struct subsys_attribute rr = __ATTR(release_region, 0600,
@@ -344,6 +406,13 @@ static int __init phyp_dump_setup(void)
 		goto release_mem;
 	}
 
+	/* re-register the dump area, if old dump was invalid */
+	if ((dump_header) && (dump_header->status & DUMP_ERROR_FLAG)) {
+		invalidate_last_dump (&phdr, dump_area_start);
+		register_dump_area (&phdr, dump_area_start);
+		goto release_mem;
+	}
+
 	/* Don't allow user to release the 256MB scratch area */
 	phyp_dump_info->init_reserve_size = free_area_length;
 
@@ -354,8 +423,6 @@ static int __init phyp_dump_setup(void)
 		goto release_mem;
 	}
 
-	/* ToDo: re-register the dump area, for next time. */
-
 	return 0;
 
 release_mem:
