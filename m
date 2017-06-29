Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz10Y2KyXzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:45 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TDYOOa105581
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:43 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcyq0qt6y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:43 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 23:36:40 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TDaTM82162968
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:37 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TDa4SB000489
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:05 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] trace/kprobes: Sanitize derived event names
Date: Thu, 29 Jun 2017 19:05:36 +0530
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <daf0b168ca884719e2d26c08dd6cd690f54d6f47.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we derive event names, convert some expected symbols (such as ':'
used to specify module:name and '.' present in some symbols) into
underscores so that the event name is not rejected.

Before this patch:
    # echo 'p kobject_example:foo_store' > kprobe_events
    trace_kprobe: Failed to allocate trace_probe.(-22)
    -sh: write error: Invalid argument

After this patch:
    # echo 'p kobject_example:foo_store' > kprobe_events
    # cat kprobe_events
    p:kprobes/p_kobject_example_foo_store_0 kobject_example:foo_store

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace_kprobe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c129fca6ec99..44fd819aa33d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -598,6 +598,14 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.priority = 1	/* Invoked after kprobe module callback */
 };
 
+/* Convert certain expected symbols into '_' when generating event names */
+static inline void sanitize_event_name(char *name)
+{
+	while (*name++ != '\0')
+		if (*name == ':' || *name == '.')
+			*name = '_';
+}
+
 static int create_trace_kprobe(int argc, char **argv)
 {
 	/*
@@ -740,6 +748,7 @@ static int create_trace_kprobe(int argc, char **argv)
 		else
 			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_0x%p",
 				 is_return ? 'r' : 'p', addr);
+		sanitize_event_name(buf);
 		event = buf;
 	}
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
-- 
2.13.1
