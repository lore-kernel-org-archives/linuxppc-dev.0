Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtDLv5kpxzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:51:03 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LInJYf097222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:51:01 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7r1mvxem-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:51:00 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 04:50:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5LIosBG50069740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:50:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LIojoh005015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:50:46 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] trace/kprobes: Sanitize derived event names
Date: Thu, 22 Jun 2017 00:20:27 +0530
In-Reply-To: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <22e10dfa9457c28e0ffeaec3a4a7161ef23196fa.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
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
