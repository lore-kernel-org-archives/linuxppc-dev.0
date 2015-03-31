Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63A4C1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:57 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:55 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D68BF19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:45:58 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1sqOn44630196
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:52 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1sqUx003220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:52 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 09/10] powerpc/hv-24x7: Define update_event_count()
Date: Mon, 30 Mar 2015 18:53:46 -0700
Message-Id: <1427766828-771-10-git-send-email-sukadev@linux.vnet.ibm.com>
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

Move the code to update an event count into a new function,
update_event_count().

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 676fb2f9..cf82026 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1172,16 +1172,22 @@ static u64 h_24x7_get_value(struct perf_event *event)
 	return ct;
 }
 
-static void h_24x7_event_read(struct perf_event *event)
+static void update_event_count(struct perf_event *event, u64 now)
 {
 	s64 prev;
-	u64 now;
 
-	now = h_24x7_get_value(event);
 	prev = local64_xchg(&event->hw.prev_count, now);
 	local64_add(now - prev, &event->count);
 }
 
+static void h_24x7_event_read(struct perf_event *event)
+{
+	u64 now;
+
+	now = h_24x7_get_value(event);
+	update_event_count(event, now);
+}
+
 static void h_24x7_event_start(struct perf_event *event, int flags)
 {
 	if (flags & PERF_EF_RELOAD)
-- 
1.8.3.1
