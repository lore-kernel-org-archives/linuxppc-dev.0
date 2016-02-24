Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E0221A03F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 12/12] powerpc/ftrace: Disable profiling for some files
Date: Thu, 25 Feb 2016 01:28:35 +1100
Message-Id: <1456324115-21144-12-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Torsten Duwe <duwe@lst.de>

Using -mprofile-kernel on early boot code not only confuses the
checker but is also useless, as the infrastructure is not yet in
place. Proceed like with -pg (remove it from CFLAGS), equally with
time.o, ftrace and its helper files.

  * arch/powerpc/kernel/Makefile,
    arch/powerpc/lib/Makefile:
    - remove -mprofile-kernel from low level, boot code and
      code-patching objects' CFLAGS.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile | 12 ++++++------
 arch/powerpc/lib/Makefile    |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 794f22adf99d..44667fde7ae4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -16,14 +16,14 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog -mprofile-kernel
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog -mprofile-kernel
 # timers used by tracing
-CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog -mprofile-kernel
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e14277fd8..98e22b2d7bec 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -6,8 +6,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-CFLAGS_REMOVE_code-patching.o = -pg
-CFLAGS_REMOVE_feature-fixups.o = -pg
+CFLAGS_REMOVE_code-patching.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_feature-fixups.o = -pg -mprofile-kernel
 
 obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
 	 feature-fixups.o
-- 
2.5.0
