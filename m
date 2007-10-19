Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A21FEDDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:49:27 +1000 (EST)
Message-ID: <471899D1.2000903@ru.mvista.com>
Date: Fri, 19 Oct 2007 15:49:37 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>	<47161D79.6000003@ru.mvista.com>	<18198.43687.44059.477047@cargo.ozlabs.ibm.com>	<47177229.2030200@ru.mvista.com>
	<18199.63230.583536.307945@cargo.ozlabs.ibm.com>
In-Reply-To: <18199.63230.583536.307945@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>>What problem do you see arising from this?

>>    Timers firing too early.

> Only if the minimum interrupt latency is less than 1 decrementer
> tick.  That seems pretty unlikely to me unless you have a very slow
> timebase frequency.

    Well, MPC8540 has 825 MHz CPU clock yet decrementor/timebase are clocked 
with 25 MHz clock if I don't mistake. That gives us 33 CPU clocks of available 
interrupt latency...

> In fact what we should program the decrementer to is:

> 	timeout - (is_booke? 0: 1) - min_interrupt_latency

    BTW, why not handle the decrementer difference right in set_dec() where we 
already have #ifdef'ed code?

> I was assuming that min_interrupt_latency (measured in timebase ticks)
> would be at least 1, but apparently some systems can have a timebase
> frequency as low as 1kHz, so we'll have to have an ifdef or something.

    IMHO it's better to have #ifdef based on the decremeter model and forget 
about the whole issue, rather than to #ifdef based on some bizarre system with 
slowish decremeter, isn't it?

> Paul.

WBR, Sergei
