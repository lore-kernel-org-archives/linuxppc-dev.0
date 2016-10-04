Return-Path: <BATV+ef2f77d1cbf736fff7a8+4790+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp34G0nVVzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:38:06 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Andi Kleen <andi@firstfloor.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/22] tools build: Make fixdep a hostprog
Date: Mon,  3 Oct 2016 23:37:03 -0300
Message-Id: <1475548641-12182-5-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jiri Olsa <jolsa@redhat.com>

It is used in the build process, so stop suppressing its build in tools
cross builds.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20160927141846.GA6589@krava
[ Use HOSTCC on the $(OUTPUT)fixdep target, it was using the x-compiler
  to link fixdep-in.o, that was correctly built with HOSTCC and thus failing ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Build            | 2 ++
 tools/build/Makefile         | 2 +-
 tools/build/Makefile.include | 4 ----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/build/Build b/tools/build/Build
index 63a6c34c0c88..76d1a4960973 100644
--- a/tools/build/Build
+++ b/tools/build/Build
@@ -1 +1,3 @@
+hostprogs := fixdep
+
 fixdep-y := fixdep.o
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 653faee2a055..8332959fbca4 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -42,7 +42,7 @@ $(OUTPUT)fixdep-in.o: FORCE
 	$(Q)$(MAKE) $(build)=fixdep
 
 $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $<
+	$(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
 
 FORCE:
 
diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
index be630bed66d2..ad22e4e7bc59 100644
--- a/tools/build/Makefile.include
+++ b/tools/build/Makefile.include
@@ -1,10 +1,6 @@
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-ifdef CROSS_COMPILE
-fixdep:
-else
 fixdep:
 	$(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
-endif
 
 .PHONY: fixdep
-- 
2.7.4
