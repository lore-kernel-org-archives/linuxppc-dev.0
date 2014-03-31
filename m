Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CB841400AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 00:32:36 +1100 (EST)
Message-ID: <53396E70.7050402@suse.de>
Date: Mon, 31 Mar 2014 15:32:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
References: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
 <1392913821-4520-3-git-send-email-mihai.caraman@freescale.com>
 <1395867121.12738.56.camel@snotra.buserror.net>
In-Reply-To: <1395867121.12738.56.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2014 09:52 PM, Scott Wood wrote:
> On Thu, 2014-02-20 at 18:30 +0200, Mihai Caraman wrote:
>> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
>> index a59a25a..80c533e 100644
>> --- a/arch/powerpc/kvm/book3s_paired_singles.c
>> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
>> @@ -640,19 +640,24 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
>>   
>>   int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
>>   {
>> -	u32 inst = kvmppc_get_last_inst(vcpu);
>> +	u32 inst;
>>   	enum emulation_result emulated = EMULATE_DONE;
>> -
>> -	int ax_rd = inst_get_field(inst, 6, 10);
>> -	int ax_ra = inst_get_field(inst, 11, 15);
>> -	int ax_rb = inst_get_field(inst, 16, 20);
>> -	int ax_rc = inst_get_field(inst, 21, 25);
>> -	short full_d = inst_get_field(inst, 16, 31);
>> -
>> -	u64 *fpr_d = &vcpu->arch.fpr[ax_rd];
>> -	u64 *fpr_a = &vcpu->arch.fpr[ax_ra];
>> -	u64 *fpr_b = &vcpu->arch.fpr[ax_rb];
>> -	u64 *fpr_c = &vcpu->arch.fpr[ax_rc];
>> +	int ax_rd, ax_ra, ax_rb, ax_rc;
>> +	short full_d;
>> +	u64 *fpr_d, *fpr_a, *fpr_b, *fpr_c;
>> +
>> +	kvmppc_get_last_inst(vcpu, &inst);
> Should probably check for failure here and elsewhere -- even though it
> can't currently fail on book3s, the interface now allows it.
>
>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>> index 5b9e906..b0d884d 100644
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -624,9 +624,10 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
>>   static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
>>   {
>>   	ulong srr0 = kvmppc_get_pc(vcpu);
>> -	u32 last_inst = kvmppc_get_last_inst(vcpu);
>> +	u32 last_inst;
>>   	int ret;
>>   
>> +	kvmppc_get_last_inst(vcpu, &last_inst);
>>   	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> This isn't new, but this function looks odd to me -- calling
> kvmppc_get_last_inst() but ignoring last_inst, then calling kvmppc_ld()
> and ignoring anything but failure.  last_inst itself is never read.  And
> no comments to explain the weirdness. :-)
>
> I get that kvmppc_get_last_inst() is probably being used for the side
> effect of filling in vcpu->arch.last_inst, but why store the return
> value without using it?  Why pass the address of it to kvmppc_ld(),
> which seems to be used only as an indirect way of determining whether
> kvmppc_get_last_inst() failed?  And that whole mechanism becomes
> stranger once it becomes possible for kvmppc_get_last_inst() to directly
> return failure.

If you're interested in the history of this, here's the patch :)

https://github.com/mirrors/linux-2.6/commit/c7f38f46f2a98d232147e47284cb4e7363296a3e

The idea is that we need 2 things to be good after this function:

   1) vcpu->arch.last_inst is valid
   2) if the last instruction is not readable, return failure

Hence this weird construct. I don't think it's really necessary though - 
just remove the kvmppc_ld() call and only fail read_inst() when the 
caching didn't work and we can't translate the address.


Alex
