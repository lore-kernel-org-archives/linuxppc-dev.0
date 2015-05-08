Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 125851A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 22:43:44 +1000 (AEST)
Message-ID: <554CAF7A.6060609@arm.com>
Date: Fri, 08 May 2015 13:43:38 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure
 gracefully
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
In-Reply-To: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
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



On 08/05/15 08:35, Preeti U Murthy wrote:
> When a CPU has to enter an idle state where tick stops, it makes a call
> to tick_broadcast_enter(). The call will fail if this CPU is the
> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
> handles this CPU.  This is not convincing because not only do we not
> know what the arch cpuidle code does, but we also do not account for the
> idle state residency time and usage of such a CPU.
>
> This scenario can be handled better by simply choosing an idle state
> where in ticks do not stop. To accommodate this change move the setting
> of runqueue idle state from the core to the cpuidle driver, else the
> rq->idle_state will be set wrong.
>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

I gave it a spin on ARM64 Juno platform with one of the CPU in broadcast
mode and Vexpress TC2 with broadcast timer. I found no issues in both
the cases. So, you can add:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
