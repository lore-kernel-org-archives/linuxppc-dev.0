Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sllb01SnwzDvLq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 18:53:15 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8U8qqlS129581
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 04:53:13 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25shh3y9hk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 04:53:13 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 30 Sep 2016 02:53:11 -0600
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
 <20160929103133.GW5016@twins.programming.kicks-ass.net>
 <496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
 <2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
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
Date: Fri, 30 Sep 2016 16:52:57 +0800
MIME-Version: 1.0
In-Reply-To: <2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <caabadb6-fe62-aaf7-260f-79f230d03a1c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


hi, Paolo
	thanks for your reply.

在 2016/9/30 14:58, Paolo Bonzini 写道:
>>>>> Please consider s390 and (x86/arm) KVM. Once we have a few, more can
>>>>> follow later, but I think its important to not only have PPC support for
>>>>> this.
>>>>
>>>> Actually the s390 preemted check via sigp sense running  is available for
>>>> all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can
>>>> no longer buy s390 systems without LPAR.
>>>>
>>>> As Heiko already pointed out we could simply use a small inline function
>>>> that calls cpu_is_preempted from arch/s390/lib/spinlock (or
>>>> smp_vcpu_scheduled from smp.c)
>>>
>>> Sure, and I had vague memories of Heiko's email. This patch set however
>>> completely fails to do that trivial hooking up.
>>
>> sorry for that.
>> I will try to work it out on x86.
>
> x86 has no hypervisor support, and I'd like to understand the desired
> semantics first, so I don't think it should block this series.  In

Once a guest do a hypercall or something similar, IOW, there is a kvm_guest_exit. we think this is a lock holder preemption.
Adn PPC implement it in this way.

> particular, there are at least the following choices:
>
> 1) exit to userspace (5-10.000 clock cycles best case) counts as
> lock holder preemption
>
just to avoid any misunderstanding.
You are saying that the guest does an IO operation for example and then exit to QEMU right?
Yes, in this scenario it's hard to guarntee that such IO operation or someghing like that could be finished in time.

  
> 2) any time the vCPU thread not running counts as lock holder
> preemption
>
> To implement the latter you'd need a hypercall or MSR (at least as
> a slow path), because the KVM preempt notifier is only active
> during the KVM_RUN ioctl.
>
seems a little expensive. :(
How many clock cycles it might cost.

I am still looking for one shared struct between kvm and guest kernel on x86.
and every time kvm_guest_exit/enter called, we store some info in it. So guest kernel can check one vcpu is running or not quickly.

thanks
xinhui

> Paolo
>
