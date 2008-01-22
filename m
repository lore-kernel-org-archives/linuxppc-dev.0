Return-Path: <ahuja@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A11CDDF49
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:02:49 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MJxZ5Y015196
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:59:35 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0ML2kaT100248
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:02:46 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0ML2j0E024177
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:02:45 -0700
Message-ID: <479659F3.3010702@austin.ibm.com>
Date: Tue, 22 Jan 2008 15:02:43 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
Subject: [PATCH 5/8] pseries: phyp dump: debugging print routines.
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


Provide some basic debugging support.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
-----

 arch/powerpc/platforms/pseries/phyp_dump.c |   64 +++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 02:51:54.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 02:58:41.000000000 -0600
@@ -2,7 +2,7 @@
  * Hypervisor-assisted dump
  *
  * Linas Vepstas, Manish Ahuja 2007
- * Copyrhgit (c) 2007 IBM Corp.
+ * Copyright (c) 2007 IBM Corp.
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
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
@@ -134,9 +189,9 @@ static void register_dump_area(struct ph
 		               1, ph, sizeof(struct phyp_dump_header));
 	} while (rtas_busy_delay(rc));
 
-	if (rc)
-	{
-		printk (KERN_ERR "phyp-dump: unexpected error (%d) on register\n", rc);
+	if (rc) {
+		printk(KERN_ERR "phyp-dump: unexpected error (%d) on register\n", rc);
+		print_dump_header(ph);
 	}
 }
 
@@ -249,6 +304,7 @@ static int __init phyp_dump_setup(void)
 		release_all();
 		return -ENOSYS;
 	}
+	print_dump_header(dump_header);
 
 	/* Is there dump data waiting for us? If there isn't,
 	 * then register a new dump area, and release all of
