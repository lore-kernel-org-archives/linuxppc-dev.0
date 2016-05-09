Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3FY45Zr1zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 18:14:48 +1000 (AEST)
Subject: Re: [PATCH] kvm-pr: manage illegal instructions
To: Laurent Vivier <lvivier@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>
References: <1458073117-24652-1-git-send-email-lvivier@redhat.com>
 <57189C75.2060701@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <573046F1.7070704@redhat.com>
Date: Mon, 9 May 2016 10:14:41 +0200
MIME-Version: 1.0
In-Reply-To: <57189C75.2060701@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.04.2016 11:25, Thomas Huth wrote:
> On 15.03.2016 21:18, Laurent Vivier wrote:
>> While writing some instruction tests for kvm-unit-tests for powerpc,
>> I've found that illegal instructions are not managed correctly with kvm-pr,
>> while it is fine with kvm-hv.
>>
>> When an illegal instruction (like ".long 0") is processed by kvm-pr,
>> the kernel logs are filled with:
>>
>>      Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>>      kvmppc_handle_exit_pr: emulation at 700 failed (00000000)
>>
>> While the exception handler receives an interrupt for each instruction
>> executed after the illegal instruction.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  arch/powerpc/kvm/book3s_emulate.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
>> index 2afdb9c..4ee969d 100644
>> --- a/arch/powerpc/kvm/book3s_emulate.c
>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>> @@ -99,7 +99,6 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  
>>  	switch (get_op(inst)) {
>>  	case 0:
>> -		emulated = EMULATE_FAIL;
>>  		if ((kvmppc_get_msr(vcpu) & MSR_LE) &&
>>  		    (inst == swab32(inst_sc))) {
>>  			/*
>> @@ -112,6 +111,9 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  			kvmppc_set_gpr(vcpu, 3, EV_UNIMPLEMENTED);
>>  			kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
>>  			emulated = EMULATE_DONE;
>> +		} else {
>> +			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> +			emulated = EMULATE_AGAIN;
>>  		}
>>  		break;
>>  	case 19:
>>
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

Ping!

Alex, Paul, could you please pick up this patch? This patch is required
to get the kvm-unit-tests working properly with kvm-pr, so I'd be glad
if we could get this included finally...

Thanks,
 Thomas
