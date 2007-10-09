Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEFA3DDFB5
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 10:34:21 +1000 (EST)
Subject: Re: [PATCH] Prevent decrementer clockevents from firing early
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18186.50261.275896.847277@cargo.ozlabs.ibm.com>
References: <18186.50261.275896.847277@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 10:34:16 +1000
Message-Id: <1191890056.6355.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-09 at 09:59 +1000, Paul Mackerras wrote:
> On old powermacs, we sometimes set the decrementer to 1 in order to
> trigger a decrementer interrupt, which we use to handle an interrupt
> that was pending at the time when it was re-enabled.  This was causing
> the decrementer clock event device to call the event function for the
> next event early, which was causing problems when high-res timers were
> not enabled.
> 
> This fixes the problem by recording the timebase value at which the
> next event should occur, and checking the current timebase against the
> recorded value in timer_interrupt.  If it isn't time for the next
> event, it just reprograms the decrementer and returns.
> 
> This also subtracts 1 from the value stored into the decrementer,
> which is appropriate because the decrementer interrupts on the
> transition from 0 to -1, not when the decrementer reaches 0.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---

Do we also need to handle lost ticks ? That is loop & do multiple events
like we used to do with the previous implementation ?

Cheers,
Ben.
