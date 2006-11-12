Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4229E67D3B
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 08:24:38 +1100 (EST)
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP id EDC8F3EC9
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 13:24:35 -0800 (PST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Fwd: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in
	latency_trace.c
Date: Mon, 13 Nov 2006 00:26:17 +0300
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611130026.17204.sshtylyov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

   Ugh, got the linuxppc-dev address wrong in the original mail...

WBR, Sergei

----------  Forwarded Message  ----------

Subject: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in latency_trace.c
Date: Monday 13 November 2006 00:23
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@linux-mips.org, dwalker@mvista.com, khilman@mvista.com

In addition to clock wrap check being falsely triggered with 32-bit cycles_t,
as noticed to Kevin Hilman, there's another issue: using %Lx format to print
32-bit values warrants erroneous values on 32-bit machines like ARM and
 PPC32.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
PPC32 actually has 64-bit timebase counter, so could provide for 64-bit
cycles_t -- maybe it's worth to rewrite get_cycles() to read both lower and
upper registers?

Index: linux-2.6/kernel/latency_trace.c
===================================================================
--- linux-2.6.orig/kernel/latency_trace.c
+++ linux-2.6/kernel/latency_trace.c
@@ -1623,8 +1623,8 @@ check_critical_timing(int cpu, struct cp
 #ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug: updating %016Lx > %016Lx?\n",
-			preempt_max_latency, delta);
-		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
+			(u64)preempt_max_latency, (u64)delta);
+		printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
 	}
 #endif

-------------------------------------------------------
