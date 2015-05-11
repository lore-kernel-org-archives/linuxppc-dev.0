Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FAD51A0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 10:49:14 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 83E54140187
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 10:49:12 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so96286282pab.2
 for <linuxppc-dev@ozlabs.org>; Sun, 10 May 2015 17:49:10 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mce: fix off by one errors in mce event handling
Date: Mon, 11 May 2015 10:48:32 +1000
Message-Id: <1431305312-9955-1-git-send-email-dja@axtens.net>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before 69111bac42f5 ("powerpc: Replace __get_cpu_var uses"), in
save_mce_event, index got the value of mce_nest_count, and
mce_nest_count was incremented *after* index was set.

However, that patch changed the behaviour so that mce_nest count was
incremented *before* setting index.

This causes an off-by-one error, as get_mce_event sets index as
mce_nest_count - 1 before reading mce_event.  Thus get_mce_event reads
bogus data, causing warnings like
"Machine Check Exception, Unknown event version 0 !"
and breaking MCEs handling.

Restore the old behaviour and unbreak MCE handling by moving the
increment to after index is set.

The same broken change occured in machine_check_queue_event (which set
a queue read by machine_check_process_queued_event).  Fix that too,
unbreaking printing of MCE information.

Fixes: 69111bac42f5 ("powerpc: Replace __get_cpu_var uses")
CC: stable@vger.kernel.org
CC: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/mce.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 15c99b6..f774b64 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -73,8 +73,9 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		    uint64_t nip, uint64_t addr)
 {
 	uint64_t srr1;
-	int index = __this_cpu_inc_return(mce_nest_count);
+	int index = __this_cpu_read(mce_nest_count);
 	struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
+	__this_cpu_inc(mce_nest_count);
 
 	/*
 	 * Return if we don't have enough space to log mce event.
@@ -184,7 +185,8 @@ void machine_check_queue_event(void)
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return;
 
-	index = __this_cpu_inc_return(mce_queue_count);
+	index = __this_cpu_read(mce_queue_count);
+	__this_cpu_inc(mce_queue_count);
 	/* If queue is full, just return for now. */
 	if (index >= MAX_MC_EVT) {
 		__this_cpu_dec(mce_queue_count);
-- 
2.1.4
