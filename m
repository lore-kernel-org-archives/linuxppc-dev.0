Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6Kry6q0rzDvS8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 01:39:46 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9UEchk1067850
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 10:39:45 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26cqxdfund-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 10:39:44 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Mon, 31 Oct 2016 00:39:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 677C12BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 01:39:39 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9UEdddD13893886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 01:39:39 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9UEdbna006361
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 01:39:39 +1100
Subject: Re: [PATCH v6 02/11] locking/osq: Drop the overload of osq_lock()
To: Davidlohr Bueso <dave@stgolabs.net>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161029165216.GA17451@linux-80c1.suse>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Sun, 30 Oct 2016 22:39:29 +0800
MIME-Version: 1.0
In-Reply-To: <20161029165216.GA17451@linux-80c1.suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <3b93d48e-a106-01ec-3367-b244bd659d2f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/10/30 00:52, Davidlohr Bueso 写道:
> On Fri, 28 Oct 2016, Pan Xinhui wrote:
>>         /*
>>          * If we need to reschedule bail... so we can block.
>> +         * Use vcpu_is_preempted to detech lock holder preemption issue
>                                            ^^ detect
ok. thanks for poingting it out.
>> +         * and break.
>
> Could you please remove the rest of this comment? Its just noise to point out
> that vcpu_is_preempted is a macro defined by arch/false. This is standard protocol
> in the kernel.
>
fair enough.

> Same goes for all locks you change with this.
>
> Thanks,
> Davidlohr
>
>>                * vcpu_is_preempted is a macro defined by false if
>> +         * arch does not support vcpu preempted check,
>>          */
>> -        if (need_resched())
>> +        if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
>>             goto unqueue;
>>
>>         cpu_relax_lowlatency();
>> --
>> 2.4.11
>>
>
