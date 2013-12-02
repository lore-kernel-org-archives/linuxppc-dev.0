Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0B5DC2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 05:00:53 +1100 (EST)
Date: Mon, 2 Dec 2013 19:00:20 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 7/9] cpuidle/powernv: Add "Fast-Sleep" CPU idle
 state
In-Reply-To: <529CA219.20109@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1312021859440.30673@ionos.tec.linutronix.de>
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
 <20131129104319.651.29563.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de>
 <529CA219.20109@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: michael@ellerman.id.au, r58472@freescale.com, shangw@linux.vnet.ibm.com,
 arnd@arndb.de, linux-pm@vger.kernel.org, geoff@infradead.org,
 fweisbec@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 deepthi@linux.vnet.ibm.com, rjw@sisk.pl, paul.gortmaker@windriver.com,
 paulus@samba.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 john.stultz@linaro.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2 Dec 2013, Preeti U Murthy wrote:
> On 11/29/2013 08:09 PM, Thomas Gleixner wrote:
> > This supports HIGHRES and NO_HZ if done right, without polling at
> > all. So you can even let the last CPU which handles the broadcast
> > hrtimer go for a long sleep, just not in the deepest idle state.
> 
> Thank you for the review. The above points are all valid. I will rework
> the design to:
> 
> 1. Eliminate the concept of a broadcast CPU and integrate its
> functionality in the timekeeping CPU.
> 
> 2. Avoid polling by using IPIs to communicate the next wakeup of the
> CPUs in deep idle state so as to reprogram the broadcast hrtimer.
> 
> 3. Make this feature generic and not arch-specific.

Great. If you need help with the generic bits, please let me know.

Thanks,

	tglx
