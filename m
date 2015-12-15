Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B8D91A0271
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:36:27 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <naveen.n.rao@linux.vnet.ibm.com>, <acme@kernel.org>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Wang Nan
 <wangnan0@huawei.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to libbpf
Date: Tue, 15 Dec 2015 03:35:54 +0000
Message-ID: <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
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

Hi Naveen,

   Now I know your problem is in native building and the reason is
missing proper $(ARCH). I think other than that there's another problem
in libbpf's building: if your problem is unable to compile libbpf,
feature checker should find it and set NO_LIBBPF=1 for perf, so perf
building won't be blocked, only BPF related features should be turned
off. Also, I think including Makefile.arch from tools/scripts would be
better, because libbpf is at the same level with perf. So I separate
them into 3 patches. Please help me test it on PowerPC.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Naveen N. Rao (1):
  perf: bpf: Fix build breakage due to libbpf

Wang Nan (2):
  perf tools: Fix PowerPC native building
  tools: Move Makefile.arch from perf/config to tools/scripts

 tools/build/feature/test-bpf.c               | 20 +++++++++++++++++++-
 tools/lib/bpf/Makefile                       |  3 ++-
 tools/lib/bpf/bpf.c                          |  4 ++--
 tools/perf/config/Makefile                   |  2 +-
 tools/perf/tests/make                        |  2 +-
 tools/{perf/config => scripts}/Makefile.arch |  0
 6 files changed, 25 insertions(+), 6 deletions(-)
 rename tools/{perf/config => scripts}/Makefile.arch (100%)

-- 
1.8.3.4
