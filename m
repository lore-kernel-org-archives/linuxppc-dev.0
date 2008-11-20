Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF553DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 01:54:25 +1100 (EST)
Date: Thu, 20 Nov 2008 15:53:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/9] powerpc: port of dynamic ftrace
Message-ID: <20081120145353.GA13550@elte.hu>
References: <20081119212204.318400312@goodmis.org>
	<20081120081307.GD21785@elte.hu>
	<alpine.DEB.1.10.0811200645510.17538@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0811200645510.17538@gandalf.stny.rr.com>
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

>     branch: ppc/ftrace-disable
> 
> 
> Matt Fleming (1):
>       ftrace: align __mcount_loc sections
> 
> Steven Rostedt (8):
>       ftrace: disable dynamic ftrace from PowerPC
>       powerpc: ftrace, do not latency trace idle
>       powerpc: ftrace, convert to new dynamic ftrace arch API
>       powerpc/ppc64: ftrace, mcount record powerpc port
>       powerpc: ftrace, use probe_kernel API to modify code
>       powerpc/ppc64: ftrace, handle module trampolines for dyn ftrace
>       powerpc/ppc32: ftrace, enabled dynamic ftrace
>       powerpc/ppc32: ftrace, dynamic ftrace to handle modules
> 
> ----
>  arch/powerpc/Kconfig              |    2 +
>  arch/powerpc/include/asm/ftrace.h |   14 +-
>  arch/powerpc/include/asm/module.h |   16 ++-
>  arch/powerpc/kernel/ftrace.c      |  473 +++++++++++++++++++++++++++++++++---
>  arch/powerpc/kernel/idle.c        |    5 +
>  arch/powerpc/kernel/module_32.c   |   10 +
>  arch/powerpc/kernel/module_64.c   |   13 +
>  kernel/trace/Kconfig              |    1 +
>  scripts/recordmcount.pl           |   20 ++-
>  9 files changed, 511 insertions(+), 43 deletions(-)
> 
> There is a dependency on Matt's commit for one of the PPC commits to 
> apply.  I could hack that commit to work without Matt's patch, but 
> then that just postpones conflicts later on.
> 
> Matt's change is this:
> 
>  scripts/recordmcount.pl           |   20 ++-

looks much better and the (minimal) generic impact is OK i think - as 
long as Paul Acks the powerpc changes we could freeze that branch (so 
that Paul can pull it in a few weeks) and base your ftrace-powerpc 
work on that.

( The branch should still be named something constructive like 
  powerpc-ftrace-v29 or so - not ppc/ftrace-disable - but that's a 
  detail. )

	Ingo
