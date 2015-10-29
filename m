Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9E751A0BFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 06:10:28 +1100 (AEDT)
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66D971402D2
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2015 06:10:26 +1100 (AEDT)
Received: by lfbn126 with SMTP id n126so23275982lfb.2
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 12:10:23 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@ozlabs.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Anton Blanchard <anton@samba.org>,
 linux-kernel@vger.kernel.org, Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH] powerpc: tracing: don't trace hcalls on offline CPUs
Date: Thu, 29 Oct 2015 22:10:10 +0300
Message-Id: <1446145810-5383-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

./drmgr -c cpu -a -r gives the following warning:

[ 2327.035563]
RCU used illegally from offline CPU!
rcu_scheduler_active = 1, debug_locks = 1
[ 2327.035564] no locks held by swapper/12/0.
[ 2327.035565]
stack backtrace:
[ 2327.035567] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G S
  4.3.0-rc3-00060-g353169a #5
[ 2327.035568] Call Trace:
[ 2327.035573] [c0000001d62578e0] [c0000000008977fc]
.dump_stack+0x98/0xd4 (unreliable)
[ 2327.035577] [c0000001d6257960] [c000000000109bd8]
.lockdep_rcu_suspicious+0x108/0x170
[ 2327.035580] [c0000001d62579f0] [c00000000006a1d0]
.__trace_hcall_exit+0x2b0/0x2c0
[ 2327.035584] [c0000001d6257ab0] [c00000000006a2e8]
plpar_hcall_norets_trace+0x70/0x8c
[ 2327.035588] [c0000001d6257b20] [c000000000067a14]
.icp_hv_set_cpu_priority+0x54/0xc0
[ 2327.035592] [c0000001d6257ba0] [c000000000066c5c]
.xics_teardown_cpu+0x5c/0xa0
[ 2327.035595] [c0000001d6257c20] [c0000000000747ac]
.pseries_mach_cpu_die+0x6c/0x320
[ 2327.035598] [c0000001d6257cd0] [c0000000000439cc] .cpu_die+0x3c/0x60
[ 2327.035602] [c0000001d6257d40] [c0000000000183d8]
.arch_cpu_idle_dead+0x28/0x40
[ 2327.035606] [c0000001d6257db0] [c0000000000ff1dc]
.cpu_startup_entry+0x4fc/0x560
[ 2327.035610] [c0000001d6257ed0] [c000000000043728]
.start_secondary+0x328/0x360
[ 2327.035614] [c0000001d6257f90] [c000000000008a6c]
start_secondary_prolog+0x10/0x14
[ 2327.035620] cpu 12 (hwid 12) Ready to die...
[ 2327.144463] cpu 13 (hwid 13) Ready to die...
[ 2327.294180] cpu 14 (hwid 14) Ready to die...
[ 2327.403599] cpu 15 (hwid 15) Ready to die...

Make the hypervisor tracepoints conditional by introducing
TRACE_EVENT_FN_COND similar to TRACE_EVENT_FN

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/include/asm/trace.h | 8 ++++++--
 include/linux/tracepoint.h       | 4 ++++
 include/trace/define_trace.h     | 6 ++++++
 include/trace/trace_events.h     | 6 ++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index 8e86b48..3dc5803 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -57,12 +57,14 @@ DEFINE_EVENT(ppc64_interrupt_class, timer_interrupt_exit,
 extern void hcall_tracepoint_regfunc(void);
 extern void hcall_tracepoint_unregfunc(void);
 
-TRACE_EVENT_FN(hcall_entry,
+TRACE_EVENT_FN_COND(hcall_entry,
 
 	TP_PROTO(unsigned long opcode, unsigned long *args),
 
 	TP_ARGS(opcode, args),
 
+	TP_CONDITION(cpu_online(smp_processor_id())),
+
 	TP_STRUCT__entry(
 		__field(unsigned long, opcode)
 	),
@@ -76,13 +78,15 @@ TRACE_EVENT_FN(hcall_entry,
 	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
 );
 
-TRACE_EVENT_FN(hcall_exit,
+TRACE_EVENT_FN_COND(hcall_exit,
 
 	TP_PROTO(unsigned long opcode, unsigned long retval,
 		unsigned long *retbuf),
 
 	TP_ARGS(opcode, retval, retbuf),
 
+	TP_CONDITION(cpu_online(smp_processor_id())),
+
 	TP_STRUCT__entry(
 		__field(unsigned long, opcode)
 		__field(unsigned long, retval)
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a5f7f3e..be17490 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -468,6 +468,10 @@ extern void syscall_unregfunc(void);
 #define TRACE_EVENT_FN(name, proto, args, struct,		\
 		assign, print, reg, unreg)			\
 	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
+		assign, print, reg, unreg)			\
+	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
+			PARAMS(args), PARAMS(cond))
 #define TRACE_EVENT_CONDITION(name, proto, args, cond,		\
 			      struct, assign, print)		\
 	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 09b3880..bfd14e3 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -40,6 +40,11 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg)
 
+#undef TRACE_EVENT_FN_COND
+#define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
+		assign, print, reg, unreg)			\
+	DEFINE_TRACE_FN(name, reg, unreg)
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
 	DEFINE_TRACE(name)
@@ -93,6 +98,7 @@
 
 #undef TRACE_EVENT
 #undef TRACE_EVENT_FN
+#undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_CONDITION
 #undef DECLARE_EVENT_CLASS
 #undef DEFINE_EVENT
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 43be3b0..1ebf1d9 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -123,6 +123,12 @@ TRACE_MAKE_SYSTEM_STR();
 	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
 
+#undef TRACE_EVENT_FN_COND
+#define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,	\
+		assign, print, reg, unreg)				\
+	TRACE_EVENT_CONDITION(name, PARAMS(proto), PARAMS(args), PARAMS(cond),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
+
 #undef TRACE_EVENT_FLAGS
 #define TRACE_EVENT_FLAGS(name, value)					\
 	__TRACE_EVENT_FLAGS(name, value)
-- 
2.4.6
