Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n3JB1n02zDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 21:47:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: desnesn@linux.vnet.ibm.com
Subject: Re: [PATCH v3 2/2] powerpc/pseries: Wait for completion of hotplug
 events during PRRN handling
In-Reply-To: <5a15ca87-74ae-171f-1506-b0bc5cee11bc@linux.vnet.ibm.com>
References: <20180808152926.28842-1-jallen@linux.ibm.com>
 <20180808152926.28842-3-jallen@linux.ibm.com>
 <5a15ca87-74ae-171f-1506-b0bc5cee11bc@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 21:47:03 +1000
Message-ID: <878t5e8mvc.fsf@concordia.ellerman.id.au>
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

Hi Nathan,

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> On 08/08/2018 10:29 AM, John Allen wrote:
>> While handling PRRN events, the time to handle the actual hotplug events
>> dwarfs the time it takes to perform the device tree updates and queue the
>> hotplug events. In the case that PRRN events are being queued continuously,
>> hotplug events have been observed to be queued faster than the kernel can
>> actually handle them. This patch avoids the problem by waiting for a
>> hotplug request to complete before queueing more hotplug events.
>> 
>> Signed-off-by: John Allen <jallen@linux.ibm.com>
>
> In the V2 thread it was mentioned that we could just call the DLPAR operation
> directly instead of going through the workqueue. I have written a patch to do
> this that also cleans up some of the request handling.
>
> requests that come through the hotplug interrupt still use the workqueue. The
> other requests, PRRN and sysfs, just call the dlpar handler directly. This
> eliminates the need for a wait conditional and return code handling in the
> workqueue handler and should solve the issue that John solves with his patch.
>
> This still needs testing but wanted to get people's thoughts.

It looks great to me.

I guess I thought we'd need to add a lock, but I think you're right that
the existing device hotplug lock will work.

So if this survives a bit of testing then I'd love to merge it.

cheers
