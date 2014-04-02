Return-Path: <wangyun@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C8961400ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 14:30:09 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <wangyun@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 13:30:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C9A082BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 14:29:58 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3239Le758523782
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 14:09:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s323TuDA013989
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 14:29:57 +1100
Message-ID: <533B8431.8090507@linux.vnet.ibm.com>
Date: Wed, 02 Apr 2014 11:29:53 +0800
From: Michael wang <wangyun@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 benh@kernel.crashing.org, paulus@samba.org, nfont@linux.vnet.ibm.com,
 sfr@canb.auug.org.au, Andrew Morton <akpm@linux-foundation.org>,
 rcj@linux.vnet.ibm.com, jlarrew@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, alistair@popple.id.au
Subject: [PATCH] power, sched: stop updating inside arch_update_cpu_topology()
 when nothing to be update
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During the testing, we encounter below WARN followed by Oops:

	WARNING: at kernel/sched/core.c:6218
	...
	NIP [c000000000101660] .build_sched_domains+0x11d0/0x1200
	LR [c000000000101358] .build_sched_domains+0xec8/0x1200
	PACATMSCRATCH [800000000000f032]
	Call Trace:
	[c00000001b103850] [c000000000101358] .build_sched_domains+0xec8/0x1200
	[c00000001b1039a0] [c00000000010aad4] .partition_sched_domains+0x484/0x510
	[c00000001b103aa0] [c00000000016d0a8] .rebuild_sched_domains+0x68/0xa0
	[c00000001b103b30] [c00000000005cbf0] .topology_work_fn+0x10/0x30
	...
	Oops: Kernel access of bad area, sig: 11 [#1]
	...
	NIP [c00000000045c000] .__bitmap_weight+0x60/0xf0
	LR [c00000000010132c] .build_sched_domains+0xe9c/0x1200
	PACATMSCRATCH [8000000000029032]
	Call Trace:
	[c00000001b1037a0] [c000000000288ff4] .kmem_cache_alloc_node_trace+0x184/0x3a0
	[c00000001b103850] [c00000000010132c] .build_sched_domains+0xe9c/0x1200
	[c00000001b1039a0] [c00000000010aad4] .partition_sched_domains+0x484/0x510
	[c00000001b103aa0] [c00000000016d0a8] .rebuild_sched_domains+0x68/0xa0
	[c00000001b103b30] [c00000000005cbf0] .topology_work_fn+0x10/0x30
	...

This was caused by that 'sd->groups == NULL' after building groups, which
was caused by the empty 'sd->span'.

The cpu's domain contain nothing because the cpu was assigned to wrong
node inside arch_update_cpu_topology() by calling update_lookup_table()
with the uninitialized param, in the case when there is nothing to be
update.

Thus we should stop the updating in such cases, this patch will achieve
this and fix the issue.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Nathan Fontenot <nfont@linux.vnet.ibm.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Robert Jennings <rcj@linux.vnet.ibm.com>
CC: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
CC: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
CC: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Michael Wang <wangyun@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 30a42e2..6757690 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1591,6 +1591,14 @@ int arch_update_cpu_topology(void)
 		cpu = cpu_last_thread_sibling(cpu);
 	}
 
+	/*
+	 * The 'cpu_associativity_changes_mask' could be cleared if
+	 * all the cpus it indicates won't change their node, in
+	 * which case the 'updated_cpus' will be empty.
+	 */
+	if (!cpumask_weight(&updated_cpus))
+		goto out;
+
 	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
 
 	/*
@@ -1612,6 +1620,7 @@ int arch_update_cpu_topology(void)
 		changed = 1;
 	}
 
+out:
 	kfree(updates);
 	return changed;
 }
-- 
1.7.9.5
