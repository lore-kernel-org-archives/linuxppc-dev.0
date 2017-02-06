Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGy8c5SkTzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 17:23:28 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v166IXfY136780
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 01:23:26 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28dbu3xkw7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 01:23:25 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 11:53:22 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 89D7CE0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 11:54:44 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v166NJQ328246084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 11:53:19 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v166NH19020488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 11:53:19 +0530
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20170203155453.GA23760@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 11:53:10 +0530
Cc: Peter Zijlstra <peterz@infradead.org>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Ross Zwisler <zwisler@gmail.com>
References: <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
 <1485863317.4498.2.camel@gmx.de>
 <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
 <20170202155506.GX6515@twins.programming.kicks-ass.net>
 <3BAB5673-2BF8-46E0-8018-6A0F3DEEC9F7@linux.vnet.ibm.com>
 <20170203085301.GA6515@twins.programming.kicks-ass.net>
 <1486126774.4277.6.camel@gmx.de>
 <20170203133748.GB6515@twins.programming.kicks-ass.net>
 <20170203154457.GJ30506@linux.vnet.ibm.com>
 <20170203155453.GA23760@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com
Message-Id: <45DC157B-EA1A-4E1C-9449-8DD317837FCB@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>> I've seen it on tip. It looks like hot unplug goes really slow when
>>> there's running tasks on the CPU being taken down.
>>>=20
>>> What I did was something like:
>>>=20
>>>  taskset -p $((1<<1)) $$
>>>  for ((i=3D0; i<20; i++)) do while :; do :; done & done
>>>=20
>>>  taskset -p $((1<<0)) $$
>>>  echo 0 > /sys/devices/system/cpu/cpu1/online
>>>=20
>>> And with those 20 tasks stuck sucking cycles on CPU1, the unplug =
goes
>>> _really_ slow and the RCU stall triggers. What I suspect happens is =
that
>>> hotplug stops participating in the RCU state machine early, but only
>>> tells RCU about it really late, and in between it gets suspicious it
>>> takes too long.
>>>=20
>>> I've yet to dig through the RCU code to figure out the exact =
sequence of
>>> events, but found the above to be fairly reliable in triggering the
>>> issue.
>=20
>> If you send me the full splat from the dmesg and the RCU portions of
>> .config, I will take a look.  Is this new behavior, or a new test?
>=20

I have sent the required files to you via separate email.

> If new behavior, I would be most suspicious of these commits in -rcu =
which
> recently entered -tip:
>=20
> 19e4d983cda1 rcu: Place guard on rcu_all_qs() and =
rcu_note_context_switch() actions
> 913324b1364f rcu: Eliminate flavor scan in =
rcu_momentary_dyntick_idle()
> fcdcfefafa45 rcu: Pull rcu_qs_ctr into rcu_dynticks structure
> 0919a0b7e7a5 rcu: Pull rcu_sched_qs_mask into rcu_dynticks structure
> caa7c8e34293 rcu: Make rcu_note_context_switch() do deferred NOCB =
wakeups
> 41e4b159d516 rcu: Make rcu_all_qs() do deferred NOCB wakeups
> b457a3356a68 rcu: Make call_rcu() do deferred NOCB wakeups
>=20
> Does reverting any of these help?

I tried reverting the above commits. That does not help. I can still =
recreate the issue.

Thanks
-Sachin=
