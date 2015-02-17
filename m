Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 226E01A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:15 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:13 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 04B1838C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:57:26 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1Aqo28246028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:11 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM17oO031640
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:09 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/9] powerpc/hv-24x7: Modify definition of request and result
 buffers
Date: Tue, 17 Feb 2015 14:00:26 -0800
Message-Id: <1424210434-28070-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1424210434-28070-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1424210434-28070-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The parameters to the 24x7 HCALL have variable number of elements in them.
Set the minimum number of such elements to 1 rather than 0 and eliminate
the temporary structures.

This would enable us to submit multiple counter requests and process
multiple results from a single HCALL (in a follow on patch).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 77 ++++++++++++++++++++++-----------------------
 arch/powerpc/perf/hv-24x7.h |  8 ++---
 2 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9445a82..408e6e9 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -142,6 +142,15 @@ static struct attribute_group event_long_desc_group = {
 
 static struct kmem_cache *hv_page_cache;
 
+/*
+ * request_buffer and result_buffer are not required to be 4k aligned,
+ * but are not allowed to cross any 4k boundary. Aligning them to 4k is
+ * the simplest way to ensure that.
+ */
+#define H24x7_DATA_BUFFER_SIZE	4096
+DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
+DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
+
 static char *event_name(struct hv_24x7_event_data *ev, int *len)
 {
 	*len = be16_to_cpu(ev->event_name_len) - 2;
@@ -976,31 +985,16 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
-DEFINE_PER_CPU(char, hv_24x7_reqb[4096]) __aligned(4096);
-DEFINE_PER_CPU(char, hv_24x7_resb[4096]) __aligned(4096);
-
 static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
-					 u16 lpar, u64 *res,
+					 u16 lpar, u64 *count,
 					 bool success_expected)
 {
 	unsigned long ret;
 
-	/*
-	 * request_buffer and result_buffer are not required to be 4k aligned,
-	 * but are not allowed to cross any 4k boundary. Aligning them to 4k is
-	 * the simplest way to ensure that.
-	 */
-	struct reqb {
-		struct hv_24x7_request_buffer buf;
-		struct hv_24x7_request req;
-	} __packed *request_buffer;
-
-	struct {
-		struct hv_24x7_data_result_buffer buf;
-		struct hv_24x7_result res;
-		struct hv_24x7_result_element elem;
-		__be64 result;
-	} __packed *result_buffer;
+	struct hv_24x7_request_buffer *request_buffer;
+	struct hv_24x7_data_result_buffer *result_buffer;
+	struct hv_24x7_result *resb;
+	struct hv_24x7_request *req;
 
 	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
 	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
@@ -1011,38 +1005,41 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	memset(request_buffer, 0, 4096);
 	memset(result_buffer, 0, 4096);
 
-	*request_buffer = (struct reqb) {
-		.buf = {
-			.interface_version = HV_24X7_IF_VERSION_CURRENT,
-			.num_requests = 1,
-		},
-		.req = {
-			.performance_domain = domain,
-			.data_size = cpu_to_be16(8),
-			.data_offset = cpu_to_be32(offset),
-			.starting_lpar_ix = cpu_to_be16(lpar),
-			.max_num_lpars = cpu_to_be16(1),
-			.starting_ix = cpu_to_be16(ix),
-			.max_ix = cpu_to_be16(1),
-		}
-	};
+	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
+	request_buffer->num_requests = 1;
+
+	req = &request_buffer->requests[0];
 
+	req->performance_domain = domain;
+	req->data_size = cpu_to_be16(8);
+	req->data_offset = cpu_to_be32(offset);
+	req->starting_lpar_ix = cpu_to_be16(lpar),
+	req->max_num_lpars = cpu_to_be16(1);
+	req->starting_ix = cpu_to_be16(ix);
+	req->max_ix = cpu_to_be16(1);
+
+	/*
+	 * NOTE: Due to variable number of array elements in request and
+	 *	 result buffer(s), sizeof() is not reliable. Use the actual
+	 *	 allocated buffer size, H24x7_DATA_BUFFER_SIZE.
+	 */
 	ret = plpar_hcall_norets(H_GET_24X7_DATA,
-			virt_to_phys(request_buffer), sizeof(*request_buffer),
-			virt_to_phys(result_buffer),  sizeof(*result_buffer));
+			virt_to_phys(request_buffer), H24x7_DATA_BUFFER_SIZE,
+			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
 
 	if (ret) {
 		if (success_expected)
 			pr_err_ratelimited("hcall failed: %d %#x %#x %d => "
 				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
 				domain, offset, ix, lpar, ret, ret,
-				result_buffer->buf.detailed_rc,
-				result_buffer->buf.failing_request_ix);
+				result_buffer->detailed_rc,
+				result_buffer->failing_request_ix);
 		goto out;
 	}
 
-	*res = be64_to_cpu(result_buffer->result);
+	resb = &result_buffer->results[0];
 
+	*count = be64_to_cpu(resb->elements[0].element_data[0]);
 out:
 	return ret;
 }
diff --git a/arch/powerpc/perf/hv-24x7.h b/arch/powerpc/perf/hv-24x7.h
index 69cd4e6..0f9fa21 100644
--- a/arch/powerpc/perf/hv-24x7.h
+++ b/arch/powerpc/perf/hv-24x7.h
@@ -50,7 +50,7 @@ struct hv_24x7_request_buffer {
 	__u8 interface_version;
 	__u8 num_requests;
 	__u8 reserved[0xE];
-	struct hv_24x7_request requests[];
+	struct hv_24x7_request requests[1];
 } __packed;
 
 struct hv_24x7_result_element {
@@ -66,7 +66,7 @@ struct hv_24x7_result_element {
 	__be32 lpar_cfg_instance_id;
 
 	/* size = @result_element_data_size of cointaining result. */
-	__u8 element_data[];
+	__u64 element_data[1];
 } __packed;
 
 struct hv_24x7_result {
@@ -87,7 +87,7 @@ struct hv_24x7_result {
 	/* WARNING: only valid for first result element due to variable sizes
 	 *          of result elements */
 	/* struct hv_24x7_result_element[@num_elements_returned] */
-	struct hv_24x7_result_element elements[];
+	struct hv_24x7_result_element elements[1];
 } __packed;
 
 struct hv_24x7_data_result_buffer {
@@ -103,7 +103,7 @@ struct hv_24x7_data_result_buffer {
 	__u8 reserved2[0x8];
 	/* WARNING: only valid for the first result due to variable sizes of
 	 *	    results */
-	struct hv_24x7_result results[]; /* [@num_results] */
+	struct hv_24x7_result results[1]; /* [@num_results] */
 } __packed;
 
 #endif
-- 
1.8.3.1
