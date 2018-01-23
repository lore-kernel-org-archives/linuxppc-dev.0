Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQjqj30c0zDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 20:36:49 +1100 (AEDT)
Date: Tue, 23 Jan 2018 20:36:44 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 22/26] KVM: PPC: Book3S PR: add emulation for trechkpt in
 PR KVM.
Message-ID: <20180123093644.GN3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-23-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-23-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:35PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch adds host emulation when guest PR KVM executes "trechkpt.",
> which is a privileged instruction and will trap into host.
> 
> We firstly copy vcpu ongoing content into vcpu tm checkpoint
> content, then perform kvmppc_restore_tm_pr() to do trechkpt.
> with updated vcpu tm checkpoint vals.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

[snip]

> +static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long guest_msr = kvmppc_get_msr(vcpu);
> +
> +	preempt_disable();
> +	vcpu->arch.save_msr_tm = MSR_TS_S;
> +	vcpu->arch.save_msr_tm &= ~(MSR_FP | MSR_VEC | MSR_VSX);

This looks odd, since you are clearing bits when you have just set
save_msr_tm to a constant value that doesn't have these bits set.
This could be taken as a sign that the previous line has a bug and you
meant "|=" or something similar instead of "=".  I think you probably
did mean "=", in which case you should remove the line clearing
FP/VEC/VSX.

Paul.
