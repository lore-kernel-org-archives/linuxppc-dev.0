Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 176ED1A09C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:25 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:23 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2874538C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:57:36 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1Lmf27590718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:21 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM1J3P000876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:19 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 9/9] powerpc/hv-24x7: Add missing put_cpu_var()
Date: Tue, 17 Feb 2015 14:00:34 -0800
Message-Id: <1424210434-28070-10-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add missing put_cpu_var() for 24x7 requests.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index fde6211..7d578d6 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1094,7 +1094,7 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 
 	ret = add_event_to_24x7_request(event, request_buffer);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = commit_24x7_get_data(request_buffer, result_buffer);
 	if (ret) {
@@ -1107,6 +1107,8 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	*count = be64_to_cpu(resb->elements[0].element_data[0]);
 
 out:
+	put_cpu_var(hv_24x7_reqb);
+	put_cpu_var(hv_24x7_resb);
 	return ret;
 }
 
-- 
1.8.3.1
