Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA7C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:37:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDA720834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDA720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gzTV1kCbzF3Fw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:37:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gzDK6XXlzF3CG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 07:26:25 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9PKOc4n008860
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nbkj9bhse-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:23 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 25 Oct 2018 21:26:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Oct 2018 21:26:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9PKQIen3015112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Oct 2018 20:26:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CCB85204F;
 Thu, 25 Oct 2018 20:26:18 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.79.235.97])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 36D3C5204E;
 Thu, 25 Oct 2018 20:26:15 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, 
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Jeremy Kerr <jk@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 5/5] powerpc/pseries: Introduce dtl_entry tracepoint
Date: Fri, 26 Oct 2018 01:55:46 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102520-0008-0000-0000-00000285C246
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102520-0009-0000-0000-000021EFC9E0
Message-Id: <04d775973f282d24c769600a2099b215e1560be0.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-25_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250167
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This tracepoint provides access to the fields of each DTL entry in the
Dispatch Trace Log buffer. Since the buffer is populated by the
hypervisor and since we allocate just a 4k area per cpu for the buffer,
we need to process the entries on a regular basis before they are
overwritten by the hypervisor. We do this by using a static branch (or a
reference counter if we don't have jump labels) in ret_from_except
similar to how the hcall/opal tracepoints do.

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
0, then the vcpu was dispatched on its home node/chip. If not,
increasing values of 'distance' indicate a dispatch on a different chip
in a MCM, different socket or a different drawer.

In terms of the implementation, we update our numa code to retain the
vcpu associativity that is retrieved while discovering our numa
topology. In addition, on tracepoint registration, we discover the
physical cpu associativity. This information is only retrieved during
the tracepoint registration and is not expected to change for the
duration of the trace.

To support configurations with/without CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
selected, we generalize and extend helpers for DTL buffer allocation,
freeing and registration. We also introduce a global variable 'dtl_mask'
to encode the DTL enable mask to be set for all cpus. This helps ensure
that cpus that come online honor the global enable mask.

Finally, to ensure that the new dtl_entry tracepoint usage does not
interfere with the dtl debugfs interface, we introduce helpers to ensure
only one of the two interfaces are used at any point in time.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h |   7 +
 arch/powerpc/include/asm/trace.h          |  55 +++++++
 arch/powerpc/kernel/entry_64.S            |  39 +++++
 arch/powerpc/mm/numa.c                    | 144 ++++++++++++++++-
 arch/powerpc/platforms/pseries/dtl.c      |  10 +-
 arch/powerpc/platforms/pseries/lpar.c     | 187 +++++++++++++++++++++-
 6 files changed, 434 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 7dcbf42e9e11..029f019ddfb6 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -88,7 +88,14 @@ static inline long register_dtl(unsigned long cpu, unsigned long vpa)
 	return vpa_call(H_VPA_REG_DTL, cpu, vpa);
 }
 
+extern void dtl_entry_tracepoint_enable(void);
+extern void dtl_entry_tracepoint_disable(void);
+extern int register_dtl_buffer_access(int global);
+extern void unregister_dtl_buffer_access(int global);
+extern void set_dtl_mask(u8 mask);
+extern void reset_dtl_mask(void);
 extern void alloc_dtl_buffers(void);
+extern void free_dtl_buffers(void);
 extern void register_dtl_buffer(int cpu);
 extern void vpa_init(int cpu);
 
diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index d018e8602694..bcb8d66d3232 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -101,6 +101,61 @@ TRACE_EVENT_FN_COND(hcall_exit,
 
 	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
 );
+
+#ifdef CONFIG_PPC_SPLPAR
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
+#endif
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693adff2a..9c3b922dda77 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -46,6 +46,7 @@
 #include <asm/exception-64e.h>
 #endif
 #include <asm/feature-fixups.h>
+#include <linux/jump_label.h>
 
 /*
  * System calls.
@@ -714,6 +715,38 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	addi	r1,r1,SWITCH_FRAME_SIZE
 	blr
 
+#if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_PPC_SPLPAR)
+#ifdef HAVE_JUMP_LABEL
+#define TRACE_DTL_ENTRY_BRANCH(LABEL)					\
+	ARCH_STATIC_BRANCH(LABEL, dtl_entry_tracepoint_key)
+#else
+
+	.pushsection	".toc","aw"
+	.globl dtl_entry_tracepoint_refcount
+dtl_entry_tracepoint_refcount:
+	.8byte	0
+	.popsection
+
+/*
+ * We branch around this in early init (eg when populating the MMU
+ * hashtable) by using an unconditional cpu feature.
+ */
+#define TRACE_DTL_ENTRY_BRANCH(LABEL)				\
+BEGIN_FTR_SECTION;						\
+	b	1f;						\
+END_FTR_SECTION(0, 1);						\
+	ld	r12,dtl_entry_tracepoint_refcount@toc(r2);	\
+	cmpdi	r12,0;						\
+	bne-	LABEL;						\
+1:
+#endif
+
+do_trace_dtl_entry:
+	bl	__trace_dtl_entry
+	b	.Lpost_trace_dtl_entry
+_ASM_NOKPROBE_SYMBOL(do_trace_dtl_entry);
+#endif
+
 	.align	7
 _GLOBAL(ret_from_except)
 	ld	r11,_TRAP(r1)
@@ -734,6 +767,11 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
+#if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_PPC_SPLPAR)
+	TRACE_DTL_ENTRY_BRANCH(do_trace_dtl_entry)
+.Lpost_trace_dtl_entry:
+#endif
+
 	CURRENT_THREAD_INFO(r9, r1)
 	ld	r3,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3E
@@ -768,6 +806,7 @@ _GLOBAL(ret_from_except_lite)
 	bl	restore_math
 	b	restore
 #endif
+
 1:	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	2f
 	bl	restore_interrupts
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 693ae1c1acba..641fb12e9e55 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -41,6 +41,7 @@
 #include <asm/setup.h>
 #include <asm/vdso.h>
 #include <asm/drmem.h>
+#include <asm/plpar_wrappers.h>
 
 static int numa_enabled = 1;
 
@@ -1078,6 +1079,9 @@ static int prrn_enabled;
 static void reset_topology_timer(void);
 static int topology_timer_secs = 1;
 static int topology_inited;
+static __be32 vcpu_associativity[NR_CPUS][VPHN_ASSOC_BUFSIZE];
+static __be32 pcpu_associativity[NR_CPUS][VPHN_ASSOC_BUFSIZE];
+static int no_distance_info;
 
 /*
  * Change polling interval for associativity changes.
@@ -1157,12 +1161,10 @@ static int update_cpu_associativity_changes_mask(void)
  * Retrieve the new associativity information for a virtual processor's
  * home node.
  */
-static long hcall_vphn(unsigned long cpu, __be32 *associativity)
+static long hcall_vphn(unsigned long hwcpu, unsigned long flags, __be32 *associativity)
 {
 	long rc;
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
-	u64 flags = 1;
-	int hwcpu = get_hard_smp_processor_id(cpu);
 
 	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
 	vphn_unpack_associativity(retbuf, associativity);
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
@@ -1237,6 +1239,138 @@ int find_and_online_cpu_nid(int cpu)
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
+	/*
+	 * The OF property reports the maximum cpu number.
+	 * We instead want the maximum number of cpus.
+	 */
+	return num_pcpus + 1;
+}
+
+DECLARE_PER_CPU(u64, dtl_entry_ridx);
+
+/* This is only called on first registration */
+int dtl_entry_tracepoint_regfunc(void)
+{
+	unsigned int i, cpu, num_pcpus;
+	long rc;
+
+	if (register_dtl_buffer_access(1))
+		return -EBUSY;
+
+	if (!vphn_enabled || distance_ref_points_depth < 1 ||
+			     !distance_ref_points ||
+			     !firmware_has_feature(FW_FEATURE_TYPE1_AFFINITY))
+		no_distance_info = 1;
+	else {
+		no_distance_info = 0;
+		num_pcpus = find_possible_pcpus();
+		if (!num_pcpus)
+			num_pcpus = NR_CPUS;
+
+		/*
+		 * Phyp numbers physical processors from 0 and theads per core
+		 * remains the same across the hypervisor and the LPAR, so we can
+		 * skip retrieving associativity for the sibling threads.
+		 * NOTE: This is only retrieved during tracepoint registration
+		 * and is not updated thereafter.
+		 */
+		for (i = 0; i < NR_CPUS; i++) {
+			if (i != cpu_first_thread_sibling(i))
+				continue;
+			if (i >= num_pcpus) {
+				pcpu_associativity[i][0] = cpu_to_be32(NR_CPUS);
+				continue;
+			}
+			rc = hcall_vphn(i, 2, pcpu_associativity[i]);
+			if (rc != H_SUCCESS) {
+				pcpu_associativity[i][0] = cpu_to_be32(NR_CPUS);
+				pr_debug_ratelimited("pcpu_associativity could not be discovered for cpu %d\n", i);
+			}
+		}
+	}
+
+	set_dtl_mask(DTL_LOG_ALL);
+
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	/* Setup dtl buffers and register those */
+	alloc_dtl_buffers();
+
+	for_each_online_cpu(cpu)
+		register_dtl_buffer(cpu);
+#endif
+
+	for_each_online_cpu(cpu)
+		per_cpu(dtl_entry_ridx, cpu) = be64_to_cpu(lppaca_of(cpu).dtl_idx);
+
+	dtl_entry_tracepoint_enable();
+
+	return 0;
+}
+
+void dtl_entry_tracepoint_unregfunc(void)
+{
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	int cpu;
+#endif
+
+	dtl_entry_tracepoint_disable();
+
+	reset_dtl_mask();
+
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	for_each_possible_cpu(cpu)
+		unregister_dtl(get_hard_smp_processor_id(cpu));
+
+	free_dtl_buffers();
+#endif
+
+	unregister_dtl_buffer_access(1);
+}
+
+/* We return 255 to indicate that we couldn't determine the dispatch distance */
+u8 compute_dispatch_distance(unsigned int pcpu)
+{
+	__be32 *pcpu_assoc, *vcpu_assoc;
+	int i, index, distance = distance_ref_points_depth;
+
+	if (!vphn_enabled || no_distance_info)
+		return 255;
+
+	vcpu_assoc = vcpu_associativity[cpu_first_thread_sibling(smp_processor_id())];
+	pcpu_assoc = pcpu_associativity[cpu_first_thread_sibling(pcpu)];
+
+	if (be32_to_cpu(pcpu_assoc[0]) == NR_CPUS)
+		return 255;
+
+	for (i = distance_ref_points_depth - 1; i >= 0; i--) {
+		index = be32_to_cpu(distance_ref_points[i]);
+		if (be32_to_cpu(vcpu_assoc[index]) == be32_to_cpu(pcpu_assoc[index]))
+			distance--;
+		else
+			break;
+	}
+
+	return distance;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and is
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index fb05804adb2f..ec25d3e6cdbb 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -193,11 +193,15 @@ static int dtl_enable(struct dtl *dtl)
 	if (dtl->buf)
 		return -EBUSY;
 
+	if (register_dtl_buffer_access(0))
+		return -EBUSY;
+
 	n_entries = dtl_buf_entries;
 	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL, cpu_to_node(dtl->cpu));
 	if (!buf) {
 		printk(KERN_WARNING "%s: buffer alloc failed for cpu %d\n",
 				__func__, dtl->cpu);
+		unregister_dtl_buffer_access(0);
 		return -ENOMEM;
 	}
 
@@ -214,8 +218,11 @@ static int dtl_enable(struct dtl *dtl)
 	}
 	spin_unlock(&dtl->lock);
 
-	if (rc)
+	if (rc) {
+		unregister_dtl_buffer_access(0);
 		kmem_cache_free(dtl_cache, buf);
+	}
+
 	return rc;
 }
 
@@ -227,6 +234,7 @@ static void dtl_disable(struct dtl *dtl)
 	dtl->buf = NULL;
 	dtl->buf_entries = 0;
 	spin_unlock(&dtl->lock);
+	unregister_dtl_buffer_access(0);
 }
 
 /* file interface */
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index d83bb3db6767..67b2c59c10b1 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -30,6 +30,7 @@
 #include <linux/jump_label.h>
 #include <linux/delay.h>
 #include <linux/stop_machine.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -64,6 +65,167 @@ EXPORT_SYMBOL(plpar_hcall);
 EXPORT_SYMBOL(plpar_hcall9);
 EXPORT_SYMBOL(plpar_hcall_norets);
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+u8 dtl_mask = DTL_LOG_PREEMPT;
+#else
+u8 dtl_mask = 0;
+#endif
+
+static DEFINE_SPINLOCK(dtl_buffer_refctr_lock);
+static unsigned int dtl_buffer_global_refctr, dtl_buffer_percpu_refctr;
+
+int register_dtl_buffer_access(int global)
+{
+	int rc = 0;
+
+	spin_lock(&dtl_buffer_refctr_lock);
+
+	if ((global && (dtl_buffer_global_refctr || dtl_buffer_percpu_refctr)) ||
+			(!global && dtl_buffer_global_refctr)) {
+		rc = -1;
+	} else {
+		if (global)
+			dtl_buffer_global_refctr++;
+		else
+			dtl_buffer_percpu_refctr++;
+	}
+
+	spin_unlock(&dtl_buffer_refctr_lock);
+
+	return rc;
+}
+
+void unregister_dtl_buffer_access(int global)
+{
+	spin_lock(&dtl_buffer_refctr_lock);
+
+	if (global)
+		dtl_buffer_global_refctr--;
+	else
+		dtl_buffer_percpu_refctr--;
+
+	spin_unlock(&dtl_buffer_refctr_lock);
+}
+
+void set_dtl_mask(u8 mask)
+{
+	int cpu;
+
+	dtl_mask = mask;
+	for_each_present_cpu(cpu)
+		lppaca_of(cpu).dtl_enable_mask = dtl_mask;
+}
+
+void reset_dtl_mask()
+{
+	int cpu;
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	dtl_mask = DTL_LOG_PREEMPT;
+#else
+	dtl_mask = 0;
+#endif
+	for_each_present_cpu(cpu)
+		lppaca_of(cpu).dtl_enable_mask = dtl_mask;
+}
+
+#if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_PPC_SPLPAR)
+#ifdef HAVE_JUMP_LABEL
+struct static_key dtl_entry_tracepoint_key = STATIC_KEY_INIT;
+
+void dtl_entry_tracepoint_enable(void)
+{
+	static_key_slow_inc(&dtl_entry_tracepoint_key);
+}
+
+void dtl_entry_tracepoint_disable(void)
+{
+	static_key_slow_dec(&dtl_entry_tracepoint_key);
+}
+#else
+/* NB: reg/unreg are called while guarded with the tracepoints_mutex */
+extern long dtl_entry_tracepoint_refcount;
+
+void dtl_entry_tracepoint_enable(void)
+{
+	dtl_entry_tracepoint_refcount++;
+}
+
+void dtl_entry_tracepoint_disable(void)
+{
+	dtl_entry_tracepoint_refcount--;
+}
+#endif
+
+/*
+ * Since the tracing code might execute hcalls we need to guard against
+ * recursion. One example of this are spinlocks calling H_YIELD on
+ * shared processor partitions.
+ */
+static DEFINE_PER_CPU(unsigned int, dtl_entry_trace_depth);
+DEFINE_PER_CPU(u64, dtl_entry_ridx);
+
+static void __process_dtl_buffer(void)
+{
+	struct dtl_entry dtle;
+	u64 i = __this_cpu_read(dtl_entry_ridx);
+	struct dtl_entry *dtl = local_paca->dispatch_log + (i % N_DISPATCH_LOG);
+	struct dtl_entry *dtl_end = local_paca->dispatch_log_end;
+	struct lppaca *vpa = local_paca->lppaca_ptr;
+
+	if (!dtl || i == be64_to_cpu(vpa->dtl_idx))
+		return;
+
+	while (i < be64_to_cpu(vpa->dtl_idx)) {
+		dtle = *dtl;
+		barrier();
+		if (i + N_DISPATCH_LOG < be64_to_cpu(vpa->dtl_idx)) {
+			/* buffer has overflowed */
+			i = be64_to_cpu(vpa->dtl_idx) - N_DISPATCH_LOG;
+			dtl = local_paca->dispatch_log + (i % N_DISPATCH_LOG);
+			continue;
+		}
+		trace_dtl_entry(dtle.dispatch_reason, dtle.preempt_reason,
+				be16_to_cpu(dtle.processor_id),
+				be32_to_cpu(dtle.enqueue_to_dispatch_time),
+				be32_to_cpu(dtle.ready_to_enqueue_time),
+				be32_to_cpu(dtle.waiting_to_ready_time),
+				be64_to_cpu(dtle.timebase),
+				be64_to_cpu(dtle.fault_addr),
+				be64_to_cpu(dtle.srr0),
+				be64_to_cpu(dtle.srr1));
+		++i;
+		++dtl;
+		if (dtl == dtl_end)
+			dtl = local_paca->dispatch_log;
+	}
+
+	__this_cpu_write(dtl_entry_ridx, i);
+}
+
+void __trace_dtl_entry(void)
+{
+	unsigned long flags;
+	unsigned int *depth;
+
+	local_irq_save(flags);
+	preempt_disable();
+
+	depth = this_cpu_ptr(&dtl_entry_trace_depth);
+
+	if (*depth)
+		goto out;
+
+	(*depth)++;
+	__process_dtl_buffer();
+	(*depth)--;
+
+out:
+	preempt_enable();
+	local_irq_restore(flags);
+}
+#endif
+
 void alloc_dtl_buffers(void)
 {
 	int cpu;
@@ -72,11 +234,15 @@ void alloc_dtl_buffers(void)
 
 	for_each_possible_cpu(cpu) {
 		pp = paca_ptrs[cpu];
+		if (pp->dispatch_log)
+			continue;
 		dtl = kmem_cache_alloc(dtl_cache, GFP_KERNEL);
 		if (!dtl) {
 			pr_warn("Failed to allocate dispatch trace log for cpu %d\n",
 				cpu);
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 			pr_warn("Stolen time statistics will be unreliable\n");
+#endif
 			break;
 		}
 
@@ -87,6 +253,23 @@ void alloc_dtl_buffers(void)
 	}
 }
 
+void free_dtl_buffers(void)
+{
+	int cpu;
+	struct paca_struct *pp;
+
+	for_each_possible_cpu(cpu) {
+		pp = paca_ptrs[cpu];
+		if (!pp->dispatch_log)
+			continue;
+		kmem_cache_free(dtl_cache, pp->dispatch_log);
+		pp->dtl_ridx = 0;
+		pp->dispatch_log = 0;
+		pp->dispatch_log_end = 0;
+		pp->dtl_curr = 0;
+	}
+}
+
 void register_dtl_buffer(int cpu)
 {
 	long ret;
@@ -96,7 +279,7 @@ void register_dtl_buffer(int cpu)
 
 	pp = paca_ptrs[cpu];
 	dtl = pp->dispatch_log;
-	if (dtl) {
+	if (dtl && dtl_mask) {
 		pp->dtl_ridx = 0;
 		pp->dtl_curr = dtl;
 		lppaca_of(cpu).dtl_idx = 0;
@@ -107,7 +290,7 @@ void register_dtl_buffer(int cpu)
 		if (ret)
 			pr_err("WARNING: DTL registration of cpu %d (hw %d) "
 			       "failed with %ld\n", cpu, hwcpu, ret);
-		lppaca_of(cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
+		lppaca_of(cpu).dtl_enable_mask = dtl_mask;
 	}
 }
 
-- 
2.19.1

