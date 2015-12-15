Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 963751A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 19:51:47 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <acme@kernel.org>, <naveen.n.rao@linux.vnet.ibm.com>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <wangnan0@huawei.com>, <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Date: Tue, 15 Dec 2015 08:51:13 +0000
Message-ID: <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
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

Fix this by including tools/scripts/Makefile.arch for the proper
$ARCH macro. While at it, remove redundant LP64 macro definition.

Also, since libbpf require $(srctree) now, detect the path of
srctree like perf.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

v3 -> v4: Add srctree detector code so directly run 'make' in libbpf
          directory would not cause error.

---
 tools/lib/bpf/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 636e3dd..0b6e013 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -6,6 +6,12 @@ BPF_EXTRAVERSION = 1
 
 MAKEFLAGS += --no-print-directory
 
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
 
 # Makefiles suck: This macro sets a default value of $(2) for the
 # variable named by $(1), unless the variable has been set by
@@ -31,7 +37,8 @@ INSTALL = install
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
