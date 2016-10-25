Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2wT36B6mzDvgn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 12:25:43 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9P1NRBa016920
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 21:25:41 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269vdm2mpe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 21:25:41 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 11:25:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 371992BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 12:25:34 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9P1PYQP19005498
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 12:25:34 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9P1PWLo014323
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 12:25:34 +1100
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161019172403.GA9240@potion>
 <c00e636e-ea06-6bbb-6a67-39804ee8ba75@redhat.com>
 <20161024151417.GC2247@potion>
 <1a556fcf-e071-8c32-7a4b-ca7a2ffc17e9@redhat.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2016 09:25:37 +0800
MIME-Version: 1.0
In-Reply-To: <1a556fcf-e071-8c32-7a4b-ca7a2ffc17e9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2f37742f-6839-1ef4-0838-05fb7222f14a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/10/24 23:18, Paolo Bonzini 写道:
>
>
> On 24/10/2016 17:14, Radim Krčmář wrote:
>> 2016-10-24 16:39+0200, Paolo Bonzini:
>>> On 19/10/2016 19:24, Radim Krčmář wrote:
>>>>>> +	if (vcpu->arch.st.msr_val & KVM_MSR_ENABLED)
>>>>>> +		if (kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
>>>>>> +					&vcpu->arch.st.steal,
>>>>>> +					sizeof(struct kvm_steal_time)) == 0) {
>>>>>> +			vcpu->arch.st.steal.preempted = 1;
>>>>>> +			kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
>>>>>> +					&vcpu->arch.st.steal,
>>>>>> +					sizeof(struct kvm_steal_time));
>>>>>> +		}
>>>> Please name this block of code.  Something like
>>>>   kvm_steal_time_set_preempted(vcpu);
>>>
>>> While at it:
>>>
>>> 1) the kvm_read_guest_cached is not necessary.  You can rig the call to
>>> kvm_write_guest_cached so that it only writes vcpu->arch.st.steal.preempted.
>>
>> I agree.  kvm_write_guest_cached() always writes from offset 0, so we'd
>> want a new function that allows to specify a starting offset.
>
> Yeah, let's leave it for a follow-up then!
>
I think I can make a having-offset version. :)

> Thanks,
>
> Paolo
>
>> Using cached vcpu->arch.st.steal to avoid the read wouldn't be as good.
>>
>
