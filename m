Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlv7D6rbqzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 18:32:40 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 14 Apr 2016 18:32:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 379992CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 18:32:27 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3E8WIH21311092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 18:32:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3E8Vrd3010621
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 18:31:54 +1000
Message-ID: <570F5557.1070207@linux.vnet.ibm.com>
Date: Thu, 14 Apr 2016 16:31:19 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Waiman Long <waiman.long@hpe.com>
CC: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
References: <570752AA.9050603@linux.vnet.ibm.com>
 <20160408074744.GU3430@twins.programming.kicks-ass.net>
 <570A6078.2050002@linux.vnet.ibm.com> <20160412143023.GH1087@worktop>
 <570E2A45.9080702@linux.vnet.ibm.com> <570E6B76.5080306@hpe.com>
In-Reply-To: <570E6B76.5080306@hpe.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Waiman

On 2016年04月13日 23:53, Waiman Long wrote:
> On 04/13/2016 07:15 AM, Pan Xinhui wrote:
>> Hello Peter,
>>
>> On 2016年04月12日 22:30, Peter Zijlstra wrote:
>>
>>>> I am working on the qspinlock implementation on PPC.
>>>> Your and Waiman's patches are so nice. :)
>>> Thanks!, last time I looked at PPC spinlocks they could not use things
>>> like ticket locks because PPC might be a guest and fairness blows etc..
>>>
>>> You're making the qspinlock-paravirt thing work on PPC, or doing
>>> qspinlock only for bare-metal PPC?
>>>
>> I am making the both work. :)
>> qspinlock works on PPC now. I am preparing the patches and will send them out in next weeks :)
> 
> What of performance improvement are you seeing in PPC?
> 
well, not good. I wrote one small benchmark which just increase a integer with spinlock hold.
the overhead of lock itself is high. But the fairness is good.
I just do the tests in guestOS, and the qspinlock does not make use of paravirt, but spinlock does. So the performance gap now is a little big.
looks like I need change the kernel config, and re-test.

I does not measure the system impact in real world now. Let's see the kernel build times with two different locks.
If possible, Could you share us how you do the performance test?

>> The paravirt work is a little hard.
>> currently, there are pv_wait() and pv_kick(). but only pv_kick has the parameter cpu(who will hold the lock as soon as the lock is unlocked).
>> We need parameter cpu(who holds the lock now) in pv_wait,too.
> 
> That can be doable to a certain extent. However, if the current lock holder acquired the lock via the fastpath only. The CPU information is not logged anywhere. For a contended lock, the information should be there.
> 
yes. Maybe we could use hashtable. We could put lock, lock holder in pv_node, too. :)
Just my thoughts.

thanks
xinhui

> Cheers, 
> Longman
> 
