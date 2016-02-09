Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB4861A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 14:08:50 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 22:08:47 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AAD8CC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 22:08:43 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1938jFO32636988
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 03:08:45 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1938jS3016847
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 22:08:45 -0500
Date: Mon, 8 Feb 2016 19:08:30 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/perf/hv-gpci: Increase request buffer size
Message-ID: <20160209030830.GA4815@us.ibm.com>
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

>From 31edd352fb7c2a72913f1977fa1bf168109089ad Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2016 02:47:45 -0500
Subject: [PATCH] powerpc/perf/hv-gpci: Increase request buffer size

The GPCI hcall allows for a 4K buffer but we limit the buffer
to 1K. The problem with a 1K buffer is if a request results in
returning more values than can be accomodated in the 1K buffer
the request will fail.

The buffer we are using is currently allocated on the stack and
hence limited in size. Instead use a per-CPU 4K buffer like we do
with 24x7 counters (hv-24x7.c).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-gpci.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 856fe6e..e6fad73 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -127,8 +127,16 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+#define HGPCI_REQ_BUFFER_SIZE	4096
 #define GPCI_MAX_DATA_BYTES \
-	(1024 - sizeof(struct hv_get_perf_counter_info_params))
+	(HGPCI_REQ_BUFFER_SIZE - sizeof(struct hv_get_perf_counter_info_params))
+
+DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
+
+struct hv_gpci_request_buffer {
+	struct hv_get_perf_counter_info_params params;
+	uint8_t bytes[1];
+} __packed;
 
 static unsigned long single_gpci_request(u32 req, u32 starting_index,
 		u16 secondary_index, u8 version_in, u32 offset, u8 length,
@@ -137,24 +145,21 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
 	unsigned long ret;
 	size_t i;
 	u64 count;
+	struct hv_gpci_request_buffer *arg;
+
+	arg = (void *)get_cpu_var(hv_gpci_reqb);
+	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
 
-	struct {
-		struct hv_get_perf_counter_info_params params;
-		uint8_t bytes[GPCI_MAX_DATA_BYTES];
-	} __packed __aligned(sizeof(uint64_t)) arg = {
-		.params = {
-			.counter_request = cpu_to_be32(req),
-			.starting_index = cpu_to_be32(starting_index),
-			.secondary_index = cpu_to_be16(secondary_index),
-			.counter_info_version_in = version_in,
-		}
-	};
+	arg->params.counter_request = cpu_to_be32(req);
+	arg->params.starting_index = cpu_to_be32(starting_index);
+	arg->params.secondary_index = cpu_to_be16(secondary_index);
+	arg->params.counter_info_version_in = version_in;
 
 	ret = plpar_hcall_norets(H_GET_PERF_COUNTER_INFO,
-			virt_to_phys(&arg), sizeof(arg));
+			virt_to_phys(arg), HGPCI_REQ_BUFFER_SIZE);
 	if (ret) {
 		pr_devel("hcall failed: 0x%lx\n", ret);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -163,9 +168,11 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
 	 */
 	count = 0;
 	for (i = offset; i < offset + length; i++)
-		count |= arg.bytes[i] << (i - offset);
+		count |= arg->bytes[i] << (i - offset);
 
 	*value = count;
+out:
+	put_cpu_var(hv_gpci_reqb);
 	return ret;
 }
 
-- 
1.8.3.1
