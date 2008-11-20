Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 51D27DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:11:50 +1100 (EST)
Message-Id: <20081120190948.057007623@goodmis.org>
Date: Thu, 20 Nov 2008 14:09:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] powerpc: dynamic ftrace port
Cc: Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul and Ingo,

The following are the changes to get dynamic ftrace working on PowerPC.
I modified these a little from the last postings.

 1) I removed the changes to recordmcount.pl.  This is not a PowerPC
    change, although PowerPC needs it for dynamic ftrace. But
    the changes here can go via linux-tip.

 2) I removed the adding of HAVE_DYNAMIC_FTRACE and HAVE_FTRACE_MCOUNT_RECORD.
    Without these config options, this code will not be compiled.
    I have a separate patch that adds them in when the time is right.

Paul, these patches should not harm anything if you decide to pull them
in. As I stated above, without the above config options, they are
not enabled.

There is one exception and that is for the first patch. The first patch
is actually a fix for the irqsoff latency tracer which is already
in mainline for PowerPC.

These patches only touch PowerPC code.

The following patches are in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: ppc/ftrace


Steven Rostedt (5):
      powerpc: ftrace, do not latency trace idle
      powerpc: ftrace, convert to new dynamic ftrace arch API
      powerpc: ftrace, use probe_kernel API to modify code
      powerpc/ppc64: ftrace, handle module trampolines for dyn ftrace
      powerpc/ppc32: ftrace, dynamic ftrace to handle modules

----
 arch/powerpc/include/asm/ftrace.h |   14 +-
 arch/powerpc/include/asm/module.h |   16 ++-
 arch/powerpc/kernel/ftrace.c      |  473 +++++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/idle.c        |    5 +
 arch/powerpc/kernel/module_32.c   |   10 +
 arch/powerpc/kernel/module_64.c   |   13 +
 6 files changed, 489 insertions(+), 42 deletions(-)
