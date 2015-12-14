Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0AFD1A11C1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 21:51:35 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 16:21:32 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 20F8F1258071
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:21:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEApSGa49741966
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:21:28 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEApRaQ004452
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:21:28 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Wang Nan <wangnan0@huawei.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <jolsa@redhat.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] perf: bpf: Fix build breakage due to libbpf
Date: Mon, 14 Dec 2015 16:20:32 +0530
Message-Id: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf build is currently (v4.4-rc5) broken on powerpc:

bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
your arch.
 #  error __NR_bpf not defined. libbpf does not support your arch.
    ^

Fix this by including tools/perf/config/Makefile.arch for the proper
$ARCH macro. While at it, remove redundant LP64 macro definition.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 636e3dd..050e0e8 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -31,7 +31,8 @@ INSTALL = install
 DESTDIR ?=
 DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
-LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
+include $(srctree)/tools/perf/config/Makefile.arch
+
 ifeq ($(LP64), 1)
   libdir_relative = lib64
 else
-- 
2.6.2
