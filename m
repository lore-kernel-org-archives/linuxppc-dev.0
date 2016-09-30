Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slmRp0rqwzDvHZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 19:32:05 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8U9SOGX009184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 05:32:03 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25sm7uasyd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 05:32:02 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 30 Sep 2016 03:32:02 -0600
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
 <20160929103133.GW5016@twins.programming.kicks-ass.net>
 <496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
 <2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
 <caabadb6-fe62-aaf7-260f-79f230d03a1c@linux.vnet.ibm.com>
 <f0e8b549-e647-6a01-a93d-9f192adc70c6@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 will deacon <will.deacon@arm.com>, kernellwp@gmail.com,
 jgross@suse.com, bsingharora@gmail.com,
 Heiko Carstens <heiko.carstens@de.ibm.com>
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Fri, 30 Sep 2016 17:31:48 +0800
MIME-Version: 1.0
In-Reply-To: <f0e8b549-e647-6a01-a93d-9f192adc70c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ce64b907-6316-7c36-428b-680d869ef045@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/9/30 17:08, Paolo Bonzini 写道:
>
>
> On 30/09/2016 10:52, Pan Xinhui wrote:
>>> x86 has no hypervisor support, and I'd like to understand the desired
>>> semantics first, so I don't think it should block this series.  In
>>
>> Once a guest do a hypercall or something similar, IOW, there is a
>> kvm_guest_exit. we think this is a lock holder preemption.
>> Adn PPC implement it in this way.
>
> Ok, good.
>
>>> particular, there are at least the following choices:
>>>
>>> 1) exit to userspace (5-10.000 clock cycles best case) counts as
>>> lock holder preemption
>>>
>>> 2) any time the vCPU thread not running counts as lock holder
>>> preemption
>>>
>>> To implement the latter you'd need a hypercall or MSR (at least as
>>> a slow path), because the KVM preempt notifier is only active
>>> during the KVM_RUN ioctl.
>>
>> seems a little expensive. :(
>> How many clock cycles it might cost.
>
> An MSR read is about 1500 clock cycles, but it need not be the fast path
> (e.g. use a bit to check if the CPU is running, if not use the MSR to
> check if the CPU is in userspace but the CPU thread is scheduled).  But
> it's not necessary if you are just matching PPC semantics.
>
> Then the simplest thing is to use the kvm_steal_time struct, and add a
> new field to it that replaces pad[0].  You can write a 0 to the flag in
> record_steal_time (not preempted) and a 1 in kvm_arch_vcpu_put
> (preempted).  record_steal_time is called before the VM starts running,
> immediately after KVM_RUN and also after every sched_in.
>
> If KVM doesn't implement the flag, it won't touch that field at all.  So
> the kernel can write a 0, meaning "not preempted", and not care if the
> hypervisor implements the flag or not: the answer will always be safe.
>
> The pointer to the flag can be placed in a per-cpu u32*, and again if
> the u32* is NULL that means "not preempted".
>
really nice suggestion!  That's what I want :)

thanks
xinhui

> Paolo
>
>
>> I am still looking for one shared struct between kvm and guest kernel on
>> x86.
>> and every time kvm_guest_exit/enter called, we store some info in it. So
>> guest kernel can check one vcpu is running or not quickly.
>>
>> thanks
>> xinhui
>>
>>> Paolo
>>>
>>
>
