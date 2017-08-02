Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMwt06fyvzDsRy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 00:43:36 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72EhY3S028413
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 10:43:34 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3cs6mw1v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 10:42:31 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 00:42:28 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72EgPW828115104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 00:42:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72EgGUc024583
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 00:42:16 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] perf/python: Add ppc64le to audit uname list
Date: Wed,  2 Aug 2017 20:12:16 +0530
Message-Id: <20170802144216.12494-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before patch:
  $ uname -m
  ppc64le
  $ ./perf script -s ./scripts/python/syscall-counts.py
  Install the audit-libs-python package to get syscall names.
  For example:
    # apt-get install python-audit (Ubuntu)
    # yum install audit-libs-python (Fedora)
    etc.

  Press control+C to stop and show the summary
  ^CWarning:
  4 out of order events recorded.

  syscall events:

  event                                          count
  ----------------------------------------  -----------
  4                                             504638
  54                                              1206
  221                                               42
  55                                                21
  3                                                 12
  167                                               10
  11                                                 8
  6                                                  7
  125                                                6
  5                                                  6
  108                                                5
  162                                                4
  90                                                 4
  45                                                 3
  33                                                 3
  311                                                1
  246                                                1
  238                                                1
  93                                                 1
  91                                                 1

After patch:
  ./perf script -s ./scripts/python/syscall-counts.py
  Press control+C to stop and show the summary
  ^CWarning:
  5 out of order events recorded.

  syscall events:

  event                                          count
  ----------------------------------------  -----------
  write                                         643411
  ioctl                                           1206
  futex                                             54
  fcntl                                             27
  poll                                              14
  read                                              12
  execve                                             8
  close                                              7
  mprotect                                           6
  open                                               6
  nanosleep                                          5
  fstat                                              5
  mmap                                               4
  inotify_add_watch                                  3
  brk                                                3
  access                                             3
  timerfd_settime                                    1
  clock_gettime                                      1
  epoll_wait                                         1
  ftruncate                                          1
  munmap                                             1

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
index 1d95009592eb..f6c84966e4f8 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
@@ -57,6 +57,7 @@ try:
 		'ia64'	: audit.MACH_IA64,
 		'ppc'	: audit.MACH_PPC,
 		'ppc64'	: audit.MACH_PPC64,
+		'ppc64le' : audit.MACH_PPC64LE,
 		's390'	: audit.MACH_S390,
 		's390x'	: audit.MACH_S390X,
 		'i386'	: audit.MACH_X86,
-- 
2.13.3
