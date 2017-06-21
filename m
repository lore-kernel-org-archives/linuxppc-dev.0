Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtDLx40wDzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:51:05 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LIn6N4137649
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:51:03 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7vn6w0tj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:51:03 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 04:51:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5LIowOk61210746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:50:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LIonRu005104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:50:49 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] selftests/ftrace: Update multiple kprobes test for powerpc
Date: Thu, 22 Jun 2017 00:20:28 +0530
In-Reply-To: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <f49dbddfbc7dee2f68a610bba468c39a4d017feb.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
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

Finally, do not filter out symbols with a dot. Powerpc Elfv1 uses dot
prefix for all functions and this prevents us from testing some of those
symbols. Furthermore, with the patch to derive event names properly in
the presence of ':' and '.', such names are accepted by kprobe_events
and constitutes a good test for those symbols.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index f4d1ff785d67..d209c071b2c0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -2,16 +2,16 @@
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
 
 echo "Setup up to 256 kprobes"
-grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
-head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
+grep t /proc/kallsyms | cut -f3 -d" " | head -n 256 | \
+while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
 
 echo 1 > events/kprobes/enable
 echo 0 > events/kprobes/enable
-- 
2.13.1
