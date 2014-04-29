Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D24D01400B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 09:15:13 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH 0/2] Fix smp_processor_id() in preemptible splat
Date: Tue, 29 Apr 2014 15:25:15 -0400
Message-ID: <1398799517-47879-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This seems to have been around for a while; I tripped over it while
working on testing 3.10-rt with Steven, and then confirmed it still
was an issue on today's mainline. (didn't check -next however...)

I didn't bisect, but it looks like it may have come in from the
changes in v3.9-rc1~100^2~57.  It probably only impacts the older
cores like the 74xx that don't have CONFIG_HAVE_HW_BREAKPOINT,
and I know I haven't booted my sbc8641D in over a year, so no
surprise this went undetected for a while.  Maybe adding a Cc:
stable is warranted?

It is pretty hard to ignore the splats since you get one per process,
so it must be just the older platform never getting much testing.

The 1st patch is just a small cleanup that makes the 2nd patch
a bit smaller.

If the __set_breakpoint() addition isn't liked, then we could
alternatively just wrap the one call site with preempt_dis/en/able.

Paul.
---

Paul Gortmaker (2):
  powerpc: drop return value from set_breakpoint as it is unused
  powerpc: fix smp_processor_id() in preemptible splat in set_breakpoint

 arch/powerpc/include/asm/debug.h         |  3 ++-
 arch/powerpc/include/asm/hw_breakpoint.h |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  8 ++++----
 arch/powerpc/kernel/process.c            | 15 +++++++++++----
 arch/powerpc/kernel/signal.c             |  2 +-
 arch/powerpc/xmon/xmon.c                 |  2 +-
 6 files changed, 20 insertions(+), 12 deletions(-)

-- 
1.9.0
