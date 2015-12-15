Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86D1B1A114E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:36:38 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <naveen.n.rao@linux.vnet.ibm.com>, <acme@kernel.org>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Wang Nan
 <wangnan0@huawei.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 2/3] tools: Move Makefile.arch from perf/config to
 tools/scripts
Date: Tue, 15 Dec 2015 03:35:56 +0000
Message-ID: <1450150557-127942-3-git-send-email-wangnan0@huawei.com>
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

After this patch other directories can use this architecture detector
without directly including it from perf's directory. Libbpf would
utilize it to get proper $(ARCH) so it can receive correct uapi include
directory.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/config/Makefile                   | 2 +-
 tools/perf/tests/make                        | 2 +-
 tools/{perf/config => scripts}/Makefile.arch | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/{perf/config => scripts}/Makefile.arch (100%)

diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index a552417..34717e4 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -17,7 +17,7 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(EXTRA_WARNINGS)
 
-include $(src-perf)/config/Makefile.arch
+include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,ARCH)
 
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8ea3dff..cd9c3ce 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -12,7 +12,7 @@ endif
 else
 PERF := .
 
-include config/Makefile.arch
+include $(srctree)/scripts/Makefile.arch
 
 # FIXME looks like x86 is the only arch running tests ;-)
 # we need some IS_(32/64) flag to make this generic
diff --git a/tools/perf/config/Makefile.arch b/tools/scripts/Makefile.arch
similarity index 100%
rename from tools/perf/config/Makefile.arch
rename to tools/scripts/Makefile.arch
-- 
1.8.3.4
