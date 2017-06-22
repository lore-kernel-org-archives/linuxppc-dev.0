Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtrbd2gVkzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:04:13 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MIwijd130035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:04:11 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8k5e9b2c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:04:11 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 23 Jun 2017 05:04:08 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5MJ46em44892294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:04:06 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5MJ44jl003785
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:04:05 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] trace/kprobes: Sanitize derived event names
Date: Fri, 23 Jun 2017 00:33:45 +0530
In-Reply-To: <20170622182953.e1959ce03145b8bb45ec55de@kernel.org>
References: <20170622182953.e1959ce03145b8bb45ec55de@kernel.org>
Message-Id: <20170622190345.6444-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/22 06:29PM, Masami Hiramatsu wrote:
> On Thu, 22 Jun 2017 00:20:27 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > When we derive event names, convert some expected symbols (such as ':'
> > used to specify module:name and '.' present in some symbols) into
> > underscores so that the event name is not rejected.
> 
> Oops, ok, this is my mistake.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> This must be marked as bugfix for stable trees.
> 
> Could you also add a testcase for this (module name) bug?
> 
> MODNAME=`lsmod | head -n 2 | tail -n 1 | cut -f 1 -d " "`
> FUNCNAME=`grep -m 1 "\\[$MODNAME\\]" /proc/kallsyms | xargs | cut -f 3 -d " "`
> 
> May gives you a target name :)

Sure. Here is a test.

Thanks for the review,
Naveen

-
[PATCH] selftests/ftrace: Add a test to probe module functions

Add a kprobes test to ensure that we are able to add a probe on a
module function using 'p <mod>:<func>' format, without having to
specify a probe name.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
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
