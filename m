Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lPdl2YHkzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 05:26:35 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77JNuCv031172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2018 15:26:33 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqdme2d2h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 15:26:33 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Tue, 7 Aug 2018 15:26:31 -0400
Date: Tue, 7 Aug 2018 14:26:28 -0500
From: John Allen <jallen@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/pseries: Wait for completion of hotplug
 events during PRRN handling
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-3-jallen@linux.ibm.com>
 <87k1pmhxx7.fsf@concordia.ellerman.id.au>
 <20180723152223.mydr5dovcv26domv@p50>
 <87in4ufcrd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87in4ufcrd.fsf@concordia.ellerman.id.au>
Message-Id: <20180807192628.uf3nycnagabjs55o@p50.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2018 at 11:16:22PM +1000, Michael Ellerman wrote:
>John Allen <jallen@linux.ibm.com> writes:
>
>> On Mon, Jul 23, 2018 at 11:41:24PM +1000, Michael Ellerman wrote:
>>>John Allen <jallen@linux.ibm.com> writes:
>>>
>>>> While handling PRRN events, the time to handle the actual hotplug events
>>>> dwarfs the time it takes to perform the device tree updates and queue the
>>>> hotplug events. In the case that PRRN events are being queued continuously,
>>>> hotplug events have been observed to be queued faster than the kernel can
>>>> actually handle them. This patch avoids the problem by waiting for a
>>>> hotplug request to complete before queueing more hotplug events.
>
>Have you tested this patch in isolation, ie. not with patch 1?

While I was away on vacation, I believe a build was tested with just 
this patch and not the first and it has been running with no problems.  
However, I think they've had problems recreating the problem in general 
so it may just be that the environment is not setup properly to recreate 
the issue.

>
>>>So do we need the hotplug work queue at all? Can we just call
>>>handle_dlpar_errorlog() directly?
>>>
>>>Or are we using the work queue to serialise things? And if so would a
>>>mutex be better?
>>
>> Right, the workqueue is meant to serialize all hotplug events and it
>> gets used for more than just PRRN events. I believe the motivation for
>> using the workqueue over a mutex is that KVM guests initiate hotplug
>> events through the hotplug interrupt and can queue fairly large requests
>> meaning that in this scenario, waiting for a lock would block interrupts
>> for a while.
>
>OK, but that just means that path needs to schedule work to run later.
>
>> Using the workqueue allows us to serialize hotplug events
>> from different sources in the same way without worrying about the
>> context in which the event is generated.
>
>A lock would be so much simpler.
>
>It looks like we have three callers of queue_hotplug_event(), the dlpar
>code, the mobility code and the ras interrupt.
>
>The dlpar code already waits synchronously:
>
>  init_completion(&hotplug_done);
>  queue_hotplug_event(hp_elog, &hotplug_done, &rc);
>  wait_for_completion(&hotplug_done);
>
>You're changing mobility to do the same (this patch), leaving only the
>ras interrupt that actually queues work and returns.
>
>
>So it really seems like a mutex would do the trick, and the ras
>interrupt would be the only case that needs to schedule work for later.

I think you may be right, but I would need some feedback from Nathan 
Fontenot before I redesign the queue. He's been thinking about that 
design for longer than I have and may know something that I don't 
regarding the reason we're using a workqueue rather than a mutex.

Given that the bug this is meant to address is pretty high priority, 
would you consider the wait_for_completion an acceptable stopgap while a 
more substantial redesign of this code is discussed?

-John
