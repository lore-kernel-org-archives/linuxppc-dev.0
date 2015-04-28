Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EB651A0213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 18:45:36 +1000 (AEST)
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E3151400B7
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 18:45:35 +1000 (AEST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 04:45:32 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 91A3138C8046
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 04:45:29 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S8jTDE51970194
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 08:45:29 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S8jS8J009620
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 04:45:29 -0400
Subject: [PATCH] tick-broadcast: Fix the printing of broadcast masks
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de, mingo@kernel.org
Date: Tue, 28 Apr 2015 14:15:20 +0530
Message-ID: <20150428084520.3314.62668.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: peterz@infradead.org, linuxppc-dev@ozlabs.org, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today the number of bits of the broadcast masks that is output into
/proc/timer_list is sizeof(unsigned long). This means that on machines
with larger number of CPUs, the bitmasks of CPUs beyond this range do
not appear.

Fix this by using bitmap printing through "%*pb" instead, so as to
output the broadcast masks for the range of nr_cpu_ids into
/proc/timer_list.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 kernel/time/timer_list.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index c82b03c..1afc726 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -269,11 +269,11 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 {
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	print_tickdevice(m, tick_get_broadcast_device(), -1);
-	SEQ_printf(m, "tick_broadcast_mask: %08lx\n",
-		   cpumask_bits(tick_get_broadcast_mask())[0]);
+	SEQ_printf(m, "tick_broadcast_mask: %*pb\n",
+		   cpumask_pr_args(tick_get_broadcast_mask()));
 #ifdef CONFIG_TICK_ONESHOT
-	SEQ_printf(m, "tick_broadcast_oneshot_mask: %08lx\n",
-		   cpumask_bits(tick_get_broadcast_oneshot_mask())[0]);
+	SEQ_printf(m, "tick_broadcast_oneshot_mask: %*pb\n",
+		   cpumask_pr_args(tick_get_broadcast_oneshot_mask()));
 #endif
 	SEQ_printf(m, "\n");
 #endif
