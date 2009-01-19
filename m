Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B4182DDF2C
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 20:33:41 +1100 (EST)
Date: Mon, 19 Jan 2009 20:33:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: printing fix for l64 to ll64 conversion: phyp_dump.c
Message-Id: <20090119203338.af695dc2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/phyp_dump.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/phyp_dump.c b/arch/powerpc/platforms/pseries/phyp_dump.c
index 6cf35cd..15eb610 100644
--- a/arch/powerpc/platforms/pseries/phyp_dump.c
+++ b/arch/powerpc/platforms/pseries/phyp_dump.c
@@ -144,8 +144,8 @@ static void print_dump_header(const struct phyp_dump_header *ph)
 		ph->first_offset_section);
 	printk(KERN_INFO "dump disk sections should be zero\n");
 	printk(KERN_INFO "dump disk section = %d\n", ph->dump_disk_section);
-	printk(KERN_INFO "block num = %ld\n", ph->block_num_dd);
-	printk(KERN_INFO "number of blocks = %ld\n", ph->num_of_blocks_dd);
+	printk(KERN_INFO "block num = %lld\n", ph->block_num_dd);
+	printk(KERN_INFO "number of blocks = %lld\n", ph->num_of_blocks_dd);
 	printk(KERN_INFO "dump disk offset = %d\n", ph->offset_dd);
 	printk(KERN_INFO "Max auto time= %d\n", ph->maxtime_to_auto);
 
@@ -154,33 +154,33 @@ static void print_dump_header(const struct phyp_dump_header *ph)
 	printk(KERN_INFO "cpu dump_flags =%d\n", ph->cpu_data.dump_flags);
 	printk(KERN_INFO "cpu source_type =%d\n", ph->cpu_data.source_type);
 	printk(KERN_INFO "cpu error_flags =%d\n", ph->cpu_data.error_flags);
-	printk(KERN_INFO "cpu source_address =%lx\n",
+	printk(KERN_INFO "cpu source_address =%llx\n",
 		ph->cpu_data.source_address);
-	printk(KERN_INFO "cpu source_length =%lx\n",
+	printk(KERN_INFO "cpu source_length =%llx\n",
 		ph->cpu_data.source_length);
-	printk(KERN_INFO "cpu length_copied =%lx\n",
+	printk(KERN_INFO "cpu length_copied =%llx\n",
 		ph->cpu_data.length_copied);
 
 	printk(KERN_INFO " HPTE AREA \n");
 	printk(KERN_INFO "HPTE dump_flags =%d\n", ph->hpte_data.dump_flags);
 	printk(KERN_INFO "HPTE source_type =%d\n", ph->hpte_data.source_type);
 	printk(KERN_INFO "HPTE error_flags =%d\n", ph->hpte_data.error_flags);
-	printk(KERN_INFO "HPTE source_address =%lx\n",
+	printk(KERN_INFO "HPTE source_address =%llx\n",
 		ph->hpte_data.source_address);
-	printk(KERN_INFO "HPTE source_length =%lx\n",
+	printk(KERN_INFO "HPTE source_length =%llx\n",
 		ph->hpte_data.source_length);
-	printk(KERN_INFO "HPTE length_copied =%lx\n",
+	printk(KERN_INFO "HPTE length_copied =%llx\n",
 		ph->hpte_data.length_copied);
 
 	printk(KERN_INFO " SRSD AREA \n");
 	printk(KERN_INFO "SRSD dump_flags =%d\n", ph->kernel_data.dump_flags);
 	printk(KERN_INFO "SRSD source_type =%d\n", ph->kernel_data.source_type);
 	printk(KERN_INFO "SRSD error_flags =%d\n", ph->kernel_data.error_flags);
-	printk(KERN_INFO "SRSD source_address =%lx\n",
+	printk(KERN_INFO "SRSD source_address =%llx\n",
 		ph->kernel_data.source_address);
-	printk(KERN_INFO "SRSD source_length =%lx\n",
+	printk(KERN_INFO "SRSD source_length =%llx\n",
 		ph->kernel_data.source_length);
-	printk(KERN_INFO "SRSD length_copied =%lx\n",
+	printk(KERN_INFO "SRSD length_copied =%llx\n",
 		ph->kernel_data.length_copied);
 #endif
 }
@@ -367,8 +367,8 @@ static ssize_t show_release_region(struct kobject *kobj,
 	/* total reserved size - start of scratch area */
 	second_addr_range = phyp_dump_info->init_reserve_size -
 				phyp_dump_info->reserved_scratch_size;
-	return sprintf(buf, "CPU:0x%lx-0x%lx: HPTE:0x%lx-0x%lx:"
-			    " DUMP:0x%lx-0x%lx, 0x%lx-0x%lx:\n",
+	return sprintf(buf, "CPU:0x%llx-0x%llx: HPTE:0x%llx-0x%llx:"
+			    " DUMP:0x%llx-0x%llx, 0x%lx-0x%llx:\n",
 		phdr.cpu_data.destination_address,
 		phdr.cpu_data.length_copied,
 		phdr.hpte_data.destination_address,
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
