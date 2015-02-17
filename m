Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 496171A0B4A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:22 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:19 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BA592C90045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:52:28 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM1H4Q28049480
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:17 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM1FI6032713
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:16 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/9] powerpc/hv-24x7: Rename hv_24x7_event_update
Date: Tue, 17 Feb 2015 14:00:30 -0800
Message-Id: <1424210434-28070-6-git-send-email-sukadev@linux.vnet.ibm.com>
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
