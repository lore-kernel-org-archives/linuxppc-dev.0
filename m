Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id DF1A9DDF11
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 22:07:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] [patch 4/6 -rt] powerpc 2.6.20-rt8: fix a runtime warnings
	for xmon
Date: Wed, 7 Mar 2007 12:06:51 +0100
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi3b4h25jj.wl@toshiba.co.jp>
	<20070307091638.GC1783@elte.hu>
In-Reply-To: <20070307091638.GC1783@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703071206.52551.arnd@arndb.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 March 2007, Ingo Molnar wrote:
> i'm not an xmon expert, but maybe it might make more sense to first 
> disable preemption, then interrupts - otherwise you could be preempted 
> right after having disabled these interrupts (and be scheduled to 
> another CPU, etc.). What is the difference between local_irq_save() and 
> the above 'disable interrupts' sequence? If it's not the same and 
> xmon_core() relied on having hardirqs disabled then it might make sense 
> to do a local_irq_save() there, instead of a preempt_disable().

Since relatively recently, powerpc does no longer actually disable
the hardware interrupts with local_irq_disable(), but rather sets
a per-cpu flag that will be checked if an actual interrupt comes
in as part of the critical section.

The mtmsr() sequence in xmon corresponds to hard_irq_disable()
and should probably changed to that, but then you still need
the extra preempt_disable() / preempt_enable().

I think you're right about the sequence having to be
1. preempt_disable()
2. hard_irq_disable()
3.
4. hard_irq_enable()
5. preempt_enable()

	Arnd <><
