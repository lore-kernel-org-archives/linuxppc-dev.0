Return-Path: <ahuja@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38A27DDED3
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 16:41:29 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1I5hLoi019964
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:43:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1I5fPHo238820
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:41:25 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1I5fPCk025924
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:41:25 -0500
Message-ID: <47B91A83.6070503@austin.ibm.com>
Date: Sun, 17 Feb 2008 23:41:23 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 5/8] pseries: phyp dump: debugging print routines.
References: <47B90F55.2080606@austin.ibm.com>
In-Reply-To: <47B90F55.2080606@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Provide some basic debugging support.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
-----

 arch/powerpc/platforms/pseries/phyp_dump.c |   61 ++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-18 03:30:53.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-18 04:25:19.000000000 -0600
@@ -122,6 +122,61 @@ static unsigned long init_dump_header(st
 	return addr_offset;
 }
 
+static void print_dump_header(const struct phyp_dump_header *ph)
+{
+#ifdef DEBUG
+	printk(KERN_INFO "dump header:\n");
+	/* setup some ph->sections required */
+	printk(KERN_INFO "version = %d\n", ph->version);
+	printk(KERN_INFO "Sections = %d\n", ph->num_of_sections);
+	printk(KERN_INFO "Status = 0x%x\n", ph->status);
+
+	/* No ph->disk, so all should be set to 0 */
+	printk(KERN_INFO "Offset to first section 0x%x\n",
+						ph->first_offset_section);
+	printk(KERN_INFO "dump disk sections should be zero\n");
+	printk(KERN_INFO "dump disk section = %d\n", ph->dump_disk_section);
+	printk(KERN_INFO "block num = %ld\n", ph->block_num_dd);
+	printk(KERN_INFO "number of blocks = %ld\n", ph->num_of_blocks_dd);
+	printk(KERN_INFO "dump disk offset = %d\n", ph->offset_dd);
+	printk(KERN_INFO "Max auto time= %d\n", ph->maxtime_to_auto);
+
+	/*set cpu state and hpte states as well scratch pad area */
+	printk(KERN_INFO " CPU AREA \n");
+	printk(KERN_INFO "cpu dump_flags =%d\n", ph->cpu_data.dump_flags);
+	printk(KERN_INFO "cpu source_type =%d\n", ph->cpu_data.source_type);
+	printk(KERN_INFO "cpu error_flags =%d\n", ph->cpu_data.error_flags);
+	printk(KERN_INFO "cpu source_address =%lx\n",
+						ph->cpu_data.source_address);
+	printk(KERN_INFO "cpu source_length =%lx\n",
+						ph->cpu_data.source_length);
+	printk(KERN_INFO "cpu length_copied =%lx\n",
+						ph->cpu_data.length_copied);
+
+	printk(KERN_INFO " HPTE AREA \n");
+	printk(KERN_INFO "HPTE dump_flags =%d\n", ph->hpte_data.dump_flags);
+	printk(KERN_INFO "HPTE source_type =%d\n", ph->hpte_data.source_type);
+	printk(KERN_INFO "HPTE error_flags =%d\n", ph->hpte_data.error_flags);
+	printk(KERN_INFO "HPTE source_address =%lx\n",
+						ph->hpte_data.source_address);
+	printk(KERN_INFO "HPTE source_length =%lx\n",
+						ph->hpte_data.source_length);
+	printk(KERN_INFO "HPTE length_copied =%lx\n",
+						ph->hpte_data.length_copied);
+
+	printk(KERN_INFO " SRSD AREA \n");
+	printk(KERN_INFO "SRSD dump_flags =%d\n", ph->kernel_data.dump_flags);
+	printk(KERN_INFO "SRSD source_type =%d\n", ph->kernel_data.source_type);
+	printk(KERN_INFO "SRSD error_flags =%d\n", ph->kernel_data.error_flags);
+	printk(KERN_INFO "SRSD source_address =%lx\n",
+						ph->kernel_data.source_address);
+	printk(KERN_INFO "SRSD source_length =%lx\n",
+						ph->kernel_data.source_length);
+	printk(KERN_INFO "SRSD length_copied =%lx\n",
+						ph->kernel_data.length_copied);
+#endif
+}
+
 static void register_dump_area(struct phyp_dump_header *ph, unsigned long addr)
 {
 	int rc;
@@ -134,9 +189,11 @@ static void register_dump_area(struct ph
 				1, ph, sizeof(struct phyp_dump_header));
 	} while (rtas_busy_delay(rc));
 
-	if (rc)
+	if (rc) {
 		printk(KERN_ERR "phyp-dump: unexpected error (%d) on "
 						"register\n", rc);
+		print_dump_header(ph);
+	}
 }
 
 /* ------------------------------------------------- */
@@ -245,8 +302,8 @@ static int __init phyp_dump_setup(void)
 		of_node_put(rtas);
 	}
 
+	print_dump_header(dump_header);
 	dump_area_length = init_dump_header(&phdr);
-
 	/* align down */
 	dump_area_start = phyp_dump_info->init_reserve_start & PAGE_MASK;
 
