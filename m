Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD14k440FzDqKQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 12:25:10 +1000 (AEST)
Date: Thu, 27 Apr 2017 11:24:59 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard
 <anton@samba.org>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] powerpc: build out kprobes blacklist
Message-Id: <20170427112459.c45b6b1e2d6889c5dadabc3f@kernel.org>
In-Reply-To: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Naveen,

On Tue, 25 Apr 2017 22:04:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This is the second in the series of patches to build out an appropriate
> kprobes blacklist. This series blacklists system_call() and functions
> involved when handling the trap itself. Not everything is covered, but
> this is the first set of functions that I have tested with. More
> patches to follow once I expand my tests.

OK, btw, have you tested to put kprobes on these functions and
saw kernel panic happened?

> I have converted many labels into private -- these are labels that I
> felt are not necessary to read stack traces. If any of those are
> important to have, please let me know.

At least from the viewpoint of kprobe-blacklist macros, it seems
good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Thank you,

> 
> - Naveen
> 
> Naveen N. Rao (4):
>   powerpc/kprobes: cleanup system_call_common and blacklist it from
>     kprobes
>   powerpc/kprobes: un-blacklist system_call() from kprobes
>   powerpc/kprobes: blacklist functions invoked on a trap
>   powerpc/kprobes: blacklist functions involved when returning from
>     exception
> 
>  arch/powerpc/kernel/entry_64.S       | 94 +++++++++++++++++++-----------------
>  arch/powerpc/kernel/exceptions-64s.S |  1 +
>  arch/powerpc/kernel/time.c           |  3 ++
>  arch/powerpc/kernel/traps.c          |  3 ++
>  arch/powerpc/platforms/pseries/dtl.c |  2 +
>  5 files changed, 60 insertions(+), 43 deletions(-)
> 
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
