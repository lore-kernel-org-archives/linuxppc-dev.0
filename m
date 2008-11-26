Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 1B72BDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 09:04:25 +1100 (EST)
Message-Id: <20081126220423.701125085@goodmis.org>
References: <20081126215821.263324391@goodmis.org>
Date: Wed, 26 Nov 2008 16:58:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/ppc32: static ftrace fixes for PPC32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <rostedt@gollum.(none)>

Impact: fix for PowerPC 32 code

There were some early init code that was not safe for static
ftrace to boot on my PowerBook. This code must only use relative
addressing, and static mcount performs a compare of the
ftrace_trace_function pointer, and gets that with an absolute address.
In the early init boot up code, this will cause a fault.

This patch removes tracing from the files containing the offending
functions.

Signed-off-by: Steven Rostedt <rostedt@gollum.(none)>
---
 arch/powerpc/kernel/Makefile |    1 +
 arch/powerpc/lib/Makefile    |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 92673b4..d17edb4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -17,6 +17,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
 CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
 CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
 
 ifdef CONFIG_DYNAMIC_FTRACE
 # dynamic ftrace setup.
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index d69912c..8db3527 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -6,6 +6,9 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
 
+CFLAGS_REMOVE_code-patching.o = -pg
+CFLAGS_REMOVE_feature-fixups.o = -pg
+
 obj-y			:= string.o alloc.o \
 			   checksum_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
-- 
1.5.6.5

-- 
