Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slp3h2ZfBzDvbw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 20:44:48 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8UAhB6p042749
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 06:44:46 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25shm92r8n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 06:44:46 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 30 Sep 2016 11:44:44 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 49E0E17D8024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 11:46:44 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8UAif7f5046758
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 10:44:41 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8UAieSk003333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 04:44:41 -0600
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Paolo Bonzini <pbonzini@redhat.com>, Pan Xinhui <xinhui@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
 <20160929103133.GW5016@twins.programming.kicks-ass.net>
 <496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
 <2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 will deacon <will.deacon@arm.com>, kernellwp@gmail.com,
 jgross@suse.com, bsingharora@gmail.com,
 Heiko Carstens <heiko.carstens@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 30 Sep 2016 12:44:39 +0200
MIME-Version: 1.0
In-Reply-To: <2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <aa24b1ac-8ab6-1aa6-f864-e52b34f042d3@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2016 08:58 AM, Paolo Bonzini wrote:
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
> particular, there are at least the following choices:

I think the semantics can be slightly different for different architectures
after all it is still a heuristics to improve performance.
> 
> 1) exit to userspace (5-10.000 clock cycles best case) counts as
> lock holder preemption
> 
> 2) any time the vCPU thread not running counts as lock holder
> preemption
> 
> To implement the latter you'd need a hypercall or MSR (at least as
> a slow path), because the KVM preempt notifier is only active
> during the KVM_RUN ioctl.

FWIW, The s390 implementation uses kvm_arch_vcpu_put/load as trigger
points for (un)setting the CPUSTAT_RUNNING. Strictly speaking an exit to
userspace is not preempted, But as KVM has no control if we are being
scheduled out when in QEMU this is the compromise that seems to work quite
well for the s390 spinlock code (which checks the running state before 
doing a yield hypercall). 
In addition an exit to QEMU is really a rare case.
