Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvF2D4sBMzDqkM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 20:25:08 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so6736298pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 03:25:08 -0700 (PDT)
Date: Fri, 23 Jun 2017 20:24:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
Message-ID: <20170623202451.15871d00@roar.ozlabs.ibm.com>
In-Reply-To: <87mv8zoxp8.fsf@concordia.ellerman.id.au>
References: <20170622172616.7598-1-mikey@neuling.org>
 <87mv8zoxp8.fsf@concordia.ellerman.id.au>
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

On Fri, 23 Jun 2017 19:33:23 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michael Neuling <mikey@neuling.org> writes:
> 
> > On POWER9 the ERAT may be incorrect on wakeup from some stop states
> > that lose state. This causes random segvs and illegal instructions
> > when these stop states are enabled.  
> 
> Incorrect how?

It can have stale ERAT entries from another idle thread.

> 
> Because with the ERAT flush where you've put it, there's still a good
> amount of code executed prior to the flush isn't there?
> 
> ie. we come in at 0x100, do some of the prolog, do IDLE_TEST which takes
> us to pnv_powersave_wakeup, which then restores state from the paca
> (memory), that returns and then we check KVM ... and then finally we end
> up at pnv_wakeup_loss.

In the case of an HMI, we could call into OPAL as well.

> Or is there some other path? Or is the ERAT incorrect in some specific
> way which means we only need to flush there?

I think we're in real mode until returning from pnv_wakeup_loss so those
ERATs should be the same.

Except KVM, which can go to guest and switch on the MMU. My bad, I
suggested putting it into pnv_wakeup_loss.

Flushing at the start of pnv_powersave_wakeup should be safest. I guess
we can avoid it for non-state-loss wakeups if cr3 is lt.

Thanks,
Nick
