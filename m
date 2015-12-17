Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 132171A119C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 12:44:23 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <acme@kernel.org>, <naveen.n.rao@linux.vnet.ibm.com>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <wangnan0@huawei.com>, <sukadev@linux.vnet.ibm.com>
Subject: [RESEND PATCH v4 0/3] perf build: PowerPC: Fix build breakage due to
 libbpf
Date: Thu, 17 Dec 2015 01:43:49 +0000
Message-ID: <1450316632-152513-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix PowerPC build breakage found by Naveen.

Perf building should not be blocked if BPF syscall is broken in some
platform.

In v3 a problem in 3/3 is found and fixed, but I only sent v4 of 3/3.
Send all 3 patches together again.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Naveen N. Rao (1):
  perf: bpf: Fix build breakage due to libbpf

Wang Nan (2):
  perf tools: Fix PowerPC native building
  tools: Move Makefile.arch from perf/config to tools/scripts

 tools/build/feature/test-bpf.c  | 20 +++++++++++++++++++-
 tools/lib/bpf/Makefile          |  9 ++++++++-
 tools/lib/bpf/bpf.c             |  4 ++--
 tools/perf/config/Makefile      |  2 +-
 tools/perf/config/Makefile.arch | 18 ------------------
 tools/perf/tests/make           |  2 +-
 tools/scripts/Makefile.arch     | 18 ++++++++++++++++++
 7 files changed, 49 insertions(+), 24 deletions(-)
 delete mode 100644 tools/perf/config/Makefile.arch
 create mode 100644 tools/scripts/Makefile.arch

-- 
1.8.3.4
