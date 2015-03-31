Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71D2D1A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:56 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:54 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4E7C91FF0026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:46:04 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1sgVU37945416
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:42 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1sqoT003268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:53 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 10/10] powerpc/hv-24x7: Break up single_24x7_request
Date: Mon, 30 Mar 2015 18:53:47 -0700
Message-Id: <1427766828-771-11-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Break up the function single_24x7_request() into smaller functions.
This would later enable us to "prepare" a multi-event request
buffer and then submit a single hcall for several events.

Changelog[v2]:
	[Michael Ellerman] Rename start_24x7_get_data() to init_24x7_request()
		and commit_24x7_get_data make_24x7_request().

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 56 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index cf82026..46be032 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1003,6 +1003,44 @@ static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
 }
 
 /*
+ * Start the process for a new H_GET_24x7_DATA hcall.
+ */
+static void init_24x7_request(struct hv_24x7_request_buffer *request_buffer,
+			struct hv_24x7_data_result_buffer *result_buffer)
+{
+
+	memset(request_buffer, 0, 4096);
+	memset(result_buffer, 0, 4096);
+
+	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
+	/* memset above set request_buffer->num_requests to 0 */
+}
+
+/*
+ * Commit (i.e perform) the H_GET_24x7_DATA hcall using the data collected
+ * by 'init_24x7_request()' and 'add_event_to_24x7_request()'.
+ */
+static int make_24x7_request(struct hv_24x7_request_buffer *request_buffer,
+			struct hv_24x7_data_result_buffer *result_buffer)
+{
+	unsigned long ret;
+
+	/*
+	 * NOTE: Due to variable number of array elements in request and
+	 *	 result buffer(s), sizeof() is not reliable. Use the actual
+	 *	 allocated buffer size, H24x7_DATA_BUFFER_SIZE.
+	 */
+	ret = plpar_hcall_norets(H_GET_24X7_DATA,
+			virt_to_phys(request_buffer), H24x7_DATA_BUFFER_SIZE,
+			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
+
+	if (ret)
+		log_24x7_hcall(request_buffer, result_buffer, ret);
+
+	return ret;
+}
+
+/*
  * Add the given @event to the next slot in the 24x7 request_buffer.
  *
  * Note that H_GET_24X7_DATA hcall allows reading several counters'
@@ -1044,7 +1082,6 @@ static int add_event_to_24x7_request(struct perf_event *event,
 static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 {
 	unsigned long ret;
-
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
 	struct hv_24x7_result *resb;
@@ -1055,31 +1092,22 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
 	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
 
-	memset(request_buffer, 0, 4096);
-	memset(result_buffer, 0, 4096);
-
-	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
+	init_24x7_request(request_buffer, result_buffer);
 
 	ret = add_event_to_24x7_request(event, request_buffer);
 	if (ret)
 		return ret;
 
-	/*
-	 * NOTE: Due to variable number of array elements in request and
-	 *	 result buffer(s), sizeof() is not reliable. Use the actual
-	 *	 allocated buffer size, H24x7_DATA_BUFFER_SIZE.
-	 */
-	ret = plpar_hcall_norets(H_GET_24X7_DATA,
-			virt_to_phys(request_buffer), H24x7_DATA_BUFFER_SIZE,
-			virt_to_phys(result_buffer),  H24x7_DATA_BUFFER_SIZE);
-
+	ret = make_24x7_request(request_buffer, result_buffer);
 	if (ret) {
 		log_24x7_hcall(request_buffer, result_buffer, ret);
 		goto out;
 	}
 
+	/* process result from hcall */
 	resb = &result_buffer->results[0];
 	*count = be64_to_cpu(resb->elements[0].element_data[0]);
+
 out:
 	return ret;
 }
-- 
1.8.3.1
