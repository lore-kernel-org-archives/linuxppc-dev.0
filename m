Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC5EA1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 10:24:53 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 18:24:51 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id F1503C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 18:24:45 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GNOm2336569150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 23:24:48 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GNOll3023702
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 18:24:48 -0500
Date: Tue, 16 Feb 2016 15:24:27 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Display domain indices in sysfs
Message-ID: <20160216232427.GA27660@us.ibm.com>
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

>From aff5a822e873522b9a3f355f816547394b452a64 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 20:07:51 -0500
Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Display domain indices in sysfs

To help users determine domains, display the domain indices used by the
kernel in sysfs.

	$ cat /sys/bus/event_source/devices/hv_24x7/interface/domains
	1: Physical Chip
	2: Physical Core
	3: VCPU Home Core
	4: VCPU Home Chip
	5: VCPU Home Node
	6: VCPU Remote Node

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/hv-24x7.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 77b958f..36b29fd 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -68,6 +68,24 @@ static bool is_physical_domain(unsigned domain)
 	}
 }
 
+static const char *domain_name(unsigned domain)
+{
+	if (!domain_is_valid(domain))
+		return NULL;
+
+	switch (domain) {
+	case HV_PERF_DOMAIN_PHYS_CHIP:		return "Physical Chip";
+	case HV_PERF_DOMAIN_PHYS_CORE:		return "Physical Core";
+	case HV_PERF_DOMAIN_VCPU_HOME_CORE:	return "VCPU Home Core";
+	case HV_PERF_DOMAIN_VCPU_HOME_CHIP:	return "VCPU Home Chip";
+	case HV_PERF_DOMAIN_VCPU_HOME_NODE:	return "VCPU Home Node";
+	case HV_PERF_DOMAIN_VCPU_REMOTE_NODE:	return "VCPU Remote Node";
+	}
+
+	WARN_ON_ONCE(domain);
+	return NULL;
+}
+
 static bool catalog_entry_domain_is_valid(unsigned domain)
 {
 	return is_physical_domain(domain);
@@ -969,6 +987,27 @@ e_free:
 	return ret;
 }
 
+static ssize_t domains_show(struct device *dev, struct device_attribute *attr,
+			    char *page)
+{
+	int d, n, count = 0;
+	const char *str;
+
+	for (d = 0; d < HV_PERF_DOMAIN_MAX; d++) {
+		str = domain_name(d);
+		if (!str)
+			continue;
+
+		n = sprintf(page, "%d: %s\n", d, str);
+		if (n < 0)
+			break;
+
+		count += n;
+		page += n;
+	}
+	return count;
+}
+
 #define PAGE_0_ATTR(_name, _fmt, _expr)				\
 static ssize_t _name##_show(struct device *dev,			\
 			    struct device_attribute *dev_attr,	\
@@ -997,6 +1036,7 @@ PAGE_0_ATTR(catalog_version, "%lld\n",
 PAGE_0_ATTR(catalog_len, "%lld\n",
 		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
 static BIN_ATTR_RO(catalog, 0/* real length varies */);
+static DEVICE_ATTR_RO(domains);
 
 static struct bin_attribute *if_bin_attrs[] = {
 	&bin_attr_catalog,
@@ -1006,6 +1046,7 @@ static struct bin_attribute *if_bin_attrs[] = {
 static struct attribute *if_attrs[] = {
 	&dev_attr_catalog_len.attr,
 	&dev_attr_catalog_version.attr,
+	&dev_attr_domains.attr,
 	NULL,
 };
 
diff --git a/arch/powerpc/perf/hv-24x7.h b/arch/powerpc/perf/hv-24x7.h
index 0f9fa21..2d7f4e4 100644
--- a/arch/powerpc/perf/hv-24x7.h
+++ b/arch/powerpc/perf/hv-24x7.h
@@ -7,6 +7,7 @@ enum hv_perf_domains {
 #define DOMAIN(n, v, x, c) HV_PERF_DOMAIN_##n = v,
 #include "hv-24x7-domains.h"
 #undef DOMAIN
+	HV_PERF_DOMAIN_MAX,
 };
 
 struct hv_24x7_request {
-- 
1.8.3.1
