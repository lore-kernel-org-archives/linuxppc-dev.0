Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x22a.google.com (mail-qc0-x22a.google.com
 [IPv6:2607:f8b0:400d:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71A362C0330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 12:02:21 +1100 (EST)
Received: by mail-qc0-f170.google.com with SMTP id n9so3661969qcw.29
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Nov 2013 17:02:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131108111217.GD16470@iris.ozlabs.ibm.com>
References: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131108111217.GD16470@iris.ozlabs.ibm.com>
Date: Mon, 11 Nov 2013 09:02:17 +0800
Message-ID: <CAFgQCTu8y51JV0kR-XsdzAP_B+cNqeS+R35C5P7CU5vqjK1S8g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: kvm: optimize "sc 0" as fast return
From: Liu ping fan <kernelfans@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 8, 2013 at 7:12 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Fri, Nov 08, 2013 at 10:44:16AM +0800, Liu Ping Fan wrote:
>> syscall is a very common behavior inside guest, and this patch
>> optimizes the path for the emulation of BOOK3S_INTERRUPT_SYSCALL,
>> so hypervisor can return to guest without heavy exit, i.e, no need
>> to swap TLB, HTAB,.. etc
>
> Many interrupts that are caused by guest code go directly to the guest
> and don't come to the hypervisor at all.  That includes system call
> (sc 0), alignment interrupts, program interrupts, SLB miss interrupts,
> etc.  See section 6.5 of Book 3S of the Power ISA specification; all
> the interrupts with '-' in the 'HV' column of the table there get
> delivered directly to the guest when they occur inside a guest.
>
Oh,got it, thanks! That is an important thing I tried to find out but
missed all these days.

>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -1388,7 +1388,8 @@ kvmppc_hisi:
>>  hcall_try_real_mode:
>>       ld      r3,VCPU_GPR(R3)(r9)
>>       andi.   r0,r11,MSR_PR
>> -     bne     guest_exit_cont
>> +     /* sc 1 from userspace - reflect to guest syscall */
>> +     bne     sc_0_fast_return
>
> Discrepancy between comment and code here.  In fact we would only take
> the branch for a sc 1 instruction in userspace, which occurs when a PR
> KVM guest nested inside a HV KVM guest does a hypercall (i.e., not for

I made a big mistake from the beginning, and now get a more clear
understand of the scene. Thanks!

> normal system calls).  It is probably worthwhile to speed those up.
>
>> +sc_0_fast_return:
>> +     ld      r10,VCPU_PC(r9)
>> +     ld      r11,VCPU_MSR(r9)
>
> r11 must already contain this since you just did andi. r0,r11,MSR_PR.
> In fact r10 already contains VCPU_PC(r9) at this point also, though
> that is not so obvious.
>
>> +     mtspr   SPRN_SRR0,r10
>> +     mtspr   SPRN_SRR1,r11
>> +     li      r10, BOOK3S_INTERRUPT_SYSCALL
>> +     LOAD_REG_IMMEDIATE(r3,0xffffffff87a0ffff)       /* zero 33:36,42:47 */
>> +     and     r11,r11,r3
>
> This is not correct, since you don't even clear PR.  In fact what you

Yes.
> need is to load up MSR_SF | MSR_ME, though that value changes with

Is it enough to only set "MSR_SF | MSR_ME"? Sould the HV guest(PR KVM)
need to fake msr,  so that PR guest feels that "sc 1" is trapped by PR
KVM directly? I.e, according to ISA "Figure 51. MSR setting due to
interrupt", about "System Call", we need to keep MSR_IR/_DR unchanged.
If it is true, then HV need to help HV guest to make this fake. Right?

> little-endian support and changes again with transactional memory
> support for POWER8.  There is an idiom for loading that MSR value,
> which is:
>
>         li      r11, (MSR_ME << 1) | 1  /* synthesize MSR_SF | MSR_ME */
>         rotldi  r11, r11, 63
>
Why do we define MSR_SF_LG as bit 63, not like the ISA says bit 0 is SF?
And could you enlighten me briefly that what is the effect on the
value, when LE and  transactional memory are introduced?

Thanks and best regards,
Pingfan

> which you could use for now, but it will need to be changed when
> Anton's LE patch gets accepted.
>
> Paul.
