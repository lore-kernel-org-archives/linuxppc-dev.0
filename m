Return-Path: <linuxppc-dev+bounces-23048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9C1C43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:11:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpbWd2PwQz2yd7;
	Mon, 29 Jun 2026 16:11:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782713485;
	cv=none; b=S6MNyLZIanMHC3VasqeJf3GqBGwO8Na8ijpsosWTMuit+5t8rZH53Z5wcLWViBd5ZmNHVuE5baeJyQwVTmH1cQaBIRFSgm4iVJV6mn77IckvwXVzVss+XHZRZuBV70Sp3JMBFti/HaKFopsbqOJlTJJrSj3/hadcuyGngDOpnG19if+XlyGS7++S90CM0xdIekGae3qWZ6bk84Y4QjGz56msEidVeIT0A7eRyVbxudGFNt/vK835Jut3T9yd/TeB31f5iiV7hvS1/OZgAPiW+LIMvnYMO1poOeY3vyB38hgdOspp2swJwNw6jmNYyGpXH2ZCS5uCktkS4ghU2qRpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782713485; c=relaxed/relaxed;
	bh=EnhouEDa9yUU7i/ckVrxEqVIxTCJn31PV/DgRcBxmo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKVN/tGZarFK/eqX66CkgeFZtP7Uchn2ODPsIfy/q+4AER+q9MgqaeiLRe7YneJj4unHSScM+D52YLtwxvpd4GYT6v3QTQ58K3L/0824rMvcfGCiA7CP6W80Hc5NKCYtBa90ZFPQB47oT79ploF2EBCY4E2lbRQRLBfbFa8SS0lFujnUTee9FOsEiML9cabaimY+/OANwKJDfjX8Ovq3qiFm3/8GcmmicjNYQBO2eTXfH1li7DYHR+CzAIjHVMTbu5DwjIyPIerPzjbHH9eHWaZ0UTywEkbwGAu44XX6bzsfFjGWko168yPBnvZlNzgipXunkeLYT8voVuLzjWTi+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=npY79DJz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=npY79DJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpbWZ73lmz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 16:11:21 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T3IT0q2098939;
	Mon, 29 Jun 2026 06:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EnhouEDa9yUU7i/ck
	VrxEqVIxTCJn31PV/DgRcBxmo8=; b=npY79DJzm1te9RXdc5jFoC0/rnjQil1sk
	76iics8ADoWdG/wTA2z4Aew6WM+qmYAw0LKX4k64eCWBInRRUxGtOv9VvaV1+x6Y
	SAcFBDaGi6ExIvqtd/0U1201+ztkb6vBevtv9C0YgJqEjIrT29cxP7K6o3C66wX8
	VPN0hk8i3c5/xuBRlilIDFwy80o7WIqk7RnebsRw0wfqfXBD/5GiqUAEk7a8iOk6
	blDuGcpV5xZnFcOlaj6oAlC9CofkPwgsPrYJFNQCv3Wl3L/RAcqFwt295dnCqGDo
	/MbhFFe8Dp58Vk66Ob+9ZUTAsv4xn57QcqT6gQD8d7gJsRwqBzjSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdqsn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T64xq0011497;
	Mon, 29 Jun 2026 06:11:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7vv767-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T6BCQA14156196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 06:11:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D4420049;
	Mon, 29 Jun 2026 06:11:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5242820040;
	Mon, 29 Jun 2026 06:11:11 +0000 (GMT)
Received: from dhcp-9-123-15-26.bl1-in.ibm.com (unknown [9.123.15.26])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 06:11:11 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com,
        shivani@linux.ibm.com, tshah@linux.ibm.com
Subject: [RFC 1/3] powerpc/perf: Register PMU from device tree and expose events
Date: Mon, 29 Jun 2026 11:40:20 +0530
Message-ID: <20260629061101.43119-2-shivani@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260629061101.43119-1-shivani@linux.ibm.com>
References: <20260629061101.43119-1-shivani@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hZ9IjdF7OAR2AIy5kWzB_pI90KrLndAy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfX/wMQZVCyNYbZ
 IOv/VXnpyLBWxyVwqDwcHRKI4LWy5+FZ/cnBffa5gVIEYnvsCsPp9fb6YnOQq63Xc6su3K+sxXU
 400KOIoGZ8OXClWKhOCLXCS8c9T//3Y=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a420c86 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pqDV2N876HMRgRtTpwkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfXyapQ3nbKelZa
 VsNkiNibhY2wJ7jjG25lyXyNRBOGzhdloaul8lyhFHEj6Rxv+pol+LbW8VrYX2coeIs3UfzY5Ie
 QQltidmp4DnVfdq8jh5/qRlJrCswDj7qglw/7puqCxI03ucS7BtDC77o4xka9IEtJMwvRNj8s3X
 DpxBrtA8FcG5C/DlpKykdjTm8Ivg1xwLjWI+rzZa8mZa8KFnK5vOGB/wbp+ijPkp7VnkX3zbLRC
 dlq0mNuti6uNAreWV8W1S7Wyquc2iYActewW1G6XhVPAwZ9lINdzCfMWukHGyFGed1OPxFduKrs
 MS8A/Q3+wf8/j2ImR8q4hQ3UoP+zVQ3d496+kjIcOinTQH/B15hjUjemI2sVo0+EdlXnssKAx1A
 5fY9MJxM2noUnmUCnUbwFNKDmV+wfeKTdQBtzusbwyjT6jI6aZ3qhDLXNRGCatenK8nUzHQOkYh
 17wfaAUe8U1PEOSxesw==
X-Proofpoint-ORIG-GUID: hZ9IjdF7OAR2AIy5kWzB_pI90KrLndAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290047

Introduce a DTS-based PMU driver that discovers PMU information
from the device tree and registers a PowerPC PMU instance at
runtime.

The driver parses basic PMU properties such as the number of
counters and MMCR register definitions, creates sysfs event
entries from the device tree event descriptions, and registers
the PMU with the perf subsystem.

To support dynamic PMU registration, add PMU unregistration
support and create a platform device for PMU nodes described
in the device tree.

This forms the foundation for moving PMU descriptions out of
architecture-specific kernel code and into device tree data.

The driver implements the following functionality:

Device Tree Parsing:
- Reads PMU properties including counter count (nr_pmc), PMU name,
  version, and platform information
- Parses MMCR (Monitor Mode Control Register) definitions from the
  sprs/mmcr node hierarchy, storing the MMCR register SPRNs
- Extracts event definitions from the events node, supporting both
  32-bit and 64-bit event codes

Dynamic Event Registration:
- Creates sysfs event entries dynamically from device tree event
  descriptions
- Generates event attributes with format "event=0x<code>" for each
  discovered event
- Exposes events under /sys/devices/<pmu-name>/events/

PMU Registration:
- Registers a power_pmu instance with the perf subsystem using the
  device tree-provided PMU name
- Adds PMU unregistration support to enable proper cleanup
- Creates platform device for "ibm,power-pmu" compatible nodes

Sysfs Interface:
- Provides format attributes (event, pmcsel) under
  /sys/devices/<pmu-name>/format/
- Exposes device tree debug information (nr_pmc) under
  /sys/devices/<pmu-name>/dt/

Platform Integration:
- Adds opal_pmus_init_dev() to create platform devices for PMU nodes
  during OPAL initialization on PowerNV systems
- Uses platform driver model with probe/remove callbacks

With the device tree based PMU registered:
 # ls /sys/devices/cpu_dts/events/

 # Snippet of "perf list" :

  cpu_dts/branch-finished/                               [Kernel PMU event]
  cpu_dts/branch-mispredict-finished/                    [Kernel PMU event]
  cpu_dts/branch-misses/                                 [Kernel PMU event]
  cpu_dts/branches/                                      [Kernel PMU event]
  cpu_dts/cycles/                                        [Kernel PMU event]

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
---
 arch/powerpc/include/asm/dts_pmu.h    |  12 ++
 arch/powerpc/perf/Makefile            |   3 +-
 arch/powerpc/perf/core-book3s.c       |  12 +-
 arch/powerpc/perf/dts_pmu.c           | 257 ++++++++++++++++++++++++++
 arch/powerpc/perf/internal.h          |   1 +
 arch/powerpc/perf/isa207-common.c     |   1 +
 arch/powerpc/platforms/powernv/opal.c |  15 ++
 7 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/dts_pmu.h
 create mode 100644 arch/powerpc/perf/dts_pmu.c

diff --git a/arch/powerpc/include/asm/dts_pmu.h b/arch/powerpc/include/asm/dts_pmu.h
new file mode 100644
index 000000000000..791dda370de8
--- /dev/null
+++ b/arch/powerpc/include/asm/dts_pmu.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_DTS_PMU_H
+#define _ASM_DTS_PMU_H
+
+#include <linux/types.h>
+
+#define MAX_MMCR   5
+#define MAX_DTS_EVENTS 32
+#define MAX_PMU_COUNTERS 6
+
+extern u32 mmcr_regs_sprs[MAX_MMCR];
+extern int mmcr_count;
+#endif
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 78dd7e25219e..537f4b87cffe 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -7,7 +7,8 @@ obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
 				   isa207-common.o power8-pmu.o power9-pmu.o \
-				   generic-compat-pmu.o power10-pmu.o bhrb.o
+				   generic-compat-pmu.o power10-pmu.o bhrb.o \
+				   dts_pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_PPC_POWERNV)	+= imc-pmu.o
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8b0081441f85..f33ed1423046 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2569,12 +2569,19 @@ int __init register_power_pmu(struct power_pmu *pmu)
 		freeze_events_kernel = MMCR0_FCHV;
 #endif /* CONFIG_PPC64 */
 
-	perf_pmu_register(&power_pmu, "cpu", PERF_TYPE_RAW);
+	perf_pmu_register(&power_pmu, pmu->name, PERF_TYPE_RAW);
 	cpuhp_setup_state(CPUHP_PERF_POWER, "perf/powerpc:prepare",
 			  power_pmu_prepare_cpu, NULL);
 	return 0;
 }
 
+void unregister_power_pmu(struct power_pmu *pmu)
+{
+	if (!ppmu)
+		return;
+
+	perf_pmu_unregister(&power_pmu);
+}
 #ifdef CONFIG_PPC64
 static bool pmu_override = false;
 static unsigned long pmu_override_val;
@@ -2588,6 +2595,9 @@ static void do_pmu_override(void *data)
 
 static int __init init_ppc64_pmu(void)
 {
+	/* Disable registering PMU from here and enable picking from device tree */
+	return 0;
+
 	if (cpu_has_feature(CPU_FTR_HVMODE) && pmu_override) {
 		pr_warn("disabling perf due to pmu_override= command line option.\n");
 		on_each_cpu(do_pmu_override, NULL, 1);
diff --git a/arch/powerpc/perf/dts_pmu.c b/arch/powerpc/perf/dts_pmu.c
new file mode 100644
index 000000000000..67eabd5ec6e5
--- /dev/null
+++ b/arch/powerpc/perf/dts_pmu.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/dts_pmu.h>
+
+
+extern void unregister_power_pmu(struct power_pmu *pmu);
+static u32 pmu_dts_nr_pmc;
+
+u32 mmcr_regs_sprs[MAX_MMCR];
+int mmcr_count;
+
+struct pmu_dts_event {
+	struct device_attribute attr;
+	char name[32];
+	char config[32];
+};
+
+static struct pmu_dts_event *dts_events[MAX_DTS_EVENTS];
+static struct attribute *pmu_dts_events_attrs[MAX_DTS_EVENTS + 1];
+static int dts_event_count;
+
+static ssize_t pmu_dts_event_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct pmu_dts_event *evt =
+			container_of(attr, struct pmu_dts_event, attr);
+
+	return sprintf(buf, "%s\n", evt->config);
+}
+
+/* Format attributes */
+PMU_FORMAT_ATTR(event, "config:0-59");
+PMU_FORMAT_ATTR(pmcsel, "config1:18-25");
+
+static struct attribute *pmu_dts_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_pmcsel.attr,
+	NULL,
+};
+
+static struct attribute_group pmu_dts_format_group = {
+	.name = "format",
+	.attrs = pmu_dts_format_attrs,
+};
+
+static ssize_t nr_pmc_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "%u\n", pmu_dts_nr_pmc);
+}
+
+static DEVICE_ATTR_RO(nr_pmc);
+
+static struct attribute *pmu_dts_dt_attrs[] = {
+	&dev_attr_nr_pmc.attr,
+	NULL,
+};
+
+static struct attribute_group pmu_dts_dt_group = {
+	.name = "dt",
+	.attrs = pmu_dts_dt_attrs,
+};
+
+static struct attribute_group pmu_dts_events_group = {
+	.name = "events",
+	.attrs = pmu_dts_events_attrs,
+};
+
+static const struct attribute_group *pmu_dts_attr_groups[] = {
+	&pmu_dts_events_group,
+	&pmu_dts_format_group,
+	&pmu_dts_dt_group,
+	NULL,
+};
+
+static struct power_pmu dts_pmu = {
+	.name           = "cpu_dts",
+	.n_counter      = MAX_PMU_COUNTERS,
+	.attr_groups    = pmu_dts_attr_groups,
+};
+
+/* Device Tree match */
+static const struct of_device_id pmu_dts_of_match[] = {
+	{ .compatible = "ibm,power-pmu" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmu_dts_of_match);
+
+/* Probe function */
+static int pmu_dts_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node, *child, *events_np;
+	struct device_node *sprs_np, *mmcr_np, *mmcr_child;
+	struct pmu_dts_event *evt;
+	u64 code;
+	u32 code32, sprn;
+	u32 code64[2];
+	u32 code128[4];
+	int cells;
+	const char *str;
+
+	pr_info("PMU DTS probe node = %s\n", np->full_name);
+
+	if (!of_property_present(np, "nr_pmc")) {
+
+		for_each_child_of_node(np, child) {
+			pr_info("child node = %s\n", child->full_name);
+
+			if (of_property_present(child, "nr_pmc")) {
+				np = child;
+				break;
+			}
+		}
+	}
+
+	if (of_property_read_u32(np, "nr_pmc", &pmu_dts_nr_pmc)) {
+		pr_err("pmu_dts: nr_pmc not found in %s\n", np->full_name);
+		return -EINVAL;
+	}
+
+	if (!of_property_read_string(np, "pmu-name", &str))
+		pr_info("PMU Name: %s\n", str);
+
+	if (!of_property_read_string(np, "pmu-version", &str))
+		pr_info("PMU Version: %s\n", str);
+
+	if (!of_property_read_string(np, "platform", &str))
+		pr_info("Platform: %s\n", str);
+
+	sprs_np = of_get_child_by_name(np, "sprs");
+	if (!sprs_np) {
+		pr_err("pmu_dts: no sprs node\n");
+		return -EINVAL;
+	}
+
+	mmcr_np = of_get_child_by_name(sprs_np, "mmcr");
+	if (!mmcr_np) {
+		pr_err("pmu_dts: no mmcr node\n");
+		return -EINVAL;
+	}
+
+	mmcr_count = 0;
+	for_each_child_of_node(mmcr_np, mmcr_child) {
+
+		if (of_property_read_u32(mmcr_child, "sprn", &sprn))
+			continue;
+
+		mmcr_regs_sprs[mmcr_count++] = sprn;
+		pr_info("pmu_dts: MMCR[%d] = %u (%s)\n", mmcr_count - 1,
+				sprn, mmcr_child->name);
+
+		if (mmcr_count >= MAX_MMCR)
+			break;
+	}
+
+	if (!mmcr_count) {
+		pr_err("pmu_dts: no MMCR SPRs found\n");
+		return -EINVAL;
+	}
+
+	/* Parse events */
+	events_np = of_get_child_by_name(np, "events");
+	if (!events_np) {
+		pr_err("pmu_dts: no events node found\n");
+		return -EINVAL;
+	}
+
+	dts_event_count = 0;
+	for_each_child_of_node(events_np, child) {
+		if (!of_device_is_available(child))
+			continue;
+
+		cells = of_property_count_u32_elems(child, "event_code");
+		if (cells == 1) {
+			if (of_property_read_u32(child, "event_code", &code32))
+				continue;
+
+			code = code32;
+
+		} else if (cells == 2) {
+			if (of_property_read_u32_array(child, "event_code", code64, 2))
+				continue;
+			code = ((u64)code64[0] << 32) | code64[1];
+
+		} else if (cells == 4) {
+			if (of_property_read_u32_array(child, "event_code", code128, 4))
+				continue;
+			code = ((u64)code128[1] << 32) | code128[3];
+
+		} else {
+			pr_warn("pmu_dts: invalid event_code for %s\n", child->name);
+			continue;
+		}
+
+		evt = kzalloc(sizeof(*evt), GFP_KERNEL);
+		if (!evt)
+			continue;
+
+		snprintf(evt->name, sizeof(evt->name), "%s", child->name);
+		snprintf(evt->config, sizeof(evt->config), "event=0x%llx", code);
+
+		sysfs_attr_init(&evt->attr.attr);
+		evt->attr.attr.name = evt->name;
+		evt->attr.attr.mode = 0444;
+		evt->attr.show = pmu_dts_event_show;
+		dts_events[dts_event_count] = evt;
+		pmu_dts_events_attrs[dts_event_count] = &evt->attr.attr;
+		dts_event_count++;
+
+		if (dts_event_count >= MAX_DTS_EVENTS)
+			break;
+	}
+	pmu_dts_events_attrs[dts_event_count] = NULL;
+
+	/* Register PMU */
+	pr_info("pmu_dts: registering PMU\n");
+	return register_power_pmu(&dts_pmu);
+}
+
+/* Platform driver */
+static struct platform_driver pmu_dts_driver = {
+	.probe = pmu_dts_probe,
+	.driver = {
+		.name = "pmu_dts",
+		.of_match_table = pmu_dts_of_match,
+	},
+};
+
+static int __init pmu_dts_init(void)
+{
+	pr_info("pmu_dts: init\n");
+	return platform_driver_register(&pmu_dts_driver);
+}
+
+static void __exit pmu_dts_exit(void)
+{
+	pr_info("pmu_dts: exit\n");
+	platform_driver_unregister(&pmu_dts_driver);
+	unregister_power_pmu(&dts_pmu);
+}
+module_init(pmu_dts_init);
+module_exit(pmu_dts_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Shivani Nittor");
+MODULE_DESCRIPTION("PMU DTS driver");
diff --git a/arch/powerpc/perf/internal.h b/arch/powerpc/perf/internal.h
index a70ac471a5a5..11154ee31f8e 100644
--- a/arch/powerpc/perf/internal.h
+++ b/arch/powerpc/perf/internal.h
@@ -2,6 +2,7 @@
 //
 // Copyright 2019 Madhavan Srinivasan, IBM Corporation.
 
+void unregister_power_pmu(struct power_pmu *pmu);
 int __init init_ppc970_pmu(void);
 int __init init_power5_pmu(void);
 int __init init_power5p_pmu(void);
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 2b3547fdba4a..e11d1bbbc27b 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -7,6 +7,7 @@
  * Copyright 2016 Madhavan Srinivasan, IBM Corporation.
  */
 #include "isa207-common.h"
+#include <asm/dts_pmu.h>
 
 PMU_FORMAT_ATTR(event,		"config:0-49");
 PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..35be67eef2c6 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -947,6 +947,18 @@ static void __init opal_imc_init_dev(void)
 
 	of_node_put(np);
 }
+#define PMU_DTB "ibm,power-pmu"
+
+static void __init opal_pmus_init_dev(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, PMU_DTB);
+	if (np)
+		of_platform_device_create(np, NULL, NULL);
+
+	of_node_put(np);
+}
 
 static int kopald(void *unused)
 {
@@ -1032,6 +1044,9 @@ static int __init opal_init(void)
 	/* Detect In-Memory Collection counters and create devices*/
 	opal_imc_init_dev();
 
+    /*Detect PMU node and create device*/
+	opal_pmus_init_dev();
+
 	/* Create leds platform devices */
 	leds = of_find_node_by_path("/ibm,opal/leds");
 	if (leds) {
-- 
2.54.0


