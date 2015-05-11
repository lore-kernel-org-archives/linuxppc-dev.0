Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B6171A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 15:21:14 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 10 May 2015 23:21:11 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E57A919D8040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 23:12:11 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t4B5Ki4p36634862
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 22:20:44 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B5L7MO008747
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 23:21:08 -0600
Message-ID: <55503C3E.6020804@linux.vnet.ibm.com>
Date: Mon, 11 May 2015 10:51:02 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <10239011.l6QLHlKIVm@vostro.rjw.lan> <3161640.llJtBoKCBr@vostro.rjw.lan>
 <8965830.CMQzZzsqm0@vostro.rjw.lan>
In-Reply-To: <8965830.CMQzZzsqm0@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2015 04:45 AM, Rafael J. Wysocki wrote:
> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>> Hi Rafael,
>>>>
>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>
>>> [cut]
>>>
>>>>>>  
>>>>>> +	/* Take note of the planned idle state. */
>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>
>>>>> And I wouldn't do this either.
>>>>>
>>>>> The behavior here is pretty much as though the driver demoted the state chosen
>>>>> by the governor and we don't call idle_set_state() again in those cases.
>>>>
>>>> Why is this wrong?
>>>
>>> It is not "wrong", but incomplete, because demotions done by the cpuidle driver
>>> should also be taken into account in the same way.
>>>
>>> But I'm seeing that the recent patch of mine that made cpuidle_enter_state()
>>> call default_idle_call() was a mistake, because it might confuse find_idlest_cpu()
>>> significantly as to what state the CPU is in.  I'll drop that one for now.
>>
>> OK, done.
>>
>> So after I've dropped it I think we need to do three things:
>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>> (2) Make cpuidle_enter_state() call default_idle_call() again, but this time
>>     do that *before* it has called idle_set_state() for target_state.
>> (3) Introduce demotion as per my last patch.
>>
>> Let me cut patches for that.
> 
> Done as per the above and the patches follow in replies to this messge.
> 
> All on top of the current linux-next branch of the linux-pm.git tree.

The patches look good. Based and tested these patches on top of
linux-pm/linux-next (They are not yet in the branch as far as I can see.)

All patches in this series
Reviewed and Tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> 
