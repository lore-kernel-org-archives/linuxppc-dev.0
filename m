Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FFED1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 23:10:55 +1000 (AEST)
Date: Wed, 3 Jun 2015 15:10:51 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] ppc64 ftrace configuration
Message-ID: <20150603131051.GC19424@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
 <20150603130257.GA19424@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603130257.GA19424@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add Kconfig variables and Makefile magic for ftrace with -mprofile-kernel

Signed-off-by: Torsten Duwe <duwe@suse.de>

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
