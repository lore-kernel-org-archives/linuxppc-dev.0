Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 82C6E2C034E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 08:32:30 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:32:27 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AFF9038C8027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:32:24 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1RLWOwW1769818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 21:32:24 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1RLWN2Y001719
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:32:24 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH v3 07/11] powerpc/perf: add a shared interface to get gpci
 version and capabilities
Date: Thu, 27 Feb 2014 13:05:00 -0800
Message-Id: <1393535105-7528-8-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exposes a simple way to grab the firmware provided
collect_priveliged, ga, expanded, and lab capability bits. All of these
bits come in from the same gpci request, so we've exposed all of them.

Only the collect_priveliged bit is really used by the hv-gpci/hv-24x7
code, the other bits are simply exposed in sysfs to inform the user.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-common.c | 39 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/hv-common.h | 17 +++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/powerpc/perf/hv-common.c
 create mode 100644 arch/powerpc/perf/hv-common.h

diff --git a/arch/powerpc/perf/hv-common.c b/arch/powerpc/perf/hv-common.c
new file mode 100644
index 0000000..47e02b3
--- /dev/null
+++ b/arch/powerpc/perf/hv-common.c
@@ -0,0 +1,39 @@
+#include <asm/io.h>
+#include <asm/hvcall.h>
+
+#include "hv-gpci.h"
+#include "hv-common.h"
+
+unsigned long hv_perf_caps_get(struct hv_perf_caps *caps)
+{
+	unsigned long r;
+	struct p {
+		struct hv_get_perf_counter_info_params params;
+		struct cv_system_performance_capabilities caps;
+	} __packed __aligned(sizeof(uint64_t));
+
+	struct p arg = {
+		.params = {
+			.counter_request = cpu_to_be32(
+					CIR_SYSTEM_PERFORMANCE_CAPABILITIES),
+			.starting_index = cpu_to_be32(-1),
+			.counter_info_version_in = 0,
+		}
+	};
+
+	r = plpar_hcall_norets(H_GET_PERF_COUNTER_INFO,
+			       virt_to_phys(&arg), sizeof(arg));
+
+	if (r)
+		return r;
+
+	pr_devel("capability_mask: 0x%x\n", arg.caps.capability_mask);
+
+	caps->version = arg.params.counter_info_version_out;
+	caps->collect_privileged = !!arg.caps.perf_collect_privileged;
+	caps->ga = !!(arg.caps.capability_mask & CV_CM_GA);
+	caps->expanded = !!(arg.caps.capability_mask & CV_CM_EXPANDED);
+	caps->lab = !!(arg.caps.capability_mask & CV_CM_LAB);
+
+	return r;
+}
diff --git a/arch/powerpc/perf/hv-common.h b/arch/powerpc/perf/hv-common.h
new file mode 100644
index 0000000..7e615bd
--- /dev/null
+++ b/arch/powerpc/perf/hv-common.h
@@ -0,0 +1,17 @@
+#ifndef LINUX_POWERPC_PERF_HV_COMMON_H_
+#define LINUX_POWERPC_PERF_HV_COMMON_H_
+
+#include <linux/types.h>
+
+struct hv_perf_caps {
+	u16 version;
+	u16 collect_privileged:1,
+	    ga:1,
+	    expanded:1,
+	    lab:1,
+	    unused:12;
+};
+
+unsigned long hv_perf_caps_get(struct hv_perf_caps *caps);
+
+#endif
-- 
1.9.0
