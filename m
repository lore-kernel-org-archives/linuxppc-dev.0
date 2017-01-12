Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzhTH5JNPzDqGK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:14:59 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tzhTG6zg8z9t0H
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2017 21:14:58 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0CAErAO055964
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2017 05:14:56 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27x5h6dgnv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2017 05:14:56 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 12 Jan 2017 03:14:22 -0700
Subject: Re: [PATCH v4 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
To: Balbir Singh <bsingharora@gmail.com>
References: <148396203530.1471.16105350692124392705.stgit@aravinda>
 <148396204569.1471.7515038338417988537.stgit@aravinda>
 <20170112090553.GA3006@localhost.localdomain>
Cc: kvm@vger.kernel.org, gleb@kernel.org, mahesh@linux.vnet.ibm.com,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 15:44:12 +0530
MIME-Version: 1.0
In-Reply-To: <20170112090553.GA3006@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Message-Id: <60f78e5e-7b4b-35ae-a2ed-8c1990411cf3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 12 January 2017 02:35 PM, Balbir Singh wrote:
> On Mon, Jan 09, 2017 at 05:10:45PM +0530, Aravinda Prasad wrote:

[ . . .]


>> The reasons for this approach is (i) it is not possible
>> to distinguish whether the exception occurred in the
>> guest or the host from the pt_regs passed on the
>> machine_check_exception(). Hence machine_check_exception()
>> calls panic, instead of passing on the exception to
>> the guest, if the machine check exception is not
>> recoverable. (ii) the approach introduced in this
>> patch gives opportunity to the host kernel to perform
>> actions in virtual mode before passing on the exception
>> to the guest. This approach does not require complex
>> tweaks to machine_check_fwnmi and friends.
> 
> It would be good to qualify the different types of MCE
> and what action we expect across hypervisor and guest.

The hypervisor performs actions depending on the type of MCE (SLB
multihit, UEs, etc). If the hypervisor is unable to recover from the MCE
and if the address in error belongs to the guest, then this patch set
forwards the error to the guest kernel for handling.

The main goal of this patch set is to pass on the unrecoverable MCE
errors in the guest address space to the guest kernel, instead of
crashing the hypervisor. The action taken by the hypervisor and the
guest kernel upon MCE remains unchanged.

[ . . . ]

> 
> Shouldn't the host take action for example poison bad pages?
> 

We want to give the guest kernel a chance to recover the clean part of
the page before poisoning. As in case of an UE only few bytes of a page
are affected. Hence we don't immediately poison the bad pages in the host.

It is expected that the guest kernel performs the poisoning of the bad
pages after performing recovery action. This prevents the guest from
reusing the bad page.

However, the missing part is to communicate back to the host when guest
is done with the recovery. This is mainly to prevent reuse of bad pages
by the host when the guest shutdowns/reboots/crashes/migrates.

We are planning to address this part as a separate patch set.

Regards,
Aravinda

>>  	if (opal_recover_mce(regs, &evt))
>>  		return 1;
>>  
>>
> 
> Balbir Singh 
> 

-- 
Regards,
Aravinda
