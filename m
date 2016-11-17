Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tK8W168PFzDvrR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 16:16:45 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAH5E4OK086227
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 00:16:43 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26s39gpe8p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 00:16:42 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 15:16:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A8A592CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 16:16:37 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAH5GbwF3670490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 16:16:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAH5GZ0C029301
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 16:16:37 +1100
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
 vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161115154706.GF11311@worktop.programming.kicks-ass.net>
 <a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
 <20161116102355.GP3142@twins.programming.kicks-ass.net>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com,
 bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com,
 rkrcmar@redhat.com, David.Laight@ACULAB.COM, dave@stgolabs.net,
 konrad.wilk@oracle.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Thu, 17 Nov 2016 13:16:30 +0800
MIME-Version: 1.0
In-Reply-To: <20161116102355.GP3142@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <cc581449-81e4-1299-2221-0b1733648fb5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/11/16 18:23, Peter Zijlstra 写道:
> On Wed, Nov 16, 2016 at 12:19:09PM +0800, Pan Xinhui wrote:
>> Hi, Peter.
>> 	I think we can avoid a function call in a simpler way. How about below
>>
>> static inline bool vcpu_is_preempted(int cpu)
>> {
>> 	/* only set in pv case*/
>> 	if (pv_lock_ops.vcpu_is_preempted)
>> 		return pv_lock_ops.vcpu_is_preempted(cpu);
>> 	return false;
>> }
>
> That is still more expensive. It needs to do an actual load and makes it
> hard to predict the branch, you'd have to actually wait for the load to
> complete etc.
>
yes, one more load in native case. I think this is acceptable as vcpu_is_preempted is not a critical function.

however if we use pv_callee_save_regs_thunk, more unnecessary registers might be save/resotred in pv case.
that will introduce a little overhead.

but I think I am okay with your idea. I can make another patch based on this patchset with your suggested-by.

thanks
xinhui

> Also, it generates more code.
>
> Paravirt muck should strive to be as cheap as possible when ran on
> native hardware.
>
