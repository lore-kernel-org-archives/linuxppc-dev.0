Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 2E18E1A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 19:56:51 +1000 (AEST)
Message-ID: <554B36DD.5080807@arm.com>
Date: Thu, 07 May 2015 10:56:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle: Handle tick_broadcast_enter() failure gracefully
References: <20150507052600.20882.39542.stgit@preeti.in.ibm.com>
In-Reply-To: <20150507052600.20882.39542.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "rlippert@google.com" <rlippert@google.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Preeti,

On 07/05/15 06:26, Preeti U Murthy wrote:
> When a CPU has to enter an idle state where tick stops, it makes a call
> to tick_broadcast_enter(). The call will fail if this CPU is the
> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
> handles this CPU.  This is not convincing because not only are we not
> aware what the arch cpuidle code does, but we also do not account for
> the idle state residency time and usage of such a CPU.
>
> This scenario can be handled better by simply asking the cpuidle
> governor to choose an idle state where in ticks do not stop. To
> accommodate this change move the setting of runqueue idle state from the
> core to the cpuidle driver, else the rq->idle_state will be set wrong.
>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Based on linux-pm/bleeding-edge

I am unable to apply this patch cleanly on linux-pm/bleeding-edge
I think it conflicts with few patches that Rafael posted recently
which are in the branch now.

Regards,
Sudeep
