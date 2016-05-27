Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGMq83H21zDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 20:35:32 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4RAXslq019795
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 06:35:29 -0400
Message-Id: <201605271035.u4RAXslq019795@mx0a-001b2d01.pphosted.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 236aymdusk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 06:35:28 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 27 May 2016 16:05:25 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E4B413940069
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:05:21 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4RAZ69d61800502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:05:06 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4RAZFXf024184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:05:19 +0530
Date: Fri, 27 May 2016 18:34:58 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, jeremy@goop.org, chrisw@sous-sol.org,
 akataria@vmware.com, rusty@rustcorp.com.au
Subject: Re: [PATCH v3 5/6] pv-qspinlock: use cmpxchg_release in
 __pv_queued_spin_unlock
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464164289-6124-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160526164729.GL3206@twins.programming.kicks-ass.net>
 <20160526165712.GT3205@twins.programming.kicks-ass.net>
In-Reply-To: <20160526165712.GT3205@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年05月27日 00:57, Peter Zijlstra wrote:
> On Thu, May 26, 2016 at 06:47:29PM +0200, Peter Zijlstra wrote:
>> On Wed, May 25, 2016 at 04:18:08PM +0800, Pan Xinhui wrote:
>>> cmpxchg_release is light-wight than cmpxchg, we can gain a better
>>> performace then. On some arch like ppc, barrier impact the performace
>>> too much.
>>>
>>> Suggested-by:  Boqun Feng <boqun.feng@gmail.com>
>>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>> ---
>>>   kernel/locking/qspinlock_paravirt.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
>>> index a5b1248..2bbffe4 100644
>>> --- a/kernel/locking/qspinlock_paravirt.h
>>> +++ b/kernel/locking/qspinlock_paravirt.h
>>> @@ -614,7 +614,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
>>>   	 * unhash. Otherwise it would be possible to have multiple @lock
>>>   	 * entries, which would be BAD.
>>>   	 */
>>> -	locked = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
>>> +	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
>>>   	if (likely(locked == _Q_LOCKED_VAL))
>>>   		return;
>>
>> This patch fails to explain _why_ it can be relaxed.
>>
>> And seeing how this cmpxchg() can actually unlock the lock, I don't see
>> how this can possibly be correct. Maybe cmpxchg_release(), but relaxed
>> seems very wrong.
>
> Clearly I need to stop working for the day, I cannea read. You're doing
> release, not relaxed.
>
Never mind.  thanks for review :)

> Still Changelog needs improvement.
>
Will do that.

thanks
xinhui
