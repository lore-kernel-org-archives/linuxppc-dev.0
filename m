Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf0Dv0PZ2zDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 07:03:26 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51Kwqvq046285
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 17:03:19 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atsv7hgn3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 17:03:19 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 18:03:16 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51L3DCM5505160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:13 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51L3D2Y002931
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:13 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 4/8] powerpc-perf/hx-24x7: Don't log failed hcall twice
Date: Thu,  1 Jun 2017 18:02:23 -0300
In-Reply-To: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1496350947-30951-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

make_24x7_request already calls log_24x7_hcall if it fails, so callers
don't have to do it again.

In fact, since the latter is now only called from the former, there's no
need for a separate log_24x7_hcall anymore so remove it.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 8b1a3e849d23..111c61ea7416 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1044,21 +1044,6 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
-static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
-			   struct hv_24x7_data_result_buffer *result_buffer,
-			   unsigned long ret)
-{
-	struct hv_24x7_request *req;
-
-	req = &request_buffer->requests[0];
-	pr_notice_ratelimited("hcall failed: [%d %#x %#x %d] => "
-			"ret 0x%lx (%ld) detail=0x%x failing ix=%x\n",
-			req->performance_domain, req->data_offset,
-			req->starting_ix, req->starting_lpar_ix, ret, ret,
-			result_buffer->detailed_rc,
-			result_buffer->failing_request_ix);
-}
-
 /*
  * Start the process for a new H_GET_24x7_DATA hcall.
  */
@@ -1091,8 +1076,16 @@ static int make_24x7_request(struct hv_24x7_request_buffer *request_buffer,
 			virt_to_phys(request_buffer), H24x7_DATA_BUFFER_SIZE,
 			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
 
-	if (ret)
-		log_24x7_hcall(request_buffer, result_buffer, ret);
+	if (ret) {
+		struct hv_24x7_request *req;
+
+		req = &request_buffer->requests[0];
+		pr_notice_ratelimited("hcall failed: [%d %#x %#x %d] => ret 0x%lx (%ld) detail=0x%x failing ix=%x\n",
+				      req->performance_domain, req->data_offset,
+				      req->starting_ix, req->starting_lpar_ix,
+				      ret, ret, result_buffer->detailed_rc,
+				      result_buffer->failing_request_ix);
+	}
 
 	return ret;
 }
@@ -1163,10 +1156,8 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 		goto out;
 
 	ret = make_24x7_request(request_buffer, result_buffer);
-	if (ret) {
-		log_24x7_hcall(request_buffer, result_buffer, ret);
+	if (ret)
 		goto out;
-	}
 
 	result = result_buffer->results;
 
@@ -1428,10 +1419,8 @@ static int h_24x7_event_commit_txn(struct pmu *pmu)
 	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
 
 	ret = make_24x7_request(request_buffer, result_buffer);
-	if (ret) {
-		log_24x7_hcall(request_buffer, result_buffer, ret);
+	if (ret)
 		goto put_reqb;
-	}
 
 	h24x7hw = &get_cpu_var(hv_24x7_hw);
 
-- 
2.7.4
