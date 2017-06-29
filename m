Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz10Y5fcszDr4R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:45 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TDYTMZ038876
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:43 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1dt3d2j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:43 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 23:36:40 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TDaVc757671890
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:39 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TDa6DL000655
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:07 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] selftests/ftrace: Add a test to probe module functions
Date: Thu, 29 Jun 2017 19:05:37 +0530
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <04c3a67eb5fe13b12725f7198ef9904f992a512a.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a kprobes test to ensure that we are able to add a probe on a
module function using 'p <mod>:<func>' format, without having to
specify a probe name.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../testing/selftests/ftrace/test.d/kprobe/probe_module.tc | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
new file mode 100644
index 000000000000..ea7657041ba6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
@@ -0,0 +1,14 @@
+#!/bin/sh
+# description: Kprobe dynamic event - probing module
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+echo 0 > events/enable
+echo > kprobe_events
+export MOD=`lsmod | head -n 2 | tail -n 1 | cut -f1 -d" "`
+export FUNC=`grep -m 1 ".* t .*\\[$MOD\\]" /proc/kallsyms | xargs | cut -f3 -d" "`
+[ "x" != "x$MOD" -a "y" != "y$FUNC" ] || exit_untested
+echo p $MOD:$FUNC > kprobe_events
+grep $MOD kprobe_events
+echo > kprobe_events
+clear_trace
-- 
2.13.1
