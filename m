Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D11291A0041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 01:55:46 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 01:55:45 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C452B2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 01:55:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55FtROq524550
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 01:55:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55FtgUB015183
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 01:55:42 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 2/4] KVM: PPC: BOOK3S: PR: Doorbell support
In-Reply-To: <53906156.4090403@suse.de>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <539060B5.9040808@suse.de> <53906156.4090403@suse.de>
Date: Thu, 05 Jun 2014 21:25:39 +0530
Message-ID: <87tx7zmjus.fsf@linux.vnet.ibm.com>
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

> On 05.06.14 14:21, Alexander Graf wrote:
>>
>> On 05.06.14 14:08, Aneesh Kumar K.V wrote:
>>> We don't have SMT support yet, hence we should not find a doorbell
>>> message generated
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/kvm/book3s_emulate.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c 
>>> b/arch/powerpc/kvm/book3s_emulate.c
>>> index 1bb16a59dcbc..d6c87d085182 100644
>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>> @@ -28,7 +28,9 @@
>>>   #define OP_19_XOP_RFI        50
>>>     #define OP_31_XOP_MFMSR        83
>>> +#define OP_31_XOP_MSGSNDP    142
>>>   #define OP_31_XOP_MTMSR        146
>>> +#define OP_31_XOP_MSGCLRP    174
>>>   #define OP_31_XOP_MTMSRD    178
>>>   #define OP_31_XOP_MTSR        210
>>>   #define OP_31_XOP_MTSRIN    242
>>> @@ -303,6 +305,22 @@ int kvmppc_core_emulate_op_pr(struct kvm_run 
>>> *run, struct kvm_vcpu *vcpu,
>>>                 break;
>>>           }
>>> +        case OP_31_XOP_MSGSNDP:
>>> +        {
>>> +            /*
>>> +             * PR KVM still don't support SMT mode. So we should
>>
>> still?
>>
>>> +             * not see a MSGSNDP/MSGCLRP used with PR KVM
>>> +             */
>>> +            pr_info("KVM: MSGSNDP used in non SMT case\n");
>>> +            emulated = EMULATE_FAIL;
>>
>> What would happen on an HV guest with only 1 thread that MSGSNDs to 
>> thread 0? Would the guest get an illegal instruction trap, a 
>> self-interrupt or would this be a simple nop?
>
> What I'm trying to say here is that it's ok to treat it as illegal 
> instructions, but then we don't need this patch :).
>

Agreed. I will verify whether it is treated as a nop. If so will send an
updated patch.

-aneesh
