Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0332E1A0140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 13:05:10 +1000 (AEST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 23:05:08 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8C00838C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 23:05:05 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3U355jl46727242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 03:05:05 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3U352e6011929
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 23:05:03 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/1] powerpc/hv-24x7: Check support before registering PMU
Date: Wed, 29 Apr 2015 20:04:51 -0700
Message-Id: <1430363091-27722-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: gusld@br.ibm.com, linuxppc-dev@lists.ozlabs.org, dev@codyps.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently try to register the 24x7 PMU unconditionally. Not all
Power systems support 24x7 counters (eg: Power7). On these systems
we get a backtrace during boot when trying to register the 24x7 PMU.

Check if the hypervisor supports 24x7 counters before attempting to
register the 24x7 PMU.

Reported-by: Gustavo Luiz Duarte <gusld@br.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index ec2eb20..19a59a3 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1268,12 +1268,44 @@ static struct pmu h_24x7_pmu = {
 	.read        = h_24x7_event_read,
 };
 
+/*
+ * Return 1 if we can access the 24x7 counter catalog from the hypervisor.
+ * Return 0 otherwise.
+ */
+static int hv_has_24x7(void)
+{
+	int page_size = 4096;
+	unsigned long hret;
+	void *page;
+	struct hv_24x7_catalog_page_0 *page_0;
+
+	page_0 = kmalloc(page_size*2, GFP_KERNEL);
+	if (!page_0)
+		return 0;
+
+	/* buffer for catalog needs to be 4K-aligned */
+	page = (void *)((long)page_0 & (~page_size-1)) + page_size;
+	hret = h_get_24x7_catalog_page(page, 0, 0);
+	kfree(page_0);
+
+	if (hret) {
+		pr_devel("Error %ld reading catalog, disabling 24x7 PMU\n", hret);
+		return 0;
+	}
+
+	return 1;
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
1.8.3.1
