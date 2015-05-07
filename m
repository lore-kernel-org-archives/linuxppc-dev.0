Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8432F1A066C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 03:49:42 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 7 May 2015 11:49:40 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5698519D8048
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 11:40:41 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t47HnEgE32702698
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 10:49:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t47HnZar001590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 11:49:37 -0600
Message-ID: <554BA5A8.3040009@linux.vnet.ibm.com>
Date: Thu, 07 May 2015 23:19:28 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpuidle: Handle tick_broadcast_enter() failure gracefully
References: <20150507052600.20882.39542.stgit@preeti.in.ibm.com>
 <554B36DD.5080807@arm.com>
In-Reply-To: <554B36DD.5080807@arm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "rlippert@google.com" <rlippert@google.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
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

On 05/07/2015 03:26 PM, Sudeep Holla wrote:
> Hi Preeti,
> 
> On 07/05/15 06:26, Preeti U Murthy wrote:
>> When a CPU has to enter an idle state where tick stops, it makes a call
>> to tick_broadcast_enter(). The call will fail if this CPU is the
>> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
>> handles this CPU.  This is not convincing because not only are we not
>> aware what the arch cpuidle code does, but we also do not account for
>> the idle state residency time and usage of such a CPU.
>>
>> This scenario can be handled better by simply asking the cpuidle
>> governor to choose an idle state where in ticks do not stop. To
>> accommodate this change move the setting of runqueue idle state from the
>> core to the cpuidle driver, else the rq->idle_state will be set wrong.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>> Based on linux-pm/bleeding-edge
> 
> I am unable to apply this patch cleanly on linux-pm/bleeding-edge
> I think it conflicts with few patches that Rafael posted recently
> which are in the branch now.

Thanks so much for pointing out this! I have resent the patch as V2
after the rebase on the updated linux-pm/bleeding-edge branch

Regards
Preeti U Murthy
> 
> Regards,
> Sudeep
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
