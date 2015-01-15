Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE6E21A0D50
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 08:01:07 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 15 Jan 2015 21:01:03 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CDC71B08061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 21:01:37 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FL10U758130682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 21:01:00 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FFv7P0002052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 10:57:07 -0500
Message-ID: <54B82A8B.7000809@de.ibm.com>
Date: Thu, 15 Jan 2015 22:00:59 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 4/8] x86/spinlock: Leftover conversion
 ACCESS_ONCE->READ_ONCE
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
 <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com>
 <20150115193839.GA28727@redhat.com> <54B81A37.80109@de.ibm.com>
 <20150115200119.GA29684@redhat.com>
In-Reply-To: <20150115200119.GA29684@redhat.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 15.01.2015 um 21:01 schrieb Oleg Nesterov:
> On 01/15, Christian Borntraeger wrote:
>>
>> Am 15.01.2015 um 20:38 schrieb Oleg Nesterov:
>>> On 01/15, Christian Borntraeger wrote:
>>>>
>>>> --- a/arch/x86/include/asm/spinlock.h
>>>> +++ b/arch/x86/include/asm/spinlock.h
>>>> @@ -186,7 +186,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
>>>>  	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
>>>>
>>>>  	for (;;) {
>>>> -		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
>>>> +		struct __raw_tickets tmp = READ_ONCE(lock->tickets);
>>>
>>> Agreed, but what about another ACCESS_ONCE() above?
>>>
>>> Oleg.
>>
>> tickets.head is a scalar type, so ACCESS_ONCE does work fine with gcc 4.6/4.7.
>> My goal was to convert all accesses on non-scalar types
> 
> I understand, but READ_ONCE(lock->tickets.head) looks better anyway and
> arch_spin_lock() already use READ_ONCE() for this.
> 
> So why we should keep the last ACCESS_ONCE() in spinlock.h ? Just to make
> another cosmetic cleanup which touches the same function later?

OK, I will change that one as well.
