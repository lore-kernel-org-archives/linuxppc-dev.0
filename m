Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 038AA1A17EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 16:34:22 +1100 (AEDT)
Message-ID: <1453268061.14751.8.camel@ellerman.id.au>
Subject: Re: Different SIGSEGV codes (x86 and ppc64le)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <brenohl@br.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Gustavo Bueno Romero <gromero@br.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Wed, 20 Jan 2016 16:34:21 +1100
In-Reply-To: <569EA155.5070602@br.ibm.com>
References: <569EA155.5070602@br.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-19 at 18:49 -0200, Breno Leitao wrote:

> During some debugging, we found that during a stack overflow, the SIGSEGV code
> returned is different on Power and Intel.
> 
> We were able to narrow down the test case to the follow simple code:
> 
>   https://github.com/leitao/stack/blob/master/overflow.c

[So the first thing I did was disable your signal handler, because that just
 complicates things.]

> On Power, the SIGSEV si->si_code is 2 (SEGV_ACCERR) , meaning "access error". On
> the other way around, the same test on x86 returns si->si_code = 1 (SEGV_MAPERR),
> meaning "invalid permission". Any idea why such difference?

This seems to be a result of the stack guard page. Whenever the lowest page of
the stack vma is faulted in, the kernel grows the vma down one page.

That means in do_page_fault() we don't ever see a bad area (ie. no vma found)
for the stack. Instead we find a vma, and call handle_mm_fault(), which then
tries to expand the stack down in check_stack_guard_page(). Then in
expand_downwards() we call acct_stack_growth() which checks the stack ulimit,
and that is what fails.

That means the failure comes from handle_mm_fault(), and by that point in the
logic we have already set code to SEGV_ACCERR. So even though we goto bad_area,
code is SEGV_ACCERR and that's what you see.

x86 on the other hand handles the error path differently, it passes the error
down to mm_fault_error(), which calls bad_area_nosemaphore(), which always
specifies SEGV_MAPERR for VM_FAULT_SIGSEGV.

The kernel describes those error codes as:

  #define SEGV_MAPERR	(__SI_FAULT|1)	/* address not mapped to object */
  #define SEGV_ACCERR	(__SI_FAULT|2)	/* invalid permissions for mapped object */

Which one is correct in this case isn't entirely clear. There is a stack
mapping, but you're not allowed to use it because of the stack ulimit, so
arguably ACCERR is more accurate.

However that's only true because of the stack guard page, which is supposed to
be somewhat invisible to userspace. If I disable the stack guard page logic,
userspace sees SEGV_MAPERR, so it seems that historically that's what is
expected.

So we should probably fix this on powerpc.

It also makes me think the logic we have in do_page_fault() to directly expand
the stack (around line 375) is now dead code.

cheers
