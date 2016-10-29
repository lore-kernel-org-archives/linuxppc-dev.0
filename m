Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5SJF4FYwzDvT7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 15:26:53 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9T4Njx3120710
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 00:26:51 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26ccnu2teb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 00:26:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Sat, 29 Oct 2016 14:26:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E83DA357805A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 15:26:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9T4QhEL6685166
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 15:26:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9T4Qga7018105
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 15:26:43 +1100
Subject: Re: [Xen-devel] [PATCH v6 10/11] x86, xen: support vcpu preempted
 check
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1477642287-24104-11-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161028194325.GE2879@char.us.oracle.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org, kernellwp@gmail.com,
 jgross@suse.com, David.Laight@ACULAB.COM, rkrcmar@redhat.com,
 peterz@infradead.org, benh@kernel.crashing.org, bsingharora@gmail.com,
 will.deacon@arm.com, borntraeger@de.ibm.com, mingo@redhat.com,
 paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com,
 paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Sat, 29 Oct 2016 12:26:30 +0800
MIME-Version: 1.0
In-Reply-To: <20161028194325.GE2879@char.us.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <4afb98a9-9fb0-28e2-8d42-8bd6e3edeb9c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/10/29 03:43, Konrad Rzeszutek Wilk 写道:
> On Fri, Oct 28, 2016 at 04:11:26AM -0400, Pan Xinhui wrote:
>> From: Juergen Gross <jgross@suse.com>
>>
>> Support the vcpu_is_preempted() functionality under Xen. This will
>> enhance lock performance on overcommitted hosts (more runnable vcpus
>> than physical cpus in the system) as doing busy waits for preempted
>> vcpus will hurt system performance far worse than early yielding.
>>
>> A quick test (4 vcpus on 1 physical cpu doing a parallel build job
>> with "make -j 8") reduced system time by about 5% with this patch.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>  arch/x86/xen/spinlock.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
>> index 3d6e006..74756bb 100644
>> --- a/arch/x86/xen/spinlock.c
>> +++ b/arch/x86/xen/spinlock.c
>> @@ -114,7 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
>>  	per_cpu(irq_name, cpu) = NULL;
>>  }
>>
>> -
>
> Spurious change.
well, just remove one unnecessary blank line while at it.

>>  /*
>>   * Our init of PV spinlocks is split in two init functions due to us
>>   * using paravirt patching and jump labels patching and having to do
>> @@ -137,6 +136,8 @@ void __init xen_init_spinlocks(void)
>>  	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
>>  	pv_lock_ops.wait = xen_qlock_wait;
>>  	pv_lock_ops.kick = xen_qlock_kick;
>> +
>> +	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
>>  }
>>
>>  /*
>> --
>> 2.4.11
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xen.org
>> https://lists.xen.org/xen-devel
>
