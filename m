Return-Path: <arbab@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9CWx0RD7zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 02:04:45 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s9CWw4Kgcz9s9x
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2016 02:04:43 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BG3fvT112645
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 12:04:41 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v1kb9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 12:04:41 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 10:04:40 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] mm: Initialize per_cpu_nodestats for hotadded pgdats
Date: Thu, 11 Aug 2016 11:04:33 -0500
In-Reply-To: <20160811092808.GD8119@techsingularity.net>
References: <20160811092808.GD8119@techsingularity.net>
Message-Id: <1470931473-7090-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following oops occurs after a pgdat is hotadded:

[   86.839956] Unable to handle kernel paging request for data at address 0x00c30001
[   86.840132] Faulting instruction address: 0xc00000000022f8f4
[   86.840328] Oops: Kernel access of bad area, sig: 11 [#1]
[   86.840468] SMP NR_CPUS=2048 NUMA pSeries
[   86.840612] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw iptable_filter nls_utf8 isofs sg virtio_balloon uio_pdrv_genirq uio ip_tables xfs libcrc32c sr_mod cdrom sd_mod virtio_net ibmvscsi scsi_transport_srp virtio_pci virtio_ring virtio dm_mirror dm_region_hash dm_log dm_mod
[   86.842955] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W 4.8.0-rc1-device #110
[   86.843140] task: c000000000ef3080 task.stack: c000000000f6c000
[   86.843323] NIP: c00000000022f8f4 LR: c00000000022f948 CTR: 0000000000000000
[   86.843595] REGS: c000000000f6fa50 TRAP: 0300   Tainted: G        W (4.8.0-rc1-device)
[   86.843889] MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 84002028  XER: 20000000
[   86.844624] CFAR: d000000001d2013c DAR: 0000000000c30001 DSISR: 40000000 SOFTE: 0
GPR00: c00000000022f948 c000000000f6fcd0 c000000000f71400 0000000000000001
GPR04: 0000000000000100 0000000000000000 0000000000000000 0000000000c30000
GPR08: ffffffffffffffff 0000000000000001 0000000000c30000 00000000ffffffff
GPR12: 0000000000002200 c000000001300000 c000000000faefb4 c000000000faefa8
GPR16: c000000000f6c000 c000000000f6c080 c000000000bf15b0 c000000000f6c080
GPR20: c000000000bf4928 0000000000000000 0000000000000003 c000000000bf4968
GPR24: c0000000ffed0000 0000000000000000 0000000000000000 c000000000f6fd58
GPR28: 0000000000000001 0000000000000001 c000000000f6fcf0 c0000000ffed9c08
[   86.847747] NIP [c00000000022f8f4] refresh_cpu_vm_stats+0x1a4/0x2f0
[   86.847897] LR [c00000000022f948] refresh_cpu_vm_stats+0x1f8/0x2f0
[   86.848060] Call Trace:
[   86.848183] [c000000000f6fcd0] [c00000000022f948] refresh_cpu_vm_stats+0x1f8/0x2f0 (unreliable)

Add per_cpu_nodestats initialization to the hotplug codepath.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 mm/memory_hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3894b65..41266dc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1219,6 +1219,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
 	free_area_init_node(nid, zones_size, start_pfn, zholes_size);
+	pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
 
 	/*
 	 * The node we allocated has no zone fallback lists. For avoiding
@@ -1249,6 +1250,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 static void rollback_node_hotadd(int nid, pg_data_t *pgdat)
 {
 	arch_refresh_nodedata(nid, NULL);
+	free_percpu(pgdat->per_cpu_nodestats);
 	arch_free_nodedata(pgdat);
 	return;
 }
-- 
1.8.3.1
