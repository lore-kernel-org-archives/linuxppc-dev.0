Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BE4BB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 06:45:49 +1100 (EST)
Message-ID: <4F4BDD63.4020801@freescale.com>
Date: Mon, 27 Feb 2012 13:45:39 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 36/37] KVM: PPC: booke: expose guest registers on irq
 reinject
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-37-git-send-email-agraf@suse.de>
 <4F481FE1.1080404@freescale.com>
 <810950A7-CD5A-46A5-865B-1209A5532DCC@suse.de>
In-Reply-To: <810950A7-CD5A-46A5-865B-1209A5532DCC@suse.de>
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

On 02/26/2012 05:59 AM, Alexander Graf wrote:
> 
> On 25.02.2012, at 00:40, Scott Wood wrote:
> 
>> On 02/24/2012 08:26 AM, Alexander Graf wrote:
>>> +static void kvmppc_fill_pt_regs(struct kvm_vcpu *vcpu, struct pt_regs *regs)
>>> {
>>> -	int r = RESUME_HOST;
>>> +	int i;
>>>
>>> -	/* update before a new last_exit_type is rewritten */
>>> -	kvmppc_update_timing_stats(vcpu);
>>> +	for (i = 0; i < 32; i++)
>>> +		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
>>> +	regs->nip = vcpu->arch.pc;
>>> +	regs->msr = vcpu->arch.shared->msr;
>>> +	regs->ctr = vcpu->arch.ctr;
>>> +	regs->link = vcpu->arch.lr;
>>> +	regs->xer = kvmppc_get_xer(vcpu);
>>> +	regs->ccr = kvmppc_get_cr(vcpu);
>>> +	regs->dar = get_guest_dear(vcpu);
>>> +	regs->dsisr = get_guest_esr(vcpu);
>>> +}
>>
>> How much overhead does this add to every interrupt?  Can't we keep this
>> to the minimum that perf cares about?
> 
> I would rather not make assumptions on what perf cares about - maybe we want to one day implement "perf kvm" and then perf could rely on pretty much anything in there.

In that case I think we should be populating a real pt_regs from the
start, as in my original patchset.

I only agreed to take it out because I thought the set of things we'd
copy would be minimal.  This seems like a lot of overhead.

I'm not familiar with "perf kvm", but if it's kvm-specific surely the
KVM code should know/dictate what it can rely on?  Or maybe there can be
a debug option that enables full pt_regs (similar to exit timing)?

Could we just set regs to NULL when the debug option isn't enabled?

>>> +static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
>>> +				     unsigned int exit_nr)
>>> +{
>>> +	struct pt_regs regs = *current->thread.regs;
>>>
>>> +	kvmppc_fill_pt_regs(vcpu, &regs);
>>
>> Why are you copying out of current->thread.regs?  That's old junk data,
>> set by some previous exception and possibly overwritten since.
> 
> Because it gives us good default values for anything we don't set. Do you have other recommendations?

It does not give good default values for anything.  It is junk,
unallocated memory, overwritten by who knows what.  Same as the memory
you're copying to.

To avoid garbage in fields we don't set, fill it with zeroes first.

-Scott
