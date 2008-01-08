Return-Path: <ahuja@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83D50DDEBF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:35:13 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080ZAvw009728
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:35:10 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080ZAXQ499098
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:35:10 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080ZA4k003175
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:35:10 -0500
Message-ID: <4782C53D.4060506@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:35:09 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] pseries: phyp dump: debugging print routines.
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



Provide some basic debugging support.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
Signed-off-by: Linas Vepsts <linas@austin.ibm.com>
-----

 arch/powerpc/platforms/pseries/phyp_dump.c |   53 ++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-01 23:24:10.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-01 23:24:27.000000000 -0600
@@ -2,7 +2,7 @@
  * Hypervisor-assisted dump
  *
  * Linas Vepstas, Manish Ahuja 2007
- * Copyrhgit (c) 2007 IBM Corp.
+ * Copyright (c) 2007 IBM Corp.
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -139,6 +139,51 @@ static unsigned long init_dump_header(st
 	return addr_offset;
 }
 
+#ifdef DEBUG
+static void print_dump_header(const struct phyp_dump_header *ph)
+{
+	printk(KERN_INFO "dump header:\n");
+	/* setup some ph->sections required */
+	printk(KERN_INFO "version = %d\n", ph->version);
+	printk(KERN_INFO "Sections = %d\n", ph->num_of_sections);
+	printk(KERN_INFO "Status = 0x%x\n", ph->status);
+
+	/* No ph->disk, so all should be set to 0 */
+	printk(KERN_INFO "Offset to first section 0x%x\n", ph->first_offset_section);
+	printk(KERN_INFO "dump disk sections should be zero\n");
+	printk(KERN_INFO "dump disk section = %d\n",ph->dump_disk_section);
+	printk(KERN_INFO "block num = %ld\n",ph->block_num_dd);
+	printk(KERN_INFO "number of blocks = %ld\n",ph->num_of_blocks_dd);
+	printk(KERN_INFO "dump disk offset = %d\n",ph->offset_dd);
+	printk(KERN_INFO "Max auto time= %d\n",ph->maxtime_to_auto);
+
+	/*set cpu state and hpte states as well scratch pad area */
+	printk(KERN_INFO " CPU AREA \n");
+	printk(KERN_INFO "cpu dump_flags =%d\n",ph->cpu_data.dump_flags);
+	printk(KERN_INFO "cpu source_type =%d\n",ph->cpu_data.source_type);
+	printk(KERN_INFO "cpu error_flags =%d\n",ph->cpu_data.error_flags);
+	printk(KERN_INFO "cpu source_address =%lx\n",ph->cpu_data.source_address);
+	printk(KERN_INFO "cpu source_length =%lx\n",ph->cpu_data.source_length);
+	printk(KERN_INFO "cpu length_copied =%lx\n",ph->cpu_data.length_copied);
+
+	printk(KERN_INFO " HPTE AREA \n");
+	printk(KERN_INFO "HPTE dump_flags =%d\n",ph->hpte_data.dump_flags);
+	printk(KERN_INFO "HPTE source_type =%d\n",ph->hpte_data.source_type);
+	printk(KERN_INFO "HPTE error_flags =%d\n",ph->hpte_data.error_flags);
+	printk(KERN_INFO "HPTE source_address =%lx\n",ph->hpte_data.source_address);
+	printk(KERN_INFO "HPTE source_length =%lx\n",ph->hpte_data.source_length);
+	printk(KERN_INFO "HPTE length_copied =%lx\n",ph->hpte_data.length_copied);
+
+	printk(KERN_INFO " SRSD AREA \n");
+	printk(KERN_INFO "SRSD dump_flags =%d\n",ph->kernel_data.dump_flags);
+	printk(KERN_INFO "SRSD source_type =%d\n",ph->kernel_data.source_type);
+	printk(KERN_INFO "SRSD error_flags =%d\n",ph->kernel_data.error_flags);
+	printk(KERN_INFO "SRSD source_address =%lx\n",ph->kernel_data.source_address);
+	printk(KERN_INFO "SRSD source_length =%lx\n",ph->kernel_data.source_length);
+	printk(KERN_INFO "SRSD length_copied =%lx\n",ph->kernel_data.length_copied);
+}
+#endif
+
 static void register_dump_area(struct phyp_dump_header *ph, unsigned long addr)
 {
 	int rc;
@@ -154,6 +199,9 @@ static void register_dump_area(struct ph
 	if (rc)
 	{
 		printk (KERN_ERR "phyp-dump: unexpected error (%d) on register\n", rc);
+#ifdef DEBUG
+		print_dump_header (ph);
+#endif
 	}
 }
 
@@ -271,6 +319,9 @@ static int __init phyp_dump_setup(void)
 		release_all();
 		return -ENOSYS;
 	}
+#ifdef DEBUG
+	print_dump_header (dump_header);
+#endif
 
 	/* Is there dump data waiting for us? If there isn't,
 	 * then register a new dump area, and release all of
