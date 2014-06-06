Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F4491A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 19:29:01 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 14:58:54 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A31FE1258053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 14:58:09 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s569T3j356688740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 14:59:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s569Sokj026632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 14:58:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 2/4] KVM: PPC: BOOK3S: PR: Doorbell support
In-Reply-To: <539060B5.9040808@suse.de>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <539060B5.9040808@suse.de>
Date: Fri, 06 Jun 2014 14:58:49 +0530
Message-ID: <87tx7ye69a.fsf@linux.vnet.ibm.com>
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

> On 05.06.14 14:08, Aneesh Kumar K.V wrote:
>> We don't have SMT support yet, hence we should not find a doorbell
>> message generated
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kvm/book3s_emulate.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
>> index 1bb16a59dcbc..d6c87d085182 100644
>> --- a/arch/powerpc/kvm/book3s_emulate.c
>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>> @@ -28,7 +28,9 @@
>>   #define OP_19_XOP_RFI		50
>>   
>>   #define OP_31_XOP_MFMSR		83
>> +#define OP_31_XOP_MSGSNDP	142
>>   #define OP_31_XOP_MTMSR		146
>> +#define OP_31_XOP_MSGCLRP	174
>>   #define OP_31_XOP_MTMSRD	178
>>   #define OP_31_XOP_MTSR		210
>>   #define OP_31_XOP_MTSRIN	242
>> @@ -303,6 +305,22 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>   
>>   			break;
>>   		}
>> +		case OP_31_XOP_MSGSNDP:
>> +		{
>> +			/*
>> +			 * PR KVM still don't support SMT mode. So we should
>
> still?
>
>> +			 * not see a MSGSNDP/MSGCLRP used with PR KVM
>> +			 */
>> +			pr_info("KVM: MSGSNDP used in non SMT case\n");
>> +			emulated = EMULATE_FAIL;
>
> What would happen on an HV guest with only 1 thread that MSGSNDs to 
> thread 0? Would the guest get an illegal instruction trap, a 
> self-interrupt or would this be a simple nop?
>

We do get a self-interrupt. I tried the below

tag = mfspr(SPRN_TIR) & 0x7f;
ppc_msgsnd(5, 0, tag);

And that results in doorbell exception. That implies we will have to
have full implementation of doorbell. You can drop patch 2 and 3 from
this series. I will rework them.

NOTE: This is not an issue for Linux guest, because we don't send ipi
to self. But to complete the emulation of msgsndp we will need to
emulate it properly.

-aneesh
