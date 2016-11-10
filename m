Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDqhj4yrbzDvWv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 15:25:09 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id n85so138786660pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 20:25:09 -0800 (PST)
Date: Thu, 10 Nov 2016 15:24:59 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: fix graceful debugger recovery
Message-ID: <20161110152459.7ab453f5@roar.ozlabs.ibm.com>
In-Reply-To: <87mvh8jev4.fsf@concordia.ellerman.id.au>
References: <20161108121445.15303-1-npiggin@gmail.com>
 <20161108121445.15303-2-npiggin@gmail.com>
 <87mvh8jev4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 10 Nov 2016 12:35:59 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > When exiting xmon with 'x' (exit and recover), oops_begin bails
> > out immediately, but die then calls __die() and oops_end(), which
> > cause a lot of bad things to happen.  
> 
> In fact oops_begin() returns 1, which oops_end() then passes directly to
> raw_local_irq_restore() as flags. On 64-bit that actually works because
> arch_local_irq_restore() takes just "en" (enable), not real flags. But
> on 32-bit it's supposed to be the MSR value. So that's impressively
> broken.

Yeah, I guess most of the time you either go to debugger with
sysrq, or in case of a crash don't try to graceful recover.

When sending debug NMIs down via system reset it becomes a problem!

> 
> > If the debugger was attached then went to graceful recovery, exit
> > from die() immediately.  
> 
> Right. Crucially it doesn't change anything in terms of the actual logic
> of oops_begin(), ie. previously oops_begin() did nothing prior to
> calling debugger(), and after this patch that remains the same (which
> you did mention above but just spelling it out for myself).

Right.

Thanks,
Nick
