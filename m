Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D047EB6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 08:48:29 +1100 (EST)
Message-ID: <4F0B60A5.1040208@freescale.com>
Date: Mon, 9 Jan 2012 15:48:21 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 15/16] KVM: PPC: booke: standard PPC floating point
 support
References: <20111221013445.GO8378@schlenkerla.am.freescale.net>
 <F0432B7A-E742-48B0-8016-3F2D0A800553@suse.de>
In-Reply-To: <F0432B7A-E742-48B0-8016-3F2D0A800553@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 11:48 AM, Alexander Graf wrote:
> 
> On 21.12.2011, at 02:34, Scott Wood wrote:
>> +#ifdef CONFIG_PPC_FPU
>> +	/* Save userspace FPU state in stack */
>> +	enable_kernel_fp();
>> +	memcpy(fpr, current->thread.fpr, sizeof(current->thread.fpr));
>> +	fpscr = current->thread.fpscr.val;
>> +	fpexc_mode = current->thread.fpexc_mode;
>> +
>> +	/* Restore guest FPU state to thread */
>> +	memcpy(current->thread.fpr, vcpu->arch.fpr, sizeof(vcpu->arch.fpr));
>> +	current->thread.fpscr.val = vcpu->arch.fpscr;
>> +
>> +	/*
>> +	 * Since we can't trap on MSR_FP in GS-mode, we consider the guest
>> +	 * as always using the FPU.  Kernel usage of FP (via
>> +	 * enable_kernel_fp()) in this thread must not occur while
>> +	 * vcpu->fpu_active is set.
>> +	 */
>> +	vcpu->fpu_active = 1;
>> +
>> +	kvmppc_load_guest_fp(vcpu);
>> +#endif
> 
> Do you think it's possible to combine this with the book3s_pr code, so we don't duplicate too much here?

book3s_pr is a bit different in that it can trap when the guest sets
MSR[FP].

Maybe a few lines could be factored out (the first memcpy, fpscr,
fpexc_mode).  I'm not sure that it makes sense given the lack of
isolation between what it's doing and what the rest of the code is doing.

>> +/*
>> + * Load up guest vcpu FP state if it's needed.
>> + * It also set the MSR_FP in thread so that host know
>> + * we're holding FPU, and then host can help to save
>> + * guest vcpu FP state if other threads require to use FPU.
>> + * This simulates an FP unavailable fault.
>> + *
>> + * It requires to be called with preemption disabled.
>> + */
>> +static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
>> +{
>> +#ifdef CONFIG_PPC_FPU
>> +	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
>> +		load_up_fpu();
>> +		current->thread.regs->msr |= MSR_FP;
> 
> I'm having a hard time to grasp when shared->msr, shadow_msr and regs->msr is used in your code :).

shadow_msr is the real MSR.

shared->msr is the guest's view of MSR.

current->thread.regs->msr is nominally userspace's MSR.  In this case we
use it to tell host Linux that FP is in use and must be saved on context
switch.  The actual userspace MSR_FP is known to be clear at this point
because we called enable_kernel_fp().  It will be clear again when we
return to userspace because we'll call giveup_fpu().

-Scott
