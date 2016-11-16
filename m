Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJhr14zj9zDvt9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:29:53 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGBSZUT144424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:29:51 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rdbpc1xv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:29:51 -0500
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 16 Nov 2016 11:29:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A49A72190056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:29:00 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAGBTlp139518398
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:29:47 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAGBTk0w006607
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:29:47 -0500
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
 vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>,
 Pan Xinhui <xinhui@linux.vnet.ibm.com>
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
 bsingharora@gmail.com, boqun.feng@gmail.com, rkrcmar@redhat.com,
 David.Laight@ACULAB.COM, dave@stgolabs.net, konrad.wilk@oracle.com
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 16 Nov 2016 12:29:44 +0100
MIME-Version: 1.0
In-Reply-To: <20161116102355.GP3142@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f8b9d1be-98a2-4d99-1ae1-c31c6fe13903@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2016 11:23 AM, Peter Zijlstra wrote:
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

Out of curiosity, why is that hard to predict?
On s390 the branch prediction runs asynchronously ahead of the downstream
pipeline (e.g. search for "IBM z Systems Processor Optimization Primer" page 11).
given enough capacity, I would assume that modern x86 processors would do the same
and be able to predict this is as soon as it becomes hot (and otherwise you would
 not notice the branch miss anyway). Is x86 behaving differently here?

> Also, it generates more code.
> 
> Paravirt muck should strive to be as cheap as possible when ran on
> native hardware.

As I am interested in this series from the s390 point of view, this is 
the only thing that block this series?

Is there a chance to add a static key around the paravirt ops somehow?
