Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A83D61007D3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 10:34:24 +1100 (EST)
Message-ID: <1323819246.7671.4.camel@pasglop>
Subject: Re: CONFIG_NO_HZ added too much idle time in /proc/stat during
 throughput test.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fushen Chen <fchen@apm.com>
Date: Wed, 14 Dec 2011 10:34:06 +1100
In-Reply-To: <alpine.LFD.2.02.1112140027230.3020@ionos>
References: <CAEu=RPirE=H1N=KjHNjNRBM6H1fRvrugCw6ojqWaTNm2=WTfng@mail.gmail.com>
 <1323818650.7671.3.camel@pasglop>
 <alpine.LFD.2.02.1112140027230.3020@ionos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-14 at 00:28 +0100, Thomas Gleixner wrote:
> On Wed, 14 Dec 2011, Benjamin Herrenschmidt wrote:
> 
> > On Tue, 2011-12-13 at 12:42 -0800, Fushen Chen wrote:
> > > On APM82181,  "vmstat" (/proc/stat)  doesn't show correct idle
> > > percent, if kernel enables "CONFIG_NO_HZ" (Tickless System / Dynamic
> > > Tick).
> > > 
> > > When I run wireless throughput test with heavy traffic, "vmstat" shows
> > > very high idle percent while "oprofile" shows very low idle percent.
> > > During the test, the system is idle, but network traffic uses a lot of
> > > hard IRQ and soft-irq time. "vmstat" would have the correct stats if
> > > account_idle_ticks(ticks) in kernel/time/tick-sched.c doesn't add more
> > > idle time in "vmstat". In the same test, if I disable "CONFIG_NO_HZ"
> > > in kernel, idle percent in "vmstat" and "oprofile" would match.
> > > 
> > > My APM82181 kernel configuration is "CONFIG_NO_HZ", "CONFIG_HZ_250=y",
> > > "CONFIG_HZ=250", and "CONFIG_HIGH_RES_TIMERS".
> > > 
> > > My question is that if kernel enables "CONFIG_NO_HZ", how would kernel
> > > report correct stats.
> > 
> > Hi Thomas ! Any idea what we're doing wrong ? :-)
> 
> Not really, that had been an issue before and had been fixed. Peter ????

Fusen, what kernel version is this ?

Cheers,
Ben.
