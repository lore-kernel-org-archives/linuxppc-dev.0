Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87A821A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:36:27 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <naveen.n.rao@linux.vnet.ibm.com>, <acme@kernel.org>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Wang Nan
 <wangnan0@huawei.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 3/3] perf: bpf: Fix build breakage due to libbpf
Date: Tue, 15 Dec 2015 03:35:57 +0000
Message-ID: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
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

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

perf build is currently (v4.4-rc5) broken on powerpc:

bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
your arch.
 #  error __NR_bpf not defined. libbpf does not support your arch.
    ^

Fix this by including tools/perf/config/Makefile.arch for the proper
$ARCH macro. While at it, remove redundant LP64 macro definition.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 636e3dd..3d34a8c 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -31,7 +31,8 @@ INSTALL = install
 DESTDIR ?=
 DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
-LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
+include $(srctree)/tools/scripts/Makefile.arch
+
 ifeq ($(LP64), 1)
   libdir_relative = lib64
 else
-- 
1.8.3.4
