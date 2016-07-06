Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkxGs73hbzDqyy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 20:06:13 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66A4CKG086431
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 06:06:11 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240ndx1d6m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 06:06:11 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 20:06:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B91F42BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 20:06:07 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66A67iX10617152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 20:06:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66A66qq012013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 20:06:07 +1000
Date: Wed, 06 Jul 2016 18:05:58 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com,
 dave@stgolabs.net, schwidefsky@de.ibm.com, pbonzini@redhat.com
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
In-Reply-To: <20160706065255.GH30909@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <577CD806.8000008@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年07月06日 14:52, Peter Zijlstra wrote:
> On Tue, Jun 28, 2016 at 10:43:07AM -0400, Pan Xinhui wrote:
>> change fomr v1:
>> 	a simplier definition of default vcpu_is_preempted
>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner.
>> 	add more comments
>> 	thanks boqun and Peter's suggestion.
>>
>> This patch set aims to fix lock holder preemption issues.
>>
>> test-case:
>> perf record -a perf bench sched messaging -g 400 -p && perf report
>>
>> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
>> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>>   5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>>   3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>>   3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>>   3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>>   2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
>>
>> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
>> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
>> These spin_on_onwer variant also cause rcu stall before we apply this patch set
>>
>
> Paolo, could you help out with an (x86) KVM interface for this?
>
> Waiman, could you see if you can utilize this to get rid of the
> SPIN_THRESHOLD in qspinlock_paravirt?
>
hmm. maybe something like below. wait_node can go into pv_wait() earlier as soon as the prev cpu is preempted.
but for the wait_head, as qspinlock does not record the lock_holder correctly(thanks to lock stealing), vcpu preemption check might get wrong results.

Waiman, I have used one hash table to keep the lock holder in my ppc implementation patch. I think we could do something similar in generic code?

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 74c4a86..40560e8 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -312,7 +312,8 @@ pv_wait_early(struct pv_node *prev, int loop)
         if ((loop & PV_PREV_CHECK_MASK) != 0)
                 return false;
  
-       return READ_ONCE(prev->state) != vcpu_running;
+       return READ_ONCE(prev->state) != vcpu_running ||
+                               vcpu_is_preempted(prev->cpu);
  }
  
  /*
