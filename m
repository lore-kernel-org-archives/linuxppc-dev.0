Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4C9DB2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 02:58:55 +1100 (EST)
Date: Tue, 11 Feb 2014 16:58:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V4 2/3] tick/cpuidle: Initialize hrtimer mode of broadcast
In-Reply-To: <52F9F896.4020402@linaro.org>
Message-ID: <alpine.DEB.2.02.1402111654190.21991@ionos.tec.linutronix.de>
References: <20140207075618.17187.20149.stgit@preeti.in.ibm.com>
 <20140207080632.17187.80532.stgit@preeti.in.ibm.com>
 <52F9F896.4020402@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, fweisbec@gmail.com,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 Feb 2014, Daniel Lezcano wrote:
> On 02/07/2014 09:06 AM, Preeti U Murthy wrote:
> Setting the smp affinity on the earliest timer should be handled automatically
> with the CLOCK_EVT_FEAT_DYNIRQ flag. Did you look at using this flag ?

How should this flag help? Not at all, because the hrtimer based
broadcast device cannot assign affinities.
 
> Another comment is the overall approach. We enter the cpuidle idle framework
> with a specific state to go to and it is the tick framework telling us we
> mustn't go to this state. IMO the logic is wrong, the decision to not enter
> this state should be moved somewhere else.
> 
> Why don't you create a cpuidle driver with the shallow idle states assigned to
> a cpu (let's say cpu0) and another one with all the deeper idle states for the
> rest of the cpus ? Using the multiple cpuidle driver support makes it
> possible. The timer won't be moving around and a cpu will be dedicated to act
> as the broadcast timer.
> 
> Wouldn't make sense and be less intrusive than the patchset you proposed ?

How do you arm the broadcast timer on CPU0 from CPU1? You can't!

You cannot access the cpu local timer on a different cpu. So you would
have to send an IPI over to CPU0 so that it can reevaluate and
schedule the broadcast. That's even more backwards than telling the
cpuidle code that the CPU is not in a state to go deep.

Thanks,

	tglx
