Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkpRx3lFlzDqyK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:58:37 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u664n6L8091234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 00:58:35 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nf1rqsg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 00:58:35 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 14:58:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1F3E03578060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:58:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u664wU7c5898594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:58:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u664wS2u005394
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:58:29 +1000
Date: Wed, 06 Jul 2016 12:58:11 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wanpeng Li <kernellwp@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>,
 benh@kernel.crashing.org, Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hpe.com>, will.deacon@arm.com,
 boqun.feng@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
 schwidefsky@de.ibm.com
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
In-Reply-To: <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577C8FE3.3010208@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, wanpeng

On 2016年07月05日 17:57, Wanpeng Li wrote:
> Hi Xinhui,
> 2016-06-28 22:43 GMT+08:00 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>:
>> This is to fix some lock holder preemption issues. Some other locks
>> implementation do a spin loop before acquiring the lock itself. Currently
>> kernel has an interface of bool vcpu_is_preempted(int cpu). It take the cpu
>> as parameter and return true if the cpu is preempted. Then kernel can break
>> the spin loops upon on the retval of vcpu_is_preempted.
>>
>> As kernel has used this interface, So lets support it.
>>
>> Only pSeries need supoort it. And the fact is powerNV are built into same
>> kernel image with pSeries. So we need return false if we are runnig as
>> powerNV. The another fact is that lppaca->yiled_count keeps zero on
>> powerNV. So we can just skip the machine type.
>
> Lock holder vCPU preemption can be detected by hardware pSeries or
> paravirt method?
>
There is one shard struct between kernel and powerVM/KVM. And we read the yield_count of this struct to detect if one vcpu is running or not.
SO it's easy for ppc to implement such interface. Note that yield_count is set by powerVM/KVM.
and only pSeries can run a guest for now. :)

I also review x86 related code, looks like we need add one hyer-call to get such vcpu preemption info?

thanks
xinui
> Regards,
> Wanpeng Li
>
