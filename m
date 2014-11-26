Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAB1C1A0519
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 03:02:46 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 26 Nov 2014 16:02:43 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E24321B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:02:54 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQG2dFE3473896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:02:39 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQG2ahN020824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:02:38 -0700
Message-ID: <5475F99B.3090307@de.ibm.com>
Date: Wed, 26 Nov 2014 17:02:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20141126070258.GA25523@redhat.com> <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com> <5475F218.4050207@de.ibm.com>
 <20141126153732.GA10568@redhat.com>
In-Reply-To: <20141126153732.GA10568@redhat.com>
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

Am 26.11.2014 um 16:37 schrieb Michael S. Tsirkin:
> On Wed, Nov 26, 2014 at 04:30:32PM +0100, Christian Borntraeger wrote:
>> Am 26.11.2014 um 16:17 schrieb Michael S. Tsirkin:
>>> On Wed, Nov 26, 2014 at 11:05:04AM +0100, David Hildenbrand wrote:
>>>>> What's the path you are trying to debug?
>>>>
>>>> Well, we had a problem where we held a spin_lock and called
>>>> copy_(from|to)_user(). We experienced very random deadlocks that took some guy
>>>> almost a week to debug. The simple might_sleep() check would have showed this
>>>> error immediately.
>>>
>>
>>> This must have been a very old kernel.
>>> A modern kernel will return an error from copy_to_user.
>>
>> I disagree. copy_to_user will not return while holding a spinlock, because it does not know! How should it?
>> See: spin_lock will call preempt_disable, but thats a no-op for a non-preempt kernel. So the mere fact that we hold a spin_lock is not known by any user access function. (or others). No?
>>
>> Christian
>>
>>
> 
> Well might_sleep() merely checks preempt count and irqs_disabled too.
> If you want debugging things to trigger, you need to enable
> a bunch of config options.  That's not new.

You miss the point of the whole thread: The problem is that even with debug options enabled, holding a spinlock would not trigger a bug on copy_to_user. So the problem is not the good path, the problem is that a debugging aid for detecting a broken case was lost. Even with all kernel debugging enabled.

That is because CONFIG_DEBUG_ATOMIC_SLEEP selects PREEMPT_COUNT. That means: spin_lock will then be considered as in_atomic and no message comes. Without CONFIG_DEBUG_ATOMIC_SLEEP spin_lock will not touch the preempt_count but we also dont see a message because might_fault is now a nop

I understand that you dont like Davids changes due to other side effects that you have mentioned. So lets focus on how we can fix the debug option. Ok?

Christian
