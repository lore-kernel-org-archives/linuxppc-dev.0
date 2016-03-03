Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15FD21A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:27:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH v3 6/8] powerpc/ftrace: Use $(CC_FLAGS_FTRACE) when disabling
 ftrace
Date: Thu,  3 Mar 2016 15:26:58 +1100
Message-Id: <1456979220-10931-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
References: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Torsten Duwe <duwe@lst.de>

Rather than open-coding -pg whereever we want to disable ftrace, use the
existing $(CC_FLAGS_FTRACE) variable.

This has the advantage that it will work in future when we use a
different set of flags to enable ftrace.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile             | 12 ++++++------
 arch/powerpc/lib/Makefile                |  4 ++--
 arch/powerpc/platforms/powermac/Makefile |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

v3: No change.
v2: New, though somewhat based on "[12/12] powerpc/ftrace: Disable profiling
    for some files".

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 794f22adf99d..2da380fcc34c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -16,14 +16,14 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_prom_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_btext.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_prom.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_ftrace.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 # timers used by tracing
-CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_time.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e14277fd8..4513d1a706be 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -6,8 +6,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-CFLAGS_REMOVE_code-patching.o = -pg
-CFLAGS_REMOVE_feature-fixups.o = -pg
+CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
 obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
 	 feature-fixups.o
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 52c6ce1cc985..1eb7b45e017d 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -2,7 +2,7 @@ CFLAGS_bootx_init.o  		+= -fPIC
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_bootx_init.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_bootx_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				+= pic.o setup.o time.o feature.o pci.o \
-- 
2.5.0
