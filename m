Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DE711A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 18:07:04 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F65514009B
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 18:07:03 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 00:07:01 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7C437C9003C
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 01:59:02 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBA76xq924117478
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 07:06:59 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBA76wSa000589
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 02:06:58 -0500
Date: Tue, 9 Dec 2014 23:06:37 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>
Subject: [PATCH 1/2] perf/powerpc/hv-24x7: Use per-cpu page buffer
Message-ID: <20141210070637.GA27377@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, dev@codyps.com, Jiri Olsa <jolsa@redhat.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 470c16c8955672103a9529c78dffbb239e9e27b8 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 9 Dec 2014 22:17:46 -0500
Subject: [PATCH 1/2] perf/poweprc/hv-24x7: Use per-cpu page buffer

The 24x7 counters are continuously running and not updated on an interrupt.
So we record the event counts when stopping the event or deleting it.

But to "read" a single counter in 24x7, we allocate a page and pass it
into the hypervisor (The HV returns the page full of counters from which
we extract the specific counter for this event).

We allocate a page using GFP_USER and when deleting the event, we end up
with the following warning because we are blocking in interrupt context.

	[  698.641709] BUG: scheduling while atomic: swapper/0/0/0x10010000

We could use GFP_ATOMIC but that could result in failures. Pre-allocate
a buffer so we don't have to allocate in interrupt context. Further as
Michael Ellerman suggested, use Per-CPU buffer so we only need to allocate
once per CPU.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index dba3408..18e1f49 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -217,11 +217,14 @@ static bool is_physical_domain(int domain)
 		domain == HV_24X7_PERF_DOMAIN_PHYSICAL_CORE;
 }
 
+DEFINE_PER_CPU(char, hv_24x7_reqb[4096]);
+DEFINE_PER_CPU(char, hv_24x7_resb[4096]);
+
 static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 					 u16 lpar, u64 *res,
 					 bool success_expected)
 {
-	unsigned long ret = -ENOMEM;
+	unsigned long ret;
 
 	/*
 	 * request_buffer and result_buffer are not required to be 4k aligned,
@@ -243,13 +246,11 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
 	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
 
-	request_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
-	if (!request_buffer)
-		goto out;
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
 
-	result_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
-	if (!result_buffer)
-		goto out_free_request_buffer;
+	memset(request_buffer, 0, 4096);
+	memset(result_buffer, 0, 4096);
 
 	*request_buffer = (struct reqb) {
 		.buf = {
@@ -278,15 +279,11 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 				domain, offset, ix, lpar, ret, ret,
 				result_buffer->buf.detailed_rc,
 				result_buffer->buf.failing_request_ix);
-		goto out_free_result_buffer;
+		goto out;
 	}
 
 	*res = be64_to_cpu(result_buffer->result);
 
-out_free_result_buffer:
-	kfree(result_buffer);
-out_free_request_buffer:
-	kfree(request_buffer);
 out:
 	return ret;
 }
-- 
1.8.3.1
