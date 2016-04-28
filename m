Return-Path: <chandan.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWrj3wF1zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:35:01 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan.kumar@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 05:34:58 -0400
From: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: acme@redhat.com, mpe@ellerman.id.au, jolsa@redhat.com,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc: Add HAVE_PERF_USER_STACK_DUMP support
Date: Thu, 28 Apr 2016 15:01:08 +0530
Message-Id: <1461835870-67778-2-git-send-email-chandan.kumar@linux.vnet.ibm.com>
In-Reply-To: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
References: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With perf regs support enabled for powerpc, the support for obtaining
perf user stack dump is already enabled.
This patch declares the support for same and also updates documentation
to mark the support for perf-regs and perf-stackdump.

Signed-off-by: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
---
 Documentation/features/perf/perf-regs/arch-support.txt      | 2 +-
 Documentation/features/perf/perf-stackdump/arch-support.txt | 2 +-
 arch/powerpc/Kconfig                                        | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index e2b4a78..f179b1f 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 3dc24b0..85777c5 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b14966d..a630ac2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -117,6 +117,7 @@ config PPC
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
 	select ARCH_WANT_IPC_PARSE_VERSION
-- 
1.9.3
