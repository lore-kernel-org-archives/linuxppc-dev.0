Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9FDE1A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 03:07:22 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 26 Nov 2014 16:07:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A29B17D805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:07:31 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQG7FFk65142892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:07:15 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQG7Eqw009798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 11:07:15 -0500
Message-ID: <5475FAB1.1000802@de.ibm.com>
Date: Wed, 26 Nov 2014 17:07:13 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20141126070258.GA25523@redhat.com> <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com> <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530> <20141126154717.GB10568@redhat.com>
In-Reply-To: <20141126154717.GB10568@redhat.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 26.11.2014 um 16:47 schrieb Michael S. Tsirkin:
> On Wed, Nov 26, 2014 at 04:32:07PM +0100, David Hildenbrand wrote:
>>> On Wed, Nov 26, 2014 at 05:17:29PM +0200, Michael S. Tsirkin wrote:
>>>> On Wed, Nov 26, 2014 at 11:05:04AM +0100, David Hildenbrand wrote:
>>>>>> What's the path you are trying to debug?
>>>>>
>>>>> Well, we had a problem where we held a spin_lock and called
>>>>> copy_(from|to)_user(). We experienced very random deadlocks that took some guy
>>>>> almost a week to debug. The simple might_sleep() check would have showed this
>>>>> error immediately.
>>>>
>>>> This must have been a very old kernel.
>>>> A modern kernel will return an error from copy_to_user.
>>>> Which is really the point of the patch you are trying to revert.
>>>
>>> That's assuming you disabled preemption. If you didn't, and take
>>> a spinlock, you have deadlocks even without userspace access.
>>>
>>
>> (Thanks for your resent, my first email was sent directly to you ... grml)
>>
>> This is what happened on our side (very recent kernel):
>>
>> spin_lock(&lock)
>> copy_to_user(...)
>> spin_unlock(&lock)
> 
> That's a deadlock even without copy_to_user - it's
> enough for the thread to be preempted and another one
> to try taking the lock.

Huh? With CONFIG_PREEMPT spin_lock will disable preemption. (we had preempt = server anyway).

But please: One step back. The problem is not the good path. The problem is that we lost a debugging aid for a known to be broken case. In other words: Our code had a bug. Older kernels detected that kind of bug. With your change we no longer saw the sleeping while atomic. Thats it. See my other mail.

Christian
