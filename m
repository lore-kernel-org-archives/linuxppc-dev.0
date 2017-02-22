Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSzPD0qMLzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:54:07 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MDnBbt069888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:06 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28s5ksfvk6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:06 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 19:24:03 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 851EB3940033
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:24:00 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MDs06K26148972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:24:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MDrx6M024624
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:24:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/5] trace/kprobes: allow return probes with offsets and
 absolute addresses
Date: Wed, 22 Feb 2017 19:23:39 +0530
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <183e7ce2921a08c9c755ee9a5da3134febc6695b.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the kernel includes many non-global functions with same names, we
will need to use offsets from other symbols (typically _text/_stext) or
absolute addresses to place return probes on specific functions. Also,
the core register_kretprobe() API never forbid use of offsets or
absolute addresses with kretprobes.

Allow its use with the trace infrastructure. To distinguish kernels that
support this, update ftrace README to explicitly call this out.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace.c        | 1 +
 kernel/trace/trace_kprobe.c | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d7449783987a..ababe56b3e8f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4362,6 +4362,7 @@ static const char readme_msg[] =
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENT
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
+  "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENT
 	"\t    place: <path>:<offset>\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7ad9e53ad174..2768cb60ebd7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -679,10 +679,6 @@ static int create_trace_kprobe(int argc, char **argv)
 		return -EINVAL;
 	}
 	if (isdigit(argv[1][0])) {
-		if (is_return) {
-			pr_info("Return probe point must be a symbol.\n");
-			return -EINVAL;
-		}
 		/* an address specified */
 		ret = kstrtoul(&argv[1][0], 0, (unsigned long *)&addr);
 		if (ret) {
@@ -698,10 +694,6 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Failed to parse symbol.\n");
 			return ret;
 		}
-		if (offset && is_return) {
-			pr_info("Return probe must be used without offset.\n");
-			return -EINVAL;
-		}
 	}
 	argc -= 2; argv += 2;
 
-- 
2.11.0
