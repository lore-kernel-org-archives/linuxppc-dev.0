Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz10h004RzDr4l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:51 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TDYTlq135263
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:50 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1nptr3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:49 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 23:36:47 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TDaaFl54001902
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:44 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TDaBsE000984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:11 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] selftests/ftrace: Add a testcase for kprobe event
 naming
Date: Thu, 29 Jun 2017 19:05:39 +0530
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <0f4f7b1d8bdcb068245ebb791845a0bc08e91921.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a testcase for kprobe event naming. This testcase
checks whether the kprobe events can automatically ganerate
its event name on normal function and dot-suffixed function.
Also it checks whether the kprobe events can correctly
define new event with given event name and group name.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[Updated tests to use vfs_read and symbols with '.isra.',
added check for kprobe_events and a command to clear it on exit]
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
new file mode 100644
index 000000000000..182e5a78ef4b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -0,0 +1,32 @@
+#!/bin/sh
+# description: Kprobe event auto/manual naming
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+disable_events
+echo > kprobe_events
+
+:;: "Add an event on function without name" ;:
+
+FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
+echo p $FUNC > kprobe_events
+FUNC_NAME=`echo $FUNC | tr ".:" "_"`
+test -d events/kprobes/p_${FUNC_NAME}_0 || exit_failure
+
+:;: "Add an event on function with new name" ;:
+
+echo p:event1 $FUNC > kprobe_events
+test -d events/kprobes/event1 || exit_failure
+
+:;: "Add an event on function with new name and group" ;:
+
+echo p:kprobes2/event2 $FUNC > kprobe_events
+test -d events/kprobes2/event2 || exit_failure
+
+:;: "Add an event on dot function without name" ;:
+
+FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
+echo p $FUNC > kprobe_events
+EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:` || exit_failure
+test -d events/$EVENT || exit_failure
+echo > kprobe_events
-- 
2.13.1
