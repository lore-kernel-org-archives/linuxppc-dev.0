Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYRp6h7FzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:52:38 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26Lmo0l107369
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 16:52:25 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2917pmgnfg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 16:52:25 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 18:52:22 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0C3341DC0029
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 16:52:22 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26LqFBV34406512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 18:52:20 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26Lq0NE012379
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 18:52:00 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf/hv-24x7: Fix off-by-one error in request_buffer
 check
Date: Mon,  6 Mar 2017 18:51:31 -0300
Message-Id: <1488837091-3835-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

request_buffer can hold 254 requests, so if it already has that number of
entries we can't add a new one.

Also, define constant to show where the number comes from.

Fixes: e3ee15dc5d19 ("powerpc/perf/hv-24x7: Define add_event_to_24x7_request()")
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 7b2ca16b1eb4..d83920db668f 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -166,6 +166,10 @@ DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
 DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
 DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
 
+#define MAX_NUM_REQUESTS	((H24x7_DATA_BUFFER_SIZE - \
+					sizeof(struct hv_24x7_request_buffer)) \
+					/ sizeof(struct hv_24x7_request))
+
 static char *event_name(struct hv_24x7_event_data *ev, int *len)
 {
 	*len = be16_to_cpu(ev->event_name_len) - 2;
@@ -1107,7 +1111,7 @@ static int add_event_to_24x7_request(struct perf_event *event,
 	int i;
 	struct hv_24x7_request *req;
 
-	if (request_buffer->num_requests > 254) {
+	if (request_buffer->num_requests >= MAX_NUM_REQUESTS) {
 		pr_devel("Too many requests for 24x7 HCALL %d\n",
 				request_buffer->num_requests);
 		return -EINVAL;
-- 
2.7.4
