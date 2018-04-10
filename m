Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L1Wv4v3DzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 19:07:07 +1000 (AEST)
Date: Tue, 10 Apr 2018 11:07:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Occasionally losing the tick_sched_timer
In-Reply-To: <20180410182651.727b5ae7@roar.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.21.1804101105260.2058@nanos.tec.linutronix.de>
References: <20180410121618.4fffffcc@roar.ozlabs.ibm.com>
 <alpine.DEB.2.21.1804100923430.2058@nanos.tec.linutronix.de>
 <20180410182651.727b5ae7@roar.ozlabs.ibm.com>
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

On Tue, 10 Apr 2018, Nicholas Piggin wrote:
> On Tue, 10 Apr 2018 09:42:29 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Thomas do you have any ideas on what we might look for, or if we can add
> > > some BUG_ON()s to catch this at its source?  
> > 
> > Not really. Tracing might be a more efficient tool that random BUG_ONs.
> 
> Sure, we could try that. Any suggestions? timer events?

timer, hrtimer and the tick-sched stuff should be a good start. And make
sure to freeze the trace once you hit the fault case. tracing_off() is your
friend.

Thanks,

	tglx
