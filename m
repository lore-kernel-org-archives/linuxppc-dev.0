Return-Path: <kernelfans@gmail.com>
Received: from mail-qa0-x233.google.com (mail-qa0-x233.google.com
 [IPv6:2607:f8b0:400d:c00::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B92552C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 15:19:44 +1100 (EST)
Received: by mail-qa0-f51.google.com with SMTP id hu16so1285777qab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 20:19:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <470E7CC0-6397-4343-89DA-6818531E6775@suse.de>
References: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <470E7CC0-6397-4343-89DA-6818531E6775@suse.de>
Date: Fri, 8 Nov 2013 12:19:36 +0800
Message-ID: <CAFgQCTvWAAr83nq9MmZm44Om36kYC3tOnkUPumfRAVCeYXjLAg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: kvm: optimize "sc 0" as fast return
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 8, 2013 at 11:10 AM, Alexander Graf <agraf@suse.de> wrote:
>
> On 08.11.2013, at 03:44, Liu Ping Fan <kernelfans@gmail.com> wrote:
>
>> syscall is a very common behavior inside guest, and this patch
>> optimizes the path for the emulation of BOOK3S_INTERRUPT_SYSCALL,
>> so hypervisor can return to guest without heavy exit, i.e, no need
>> to swap TLB, HTAB,.. etc
>
> The syscall exit you touch here only happens when you do an sc > 0 with MSR_PR set inside the guest. The only case you realistically see this is when you run PR KVM inside of an HV KVM guest.
>
Maybe I misunderstood the ISA spec, but refer for "6.5.14 System Call
Interrupt", no description about the MSR_PR when sc trigger a syscall
interrupt. So I think, guest application "sc 0" will also fall to the
kernel who owns hypervisor mode.  Am I right?

> I don't think we should optimize for that case. Instead, we should rather try to not bounce to the 1st hypervisor in the first place in that scenario :).
>
Sorry, but just want to make clear about the idiom:  0 -> kernel run
with NV, and 1st -> kernel run on HV-KVM and provide PR-KVM to up
layer? Right?

When you say "try to not bounce to the 1st hypervisor ", what is the
exact meaning and how can we achieve this?  I am a quite newer on
powerpc, and hope that I can get more clear figure about it  :)

Thanks

Pingfan
>
> Alex
>
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>> Compiled, but lack of bare metal, I have not tested it yet.
>> ---
>> arch/powerpc/kvm/book3s_hv.c            |  6 ------
>> arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 ++++++++++++-
>> 2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 62a2b5a..73dc852 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -628,12 +628,6 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>               /* hcall - punt to userspace */
>>               int i;
>>
>> -             if (vcpu->arch.shregs.msr & MSR_PR) {
>> -                     /* sc 1 from userspace - reflect to guest syscall */
>> -                     kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_SYSCALL);
>> -                     r = RESUME_GUEST;
>> -                     break;
>> -             }
>>               run->papr_hcall.nr = kvmppc_get_gpr(vcpu, 3);
>>               for (i = 0; i < 9; ++i)
>>                       run->papr_hcall.args[i] = kvmppc_get_gpr(vcpu, 4 + i);
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index c71103b..9f626c3 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -1388,7 +1388,8 @@ kvmppc_hisi:
>> hcall_try_real_mode:
>>       ld      r3,VCPU_GPR(R3)(r9)
>>       andi.   r0,r11,MSR_PR
>> -     bne     guest_exit_cont
>> +     /* sc 1 from userspace - reflect to guest syscall */
>> +     bne     sc_0_fast_return
>>       clrrdi  r3,r3,2
>>       cmpldi  r3,hcall_real_table_end - hcall_real_table
>>       bge     guest_exit_cont
>> @@ -1409,6 +1410,16 @@ hcall_try_real_mode:
>>       ld      r11,VCPU_MSR(r4)
>>       b       fast_guest_return
>>
>> +sc_0_fast_return:
>> +     ld      r10,VCPU_PC(r9)
>> +     ld      r11,VCPU_MSR(r9)
>> +     mtspr   SPRN_SRR0,r10
>> +     mtspr   SPRN_SRR1,r11
>> +     li      r10, BOOK3S_INTERRUPT_SYSCALL
>> +     LOAD_REG_IMMEDIATE(r3,0xffffffff87a0ffff)       /* zero 33:36,42:47 */
>> +     and     r11,r11,r3
>> +     b       fast_guest_return
>> +
>>       /* We've attempted a real mode hcall, but it's punted it back
>>        * to userspace.  We need to restore some clobbered volatiles
>>        * before resuming the pass-it-to-qemu path */
>> --
>> 1.8.1.4
>>
>
