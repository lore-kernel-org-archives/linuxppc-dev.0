Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4qgR3yXszDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:56:03 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4qgQ5q2xz9sD5
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 22:56:02 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so17191859pad.2
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 05:56:02 -0700 (PDT)
Date: Thu, 4 Aug 2016 22:55:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
Message-ID: <20160804225551.03df1fa3@roar.ozlabs.ibm.com>
In-Reply-To: <3ad321e8-0cbd-1b23-0152-e70cda4815f0@linux.vnet.ibm.com>
References: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
 <87bn18g8l9.fsf@concordia.ellerman.id.au>
 <3ad321e8-0cbd-1b23-0152-e70cda4815f0@linux.vnet.ibm.com>
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

On Thu, 4 Aug 2016 17:35:45 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 08/04/2016 03:27 PM, Michael Ellerman wrote:
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> >   
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> When machine check occurs with MSR(RI=0), it means MC interrupt is
> >> unrecoverable and kernel goes down to panic path. But the console
> >> message still shows it as recovered. This patch fixes the MCE console
> >> messages.
> >>
> >> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/kernel/mce.c             |    3 ++-
> >>  arch/powerpc/platforms/powernv/opal.c |    2 ++
> >>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> >> index ef267fd..5e7ece0 100644
> >> --- a/arch/powerpc/kernel/mce.c
> >> +++ b/arch/powerpc/kernel/mce.c
> >> @@ -92,7 +92,8 @@ void save_mce_event(struct pt_regs *regs, long handled,
> >>  	mce->in_use = 1;
> >>  
> >>  	mce->initiator = MCE_INITIATOR_CPU;
> >> -	if (handled)
> >> +	/* Mark it recovered if we have handled it and MSR(RI=1). */
> >> +	if (handled && (regs->msr & MSR_RI))
> >>  		mce->disposition = MCE_DISPOSITION_RECOVERED;  
> > 
> > This seems like it has bigger implications than just changing the
> > printk output? We're now (correctly) marking any MC where RI=0 as
> > unrecoverable.
> > 
> > Or is the only place that uses this the code below which *also* checks
> > MSR_RI?  
> 
> We would always check MSR_RI at code below and panic correctly. It was
> just that we were always printing it as recovered and then panic.
> 
> >   
> >> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> >> index 5385434..8154171 100644
> >> --- a/arch/powerpc/platforms/powernv/opal.c
> >> +++ b/arch/powerpc/platforms/powernv/opal.c
> >> @@ -401,6 +401,8 @@ static int opal_recover_mce(struct pt_regs *regs,
> >>  
> >>  	if (!(regs->msr & MSR_RI)) {
> >>  		/* If MSR_RI isn't set, we cannot recover */  
> > 
> > Why do we check MSR_RI again here? Shouldn't we just be looking at the evt->disposition?  
> 
> When MSR_RI=0, where SRR0/SRR1 registers values have been thrashed,
> kernel can not continue reliably if we return from interrupt.

If it's a user process that raises a synchronous/instruction caused
exception that gets hit with the MCE, I wonder if we can kill the
process and continue? I'm not saying you should do it with this patch.

It might need some auditing we don't leave the paca in some bad state
or something, but it would be a nice feature because right now a user
doing a busy loop of the funny 0x1ebe syscall, or maybe an illegal
instruction or emulation could probably keep the MSR_RI bit clear for
probably half or more of the CPU's cycles couldn't they?

Thanks,
Nick
