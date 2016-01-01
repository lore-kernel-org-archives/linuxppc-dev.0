Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECD531A1024
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jan 2016 09:22:52 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15015140B9C
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2016 09:22:51 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Sat, 2 Jan 2016 03:52:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5A6D0125805C
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2016 03:53:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u01MMlfb49479682
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Jan 2016 03:52:47 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u01MMkjD031675
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Jan 2016 03:52:47 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/2] cpufreq: powernv/tracing: Add powernv_throttle
 tracepoint
Date: Sat,  2 Jan 2016 03:51:53 +0530
Message-Id: <1451686914-3761-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the powernv_throttle tracepoint to trace the CPU
frequency throttling event, which is used by the powernv-cpufreq
driver in POWER8.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>
---
Changes from v1:
- Export the tracepoint

 include/trace/events/power.h | 22 ++++++++++++++++++++++
 kernel/trace/power-traces.c  |  1 +
 2 files changed, 23 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 284244e..19e5030 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -38,6 +38,28 @@ DEFINE_EVENT(cpu, cpu_idle,
 	TP_ARGS(state, cpu_id)
 );
 
+TRACE_EVENT(powernv_throttle,
+
+	TP_PROTO(int chip_id, const char *reason, int pmax),
+
+	TP_ARGS(chip_id, reason, pmax),
+
+	TP_STRUCT__entry(
+		__field(int, chip_id)
+		__string(reason, reason)
+		__field(int, pmax)
+	),
+
+	TP_fast_assign(
+		__entry->chip_id = chip_id;
+		__assign_str(reason, reason);
+		__entry->pmax = pmax;
+	),
+
+	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
+		  __entry->pmax, __get_str(reason))
+);
+
 TRACE_EVENT(pstate_sample,
 
 	TP_PROTO(u32 core_busy,
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index eb4220a..81b8745 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -15,4 +15,5 @@
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
+EXPORT_TRACEPOINT_SYMBOL_GPL(powernv_throttle);
 
-- 
1.9.3
