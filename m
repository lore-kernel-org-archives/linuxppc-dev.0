Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BCA1A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 14:15:53 +1000 (EST)
Date: Wed, 4 Jun 2014 14:15:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR emulation
Message-ID: <20140604041547.GA32223@drongo>
References: <1401797771-25606-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401797771-25606-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2014 at 05:46:11PM +0530, Aneesh Kumar K.V wrote:
> We use time base for PURR and SPURR emulation with PR KVM since we
> are emulating a single threaded core. When using time base
> we need to make sure that we don't accumulate time spent in the host
> in PURR and SPURR value.

Mostly looks good except for this...

> @@ -170,6 +175,11 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
>  
>  out:
>  	preempt_enable();
> +	/*
> +	 * Update purr and spurr using time base
> +	 */
> +	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
> +	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;

You need to do those updates before the "out:" label.  Otherwise if
this function gets called with !svcpu->in_use (which can happen if
CONFIG_PREEMPT is enabled) we would do these updates a second time for
one guest exit.  The thing is that kvmppc_copy_from_svcpu() can get
called from kvmppc_core_vcpu_put_pr() if the vcpu task gets preempted
on the way out from the guest before we get to the regular call of
kvmppc_copy_from_svcpu().  It would then get called again when the
task gets to run, but this time it does nothing because svcpu->in_use
is false.

Paul.
