Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34C40DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 09:37:20 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7LZfYJ010511
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 16:35:41 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7MbHAn132894
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:37:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7MbHYZ032178
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:37:17 -0700
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Date: Sat, 08 Dec 2007 04:07:14 +0530
Message-Id: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
Subject: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Cc: LKML <linux-kernel@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Changelog

1. Get rid of the constant 5 (based on comments from
                                Geert.Uytterhoeven@sonycom.com)
2. Implement suggestions from Olof Johannson
3. Check if cmdline is NULL in fake_numa_create_new_node()

Tested with additional parameters from Olof

numa=debug,fake=
numa=foo,fake=bar


Here's a dumb simple implementation of fake NUMA nodes for PowerPC. Fake
NUMA nodes can be specified using the following command line option

numa=fake=<node range>

node range is of the format <range1>,<range2>,...<rangeN>

Each of the rangeX parameters is passed using memparse(). I find the patch
useful for fake NUMA emulation on my simple PowerPC machine. I've tested it
on a non-numa box with the following arguments

numa=fake=1G
numa=fake=1G,2G
name=fake=1G,512M,2G
numa=fake=1500M,2800M mem=3500M
numa=fake=1G mem=512M
numa=fake=1G mem=1G

This patch applies on top of 2.6.24-rc4.

All though I've tried my best to handle some of the architecture specific
details of PowerPC, I might have overlooked something obvious, like the usage
of an API or some architecture tweaks. The patch depends on CONFIG_NUMA and
I decided against creating a separate config option for fake NUMA to keep
the code simple.

Comments are as always welcome!

Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
---

 arch/powerpc/mm/numa.c |   59 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff -puN arch/powerpc/mm/numa.c~ppc-fake-numa-easy arch/powerpc/mm/numa.c
--- linux-2.6.24-rc4-mm1/arch/powerpc/mm/numa.c~ppc-fake-numa-easy	2007-12-07 21:25:55.000000000 +0530
+++ linux-2.6.24-rc4-mm1-balbir/arch/powerpc/mm/numa.c	2007-12-08 03:19:46.000000000 +0530
@@ -24,6 +24,8 @@
 
 static int numa_enabled = 1;
 
+static char *cmdline __initdata;
+
 static int numa_debug;
 #define dbg(args...) if (numa_debug) { printk(KERN_INFO args); }
 
@@ -39,6 +41,43 @@ static bootmem_data_t __initdata plat_no
 static int min_common_depth;
 static int n_mem_addr_cells, n_mem_size_cells;
 
+static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
+						unsigned int *nid)
+{
+	unsigned long long mem;
+	char *p = cmdline;
+	static unsigned int fake_nid = 0;
+	static unsigned long long curr_boundary = 0;
+
+	*nid = fake_nid;
+	if (!p)
+		return 0;
+
+	mem = memparse(p, &p);
+	if (!mem)
+		return 0;
+
+	if (mem < curr_boundary)
+		return 0;
+
+	curr_boundary = mem;
+
+	if ((end_pfn << PAGE_SHIFT) > mem) {
+		/*
+		 * Skip commas and spaces
+		 */
+		while (*p == ',' || *p == ' ' || *p == '\t')
+			p++;
+
+		cmdline = p;
+		fake_nid++;
+		*nid = fake_nid;
+		dbg("created new fake_node with id %d\n", fake_nid);
+		return 1;
+	}
+	return 0;
+}
+
 static void __cpuinit map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
@@ -344,12 +383,14 @@ static void __init parse_drconf_memory(s
 			if (nid == 0xffff || nid >= MAX_NUMNODES)
 				nid = default_nid;
 		}
-		node_set_online(nid);
 
 		size = numa_enforce_memory_limit(start, lmb_size);
 		if (!size)
 			continue;
 
+		fake_numa_create_new_node(((start + size) >> PAGE_SHIFT), &nid);
+		node_set_online(nid);
+
 		add_active_range(nid, start >> PAGE_SHIFT,
 				 (start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
 	}
@@ -429,7 +470,6 @@ new_range:
 		nid = of_node_to_nid_single(memory);
 		if (nid < 0)
 			nid = default_nid;
-		node_set_online(nid);
 
 		if (!(size = numa_enforce_memory_limit(start, size))) {
 			if (--ranges)
@@ -438,6 +478,9 @@ new_range:
 				continue;
 		}
 
+		fake_numa_create_new_node(((start + size) >> PAGE_SHIFT), &nid);
+		node_set_online(nid);
+
 		add_active_range(nid, start >> PAGE_SHIFT,
 				(start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
 
@@ -461,7 +504,7 @@ static void __init setup_nonnuma(void)
 	unsigned long top_of_ram = lmb_end_of_DRAM();
 	unsigned long total_ram = lmb_phys_mem_size();
 	unsigned long start_pfn, end_pfn;
-	unsigned int i;
+	unsigned int i, nid = 0;
 
 	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
@@ -471,9 +514,11 @@ static void __init setup_nonnuma(void)
 	for (i = 0; i < lmb.memory.cnt; ++i) {
 		start_pfn = lmb.memory.region[i].base >> PAGE_SHIFT;
 		end_pfn = start_pfn + lmb_size_pages(&lmb.memory, i);
-		add_active_range(0, start_pfn, end_pfn);
+
+		fake_numa_create_new_node(end_pfn, &nid);
+		add_active_range(nid, start_pfn, end_pfn);
+		node_set_online(nid);
 	}
-	node_set_online(0);
 }
 
 void __init dump_numa_cpu_topology(void)
@@ -702,6 +747,10 @@ static int __init early_numa(char *p)
 	if (strstr(p, "debug"))
 		numa_debug = 1;
 
+	p = strstr(p, "fake=");
+	if (p)
+		cmdline = p + strlen("fake=");
+
 	return 0;
 }
 early_param("numa", early_numa);
_

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
