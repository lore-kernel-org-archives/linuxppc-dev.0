Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DCF152C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 22:26:05 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 21:26:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 468D12CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 22:25:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VB6Z0Z52101280
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 22:06:35 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VBPvsS004965
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 22:25:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 03/10] KVM: PPC: BOOK3S: PR: Emulate instruction
 counter
In-Reply-To: <52E92F08.6020803@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E92F08.6020803@suse.de>
Date: Fri, 31 Jan 2014 16:55:53 +0530
Message-ID: <87r47ojsu6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
>> Writing to IC is not allowed in the privileged mode.
>
> This is not a patch description.
>
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/kvm_host.h | 1 +
>>   arch/powerpc/kvm/book3s_emulate.c   | 3 +++
>>   arch/powerpc/kvm/book3s_pr.c        | 2 ++
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 9ebdd12e50a9..e0b13aca98e6 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -509,6 +509,7 @@ struct kvm_vcpu_arch {
>>   	/* Time base value when we entered the guest */
>>   	u64 entry_tb;
>>   	u64 entry_vtb;
>> +	u64 entry_ic;
>>   	u32 tcr;
>>   	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
>>   	u32 ivor[64];
>> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
>> index 4b58d8a90cb5..abe6f3057e5b 100644
>> --- a/arch/powerpc/kvm/book3s_emulate.c
>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>> @@ -531,6 +531,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>>   	case SPRN_VTB:
>>   		*spr_val = vcpu->arch.vtb;
>>   		break;
>> +	case SPRN_IC:
>> +		*spr_val = vcpu->arch.ic;
>> +		break;
>>   	case SPRN_GQR0:
>>   	case SPRN_GQR1:
>>   	case SPRN_GQR2:
>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>> index b5598e9cdd09..51d469f8c9fd 100644
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -121,6 +121,7 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
>>   	 */
>>   	vcpu->arch.entry_tb = get_tb();
>>   	vcpu->arch.entry_vtb = get_vtb();
>> +	vcpu->arch.entry_ic = mfspr(SPRN_IC);
>
> Is this implemented on all systems?
>
>>   
>>   }
>>   
>> @@ -174,6 +175,7 @@ out:
>>   	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
>>   	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
>>   	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;
>> +	vcpu->arch.ic += mfspr(SPRN_IC) - vcpu->arch.entry_ic;
>
> This is getting quite convoluted. How about we act slightly more fuzzy 
> and put all of this into vcpu_load/put?
>

I am not sure whether vcpu_load/put is too early/late to save these
context ?

-aneesh
