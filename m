Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B6E81A17AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 07:20:30 +1100 (AEDT)
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com
 [IPv6:2a00:1450:4010:c04::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ABFFF1401CA
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 07:20:29 +1100 (AEDT)
Received: by lbblt2 with SMTP id lt2so115047051lbb.3
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 12:20:26 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH v3 1/2] tracing: introduce TRACE_EVENT_FN_COND macro
Date: Mon, 14 Dec 2015 23:18:05 +0300
Message-Id: <1450124286-4822-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

TRACE_EVENT_FN can't be used in some circumstances
like invoking trace functions from offlined CPU due
to RCU usage.

This patch adds the TRACE_EVENT_FN_COND macro
to make such trace points conditional.

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 include/linux/tracepoint.h   | 4 ++++
 include/trace/define_trace.h | 6 ++++++
 include/trace/trace_events.h | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 696a339c..45b3fcf 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -493,6 +493,10 @@ extern void syscall_unregfunc(void);
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
index 2d8639e..6e3945f 100644
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
index de996cf..170c93b 100644
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
2.4.0
