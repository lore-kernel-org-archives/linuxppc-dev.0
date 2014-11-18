Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33A781A06DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 16:29:14 +1100 (AEDT)
Received: by mail-yh0-f49.google.com with SMTP id f10so5846325yha.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:29:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <544DD8EC.6050403@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-7-git-send-email-kernelfans@gmail.com>
 <544DD8EC.6050403@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 13:29:12 +0800
Message-ID: <CAFgQCTtFF4axj15SjD-tY1L7BQPsHy=wqvTXhbPLQcL8sQPkZA@mail.gmail.com>
Subject: Re: [RFC 06/11] powerpc: kvm: introduce online in paca to indicate
 whether cpu is needed by host
From: Liu ping fan <kernelfans@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2014 at 1:32 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> Hi Liu,
>
> On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
>> Nowadays, powerKVM runs with secondary hwthread offline. Although
>> we can make all secondary hwthread online later, we still preserve
>> this behavior for dedicated KVM env. Achieve this by setting
>> paca->online as false.
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/paca.h         |  3 +++
>>  arch/powerpc/kernel/asm-offsets.c       |  3 +++
>>  arch/powerpc/kernel/smp.c               |  3 +++
>>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 12 ++++++++++++
>>  4 files changed, 21 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>> index a5139ea..67c2500 100644
>> --- a/arch/powerpc/include/asm/paca.h
>> +++ b/arch/powerpc/include/asm/paca.h
>> @@ -84,6 +84,9 @@ struct paca_struct {
>>       u8 cpu_start;                   /* At startup, processor spins until */
>>                                       /* this becomes non-zero. */
>>       u8 kexec_state;         /* set when kexec down has irqs off */
>> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
>> +     u8 online;
>> +#endif
>>  #ifdef CONFIG_PPC_STD_MMU_64
>>       struct slb_shadow *slb_shadow_ptr;
>>       struct dtl_entry *dispatch_log;
>> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
>> index 9d7dede..0faa8fe 100644
>> --- a/arch/powerpc/kernel/asm-offsets.c
>> +++ b/arch/powerpc/kernel/asm-offsets.c
>> @@ -182,6 +182,9 @@ int main(void)
>>       DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
>>       DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
>>       DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
>> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
>> +     DEFINE(PACAONLINE, offsetof(struct paca_struct, online));
>> +#endif
>>       DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
>>       DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
>>       DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index a0738af..4c3843e 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -736,6 +736,9 @@ void start_secondary(void *unused)
>>
>>       cpu_startup_entry(CPUHP_ONLINE);
>>
>> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
>> +     get_paca()->online = true;
>> +#endif
>>       BUG();
>>  }
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index f0c4db7..d5594b0 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -322,6 +322,13 @@ kvm_no_guest:
>>       li      r0, KVM_HWTHREAD_IN_NAP
>>       stb     r0, HSTATE_HWTHREAD_STATE(r13)
>>  kvm_do_nap:
>> +#ifdef PPCKVM_ENABLE_SECONDARY
>> +     /* check the cpu is needed by host or not */
>> +     ld      r2, PACAONLINE(r13)
>> +     ld      r3, 0
>> +     cmp     r2, r3
>> +     bne     kvm_secondary_exit_trampoline
>> +#endif
>>       /* Clear the runlatch bit before napping */
>>       mfspr   r2, SPRN_CTRLF
>>       clrrdi  r2, r2, 1
>> @@ -340,6 +347,11 @@ kvm_do_nap:
>>       nap
>>       b       .
>>
>> +#ifdef PPCKVM_ENABLE_SECONDARY
>> +kvm_secondary_exit_trampoline:
>> +     b       .
>
> Uh? When we have no vcpu to run, we loop here instead of doing a nap?
> What are we achieving?
>
> If I understand the intention of the patch well, we are looking to
> provide a knob whereby the host can indicate if it needs the secondaries
> at all.
>
Yes, you catch it :)

> Today the host does boot with all threads online. There are some init
> scripts which take the secondaries down. So today the host does not have
> a say in preventing this, compile time or runtime. So lets see how we
> can switch between the two behaviors if we don't have the init script,
> which looks like a saner thing to do.
>
> We should set the paca->online flag to false by default. If
> KVM_PPC_ENABLE_SECONDARY is configured, we need to set this flag to
> true. So at compile time, we resolve the flag.
>
> While booting, we look at the flag and decide whether to get the
> secondaries online. So we get the current behavior if we have not
> configured KVM_PPC_ENABLE_SECONDARY. Will this achieve the purpose of
> this patch?
>
At boot time, KVM can not run. So we can achieve the change of the
flag by soft cpu hotplug on/off.
I think this is a more flexible way.

Thx,
Fan

> Regards
> Preeti U Murthy
>
