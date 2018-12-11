Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59092C67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:09:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BB92084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BB92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DvJ40GyDzDqXR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:09:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dv9K1vV4zDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 09:04:04 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBBM3aX0091043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 17:04:02 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pamw8sxt3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 17:04:02 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 11 Dec 2018 22:04:01 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Dec 2018 22:03:58 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBBM3tFd20119698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 22:03:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A48F67805F;
 Tue, 11 Dec 2018 22:03:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 743147805E;
 Tue, 11 Dec 2018 22:03:55 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 11 Dec 2018 22:03:55 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 20E6F489EFAB;
 Tue, 11 Dec 2018 16:03:55 -0600 (CST)
Subject: [RFC 2/3] powerpc/numa: Define mapping between HW and kernel cpus
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 11 Dec 2018 16:03:55 -0600
In-Reply-To: <20181211220321.87502.72082.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <20181211220321.87502.72082.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121122-0004-0000-0000-000014C0BFBF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130389; UDB=6.00587377; IPR=6.00910522; 
 MB=3.00024658; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-11 22:04:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121122-0005-0000-0000-000089D17B8E
Message-Id: <20181211220350.87502.78343.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-11_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110194
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
Cc: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>,
 tlfalcon@linux.vnet.ibm.com, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidyan@in.ibm.com>, mwb@linux.vnet.ibm.com,
 minkim@us.ibm.com, Paul Mackerras <paulus@samba.org>,
 tyreld@linux.vnet.ibm.com, Oliver O'Halloran <oohall@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Corentin Labbe <clabbe@baylibre.com>
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

