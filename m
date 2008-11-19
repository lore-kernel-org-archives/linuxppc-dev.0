Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 55094DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:23:34 +1100 (EST)
Message-Id: <20081119212204.318400312@goodmis.org>
Date: Wed, 19 Nov 2008 16:22:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] powerpc: port of dynamic ftrace
Cc: Andrew Morton <akpm@linux-foundation.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Here are the patches that include the changes suggested by both you
and Milton. This series includes the back port of three commits from tip
that are needed for the PowerPC port.

I also made a git branch called "ppc/ftrace-disable" that does not
include two of the three commits. It adds a patch to keep dynamic
ftrace from being enabled by PowerPC architectures.

As I stated above, both branches include one commit from tip:

  ftrace: align __mcount_loc sections

This is because one of the PowerPC patches will not apply without
it. That commit was a clean cherry pick into mainline, so I'm not
worried about it. Still, the only commits that should go to mainline
from the PowerPC git repo are the ones that start with "powerpc".

In the ppc/ftrace-hack branch, I folded the other two commits
from tip, that are needed for the port, into a single commit.
This commit is called:

 NOT FOR MAINLINE ftrace: pass module struct to arch dynamic ftrace functions

This is only to let you test the rest of the patches. I've booted
this branch and ran it on both my PPC64 and my PP32 boxes.

Again:

  The working branch is:                   ppc/ftrace-hack

  The disabling dynamic ftrace branch is:  ppc/ftrace-disable

Only the commits starting with "powerpc" should be pushed to mainline
by you. Those patches are the same in both of the above branches.

Also, I have not tested that "NOT FOR MAINLINE" patch on x86. It may
break that arch. Which is another reason not to push it.


The following patches are in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: ppc/ftrace-hack


Matt Fleming (1):
      ftrace: align __mcount_loc sections

Steven Rostedt (8):
      NOT FOR MAINLINE ftrace: pass module struct to arch dynamic ftrace functions
      powerpc: ftrace, do not latency trace idle
      powerpc: ftrace, convert to new dynamic ftrace arch API
      powerpc/ppc64: ftrace, mcount record powerpc port
      powerpc: ftrace, use probe_kernel API to modify code
      powerpc/ppc64: ftrace, handle module trampolines for dyn ftrace
      powerpc/ppc32: ftrace, enabled dynamic ftrace
      powerpc/ppc32: ftrace, dynamic ftrace to handle modules

----
 arch/powerpc/Kconfig              |    2 +
 arch/powerpc/include/asm/ftrace.h |   14 +-
 arch/powerpc/include/asm/module.h |   16 ++-
 arch/powerpc/kernel/ftrace.c      |  473 +++++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/idle.c        |    5 +
 arch/powerpc/kernel/module_32.c   |   10 +
 arch/powerpc/kernel/module_64.c   |   13 +
 arch/x86/include/asm/ftrace.h     |    9 +-
 arch/x86/kernel/ftrace.c          |  168 +++++++++++++-
 include/linux/ftrace.h            |   51 ++++-
 kernel/module.c                   |    2 +-
 kernel/trace/ftrace.c             |  137 ++++++------
 scripts/recordmcount.pl           |   20 ++-
 13 files changed, 790 insertions(+), 130 deletions(-)
