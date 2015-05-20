Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A05541A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 09:34:47 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 20 May 2015 17:34:45 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3E8C33E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 17:34:43 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4KNYgoX53412008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 16:34:43 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4KNYgub019557
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 17:34:42 -0600
Date: Wed, 20 May 2015 16:34:16 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] powerpc/perf/hv-24x7: Check support before registering
Message-ID: <20150520233416.GA10270@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 955102eacf035b19080dc659a15d9b8fbd8fae7f Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 18:47:58 -0400
Subject: [PATCH 1/1] powerpc/perf/hv-24x7: Check support before registering
 PMU

We currently try to register the 24x7 PMU unconditionally. Not all
Power systems support 24x7 counters (eg: Power7). On these systems
we get a backtrace during boot when trying to register the 24x7 PMU.

Check if the hypervisor supports 24x7 counters before attempting to
register the 24x7 PMU.

Reported-by: Gustavo Luiz Duarte <gusld@br.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Changelog[v2]
	- [Michael Ellerman] Simplify check with bogus parameters.
---
 arch/powerpc/perf/hv-24x7.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index ec2eb20..c04a332 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1268,12 +1268,33 @@ static struct pmu h_24x7_pmu = {
 	.read        = h_24x7_event_read,
 };
 
+/*
+ * Return 1 if we can access the 24x7 counter catalog from the hypervisor.
+ * Return 0 otherwise.
+ */
+static bool hv_has_24x7(void)
+{
+	unsigned long hret;
+
+	hret = h_get_24x7_catalog_page(0, 0, 0);
+
+	if (hret != H_FUNCTION)
+		pr_err("Error %ld reading catalog, disabling 24x7 PMU\n", hret);
+
+	return hret == 0;
+
+}
+
+
 static int hv_24x7_init(void)
 {
 	int r;
 	unsigned long hret;
 	struct hv_perf_caps caps;
 
+	if (!hv_has_24x7())
+		return -ENODEV;
+
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		pr_debug("not a virtualized system, not enabling\n");
 		return -ENODEV;
-- 
1.7.9.5
