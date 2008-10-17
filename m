Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id CDF1CDDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 11:48:08 +1100 (EST)
Date: Thu, 16 Oct 2008 20:48:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] ftrace: powerpc: remove startup functions from tracing
In-Reply-To: <20081016181452.GA29739@yoda.jdub.homelinux.org>
Message-ID: <alpine.DEB.1.10.0810162046570.20570@gandalf.stny.rr.com>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[
  Josh, can you see if this allows you to boot on PowerPC?
  It worked on my powerbook.
]

The early init code in PowerPC is not mapped to their final locations
and all jumps and memory references must be done with relative jumps
and accesses.

The lib files in the powerpc directory are called in early boot, and
since mcount will perform direct access to memory, the lib files need
not be traced.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/lib/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-compile.git/arch/powerpc/lib/Makefile
===================================================================
--- linux-compile.git.orig/arch/powerpc/lib/Makefile	2008-10-16 19:26:39.000000000 -0400
+++ linux-compile.git/arch/powerpc/lib/Makefile	2008-10-16 19:26:49.000000000 -0400
@@ -2,6 +2,11 @@
 # Makefile for ppc-specific library files..
 #
 
+ifdef CONFIG_FTRACE
+ORIG_CFLAGS := $(KBUILD_CFLAGS)
+KBUILD_CFLAGS = $(subst -pg,,$(ORIG_CFLAGS))
+endif
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
