Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZGT91VM8zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 17:30:05 +1000 (AEST)
Received: by mail-qk0-x22b.google.com with SMTP id c73so53741977qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 00:30:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464762233.30958.135.camel@neuling.org>
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
 <1464679016-10347-2-git-send-email-oohall@gmail.com>
 <1464762233.30958.135.camel@neuling.org>
From: oliver <oohall@gmail.com>
Date: Wed, 22 Jun 2016 17:30:02 +1000
Message-ID: <CAOSf1CFtLotyoZtQiGLdwcOui+GUNUe0RuOD5kDGxu82Fv2o2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: PPC: hypervisor large decrementer support
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 1, 2016 at 4:23 PM, Michael Neuling <mikey@neuling.org> wrote:
> On Tue, 2016-05-31 at 17:16 +1000, Oliver O'Halloran wrote:
>> +#define IS_LD_ENABLED(reg)                 \
>> +     mfspr  reg,SPRN_LPCR;              \
>> +     andis. reg,reg,(LPCR_LD >> 16);
>
> FWIW you can use:
>         andis. reg,reg,(LPCR_LD)@ha
>
>> +#define GET_DEC(reg)                       \
>> +     IS_LD_ENABLED(reg);                \
>> +     mfspr reg, SPRN_DEC;               \
>> +     bne 99f;                           \
>> +     extsw reg, reg;                    \
>> +99:
>
> It's a little painful that GET_DEC() is now 2 SPR moves.  SPR moves can be
> a bit expensive.  Probably ok for now, but might be nice to store the guest
> dec LD state somewhere so we don't have to retrieve it from the LPCR SPR.

Seems reasonable. It looks like it stashes the LPCR value in the KVM vcpu
structure already


> Actually, it's probably best to do this now since checking the LD bit in
> the LPCR on P8 is a bit dodgy and unnecessary. There is a kvm->arch.lpcr
> you might be able use for this and you can add an asm-offsets for it too
> (like KVM_LPID).
>
> Is GET_DEC ever run in HV=0, where the guest couldn't read the LPCR?

It's only used in book3s_hv_rmhandlers.S, which contains the real mode h-call
handlers and none of that should be executed outside the host. Moving that
code into there from the generic exception header file is a good idea though.

> Also, this now trashes cr0... have you checked that's ok in the paths it's
> used?

It looks fine, but I'll document that.

>> +
>> +     LOAD_REG_ADDR(r6, decrementer_max);
>> +     ld      r6,0(r6);
>>       mtspr   SPRN_HDEC, r6
>>       /* and set per-LPAR registers, if doing dynamic micro-threading */
>>       ld      r6, HSTATE_SPLIT_MODE(r13)
>> @@ -897,7 +902,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>>       mftb    r7
>>       subf    r3,r7,r8
>>       mtspr   SPRN_DEC,r3
>> -     stw     r3,VCPU_DEC(r4)
>> +     std     r3,VCPU_DEC(r4)
>>
>>       ld      r5, VCPU_SPRG0(r4)
>>       ld      r6, VCPU_SPRG1(r4)
>> @@ -953,8 +958,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>>       isync
>>
>>       /* Check if HDEC expires soon */
>> -     mfspr   r3, SPRN_HDEC
>> -     cmpwi   r3, 512         /* 1 microsecond */
>> +     GET_HDEC(r3)
>> +     cmpdi   r3, 512         /* 1 microsecond */
>>       blt     hdec_soon
>>
>>       ld      r6, VCPU_CTR(r4)
>> @@ -990,8 +995,9 @@ deliver_guest_interrupt:
>>       beq     5f
>>       li      r0, BOOK3S_INTERRUPT_EXTERNAL
>>       bne     cr1, 12f
>> -     mfspr   r0, SPRN_DEC
>> -     cmpwi   r0, 0
>> +
>> +     GET_DEC(r0)
>> +     cmpdi   r0, 0
>
> We could just use mfspr DEC here since we are just comparing to 0.  It
> should work in any mode.

I'm not sure about that. The result of the comparison is used below:

>>       li      r0, BOOK3S_INTERRUPT_DECREMENTER
>>       bge     5f

It's checking for the DEC overflowing rather than checking if it's zero. If
LD=0 the mfspr result would not be sign extended causing the branch to be
taken even if the DEC overflowed.

Anyway I'm thinking I might drop this patch for now and let Balbir post it
as a part of his KVM series when that's ready.
