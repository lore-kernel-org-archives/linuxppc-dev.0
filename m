Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id 75CBB1007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 08:32:32 +1000 (EST)
Received: from mail69-va3 (localhost.localdomain [127.0.0.1])	by
	mail69-va3-R.bigfish.com (Postfix) with ESMTP id F08D4EA00BC	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 22:17:22 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.246])	by
	mail69-va3.bigfish.com (Postfix) with ESMTP id C405DF3004B	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 22:17:22 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o72MHJYF023480	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 15:17:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o72MHPAX010854	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 17:17:25 -0500 (CDT)
Date: Mon, 2 Aug 2010 17:17:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] perf, powerpc: fsl_emb: Restore setting
	perf_sample_data.period
Message-ID: <20100802221718.GA11003@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 6b95ed345b9faa4ab3598a82991968f2e9f851bb changed from
a struct initializer to perf_sample_data_init(), but the setting
of the .period member was left out.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/perf_event_fsl_emb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/perf_event_fsl_emb.c b/arch/powerpc/kernel/perf_event_fsl_emb.c
index babccee..4339d20 100644
--- a/arch/powerpc/kernel/perf_event_fsl_emb.c
+++ b/arch/powerpc/kernel/perf_event_fsl_emb.c
@@ -569,6 +569,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 		struct perf_sample_data data;
 
 		perf_sample_data_init(&data, 0);
+		data.period = event->hw.last_period;
 
 		if (perf_event_overflow(event, nmi, &data, regs)) {
 			/*
-- 
1.7.0.4
