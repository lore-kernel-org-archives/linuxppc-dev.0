Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CC141A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 22:04:26 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 7 May 2015 13:04:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C0D692190061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:04:01 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t47C4J0C24838238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 12:04:19 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t47C4JPK013440
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 06:04:19 -0600
Message-ID: <554B54C2.70903@de.ibm.com>
Date: Thu, 07 May 2015 14:04:18 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] kvm/powerpc: report guest steal time in host
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
 <c0db7eafdd13fcec26a0398e2ad0b7225c3998e9.1430913088.git.naveen.n.rao@linux.vnet.ibm.com>
 <554A0D0D.8090209@de.ibm.com> <20150506164215.GB26540@naverao1-tp.in.ibm.com>
In-Reply-To: <20150506164215.GB26540@naverao1-tp.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de,
 mingo@redhat.com, paulus@samba.org, warrier@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 06.05.2015 um 18:42 schrieb Naveen N. Rao:
> On 2015/05/06 02:46PM, Christian Borntraeger wrote:
>> Am 06.05.2015 um 13:56 schrieb Naveen N. Rao:
>>> On powerpc, kvm tracks both the guest steal time as well as the time
>>> when guest was idle and this gets sent in to the guest through DTL. The
>>> guest accounts these entries as either steal time or idle time based on
>>> the last running task. Since the true guest idle status is not visible
>>> to the host, we can't accurately expose the guest steal time in the
>>> host.
>>>
>>> However, tracking the guest vcpu cede status can get us a reasonable
>>> (within 5% variation) vcpu steal time since guest vcpus cede the
>>> processor on entering the idle task. To do this, we introduce a new
>>> field ceded_st in kvm_vcpu_arch structure to accurately track the guest
>>> vcpu cede status (this is needed since the existing ceded field is
>>> modified before we can use it). During DTL entry creation, we check this
>>> flag and account the time as stolen if the guest vcpu had not ceded.
>>
>> I think this is more or less a question about the semantic:
>>
>> What would happen if you use  current->sched_info.run_delay like x86 also
>> on power? How far are the numbers away?
> 
> The numbers were quite off and didn't quite make sense.

Strange. I would expect to match at least the wall clock time between
runnable and running. Maybe its just a bug?


> 
>> My feeling is, that the semantics
>> of "steal time" inside the guest is somewhat different on each platform. 
>>
>> This brings me to a 2nd question:
>> Do you need to match the host view of guest steal time with the guest view
>> or do we want to have a host view that translates as "this is the time that
>> the guest was runnable but we were too busy to schedule him"?
> 
> Very good point. This is probably good enough for our purpose and I'd 
> like to think my current patchset does something similar for powerpc. We 
> don't report the exact steal time as seen from within the guest, but a 
> close approximation of it. We count all time that a vcpu was not-idle as 
> steal. This includes time we were doing something in the host on behalf 
> of the vcpu as well as time when we were just doing something else. I 
> don't know if we can separate these two or if that would be desirable.  
> The scheduler statistics don't seem to accurately reflect this on ppc.
> 
>> For the former x86 has the best solution, as the host tells the guest its
>> understanding of steal - so both match. For the latter we actually try to
>> give guest steal a meaning in the host context  - the overload.
>> Would /proc/<pid>/schedstat value 2 (time spent waiting on a runqueue)
>> meet your requirements from the cover-letter?
> 
> This looks to be the same as sched_info.run_delay, which doesn't seem to 
> reflect the wait on the runqueue. I will recheck this on ppc tomorrow.
> 
> As an aside, do you happen to know if /proc/<pid>/schedstat accurately 
> reports the "overload" on s390?

Things are usually even more complicated as we always have the LPAR hypervisor
below the KVM or z/VM hypervisor (KVM or z/VM guests are always nested so to
speak). Depending on the overcommit on LPAR level the wall clock times might 
indicate a problem in a "wrong" place. 

Now the steal time in a kvm guest is actually precise as the hardware will
step the guest cpu timer only when both LPAR and KVM have this CPU scheduled.
This will also cause "steal" when KVM emulates an instruction for the guest - 
unless we correct the guest view - which we dont right now.
The Linux in LPAR also sees the steal time it got stolen by LPAR.

I really have not looked closely at run_delay. My assumption is that
it boils down to "wall clock time between runnable and running". If the
admin does overcommit in KVM and LPAR is just slightly  overcommitted this
is probably good enough. If the overcommit happens at LPAR then the value
might be confusing. I would assume that people overcommit at the z/VM or KVM
level and the LPAR is managed with less overcommit - but thats not a given.

Christian
