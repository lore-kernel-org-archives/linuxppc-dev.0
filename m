Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFA401A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:16:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 14 May 2015 20:16:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 585F23578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:16:01 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4EAFrpb23134334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:16:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4EAFSRj024160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:15:28 +1000
Message-ID: <1431598497.4160.53.camel@au1.ibm.com>
Subject: Re: G5 Xserve rackmeter broken?
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 14 May 2015 20:14:57 +1000
In-Reply-To: <20150514100656.GC609@fuloong-minipc.musicnaut.iki.fi>
References: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
 <1431296015.13039.12.camel@kernel.crashing.org>
 <20150512175555.GB609@fuloong-minipc.musicnaut.iki.fi>
 <1431463180.20218.57.camel@au1.ibm.com>
 <20150514100656.GC609@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 13:06 +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, May 13, 2015 at 06:39:40AM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2015-05-12 at 20:55 +0300, Aaro Koskinen wrote:
> > > I'm running with HZ=100 so the values are still probably within
> > > jiffy resolution, so perhaps the calculation should first do
> > > idle = min(idle, total)?
> > 
> > Does it gives you a reasonable output if you do that ?
> 
> The below change fixes the idle system blinking behaviour.
> 
> I'm also able to reproduce the leds going off during full CPU load case.
> It seems there is some DMA error. Normally, reading rm->dma_regs->status
> in the IRQ handler gives 0x8400. In the failure cases I've seen values
> 0x8880 and 0x8980 - the IRQ will stop after this and it will need
> paused -> started cycle before it gets going again (but sometimes fails
> again soon after).

That's a bit worrysome, is that new ? Smells like faulting HW ...

Ben.

> A.
> 
> diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
> index 048901a..3381fa59 100644
> --- a/drivers/macintosh/rack-meter.c
> +++ b/drivers/macintosh/rack-meter.c
> @@ -227,6 +227,7 @@ static void rackmeter_do_timer(struct work_struct *work)
>  
>  	total_idle_ticks = get_cpu_idle_time(cpu);
>  	idle_ticks = (unsigned int) (total_idle_ticks - rcpu->prev_idle);
> +	idle_ticks = min(idle_ticks, total_ticks);
>  	rcpu->prev_idle = total_idle_ticks;
>  
>  	/* We do a very dumb calculation to update the LEDs for now,
