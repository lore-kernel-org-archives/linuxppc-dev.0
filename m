Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF77EDDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:15:51 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MKFmDF019650
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 15:15:48 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MKFjIS1056822
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 15:15:45 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MKFjfr014601
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 13:15:45 -0700
Message-ID: <47964EEE.6080309@austin.ibm.com>
Date: Tue, 22 Jan 2008 14:15:42 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	linasvepstas@gmail.com
Subject: [PATCH 4/8] pseries: phyp dump: register dump area.
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


Set up the actual dump header, register it with the hypervisor.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

------
 arch/powerpc/platforms/pseries/phyp_dump.c |  136 +++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 7 deletions(-)

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-18 22:43:00.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 23:49:23.000000000 -0600
@@ -30,6 +30,117 @@ struct phyp_dump *phyp_dump_info = &phyp
 static int ibm_configure_kernel_dump;
 
 /* ------------------------------------------------- */
+/* RTAS interfaces to declare the dump regions */
+
+struct dump_section {
+	u32 dump_flags;
+	u16 source_type;
+	u16 error_flags;
+	u64 source_address;
+	u64 source_length;
+	u64 length_copied;
+	u64 destination_address;
+};
+
+struct phyp_dump_header {
+	u32 version;
+	u16 num_of_sections;
+	u16 status;
+
+	u32 first_offset_section;
+	u32 dump_disk_section;
+	u64 block_num_dd;
+	u64 num_of_blocks_dd;
+	u32 offset_dd;
+	u32 maxtime_to_auto;
+	/* No dump disk path string used */
+
+	struct dump_section cpu_data;
+	struct dump_section hpte_data;
+	struct dump_section kernel_data;
+};
+
+/* The dump header *must be* in low memory, so .bss it */
+static struct phyp_dump_header phdr;
+
+#define NUM_DUMP_SECTIONS 3
+#define DUMP_HEADER_VERSION 0x1
+#define DUMP_REQUEST_FLAG 0x1
+#define DUMP_SOURCE_CPU 0x0001
+#define DUMP_SOURCE_HPTE 0x0002
+#define DUMP_SOURCE_RMO  0x0011
+
+/**
+ * init_dump_header() - initialize the header declaring a dump
+ * Returns: length of dump save area.
+ *
+ * When the hypervisor saves crashed state, it needs to put
+ * it somewhere. The dump header tells the hypervisor where
+ * the data can be saved.
+ */
+static unsigned long init_dump_header(struct phyp_dump_header *ph)
+{
+	unsigned long addr_offset = 0;
+
+	/* Set up the dump header */
+	ph->version = DUMP_HEADER_VERSION;
+	ph->num_of_sections = NUM_DUMP_SECTIONS;
+	ph->status = 0;
+
+	ph->first_offset_section =
+		(u32)offsetof(struct phyp_dump_header, cpu_data);
+	ph->dump_disk_section = 0;
+	ph->block_num_dd = 0;
+	ph->num_of_blocks_dd = 0;
+	ph->offset_dd = 0;
+
+	ph->maxtime_to_auto = 0; /* disabled */
+
+	/* The first two sections are mandatory */
+	ph->cpu_data.dump_flags = DUMP_REQUEST_FLAG;
+	ph->cpu_data.source_type = DUMP_SOURCE_CPU;
+	ph->cpu_data.source_address = 0;
+	ph->cpu_data.source_length = phyp_dump_info->cpu_state_size;
+	ph->cpu_data.destination_address = addr_offset;
+	addr_offset += phyp_dump_info->cpu_state_size;
+
+	ph->hpte_data.dump_flags = DUMP_REQUEST_FLAG;
+	ph->hpte_data.source_type = DUMP_SOURCE_HPTE;
+	ph->hpte_data.source_address = 0;
+	ph->hpte_data.source_length = phyp_dump_info->hpte_region_size;
+	ph->hpte_data.destination_address = addr_offset;
+	addr_offset += phyp_dump_info->hpte_region_size;
+
+	/* This section describes the low kernel region */
+	ph->kernel_data.dump_flags = DUMP_REQUEST_FLAG;
+	ph->kernel_data.source_type = DUMP_SOURCE_RMO;
+	ph->kernel_data.source_address = PHYP_DUMP_RMR_START;
+	ph->kernel_data.source_length = PHYP_DUMP_RMR_END;
+	ph->kernel_data.destination_address = addr_offset;
+	addr_offset += ph->kernel_data.source_length;
+
+	return addr_offset;
+}
+
+static void register_dump_area(struct phyp_dump_header *ph, unsigned long addr)
+{
+	int rc;
+	ph->cpu_data.destination_address += addr;
+	ph->hpte_data.destination_address += addr;
+	ph->kernel_data.destination_address += addr;
+
+	do {
+		rc = rtas_call(ibm_configure_kernel_dump, 3, 1, NULL,
+		               1, ph, sizeof(struct phyp_dump_header));
+	} while (rtas_busy_delay(rc));
+
+	if (rc)
+	{
+		printk (KERN_ERR "phyp-dump: unexpected error (%d) on register\n", rc);
+	}
+}
+
+/* ------------------------------------------------- */
 /**
  * release_memory_range -- release memory previously lmb_reserved
  * @start_pfn: starting physical frame number
@@ -125,7 +236,9 @@ static void release_all (void)
 static int __init phyp_dump_setup(void)
 {
 	struct device_node *rtas;
-	const int *dump_header;
+	const struct phyp_dump_header *dump_header;
+	unsigned long dump_area_start;
+	unsigned long dump_area_length;
 	int header_len = 0;
 	int rc;
 
@@ -140,22 +253,31 @@ static int __init phyp_dump_setup(void)
 		return -ENOSYS;
 	}
 
-	/* Is there dump data waiting for us? */
+	/* Is there dump data waiting for us? If there isn't,
+	 * then register a new dump area, and release all of
+	 * the rest of the reserved ram.
+	 *
+	 * The /rtas/ibm,kernel-dump rtas node is present only
+	 * if there is dump data waiting for us.
+	 */
 	rtas = of_find_node_by_path("/rtas");
 	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
+	of_node_put(rtas);
+
+	dump_area_length = init_dump_header(&phdr);
+	dump_area_start = phyp_dump_info->init_reserve_start & PAGE_MASK; /* align down */
+
 	if (dump_header == NULL) {
-		release_all();
+		register_dump_area(&phdr, dump_area_start);
 		return 0;
 	}
 
 	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
 	rc = subsys_create_file(&kernel_subsys, &rr);
-	if (rc) {
+	if (rc)
 		printk (KERN_ERR "phyp-dump: unable to create sysfs file (%d)\n", rc);
-		release_all();
-		return 0;
-	}
 
+	/* ToDo: re-register the dump area, for next time. */
 	return 0;
 }
 subsys_initcall(phyp_dump_setup);
