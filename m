Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DF78B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 10:40:27 +1100 (EST)
Message-ID: <4F481FE1.1080404@freescale.com>
Date: Fri, 24 Feb 2012 17:40:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 36/37] KVM: PPC: booke: expose guest registers on irq
 reinject
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-37-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-37-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2012 08:26 AM, Alexander Graf wrote:
> +static void kvmppc_fill_pt_regs(struct kvm_vcpu *vcpu, struct pt_regs *regs)
>  {
> -	int r = RESUME_HOST;
> +	int i;
>  
> -	/* update before a new last_exit_type is rewritten */
> -	kvmppc_update_timing_stats(vcpu);
> +	for (i = 0; i < 32; i++)
> +		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
> +	regs->nip = vcpu->arch.pc;
> +	regs->msr = vcpu->arch.shared->msr;
> +	regs->ctr = vcpu->arch.ctr;
> +	regs->link = vcpu->arch.lr;
> +	regs->xer = kvmppc_get_xer(vcpu);
> +	regs->ccr = kvmppc_get_cr(vcpu);
> +	regs->dar = get_guest_dear(vcpu);
> +	regs->dsisr = get_guest_esr(vcpu);
> +}

How much overhead does this add to every interrupt?  Can't we keep this
to the minimum that perf cares about?

> +
> +static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
> +				     unsigned int exit_nr)
> +{
> +	struct pt_regs regs = *current->thread.regs;
>  
> +	kvmppc_fill_pt_regs(vcpu, &regs);

Why are you copying out of current->thread.regs?  That's old junk data,
set by some previous exception and possibly overwritten since.

-Scott
