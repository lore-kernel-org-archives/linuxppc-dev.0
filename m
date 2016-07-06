Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkxYf5RZhzDr07
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 20:19:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66AIwGY146347
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 06:19:00 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nm9974q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 06:18:59 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 15:48:51 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D190DE0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:52:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66AInva29491254
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:48:49 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66AIhtL014458
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:48:49 +0530
Date: Wed, 06 Jul 2016 18:18:27 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, mpe@ellerman.id.au,
 Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hpe.com>, will.deacon@arm.com,
 boqun.feng@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
 schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 kvm <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
 <577C8FE3.3010208@linux.vnet.ibm.com>
 <CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
 <20160706075814.GF30921@twins.programming.kicks-ass.net>
 <CANRm+Cz5-XGDTNkZ_RcoX+gxF_+JDpUB6OB+ECOQcScuaeKfGA@mail.gmail.com>
In-Reply-To: <CANRm+Cz5-XGDTNkZ_RcoX+gxF_+JDpUB6OB+ECOQcScuaeKfGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577CDAF3.4030401@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年07月06日 16:32, Wanpeng Li wrote:
> 2016-07-06 15:58 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>> On Wed, Jul 06, 2016 at 02:46:34PM +0800, Wanpeng Li wrote:
>>>> SO it's easy for ppc to implement such interface. Note that yield_count is
>>>> set by powerVM/KVM.
>>>> and only pSeries can run a guest for now. :)
>>>>
>>>> I also review x86 related code, looks like we need add one hyer-call to get
>>>> such vcpu preemption info?
>>>
>>> There is no such stuff to record lock holder in x86 kvm, maybe we
>>> don't need to depend on PLE handler algorithm to guess it if we can
>>> know lock holder vCPU directly.
>>
>> x86/kvm has vcpu->preempted to indicate if a vcpu is currently preempted
>> or not. I'm just not sure if that is visible to the guest or how to make
>> it so.
>
> Yeah, I miss it. I can be the volunteer to do it if there is any idea,
> ping Paolo. :)
>
glad to know that. :)


> Regards,
> Wanpeng Li
>
