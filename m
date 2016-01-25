Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36D141A023F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 03:21:37 +1100 (AEDT)
In-Reply-To: <20160204161527.5F3AC692CD@newverein.lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Mon, 25 Jan 2016 16:33:51 +0100
Subject: [PATCH v7 09/10] Enable LIVEPATCH to be configured on ppc64le and add
 livepatch.o if it is selected.
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160204162131.7BC12692E1@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/Kconfig         | 3 +++
 arch/powerpc/kernel/Makefile | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e5f288c..8c7a327 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select HAVE_LIVEPATCH if PPC64 && CPU_LITTLE_ENDIAN
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
@@ -1093,3 +1094,5 @@ config PPC_LIB_RHEAP
 	bool
 
 source "arch/powerpc/kvm/Kconfig"
+
+source "kernel/livepatch/Kconfig"
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 44667fd..405efce 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_TRACING)		+= trace_clock.o
+obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
 
 ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
-- 
1.8.5.6
