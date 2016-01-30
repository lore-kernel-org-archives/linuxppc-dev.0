Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F731A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 14:07:26 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 29 Jan 2016 22:07:23 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 27ADCC90027
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 22:07:18 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0U37Jpi31850542
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 03:07:19 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0U37JL5011437
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 22:07:19 -0500
Date: Fri, 29 Jan 2016 19:07:10 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Fix usage with chip events
Message-ID: <20160130030710.GA7330@us.ibm.com>
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

>From 9b5848ce1834a4d82fc251022035d36d9e26b500 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Sat, 23 Jan 2016 03:58:12 -0500
Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Fix usage with chip events.

24x7 counters can belong to different domains (core, chip, virtual CPU
etc). For events in the 'chip' domain, sysfs entry currently looks like:

	$ cd /sys/bus/event_source/devices/hv_24x7/events
	$ cat PM_XLINK_CYCLES__PHYS_CHIP
	domain=0x1,offset=0x230,core=?,lpar=0x0

where the required parameter, 'core=?' is specified with perf as:

	perf stat -C 0 -e hv_24x7/PM_XLINK_CYCLES__PHYS_CHIP,core=1/ \
		/bin/true

This is inconsistent in that 'core' is a required parameter for a chip
event.  Instead, have the the sysfs entry display 'chip=?' for chip
events:

	$ cd /sys/bus/event_source/devices/hv_24x7/events
	$ cat PM_XLINK_CYCLES__PHYS_CHIP
	domain=0x1,offset=0x230,chip=?,lpar=0x0

We also need to add a 'chip' entry in the sysfs format directory:

	$ ls /sys/bus/event_source/devices/hv_24x7/format
	chip  core  domain  lpar  offset  vcpu
	^^^^
	(new)

so the perf tool can automatically check usage and format the chip
parameter correctly:

	$ perf stat -C 0 -v -e hv_24x7/PM_XLINK_CYCLES__PHYS_CHIP/ \
		/bin/true
	Required parameter 'chip' not specified
	invalid or unsupported event: 'hv_24x7/PM_XLINK_CYCLES__PHYS_CHIP/'

	$ perf stat -C 0 -v -e hv_24x7/PM_XLINK_CYCLES__PHYS_CHIP,chip=1/ \
		/bin/true
	hv_24x7/PM_XLINK_CYCLES__PHYS_CHIP,chip=1/: 0 6628908 6628908

	 Performance counter stats for 'CPU(s) 0':

	         0      hv_24x7/PM_XLINK_CYCLES__PHYS_CHIP,chip=1/

	    0.006606970 seconds time elapsed

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9f9dfda..b7a9a03 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -101,6 +101,7 @@ static bool catalog_entry_domain_is_valid(unsigned domain)
 EVENT_DEFINE_RANGE_FORMAT(domain, config, 0, 3);
 /* u16 */
 EVENT_DEFINE_RANGE_FORMAT(core, config, 16, 31);
+EVENT_DEFINE_RANGE_FORMAT(chip, config, 16, 31);
 EVENT_DEFINE_RANGE_FORMAT(vcpu, config, 16, 31);
 /* u32, see "data_offset" */
 EVENT_DEFINE_RANGE_FORMAT(offset, config, 32, 63);
@@ -115,6 +116,7 @@ static struct attribute *format_attrs[] = {
 	&format_attr_domain.attr,
 	&format_attr_offset.attr,
 	&format_attr_core.attr,
+	&format_attr_chip.attr,
 	&format_attr_vcpu.attr,
 	&format_attr_lpar.attr,
 	NULL,
@@ -289,10 +291,16 @@ static char *event_fmt(struct hv_24x7_event_data *event, unsigned domain)
 	const char *sindex;
 	const char *lpar;
 
-	if (is_physical_domain(domain)) {
+	switch (domain) {
+	case HV_PERF_DOMAIN_PHYS_CHIP:
+		lpar = "0x0";
+		sindex = "chip";
+		break;
+	case HV_PERF_DOMAIN_PHYS_CORE:
 		lpar = "0x0";
 		sindex = "core";
-	} else {
+		break;
+	default:
 		lpar = "?";
 		sindex = "vcpu";
 	}
@@ -1089,10 +1097,16 @@ static int add_event_to_24x7_request(struct perf_event *event,
 		return -EINVAL;
 	}
 
-	if (is_physical_domain(event_get_domain(event)))
+	switch (event_get_domain(event)) {
+	case HV_PERF_DOMAIN_PHYS_CHIP:
+		idx = event_get_chip(event);
+		break;
+	case HV_PERF_DOMAIN_PHYS_CORE:
 		idx = event_get_core(event);
-	else
+		break;
+	default:
 		idx = event_get_vcpu(event);
+	}
 
 	i = request_buffer->num_requests++;
 	req = &request_buffer->requests[i];
-- 
2.5.3
