Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 790F31A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 17:46:23 +1000 (EST)
Message-ID: <53B65BCA.6040200@suse.de>
Date: Fri, 04 Jul 2014 09:46:18 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Subject: Re: [PATCH 3/6 v2] KVM: PPC: Book3E: Increase FPU laziness
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-4-git-send-email-mihai.caraman@freescale.com>
 <53B54C8A.1060209@suse.de>
 <bf24ca20f84f449a8781107acaec33d1@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <bf24ca20f84f449a8781107acaec33d1@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.14 17:46, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, July 03, 2014 3:29 PM
>> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
>> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH 3/6 v2] KVM: PPC: Book3E: Increase FPU laziness
>>
>>
>> On 30.06.14 17:34, Mihai Caraman wrote:
>>> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
>>> returning to guest instead of each sched in. Without this improvement
>>> an interrupt may also claim floting point corrupting guest state.
>> How do you handle context switching with this patch applied? During most
>> of the guest's lifetime we never exit kvmppc_vcpu_run(), so when the
>> guest gets switched out all FPU state gets lost?
> No, we had this discussion in ver 1. The FP/VMX/VSX is implemented lazy in
> the kernel i.e. the unit state is not saved/restored until another thread
> that once claimed the unit is sched in.
>
> Since FP/VMX/VSX can be activated by the guest independent of the host, the
> vcpu thread is always using the unit (even if it did not claimed it once).
>
> Now, this patch optimize the sched in flow. Instead of checking on each vcpu
> sched in if the kernel unloaded unit's guest state for another competing host
> process we do this when we enter the guest.

But we only do it when we enter the guest from QEMU, not when we enter 
the guest after a context switch on cond_resched(), no?


Alex
