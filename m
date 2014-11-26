Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D51B31A0B8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 03:51:17 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 26 Nov 2014 16:51:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 838B917D8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:51:27 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQGpBZS3735810
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:51:11 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQGp8Bi009838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:51:10 -0700
Message-ID: <547604FC.4030300@de.ibm.com>
Date: Wed, 26 Nov 2014 17:51:08 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20141126070258.GA25523@redhat.com> <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com> <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530> <20141126154717.GB10568@redhat.com>
 <5475FAB1.1000802@de.ibm.com> <20141126163216.GB10850@redhat.com>
In-Reply-To: <20141126163216.GB10850@redhat.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>,
 paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 26.11.2014 um 17:32 schrieb Michael S. Tsirkin:
[...]
>>>> This is what happened on our side (very recent kernel):
>>>>
>>>> spin_lock(&lock)
>>>> copy_to_user(...)
>>>> spin_unlock(&lock)
>>>
>>> That's a deadlock even without copy_to_user - it's
>>> enough for the thread to be preempted and another one
>>> to try taking the lock.
>>
>> Huh? With CONFIG_PREEMPT spin_lock will disable preemption. (we had preempt = server anyway).
> 
> Are you sure? Can you point me where it does this please?

spin_lock --> raw_spin_lock --> _raw_spin_lock --> __raw_spin_lock

static inline void __raw_spin_lock(raw_spinlock_t *lock)
{
---->   preempt_disable();   <-----
        spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
        LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
}


Michael, please be serious. The whole kernel would be broken if spin_lock would not disable preemption.


> 
>> But please: One step back. The problem is not the good path. The problem is that we lost a debugging aid for a known to be broken case. In other words: Our code had a bug. Older kernels detected that kind of bug. With your change we no longer saw the sleeping while atomic. Thats it. See my other mail.
>>
>> Christian
> 
> You want to add more debugging tools, fine.

We dont want to add, we want to fix something that used to work

> But this one was > giving users in field false positives.

So lets try to fix those, ok? If we cant, then tough luck. But coming up with wrong statements is not helpful.

> 
> The point is that *_user is safe with preempt off.
> It returns an error gracefully.
> It does not sleep.
> It does not trigger the scheduler in that context.

There are special cases where your statement is true. But its not in general.
copy_to_user might fault and that fault might sleep and reschedule. For example handle_mm_fault might go down to pud_alloc, pmd_alloc etc and all these functions could do an GFP_KERNEL allocation. Which might sleep. Which will schedule.


> 
> 
> David's patch makes it say it does, so it's wrong.
> 
> 
> 
