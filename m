Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzD4g6RKpzDr5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 07:56:03 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TLsASI087734
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:56:02 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bd282w81u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:56:01 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 18:55:59 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TLtuY362062806
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:55:57 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TLtvnM030178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:55:57 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v3 2/8] powerpc/perf/hv-24x7: Fix off-by-one error in
 request_buffer check
Date: Thu, 29 Jun 2017 18:55:32 -0300
In-Reply-To: <20170629215538.1645-1-bauerman@linux.vnet.ibm.com>
References: <20170629215538.1645-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20170629215538.1645-3-bauerman@linux.vnet.ibm.com>
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
Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 1354cde7095c..141de0f708f7 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -166,6 +166,10 @@ DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
 DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
 DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
 
+#define MAX_NUM_REQUESTS	((H24x7_DATA_BUFFER_SIZE -		       \
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
2.13.0
