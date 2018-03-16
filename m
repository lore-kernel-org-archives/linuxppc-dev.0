Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402mw7676XzDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 00:46:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: rostedt@goodmis.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: [RFC PATCH 1/2] ftrace: Allow arches to opt-out of static ftrace
Date: Sat, 17 Mar 2018 00:46:32 +1100
Message-Id: <20180316134633.10584-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a small but non-zero amount of code required by arches to
suppory non-dynamic (static) ftrace, and more importantly there is the
added work of testing both configurations.

There are also almost no down sides to dynamic ftrace once it's well
tested, other than a small increase in code/data size.

So give arches the option to opt-out of supporting static ftrace.

This is implemented as a DYNAMIC_FTRACE_CHOICE option, which controls
whether DYNAMIC_FTRACE is presented as a user-selectable option or if
it is just enabled based on its dependencies being enabled (because
it's already default y).

Then the CHOICE option depends on an arch *not* selecting
HAVE_DYNAMIC_FTRACE_ONLY. This would be more natural in reverse, as a
HAVE_STATIC_FTRACE option, but that would require updating every arch.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/trace/ftrace-design.txt | 12 ++++++++++++
 kernel/trace/Kconfig                  |  9 ++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.txt
index a273dd0bbaaa..50c1d252f01d 100644
--- a/Documentation/trace/ftrace-design.txt
+++ b/Documentation/trace/ftrace-design.txt
@@ -391,3 +391,15 @@ Quick notes:
 	  ftrace_graph_call location with a call to ftrace_graph_caller()
 	- ftrace_disable_ftrace_graph_caller() will runtime patch the
 	  ftrace_graph_call location with nops
+
+HAVE_DYNAMIC_FTRACE_ONLY
+------------------------
+
+An arch can select this option to indicate that it only supports dynamic ftrace,
+and not non-dynamic (static) ftrace.
+
+Once dynamic ftrace is well tested it is superior to static ftrace in basically
+all respects other than code/data size.
+
+Selection this option allows an arch to only support dyanmic, removing a small
+amount of code complexity required to support both static and dynamic.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0b249e2f0c3c..1998e30d2ea2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -29,6 +29,9 @@ config HAVE_DYNAMIC_FTRACE
 	help
 	  See Documentation/trace/ftrace-design.txt
 
+config HAVE_DYNAMIC_FTRACE_ONLY
+	bool
+
 config HAVE_DYNAMIC_FTRACE_WITH_REGS
 	bool
 
@@ -488,8 +491,12 @@ config BPF_EVENTS
 config PROBE_EVENTS
 	def_bool n
 
+config DYNAMIC_FTRACE_CHOICE
+	def_bool y
+	depends on !HAVE_DYNAMIC_FTRACE_ONLY
+
 config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
+	bool "enable/disable function tracing dynamically" if DYNAMIC_FTRACE_CHOICE
 	depends on FUNCTION_TRACER
 	depends on HAVE_DYNAMIC_FTRACE
 	default y
-- 
2.14.1
