Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz10d6JkfzDr5C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TDYxFJ096392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:47 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1mfjw35-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:47 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 23:36:43 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TDaXHr1114530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TDa9NB000829
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:09 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] selftests/ftrace: Update multiple kprobes test for
 powerpc
Date: Thu, 29 Jun 2017 19:05:38 +0530
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <f7a4667e3a43fa6a3e33c4026d412a4dd02b4550.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KPROBES_ON_FTRACE is only available on powerpc64le. Update comment to
clarify this.

Also, we should use an offset of 8 to ensure that the probe does not
fall on ftrace location. The current offset of 4 will fall before the
function local entry point and won't fire, while an offset of 12 or 16
will fall on ftrace location. Offset 8 is currently guaranteed to not be
the ftrace location.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index f4d1ff785d67..2a1cb9908746 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -2,10 +2,10 @@
 # description: Register/unregister many kprobe events
 
 # ftrace fentry skip size depends on the machine architecture.
-# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc
+# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
 case `uname -m` in
   x86_64|i[3456]86) OFFS=5;;
-  ppc*) OFFS=4;;
+  ppc64le) OFFS=8;;
   *) OFFS=0;;
 esac
 
-- 
2.13.1
