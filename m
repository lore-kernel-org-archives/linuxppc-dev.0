Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5603FDDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 19:13:40 +1100 (EST)
Date: Thu, 20 Nov 2008 09:13:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/9] powerpc: port of dynamic ftrace
Message-ID: <20081120081307.GD21785@elte.hu>
References: <20081119212204.318400312@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081119212204.318400312@goodmis.org>
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

> ----
>  arch/powerpc/Kconfig              |    2 +
>  arch/powerpc/include/asm/ftrace.h |   14 +-
>  arch/powerpc/include/asm/module.h |   16 ++-
>  arch/powerpc/kernel/ftrace.c      |  473 +++++++++++++++++++++++++++++++++---
>  arch/powerpc/kernel/idle.c        |    5 +
>  arch/powerpc/kernel/module_32.c   |   10 +
>  arch/powerpc/kernel/module_64.c   |   13 +
>  arch/x86/include/asm/ftrace.h     |    9 +-
>  arch/x86/kernel/ftrace.c          |  168 +++++++++++++-
>  include/linux/ftrace.h            |   51 ++++-
>  kernel/module.c                   |    2 +-
>  kernel/trace/ftrace.c             |  137 ++++++------
>  scripts/recordmcount.pl           |   20 ++-
>  13 files changed, 790 insertions(+), 130 deletions(-)

Hm, something like this shouldnt be pulled into the powerpc tree: it 
touches the core kernel, x86 code and ftrace code as well.

Please do the suggestion i outlined and which Paul agreed with: 
prepare a branch that touches _only_ powerpc files and gets these 
changes there, without actually breaking the build on powerpc. And 
please do not name the branch as "hack" - we dont want Paul to pull 
such a branch name - it will show up in the upstream git logs.

Those changes should only touch powerpc files. Do not try to shoe-horn 
already applied ftrace commits into a separate branch with different 
sha1's. Yes, ftrace wont be enable-able on powerpc when that is 
pulled, but it will only be for a brief period shortly before the 
merge window. (and it will all just work fine when integrated 
together)

Once this branch is done, and once Paul agrees that it looks OK-ish to 
him, we can put it into ftrace-next straight away [but still keep it 
in a separate topic tree in tip/tracing/powerpc - so it can all be 
reconsidered reversibly if it causes too much merge trouble]. Paul 
will then be able to pull it in a few weeks, in the runup to the 
v2.6.29 merge window.

The other option is to go the slow route of 2-3 kernel releases to 
pull this all off.

ok?

	Ingo
