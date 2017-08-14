Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWLcw6D6JzDqh4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 02:28:00 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/19] perf scripting python: Add ppc64le to audit uname list
Date: Mon, 14 Aug 2017 13:27:23 -0300
Message-Id: <20170814162741.6101-2-acme@kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

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
Acked-by: Paul Clarke <pc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/n/tip-bnl67p1alkvx97pn9moxz3qp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.13.4
