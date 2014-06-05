Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D54501A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 03:33:23 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 23:03:19 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2D453E0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 23:04:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55HY2JN58195986
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 23:04:02 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55HXGdd000570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 23:03:16 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
In-Reply-To: <5390A071.9040006@suse.de>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5390604C.4050704@suse.de> <87wqcvmk3f.fsf@linux.vnet.ibm.com>
 <5390A071.9040006@suse.de>
Date: Thu, 05 Jun 2014 23:03:15 +0530
Message-ID: <87sinjqn1g.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 05.06.14 17:50, Aneesh Kumar K.V wrote:
>> Alexander Graf <agraf@suse.de> writes:
>>
>>> On 05.06.14 14:08, Aneesh Kumar K.V wrote:
>>>> virtual time base register is a per VM, per cpu register that needs
>>>> to be saved and restored on vm exit and entry. Writing to VTB is not
>>>> allowed in the privileged mode.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

.......

>>>>    			break;
>>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
>>>> index 3565e775b61b..1bb16a59dcbc 100644
>>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>>> @@ -577,6 +577,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>>>>    		 */
>>>>    		*spr_val = vcpu->arch.spurr;
>>>>    		break;
>>>> +	case SPRN_VTB:
>>>> +		*spr_val = vcpu->arch.vtb;
>>> Doesn't this mean that vtb can be the same 2 when the guest reads it 2
>>> times in a row without getting preempted?
>>
>> But a mfspr will result in VM exit and that would make sure we
>> update vcpu->arch.vtb with the correct value.
>
> We only call kvmppc_core_vcpu_put_pr() when we context switch away from 
> KVM, so it won't be updated, no?
>
>

kvmppc_copy_from_svcpu is also called from VM exit path (book3s_interrupt.S)

-aneesh
