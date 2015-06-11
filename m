Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B5DF1A0622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 19:59:58 +1000 (AEST)
Date: Thu, 11 Jun 2015 11:59:54 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ppc64 ftrace_with_regs configuration variables
Message-ID: <20150611095954.GC4492@lst.de>
References: <20150611095338.GA4492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150611095338.GA4492@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  * Makefile:
    - globally use -mprofile-kernel in case it's configured.
  * arch/powerpc/Kconfig / kernel/trace/Kconfig:
    - declare that ppc64 HAVE_MPROFILE_KERNEL and HAVE_DYNAMIC_FTRACE_WITH_REGS,
      and use it.

Signed-off-by: Torsten Duwe <duwe@suse.de>
--
 Makefile             |    5 ++++-
 arch/powerpc/Kconfig |    2 ++
 kernel/trace/Kconfig |    5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)
--
diff --git a/Makefile b/Makefile
index 3d16bcc..bbd5e87 100644
--- a/Makefile
+++ b/Makefile
@@ -733,7 +733,10 @@ export CC_FLAGS_FTRACE
 ifdef CONFIG_HAVE_FENTRY
 CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
 endif
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY)
+ifdef CONFIG_HAVE_MPROFILE_KERNEL
+CC_USING_MPROFILE_KERNEL	:= $(call cc-option, -mprofile-kernel -DCC_USING_MPROFILE_KERNEL)
+endif
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY) $(CC_USING_MPROFILE_KERNEL)
 KBUILD_AFLAGS	+= $(CC_USING_FENTRY)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940..566f204 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -94,8 +94,10 @@ config PPC
 	select OF_RESERVED_MEM
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_MPROFILE_KERNEL
 	select SYSCTL_EXCEPTION_TRACE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select VIRT_TO_BUS if !PPC64
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a5da09c..dd53f3d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -52,6 +52,11 @@ config HAVE_FENTRY
 	help
 	  Arch supports the gcc options -pg with -mfentry
 
+config HAVE_MPROFILE_KERNEL
+	bool
+	help
+	  Arch supports the gcc options -pg with -mprofile-kernel
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
