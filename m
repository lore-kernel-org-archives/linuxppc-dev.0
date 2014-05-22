Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB5611A06E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:44:45 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 22 May 2014 18:44:43 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 195956E804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:44:33 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4MMieiN7864810
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 22:44:40 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4MMid18014782
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:44:40 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/perf/hv-24x7: use kmem_cache instead of aligned
 stack allocations
Date: Thu, 22 May 2014 15:44:25 -0700
Message-Id: <1400798673-27522-1-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <537E78AD.1040409@linux.vnet.ibm.com>
References: <537E78AD.1040409@linux.vnet.ibm.com>
Cc: sfr@canb.auug.org.au, peterz@infradead.org, linux-kernel@vger.kernel.org,
 michael@ellerman.id.au, mingo@redhat.com, paulus@samba.org,
 imunsie@au1.ibm.com, acme@ghostprotocols.net, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian pointed out the use of __aligned(4096) caused rather large stack
consumption in single_24x7_request(), so use the kmem_cache
hv_page_cache (which we've already got set up for other allocations)
insead of allocating locally.

Reported-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
In v2:
  - remove duplicate exit path


 arch/powerpc/perf/hv-24x7.c | 48 +++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index e0766b8..998863b 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -294,7 +294,7 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 					 u16 lpar, u64 *res,
 					 bool success_expected)
 {
-	unsigned long ret;
+	unsigned long ret = -ENOMEM;
 
 	/*
 	 * request_buffer and result_buffer are not required to be 4k aligned,
@@ -304,7 +304,27 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	struct reqb {
 		struct hv_24x7_request_buffer buf;
 		struct hv_24x7_request req;
-	} __packed __aligned(4096) request_buffer = {
+	} __packed *request_buffer;
+	struct resb {
+		struct hv_24x7_data_result_buffer buf;
+		struct hv_24x7_result res;
+		struct hv_24x7_result_element elem;
+		__be64 result;
+	} __packed *result_buffer;
+
+	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
+	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
+
+	request_buffer = kmem_cache_alloc(hv_page_cache, GFP_USER);
+
+	if (!request_buffer)
+		goto out_reqb;
+
+	result_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
+	if (!result_buffer)
+		goto out_resb;
+
+	*request_buffer = (struct reqb) {
 		.buf = {
 			.interface_version = HV_24X7_IF_VERSION_CURRENT,
 			.num_requests = 1,
@@ -320,28 +340,26 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 		}
 	};
 
-	struct resb {
-		struct hv_24x7_data_result_buffer buf;
-		struct hv_24x7_result res;
-		struct hv_24x7_result_element elem;
-		__be64 result;
-	} __packed __aligned(4096) result_buffer = {};
-
 	ret = plpar_hcall_norets(H_GET_24X7_DATA,
-			virt_to_phys(&request_buffer), sizeof(request_buffer),
-			virt_to_phys(&result_buffer),  sizeof(result_buffer));
+			virt_to_phys(request_buffer), sizeof(*request_buffer),
+			virt_to_phys(result_buffer),  sizeof(*result_buffer));
 
 	if (ret) {
 		if (success_expected)
 			pr_err_ratelimited("hcall failed: %d %#x %#x %d => 0x%lx (%ld) detail=0x%x failing ix=%x\n",
 					domain, offset, ix, lpar,
 					ret, ret,
-					result_buffer.buf.detailed_rc,
-					result_buffer.buf.failing_request_ix);
-		return ret;
+					result_buffer->buf.detailed_rc,
+					result_buffer->buf.failing_request_ix);
+		goto out_hcall;
 	}
 
-	*res = be64_to_cpu(result_buffer.result);
+	*res = be64_to_cpu(result_buffer->result);
+out_hcall:
+	kfree(result_buffer);
+out_resb:
+	kfree(request_buffer);
+out_reqb:
 	return ret;
 }
 
-- 
1.9.3
