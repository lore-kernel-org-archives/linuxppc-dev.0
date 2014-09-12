Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 352EE1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 17:28:58 +1000 (EST)
Message-ID: <1410506936.17540.7.camel@concordia>
Subject: Re: [PATCH v3 1/3] init/main.c: Give init_task a canary
From: Michael Ellerman <mpe@ellerman.id.au>
To: Aaron Tomlin <atomlin@redhat.com>
Date: Fri, 12 Sep 2014 17:28:56 +1000
In-Reply-To: <1410450088-18236-2-git-send-email-atomlin@redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-2-git-send-email-atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 prarit@redhat.com, pzijlstr@redhat.com, peterz@infradead.org, bmr@redhat.com,
 x86@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, minchan@kernel.org, mingo@redhat.com,
 tglx@linutronix.de, aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, jgh@redhat.com,
 akpm@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-11 at 16:41 +0100, Aaron Tomlin wrote:
> Tasks get their end of stack set to STACK_END_MAGIC with the
> aim to catch stack overruns. Currently this feature does not
> apply to init_task. This patch removes this restriction.
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 51ab9e7..35d0760c 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -30,7 +30,6 @@
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
>  #include <linux/perf_event.h>
> -#include <linux/magic.h>
>  #include <linux/ratelimit.h>
>  #include <linux/context_tracking.h>
>  
> @@ -538,7 +537,7 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  		regs->nip);
>  
>  	stackend = end_of_stack(current);
> -	if (current != &init_task && *stackend != STACK_END_MAGIC)
> +	if (*stackend != STACK_END_MAGIC)
>  		printk(KERN_ALERT "Thread overran stack, or stack corrupted\n");

This part looks fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
