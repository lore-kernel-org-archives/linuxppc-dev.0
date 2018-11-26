Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA4C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:42:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC16208E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC16208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433f4N4sMPzDq96
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:42:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433dvy10tFzDqbs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 07:35:25 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQKZL53030566
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:35:24 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p0mpn91bb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:35:22 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Nov 2018 20:34:41 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 20:34:38 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQKYaDc23593096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 20:34:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D1C3C605B;
 Mon, 26 Nov 2018 20:34:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 358EBC6055;
 Mon, 26 Nov 2018 20:34:36 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (unknown [9.40.193.67])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 20:34:36 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltczep4-lp5.aus.stglabs.ibm.com (Postfix) with ESMTP id D3D2240CAA83;
 Mon, 26 Nov 2018 14:34:35 -0600 (CST)
Subject: [Internal Review PATCH 2/3] powerpc/numa: Define mapping between HW
 and kernel cpus
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidyan@in.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 26 Nov 2018 14:34:35 -0600
In-Reply-To: <20181126203327.11326.32023.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
References: <20181126203327.11326.32023.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112620-8235-0000-0000-00000E2EB61E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123168; UDB=6.00583042; IPR=6.00903297; 
 MB=3.00024341; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 20:34:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112620-8236-0000-0000-0000437EC9F7
Message-Id: <20181126203421.11326.5705.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260175
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Define interface to map external powerpc cpus across multiple nodes
to a range of kernel cpu values.  Mapping is intended to prevent
confusion within the kernel about the cpu+node mapping, and the
changes in configuration that may happen due to powerpc LPAR
migration or other associativity changes during the lifetime of a
system.  These interfaces will be used entirely within the powerpc
kernel code to maintain separation between the machine and kernel
contexts.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h       |   31 +++++++
 arch/powerpc/platforms/pseries/Kconfig    |   10 ++
 arch/powerpc/platforms/pseries/Makefile   |    1 
 arch/powerpc/platforms/pseries/cpuremap.c |  131 +++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/cpuremap.c

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 4621f40..db11969 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,5 +135,36 @@ static inline void shared_proc_topology_init(void) {}
 #endif
 #endif
 
+#define CPUREMAP_NO_CPU		(~0)
+#define CPUREMAP_NO_THREAD	(~0)
+
+#ifdef CONFIG_CPUREMAP
+extern int cpuremap_thread_to_cpu(int thread_index);
+		/* Return CPUREMAP_NO_CPU if not found */
+extern int cpuremap_map_cpu(int thread_index, int in_core_ndx, int node);
+		/* Return CPUREMAP_NO_CPU if fails */
+extern int cpuremap_reserve_cpu(int cpu);
+		/* Return CPUREMAP_NO_CPU if fails */
+extern int cpuremap_release_cpu(int cpu);
+		/* Return CPUREMAP_NO_CPU if fails */
+extern int cpuremap_cpu_to_thread(int cpu);
+		/* Return CPUREMAP_NO_THREAD if not found */
+extern void cpuremap_init(void);
+		/* Identify necessary constants & alloc memory at boot */
+#else
+static inline int cpuremap_thread_to_cpu(int thread_index)
+{
+	return thread_index;
+}
+static inline int cpuremap_map_cpu(int thread_index, int in_core_ndx, int node)
+{
+	return thread_index;
+}
+static inline int cpuremap_reserve_cpu(int cpu) { return cpu; }
+static inline int cpuremap_release_cpu(int cpu) { return cpu; }
+static inline int cpuremap_cpu_to_thread(int cpu) { return cpu; }
+static inline void cpuremap_init(void) {}
+#endif
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 2e4bd32..c35009f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -145,3 +145,13 @@ config PAPR_SCM
 	tristate "Support for the PAPR Storage Class Memory interface"
 	help
 	  Enable access to hypervisor provided storage class memory.
+          Enable access to hypervisor provided storage class memory.
+
+config CPUREMAP
+        bool "Support for mapping hw cpu+node to kernel index"
+        depends on SMP && (PPC_PSERIES)
+        ---help---
+          Say Y here to be able to remap hw cpu+node to standardized
+          kernel CPUs at runtime on Pseries machines.
+
+          Say N if you are unsure.
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index a43ec84..ad49d8e 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
+obj-$(CONFIG_CPUREMAP)		+= cpuremap.o
 obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o pmem.o
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
diff --git a/arch/powerpc/platforms/pseries/cpuremap.c b/arch/powerpc/platforms/pseries/cpuremap.c
new file mode 100644
index 0000000..86fdf12
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/cpuremap.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <asm/prom.h>
+#include <asm/topology.h>
+
+struct cpuremap_cpu {
+	int thread_index;
+		/* Set to thread_index from ibm,ppc-interrupt-server#s arrays
+		 * Don't clear when release'ed
+		 */
+	int node;
+	bool in_use;
+		/* Set to true when reserve'ed
+		 * Don't clear when release'ed
+		*/
+};
+
+struct cpuremap_struct {
+	int num_nodes;
+	int num_cores;
+	int num_threads_per_core;
+	struct cpuremap_cpu *threads;
+} cpuremap_data;
+
+
+void cpuremap_init(void)
+{
+	int i, k;
+
+	/* Identify necessary constants & alloc memory at boot */
+	cpuremap_data.num_threads_per_core = 8;
+	cpuremap_data.num_cores = 32;
+	cpuremap_data.num_nodes =
+		nr_cpu_ids /
+		(cpuremap_data.num_threads_per_core * cpuremap_data.num_cores);
+	cpuremap_data.threads = kcalloc(nr_cpu_ids, sizeof(struct cpuremap_cpu), GFP_KERNEL);
+
+	k = cpuremap_data.num_nodes *
+		cpuremap_data.num_threads_per_core *
+		cpuremap_data.num_cores;
+	for (i = 0; i < k; k++)
+		cpuremap_data.threads[i].thread_index = CPUREMAP_NO_THREAD;
+}
+
+int cpuremap_thread_to_cpu(int thread_index)
+{
+	int i, k;
+
+	/* Return NO_CPU if not found */
+	for (i = thread_index, k = 0; k < nr_cpu_ids; k++) {
+		if (cpuremap_data.threads[i].in_use &&
+		    (cpuremap_data.threads[i].thread_index == thread_index)) {
+			cpuremap_data.threads[i].in_use = true;
+			cpuremap_data.threads[i].thread_index = thread_index;
+			return i;
+		}
+		if (i >= nr_cpu_ids)
+			i = 0;
+	}
+	return CPUREMAP_NO_CPU;
+}
+
+int cpuremap_cpu_to_thread(int cpu)
+{
+	/* Return NO_THREAD if not found */
+	if (cpuremap_data.threads[cpu].in_use)
+		return cpuremap_data.threads[cpu].thread_index;
+	return CPUREMAP_NO_THREAD;
+}
+
+int cpuremap_map_cpu(int thread_index, int in_core_ndx, int node)
+{
+	int first_thread, i, k;
+
+	/* Return NO_CPU if fails */
+	first_thread = (node *
+		(cpuremap_data.num_threads_per_core *
+		 cpuremap_data.num_cores)) + in_core_ndx;
+
+	/* Alternative 0: Compressed map of cpus+nodes+threads
+	 *   assuming that no system will be fully built out.
+	 * Alternative 1: Fully compact.  Allocate new cpu ids
+	 *   as needed.  No 'pretty' separation between nodes.
+	 * Alternative 2: Also map incoming nodes from pHyp
+	 *   to virtual nodes for purposes of new cpu ids.
+	 */
+
+	if (first_thread > nr_cpu_ids)
+		first_thread = 0 + in_core_ndx;
+	for (i = first_thread, k = 0; k < nr_cpu_ids; k++) {
+		if (!cpuremap_data.threads[i].in_use || (cpuremap_data.threads[i].thread_index == thread_index)) {
+			cpuremap_data.threads[i].thread_index = thread_index;
+			cpuremap_data.threads[i].node = node;
+			return i;
+		}
+		if (i >= nr_cpu_ids)
+			i = 0;
+	}
+	return CPUREMAP_NO_CPU;
+}
+
+int cpuremap_reserve_cpu(int cpu)
+{
+	if (!cpuremap_data.threads[cpu].in_use) {
+		cpuremap_data.threads[cpu].in_use = true;
+		return cpu;
+	}
+	return CPUREMAP_NO_CPU;
+}
+
+int cpuremap_release_cpu(int cpu)
+{
+	if (cpuremap_data.threads[cpu].in_use) {
+		cpuremap_data.threads[cpu].in_use = false;
+		return cpu;
+	}
+	return CPUREMAP_NO_CPU;
+}
+
+int cpuremap_free_cpu(int cpu)
+{
+	/* Return NO_CPU if fails */
+	if (cpuremap_data.threads[cpu].in_use) {
+		cpuremap_data.threads[cpu].in_use = false;
+		return cpu;
+	}
+	return CPUREMAP_NO_CPU;
+}

