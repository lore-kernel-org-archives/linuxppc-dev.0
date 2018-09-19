Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FYng3DnQzDrdd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 19:04:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J88vZL037407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkgknnaft-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:00 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Sep 2018 09:08:50 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 4/4] powerpc/pseries: Introduce dtl_entry tracepoint
Date: Wed, 19 Sep 2018 13:38:21 +0530
In-Reply-To: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <2576361c3d9cb6f34c36e8a5711f87460e515c27.1537343905.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This tracepoint provides access to the fields of each DTL entry in the
Dispatch Trace Log buffer, and is hit when processing the DTL buffer for
accounting stolen time. As such, this tracepoint is only available when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is enabled.

Apart from making the DTL entries available for processing through the
usual trace interface, this tracepoint also adds a new field 'distance'
to each DTL entry, enabling enhanced statistics around the vcpu dispatch
behavior of the hypervisor.

For Shared Processor LPARs, the POWER Hypervisor maintains a relatively
static mapping of LPAR vcpus to physical processor cores and tries to
always dispatch vcpus on their associated physical processor core. The
LPAR can discover this through the H_VPHN(flags=1) hcall to obtain the
associativity of the LPAR vcpus.

However, under certain scenarios, vcpus may be dispatched on a different
processor core. The actual physical processor number on which a certain
vcpu is dispatched is available to the LPAR in the 'processor_id' field
of each DTL entry. The LPAR can then discover the associativity of that
physical processor through the H_VPHN(flags=2) hcall. This can then be
compared to the home node associativity for that specific vcpu to
determine if the vcpu was dispatched on the same core or not.  If the
vcpu was not dispatched on the home node, it is possible to determine if
the vcpu was dispatched in a different chip, socket or drawer.

The tracepoint field 'distance' encodes this information. If distance is
0, then the vcpu was dispatched on its home node. If not, increasing
values of 'distance' indicate a dispatch on a different core in the same
chip, different chip in a DCM, different socket or a different drawer.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/trace.h | 53 ++++++++++++++++++
 arch/powerpc/kernel/time.c       |  9 +++
 arch/powerpc/mm/numa.c           | 94 ++++++++++++++++++++++++++++++--
 3 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index d018e8602694..27ccb2c8afc3 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -101,6 +101,59 @@ TRACE_EVENT_FN_COND(hcall_exit,
 
 	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
 );
+
+extern int dtl_entry_tracepoint_regfunc(void);
+extern void dtl_entry_tracepoint_unregfunc(void);
+extern u8 compute_dispatch_distance(unsigned int pcpu);
+
+TRACE_EVENT_FN(dtl_entry,
+
+	TP_PROTO(u8 dispatch_reason, u8 preempt_reason, u16 processor_id,
+		u32 enqueue_to_dispatch_time, u32 ready_to_enqueue_time,
+		u32 waiting_to_ready_time, u64 timebase, u64 fault_addr,
+		u64 srr0, u64 srr1),
+
+	TP_ARGS(dispatch_reason, preempt_reason, processor_id,
+		enqueue_to_dispatch_time, ready_to_enqueue_time,
+		waiting_to_ready_time, timebase, fault_addr,
+		srr0, srr1),
+
+	TP_STRUCT__entry(
+		__field(u8, dispatch_reason)
+		__field(u8, preempt_reason)
+		__field(u16, processor_id)
+		__field(u32, enqueue_to_dispatch_time)
+		__field(u32, ready_to_enqueue_time)
+		__field(u32, waiting_to_ready_time)
+		__field(u64, timebase)
+		__field(u64, fault_addr)
+		__field(u64, srr0)
+		__field(u64, srr1)
+		__field(u8, distance)
+	),
+
+	TP_fast_assign(
+		__entry->dispatch_reason = dispatch_reason;
+		__entry->preempt_reason = preempt_reason;
+		__entry->processor_id = processor_id;
+		__entry->enqueue_to_dispatch_time = enqueue_to_dispatch_time;
+		__entry->ready_to_enqueue_time = ready_to_enqueue_time;
+		__entry->waiting_to_ready_time = waiting_to_ready_time;
+		__entry->timebase = timebase;
+		__entry->fault_addr = fault_addr;
+		__entry->srr0 = srr0;
+		__entry->srr1 = srr1;
+		__entry->distance = compute_dispatch_distance(processor_id);
+	),
+
+	TP_printk("dispatch_reason=%u preempt_reason=%u processor_id=%u enq_to_disp=%u ready_to_enq=%u wait_to_ready=%u tb=%llu fault_addr=0x%llx srr0=0x%llx srr1=0x%llx distance=%u",
+		__entry->dispatch_reason, __entry->preempt_reason, __entry->processor_id,
+		__entry->enqueue_to_dispatch_time, __entry->ready_to_enqueue_time,
+		__entry->waiting_to_ready_time, __entry->timebase, __entry->fault_addr,
+		__entry->srr0, __entry->srr1, __entry->distance),
+
+	dtl_entry_tracepoint_regfunc, dtl_entry_tracepoint_unregfunc
+);
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 70f145e02487..94802fc22521 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -220,6 +220,15 @@ static u64 scan_dispatch_log(u64 stop_tb)
 			break;
 		if (dtl_consumer)
 			dtl_consumer(dtl, i);
+		trace_dtl_entry(dtl->dispatch_reason, dtl->preempt_reason,
+				be16_to_cpu(dtl->processor_id),
+				be32_to_cpu(dtl->enqueue_to_dispatch_time),
+				be32_to_cpu(dtl->ready_to_enqueue_time),
+				be32_to_cpu(dtl->waiting_to_ready_time),
+				be64_to_cpu(dtl->timebase),
+				be64_to_cpu(dtl->fault_addr),
+				be64_to_cpu(dtl->srr0),
+				be64_to_cpu(dtl->srr1));
 		stolen += tb_delta;
 		++i;
 		++dtl;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 35ac5422903a..b3fcdf6a8b4a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -41,6 +41,7 @@
 #include <asm/setup.h>
 #include <asm/vdso.h>
 #include <asm/drmem.h>
+#include <asm/trace.h>
 
 static int numa_enabled = 1;
 
@@ -1078,6 +1079,9 @@ static int prrn_enabled;
 static void reset_topology_timer(void);
 static int topology_timer_secs = 1;
 static int topology_inited;
+static __be32 vcpu_associativity[NR_CPUS][VPHN_ASSOC_BUFSIZE];
+static __be32 pcpu_associativity[NR_CPUS][VPHN_ASSOC_BUFSIZE];
+static unsigned int associativity_depth;
 
 /*
  * Change polling interval for associativity changes.
@@ -1157,14 +1161,12 @@ static int update_cpu_associativity_changes_mask(void)
  * Retrieve the new associativity information for a virtual processor's
  * home node.
  */
-static long hcall_vphn(unsigned long cpu, __be32 *associativity)
+static long hcall_vphn(unsigned long cpu, unsigned long flags, __be32 *associativity)
 {
 	long rc;
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
-	u64 flags = 1;
-	int hwcpu = get_hard_smp_processor_id(cpu);
 
-	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
+	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, cpu);
 	vphn_unpack_associativity(retbuf, associativity);
 
 	return rc;
@@ -1175,7 +1177,7 @@ static long vphn_get_associativity(unsigned long cpu,
 {
 	long rc;
 
-	rc = hcall_vphn(cpu, associativity);
+	rc = hcall_vphn(get_hard_smp_processor_id(cpu), 1, associativity);
 
 	switch (rc) {
 	case H_FUNCTION:
@@ -1200,7 +1202,7 @@ static long vphn_get_associativity(unsigned long cpu,
 
 int find_and_online_cpu_nid(int cpu)
 {
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	__be32 *associativity = vcpu_associativity[cpu];
 	int new_nid;
 
 	/* Use associativity from first thread for all siblings */
@@ -1234,6 +1236,86 @@ int find_and_online_cpu_nid(int cpu)
 	return new_nid;
 }
 
+static unsigned int find_possible_pcpus(void)
+{
+	struct device_node *rtas;
+	unsigned int max_depth, num_pcpus = 0;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (min_common_depth <= 0 || !rtas)
+		return 0;
+
+	if (!of_property_read_u32(rtas,
+				"ibm,max-associativity-domains",
+				&max_depth))
+		of_property_read_u32_index(rtas,
+					   "ibm,max-associativity-domains",
+					   max_depth, &num_pcpus);
+
+	of_node_put(rtas);
+
+	return num_pcpus;
+}
+
+int dtl_entry_tracepoint_regfunc(void)
+{
+	unsigned int i, num_pcpus, pcpu_associativity_depth = 0;
+	long rc;
+
+	num_pcpus = find_possible_pcpus();
+	if (num_pcpus <= 0)
+		num_pcpus = NR_CPUS;
+	else
+		/*
+		 * The OF property reports the maximum cpu number.
+		 * We instead want the maximum number of cpus.
+		 */
+		num_pcpus++;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		pcpu_associativity[i][0] = NR_CPUS;
+		if (i < num_pcpus && vphn_enabled) {
+			rc = hcall_vphn(i, 2, pcpu_associativity[i]);
+			if (!pcpu_associativity_depth && rc == H_SUCCESS)
+				pcpu_associativity_depth = pcpu_associativity[i][0];
+		}
+	}
+
+	if (vphn_enabled)
+		associativity_depth = min(pcpu_associativity_depth,
+				vcpu_associativity[smp_processor_id()][0]);
+
+	if (set_dtl_mask(-1, DTL_LOG_ALL))
+		return -EBUSY;
+
+	return 0;
+}
+
+void dtl_entry_tracepoint_unregfunc(void)
+{
+	reset_dtl_mask(-1);
+}
+
+u8 compute_dispatch_distance(unsigned int pcpu)
+{
+	__be32 *pcpu_assoc, *vcpu_assoc;
+	unsigned int i, distance = associativity_depth;
+
+	vcpu_assoc = vcpu_associativity[smp_processor_id()];
+	pcpu_assoc = pcpu_associativity[pcpu];
+
+	if (!vphn_enabled || pcpu_assoc[0] == NR_CPUS)
+		return 255;
+
+	for (i = 1; i <= associativity_depth; i++)
+		if (vcpu_assoc[i] == pcpu_assoc[i])
+			distance--;
+		else
+			break;
+
+	return distance;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and is
-- 
2.18.0
