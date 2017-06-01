Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf0F54K0QzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 07:03:37 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51Kwpr1058492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 17:03:26 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2att680tgf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 17:03:26 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 18:03:24 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51L3MUe62783510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:22 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51L3NlT003131
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:23 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 8/8] powerpc/perf/hv-24x7: Aggregate result elements on POWER9
 SMT8
Date: Thu,  1 Jun 2017 18:02:27 -0300
In-Reply-To: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1496350947-30951-9-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 SMT8 the 24x7 API returns two result elements for physical core
and virtual CPU events and we need to add their counts to get the final
result.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 58 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 95c44f1d2fd2..641f385e7eb0 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -31,6 +31,9 @@
 /* Version of the 24x7 hypervisor API that we should use in this machine. */
 static int interface_version;
 
+/* Whether we have to aggregate result data for some domains. */
+static bool aggregate_result_elements;
+
 static bool domain_is_valid(unsigned domain)
 {
 	switch (domain) {
@@ -58,6 +61,15 @@ static bool is_physical_domain(unsigned domain)
 	}
 }
 
+/* Domains for which more than one result element are returned for each event. */
+static bool domain_needs_aggregation(unsigned int domain)
+{
+	return aggregate_result_elements &&
+			(domain == HV_PERF_DOMAIN_PHYS_CORE ||
+			 (domain >= HV_PERF_DOMAIN_VCPU_HOME_CORE &&
+			  domain <= HV_PERF_DOMAIN_VCPU_REMOTE_NODE));
+}
+
 static const char *domain_name(unsigned domain)
 {
 	if (!domain_is_valid(domain))
@@ -1149,17 +1161,23 @@ static int add_event_to_24x7_request(struct perf_event *event,
 	req->starting_ix = cpu_to_be16(idx);
 	req->max_ix = cpu_to_be16(1);
 
-	if (request_buffer->interface_version > 1 &&
-	    req->performance_domain != HV_PERF_DOMAIN_PHYS_CHIP) {
-		req->starting_thread_group_ix = idx % 2;
-		req->max_num_thread_groups = 1;
+	if (request_buffer->interface_version > 1) {
+		if (domain_needs_aggregation(req->performance_domain))
+			req->max_num_thread_groups = -1;
+		else if (req->performance_domain != HV_PERF_DOMAIN_PHYS_CHIP) {
+			req->starting_thread_group_ix = idx % 2;
+			req->max_num_thread_groups = 1;
+		}
 	}
 
 	return 0;
 }
 
 /**
- * get_count_from_result - get event count from the given result
+ * get_count_from_result - get event count from all result elements in result
+ *
+ * If the event corresponding to this result needs aggregation of the result
+ * element values, then this function does that.
  *
  * @event:	Event associated with @res.
  * @resb:	Result buffer containing @res.
@@ -1176,7 +1194,8 @@ static int get_count_from_result(struct perf_event *event,
 	u16 data_size = be16_to_cpu(res->result_element_data_size);
 	unsigned int data_offset;
 	void *element_data;
-	int ret = 0;
+	int i, ret = 0;
+	u64 count;
 
 	/*
 	 * We can bail out early if the result is empty.
@@ -1192,9 +1211,11 @@ static int get_count_from_result(struct perf_event *event,
 	}
 
 	/*
-	 * This code assumes that a result has only one element.
+	 * This code assumes that a result has only one element, except
+	 * when an event needs aggregation.
 	 */
-	if (num_elements != 1) {
+	if (num_elements != 1 &&
+	    !domain_needs_aggregation(event_get_domain(event))) {
 		pr_debug("Error: result of request %hhu has %hu elements\n",
 			 res->result_ix, num_elements);
 
@@ -1225,14 +1246,19 @@ static int get_count_from_result(struct perf_event *event,
 		data_offset = offsetof(struct hv_24x7_result_element_v2,
 				       element_data);
 
-	element_data = res->elements + data_offset;
+	/* Go through the result elements in the result. */
+	for (i = count = 0, element_data = res->elements + data_offset;
+	     i < num_elements;
+	     i++, element_data += data_size + data_offset)
+		if (!ret)
+			count += be64_to_cpu(*((u64 *) element_data));
 
 	if (!ret)
-		*countp = be64_to_cpu(*((u64 *) element_data));
+		*countp = count;
 
-	/* The next result is after the result element. */
+	/* The next result is after the last result element. */
 	if (next)
-		*next = element_data + data_size;
+		*next = element_data - data_offset;
 
 	return ret;
 }
@@ -1580,9 +1606,13 @@ static int hv_24x7_init(void)
 	}
 
 	/* POWER8 only supports v1, while POWER9 only supports v2. */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		interface_version = 2;
-	else
+
+		/* SMT8 in POWER9 needs to aggregate result elements. */
+		if (threads_per_core == 8)
+			aggregate_result_elements = true;
+	} else
 		interface_version = 1;
 
 	hret = hv_perf_caps_get(&caps);
-- 
2.7.4
