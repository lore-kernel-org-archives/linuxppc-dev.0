Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C51F91A090E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:23 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:21 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7A62DC90057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:52:30 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1JFX7733430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:19 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM1HVl000655
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:18 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/9] powerpc/hv-24x7: Break up single_24x7_request
Date: Tue, 17 Feb 2015 14:00:33 -0800
Message-Id: <1424210434-28070-9-git-send-email-sukadev@linux.vnet.ibm.com>
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

Break up the function single_24x7_request() into smaller functions.
This would later enable us to "prepare" a multi-event request
buffer and then submit a single hcall for several events.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 56 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 3c36694..fde6211 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1001,6 +1001,44 @@ static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
 }
 
 /*
+ * Start the process for a new H_GET_24x7_DATA hcall.
+ */
+static void start_24x7_get_data(struct hv_24x7_request_buffer *request_buffer,
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
+ * by 'start_24x7_get_data()' and 'add_event_to_24x7_request()'.
+ */
+static int commit_24x7_get_data(struct hv_24x7_request_buffer *request_buffer,
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
@@ -1042,7 +1080,6 @@ static int add_event_to_24x7_request(struct perf_event *event,
 static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 {
 	unsigned long ret;
-
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
 	struct hv_24x7_result *resb;
@@ -1053,31 +1090,22 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
 	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
 
-	memset(request_buffer, 0, 4096);
-	memset(result_buffer, 0, 4096);
-
-	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
+	start_24x7_get_data(request_buffer, result_buffer);
 
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
+	ret = commit_24x7_get_data(request_buffer, result_buffer);
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
