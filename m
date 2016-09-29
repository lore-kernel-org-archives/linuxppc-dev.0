Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl9dc4v9xzDsqK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 20:23:32 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8TANRX0006083
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 06:23:30 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25rugac2y2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 06:23:30 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 29 Sep 2016 11:23:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C07171B08074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 11:25:16 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8TANLpe11338144
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 10:23:21 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8TANKNk028051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 04:23:21 -0600
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com,
 bsingharora@gmail.com, linux-s390 <linux-s390@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Sep 2016 12:23:19 +0200
MIME-Version: 1.0
In-Reply-To: <20160929101040.GV5016@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/29/2016 12:10 PM, Peter Zijlstra wrote:
> On Thu, Jul 21, 2016 at 07:45:10AM -0400, Pan Xinhui wrote:
>> change from v2:
>> 	no code change, fix typos, update some comments
>>
>> change from v1:
>> 	a simplier definition of default vcpu_is_preempted
>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
>> 	add more comments
>> 	thanks boqun and Peter's suggestion.
>>
>> This patch set aims to fix lock holder preemption issues.
> 
> So I really like the concept, but I would also really like to see
> support for more hypervisors included before we can move forward with
> this.
> 
> Please consider s390 and (x86/arm) KVM. Once we have a few, more can
> follow later, but I think its important to not only have PPC support for
> this.

Actually the s390 preemted check via sigp sense running  is available for
all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can no
longer buy s390 systems without LPAR.

As Heiko already pointed out we could simply use a small inline function
that calls cpu_is_preempted from arch/s390/lib/spinlock (or smp_vcpu_scheduled from smp.c)

Christian
