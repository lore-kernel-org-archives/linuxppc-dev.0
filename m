Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B1CA1A03A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 11:50:59 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 17 Oct 2014 20:50:56 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTPS id 831876E8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 20:39:37 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9I0orZd7405872
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 00:50:53 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9I0oqGC010356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 20:50:53 -0400
Date: Fri, 17 Oct 2014 17:50:40 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/numa: ensure per-cpu NUMA mappings are correct
 on topology update
Message-ID: <20141018005040.GB3969@linux.vnet.ibm.com>
References: <20141018004944.GA3969@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141018004944.GA3969@linux.vnet.ibm.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Wang <wangyun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We received a report of warning in kernel/sched/core.c where the sched
group was NULL on an LPAR after a topology update. This seems to occur
because after the topology update has moved the CPUs, cpu_to_node is
returning the old value still, which ends up breaking the consistency of
the NUMA topology in the per-cpu maps. Ensure that we update the per-cpu
fields when we re-map CPUs.
    
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 86fdb004ad2f..048be62dc979 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1488,11 +1488,14 @@ static int update_cpu_topology(void *data)
 	cpu = smp_processor_id();
 
 	for (update = data; update; update = update->next) {
+		int new_nid = update->new_nid;
 		if (cpu != update->cpu)
 			continue;
 
 		unmap_cpu_from_node(cpu);
-		map_cpu_to_node(cpu, update->new_nid);
+		map_cpu_to_node(cpu, new_nid);
+		set_cpu_numa_node(cpu, new_nid);
+		set_cpu_numa_mem(cpu, local_memory_node(new_nid));
 		vdso_getcpu_init();
 	}
 
