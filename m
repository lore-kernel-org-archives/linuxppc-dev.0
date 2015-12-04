Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 335331A0E82
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:29:01 +1100 (AEDT)
In-Reply-To: <20151204152419.28E0D691D2@newverein.lst.de>
References: <20151204152419.28E0D691D2@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Fri, 4 Dec 2015 15:13:44 +0100
Subject: [PATCH v5 9/9] Enable LIVEPATCH to be configured on ppc64le and add
 livepatch.o if it is selected.
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 Petr Mladek <pmladek@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151204152858.2EE5C691D2@newverein.lst.de>
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
 arch/powerpc/Kconfig         | 5 +++++
 arch/powerpc/kernel/Makefile | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 89b1a2a..62a3f54 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -163,6 +163,9 @@ config PPC
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select HAVE_ARCH_SECCOMP_FILTER
 
+config HAVE_LIVEPATCH
+       def_bool PPC64 && CPU_LITTLE_ENDIAN
+
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
 
@@ -1095,3 +1098,5 @@ config PPC_LIB_RHEAP
 	bool
 
 source "arch/powerpc/kvm/Kconfig"
+
+source "kernel/livepatch/Kconfig"
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0f417d5..f9a2925 100644
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
