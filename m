Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0T2P0VT9zDt62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:42:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L1ciTx052078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 21:42:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yff7ay-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 21:42:34 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 11:42:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1092E2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:42:30 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L1gTaT20906058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:42:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L1gSU9007271
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:42:29 +1100
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
 preempted check
To: Boqun Feng <boqun.feng@gmail.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161021012348.GC8429@tardis.cn.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, borntraeger@de.ibm.com,
 rkrcmar@redhat.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Fri, 21 Oct 2016 09:42:22 +0800
MIME-Version: 1.0
In-Reply-To: <20161021012348.GC8429@tardis.cn.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <26e3f487-10e5-3a45-0b8d-e4554d716ae8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/10/21 09:23, Boqun Feng 写道:
> On Thu, Oct 20, 2016 at 05:27:54PM -0400, Pan Xinhui wrote:
>> Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
>> preempted" into struct kvm_steal_time. This field tells if one vcpu is
>> running or not.
>>
>> It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
>> preempted. Other values means the vcpu has been preempted.
>   ^^^^^^^^^
> s/preempted/not preempted
>
yes. the less of *not* definitely sould be avoided..
> And better to fix other typos in the commit log ;-)
> Maybe you can try aspell? That works for me.
>
I will try it. :)

> Regards,
> Boqun
>
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>  Documentation/virtual/kvm/msr.txt | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kvm/msr.txt
>> index 2a71c8f..3376f13 100644
>> --- a/Documentation/virtual/kvm/msr.txt
>> +++ b/Documentation/virtual/kvm/msr.txt
>> @@ -208,7 +208,8 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>>  		__u64 steal;
>>  		__u32 version;
>>  		__u32 flags;
>> -		__u32 pad[12];
>> +		__u8  preempted;
>> +		__u32 pad[11];
>>  	}
>>
>>  	whose data will be filled in by the hypervisor periodically. Only one
>> @@ -232,6 +233,11 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>>  		nanoseconds. Time during which the vcpu is idle, will not be
>>  		reported as steal time.
>>
>> +		preempted: indicate the VCPU who owns this struct is running or
>> +		not. Non-zero values mean the VCPU has been preempted. Zero
>> +		means the VCPU is not preempted. NOTE, it is always zero if the
>> +		the hypervisor doesn't support this field.
>> +
>>  MSR_KVM_EOI_EN: 0x4b564d04
>>  	data: Bit 0 is 1 when PV end of interrupt is enabled on the vcpu; 0
>>  	when disabled.  Bit 1 is reserved and must be zero.  When PV end of
>> --
>> 2.4.11
>>
