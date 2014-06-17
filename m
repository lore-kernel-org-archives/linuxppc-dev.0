Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52BD71A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:33:21 +1000 (EST)
Message-ID: <1403019186.6603.722.camel@snotra.buserror.net>
Subject: Re: [PATCH] KVM: PPC: e500mc: Relax tlb invalidation condition on
 vcpu schedule
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 17 Jun 2014 10:33:06 -0500
In-Reply-To: <5399DDA8.5060404@suse.de>
References: <1402581610-16585-1-git-send-email-mihai.caraman@freescale.com>
 <5399DDA8.5060404@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Thu, 2014-06-12 at 19:04 +0200, Alexander Graf wrote:
> On 06/12/2014 04:00 PM, Mihai Caraman wrote:
> > @@ -140,12 +142,24 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
> >   	mtspr(SPRN_GDEAR, vcpu->arch.shared->dar);
> >   	mtspr(SPRN_GESR, vcpu->arch.shared->esr);
> >   
> > -	if (vcpu->arch.oldpir != mfspr(SPRN_PIR) ||
> > -	    __get_cpu_var(last_vcpu_on_cpu) != vcpu) {
> > -		kvmppc_e500_tlbil_all(vcpu_e500);
> > +	if (vcpu->arch.oldpir != mfspr(SPRN_PIR)) {
> > +		/* tlb entries deprecated */
> > +		inval_tlb = update_last = true;
> > +	} else if (__get_cpu_var(last_vcpu_on_cpu) != vcpu) {
> > +		update_last = true;
> > +		/* tlb entries polluted */
> > +		inval_tlb = __get_cpu_var(last_lpid_on_cpu) ==
> > +			    vcpu->kvm->arch.lpid;
> > +	}

What about the following sequence on one CPU:

LPID 1, vcpu A
LPID 2, vcpu C
LPID 1, vcpu B
LPID 2, vcpu C	doesn't invalidate
LPID 1, vcpu A  doesn't invalidate

In the last line, vcpu A last ran on this cpu (oldpir matches), but LPID
2 last ran on this cpu (last_lpid_on_cpu does not match) -- but an
invalidation has never happened since vcpu B from LPID 1 ran on this
cpu.

-Scott
