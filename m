Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0933DDDD5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:45:52 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALMjoCw024195
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 17:45:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALMjn6a073396
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:45:49 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALMjnsr019469
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:45:49 -0700
Date: Wed, 21 Nov 2007 16:45:49 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC 6/6]: phyp dump: debugging print routines.
Message-ID: <20071121224549.GF26122@austin.ibm.com>
References: <20071121223639.GB4374@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071121223639.GB4374@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: mahuja@us.ibm.com, lkessler@us.ibm.com, strosake@us.ibm.com
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

 arch/powerpc/platforms/pseries/phyp_dump.c |   51 +++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

Index: linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- linux-2.6.24-rc3-git1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2007-11-21 16:12:21.000000000 -0600
+++ linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/phyp_dump.c	2007-11-21 16:12:46.000000000 -0600
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
 
@@ -292,6 +340,9 @@ static int __init phyp_dump_setup(void)
 		register_dump_area (&phdr, dump_area_start);
 		goto release_mem;
 	}
+#ifdef DEBUG
+	print_dump_header (dump_header);
+#endif
 
 	/* Don't allow user to release the 256MB scratch area */
 	phyp_dump_info->init_reserve_size = free_area_length;
