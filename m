Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 580C71007D3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 10:44:25 +1100 (EST)
Date: Wed, 14 Dec 2011 00:28:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_NO_HZ added too much idle time in /proc/stat during
 throughput test.
In-Reply-To: <1323818650.7671.3.camel@pasglop>
Message-ID: <alpine.LFD.2.02.1112140027230.3020@ionos>
References: <CAEu=RPirE=H1N=KjHNjNRBM6H1fRvrugCw6ojqWaTNm2=WTfng@mail.gmail.com>
 <1323818650.7671.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Dec 2011, Benjamin Herrenschmidt wrote:

> On Tue, 2011-12-13 at 12:42 -0800, Fushen Chen wrote:
> > On APM82181,  "vmstat" (/proc/stat)  doesn't show correct idle
> > percent, if kernel enables "CONFIG_NO_HZ" (Tickless System / Dynamic
> > Tick).
> > 
> > When I run wireless throughput test with heavy traffic, "vmstat" shows
> > very high idle percent while "oprofile" shows very low idle percent.
> > During the test, the system is idle, but network traffic uses a lot of
> > hard IRQ and soft-irq time. "vmstat" would have the correct stats if
> > account_idle_ticks(ticks) in kernel/time/tick-sched.c doesn't add more
> > idle time in "vmstat". In the same test, if I disable "CONFIG_NO_HZ"
> > in kernel, idle percent in "vmstat" and "oprofile" would match.
> > 
> > My APM82181 kernel configuration is "CONFIG_NO_HZ", "CONFIG_HZ_250=y",
> > "CONFIG_HZ=250", and "CONFIG_HIGH_RES_TIMERS".
> > 
> > My question is that if kernel enables "CONFIG_NO_HZ", how would kernel
> > report correct stats.
> 
> Hi Thomas ! Any idea what we're doing wrong ? :-)

Not really, that had been an issue before and had been fixed. Peter ????

Thanks,

	tglx
