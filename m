Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9835D1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 13:03:08 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 21:03:06 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 095C61FF004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 20:54:14 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t6F333kw54460478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 20:03:03 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6F332A3026612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:03:03 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 2/8] powerpc/perf/hv-24x7: Simplify extracting counter from
 result buffer
Date: Tue, 14 Jul 2015 20:01:49 -0700
Message-Id: <1436929315-28520-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify code that extracts a 24x7 counter from the HCALL's result buffer.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9d73c69..4d1a8d1 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1104,7 +1104,7 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	unsigned long ret;
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
-	struct hv_24x7_result *resb;
+	__be64 val;
 
 	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
 	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
@@ -1125,8 +1125,8 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	}
 
 	/* process result from hcall */
-	resb = &result_buffer->results[0];
-	*count = be64_to_cpu(resb->elements[0].element_data[0]);
+	val = result_buffer->results[0].elements[0].element_data[0];
+	*count = be64_to_cpu(val);
 
 out:
 	put_cpu_var(hv_24x7_reqb);
-- 
1.7.9.5
