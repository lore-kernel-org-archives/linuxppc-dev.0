Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA6321A0633
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:54 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:52 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 06FB93E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:51 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1sdXR36765948
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:39 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1soEM003120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:50 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 06/10] powerpc/hv-24x7: Rename hv_24x7_event_update
Date: Mon, 30 Mar 2015 18:53:43 -0700
Message-Id: <1427766828-771-7-git-send-email-sukadev@linux.vnet.ibm.com>
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

For consistency with the pmu operation ->read() and with other
pmus, rename hv_24x7_event_update() to hv_24x7_event_read().

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index a58a1df..e78b127 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1146,7 +1146,7 @@ static u64 h_24x7_get_value(struct perf_event *event)
 	return ct;
 }
 
-static void h_24x7_event_update(struct perf_event *event)
+static void h_24x7_event_read(struct perf_event *event)
 {
 	s64 prev;
 	u64 now;
@@ -1163,7 +1163,7 @@ static void h_24x7_event_start(struct perf_event *event, int flags)
 
 static void h_24x7_event_stop(struct perf_event *event, int flags)
 {
-	h_24x7_event_update(event);
+	h_24x7_event_read(event);
 }
 
 static int h_24x7_event_add(struct perf_event *event, int flags)
@@ -1184,7 +1184,7 @@ static struct pmu h_24x7_pmu = {
 	.del         = h_24x7_event_stop,
 	.start       = h_24x7_event_start,
 	.stop        = h_24x7_event_stop,
-	.read        = h_24x7_event_update,
+	.read        = h_24x7_event_read,
 };
 
 static int hv_24x7_init(void)
-- 
1.8.3.1
