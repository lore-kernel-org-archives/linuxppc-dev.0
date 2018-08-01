Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gYjN14j5zF1BL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 23:16:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH v2 2/2] powerpc/pseries: Wait for completion of hotplug
 events during PRRN handling
In-Reply-To: <20180723152223.mydr5dovcv26domv@p50>
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-3-jallen@linux.ibm.com>
 <87k1pmhxx7.fsf@concordia.ellerman.id.au>
 <20180723152223.mydr5dovcv26domv@p50>
Date: Wed, 01 Aug 2018 23:16:22 +1000
Message-ID: <87in4ufcrd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

John Allen <jallen@linux.ibm.com> writes:

> On Mon, Jul 23, 2018 at 11:41:24PM +1000, Michael Ellerman wrote:
>>John Allen <jallen@linux.ibm.com> writes:
>>
>>> While handling PRRN events, the time to handle the actual hotplug events
>>> dwarfs the time it takes to perform the device tree updates and queue the
>>> hotplug events. In the case that PRRN events are being queued continuously,
>>> hotplug events have been observed to be queued faster than the kernel can
>>> actually handle them. This patch avoids the problem by waiting for a
>>> hotplug request to complete before queueing more hotplug events.

Have you tested this patch in isolation, ie. not with patch 1?

>>So do we need the hotplug work queue at all? Can we just call
>>handle_dlpar_errorlog() directly?
>>
>>Or are we using the work queue to serialise things? And if so would a
>>mutex be better?
>
> Right, the workqueue is meant to serialize all hotplug events and it 
> gets used for more than just PRRN events. I believe the motivation for 
> using the workqueue over a mutex is that KVM guests initiate hotplug 
> events through the hotplug interrupt and can queue fairly large requests 
> meaning that in this scenario, waiting for a lock would block interrupts
> for a while.

OK, but that just means that path needs to schedule work to run later.

> Using the workqueue allows us to serialize hotplug events 
> from different sources in the same way without worrying about the 
> context in which the event is generated.

A lock would be so much simpler.

It looks like we have three callers of queue_hotplug_event(), the dlpar
code, the mobility code and the ras interrupt.

The dlpar code already waits synchronously:

  init_completion(&hotplug_done);
  queue_hotplug_event(hp_elog, &hotplug_done, &rc);
  wait_for_completion(&hotplug_done);

You're changing mobility to do the same (this patch), leaving only the
ras interrupt that actually queues work and returns.


So it really seems like a mutex would do the trick, and the ras
interrupt would be the only case that needs to schedule work for later.

cheers
