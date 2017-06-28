Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wydnW3WPCzDr4Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:10:55 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SN3bcY066948
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:10:54 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcfq6yj6p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:10:53 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 20:10:51 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5SN6Xmn32309422
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 20:06:33 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5SNAnZk018620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 20:10:49 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 6/8] powerpc/perf/hv-24x7: Minor improvements
Date: Wed, 28 Jun 2017 20:10:24 -0300
In-Reply-To: <20170628231026.23190-1-bauerman@linux.vnet.ibm.com>
References: <20170628231026.23190-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20170628231026.23190-7-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's an H24x7_DATA_BUFFER_SIZE constant, so use it in init_24x7_request.

There's also an HV_PERF_DOMAIN_MAX constant, so use it in
h_24x7_event_init. This makes the comment above the check redundant,
so remove it.

In add_event_to_24x7_request, a statement is terminated with a comma
instead of a semicolon. Fix it.

In hv-24x7.h, improve comments in struct hv_24x7_result.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c |  9 ++++-----
 arch/powerpc/perf/hv-24x7.h | 11 ++++++++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 7e47dcdea62a..043cbc78be98 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1049,8 +1049,8 @@ static void init_24x7_request(struct hv_24x7_request_buffer *request_buffer,
 			      struct hv_24x7_data_result_buffer *result_buffer)
 {
 
-	memset(request_buffer, 0, 4096);
-	memset(result_buffer, 0, 4096);
+	memset(request_buffer, 0, H24x7_DATA_BUFFER_SIZE);
+	memset(result_buffer, 0, H24x7_DATA_BUFFER_SIZE);
 
 	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
 	/* memset above set request_buffer->num_requests to 0 */
@@ -1126,7 +1126,7 @@ static int add_event_to_24x7_request(struct perf_event *event,
 	req->performance_domain = event_get_domain(event);
 	req->data_size = cpu_to_be16(8);
 	req->data_offset = cpu_to_be32(event_get_offset(event));
-	req->starting_lpar_ix = cpu_to_be16(event_get_lpar(event)),
+	req->starting_lpar_ix = cpu_to_be16(event_get_lpar(event));
 	req->max_num_lpars = cpu_to_be16(1);
 	req->starting_ix = cpu_to_be16(idx);
 	req->max_ix = cpu_to_be16(1);
@@ -1218,9 +1218,8 @@ static int h_24x7_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* Domains above 6 are invalid */
 	domain = event_get_domain(event);
-	if (domain > 6) {
+	if (domain > HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
diff --git a/arch/powerpc/perf/hv-24x7.h b/arch/powerpc/perf/hv-24x7.h
index 634ef4082cdc..b95909400b2a 100644
--- a/arch/powerpc/perf/hv-24x7.h
+++ b/arch/powerpc/perf/hv-24x7.h
@@ -71,6 +71,10 @@ struct hv_24x7_result_element {
 } __packed;
 
 struct hv_24x7_result {
+	/*
+	 * The index of the 24x7 Request Structure in the 24x7 Request Buffer
+	 * used to request this result.
+	 */
 	__u8 result_ix;
 
 	/*
@@ -81,7 +85,12 @@ struct hv_24x7_result {
 	__u8 results_complete;
 	__be16 num_elements_returned;
 
-	/* This is a copy of @data_size from the corresponding hv_24x7_request */
+	/*
+	 * This is a copy of @data_size from the corresponding hv_24x7_request
+	 *
+	 * Warning: to obtain the size of each element in @elements you have
+	 * to add the size of the other members of the result_element struct.
+	 */
 	__be16 result_element_data_size;
 	__u8 reserved[0x2];
 
-- 
2.13.0
