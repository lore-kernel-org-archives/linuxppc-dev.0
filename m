Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAD841A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:52:23 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 21:52:20 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 86E0B6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:44:07 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1qHle23789630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 01:52:17 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1qGmj027478
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:52:17 -0400
Date: Mon, 30 Mar 2015 18:51:17 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/1] powerpc/hv-24x7: Add missing put_cpu_var()
Message-ID: <20150331015117.GA32741@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 17 Feb 2015 14:14:36 -0500
Subject: [PATCH 1/1] powerpc/hv-24x7: Add missing put_cpu_var()

Add missing put_cpu_var() for 24x7 requests. This went missing in
commit f34b6c7 (3.18-rc3).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 46be032..ead8878 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1096,7 +1096,7 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 
 	ret = add_event_to_24x7_request(event, request_buffer);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = make_24x7_request(request_buffer, result_buffer);
 	if (ret) {
@@ -1109,6 +1109,8 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	*count = be64_to_cpu(resb->elements[0].element_data[0]);
 
 out:
+	put_cpu_var(hv_24x7_reqb);
+	put_cpu_var(hv_24x7_resb);
 	return ret;
 }
 
-- 
1.8.3.1
