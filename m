Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 18EA42C0342
 for <linuxppc-dev@ozlabs.org>; Wed, 29 May 2013 10:41:31 +1000 (EST)
Message-ID: <1369788078.3928.28.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add support for H_IPOLL and H_XIRR_X
 in XICS emulation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 29 May 2013 10:41:18 +1000
In-Reply-To: <1369762902.18630.2@snotra>
References: <1369762902.18630.2@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-05-28 at 12:41 -0500, Scott Wood wrote:

> I believe Alex is staying far away from e-mail on his vacation.  He's  
> asked me to fill in for him while he's gone.
> 
> The patch itself seems reasonable (though I don't know much about XICS,  
> and do have one question...), but I'll leave it up to Gleb/Marcelo/Ben  
> if it should go in for 3.10 and via which tree.  I understand the  
> desire to not have an incomplete ABI in a released version, but Linus  
> is already grumbling about how much went into rc3, and you say the  
> hcalls aren't currently used...  Are they likely to be used in any  
> timeframe in which we'd reasonably care about 3.10? 

Yes. I'd like to have them in. Their implementation is actually fairly
trivial and they cannot be emulated by qemu if the rest of the XICS is
in the kernel, so it's a problem.

>  If so, would the  
> effect of not having them implemented be such that it would be worse  
> than not having in-kernel XICS at all?

Well, that would mean that running that potential future kernel that
uses them (or some other OS that already uses them) would not work
without the user explicitly disable in kernel irq chip.

> > @@ -787,6 +804,18 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32  
> > req)
> >  	if (!xics || !vcpu->arch.icp)
> >  		return H_HARDWARE;
> > 
> > +	/* These requests don't have real-mode implementations at  
> > present */
> > +	switch (req) {
> > +	case H_XIRR_X:
> > +		res = kvmppc_h_xirr(vcpu);
> > +		kvmppc_set_gpr(vcpu, 4, res);
> > +		kvmppc_set_gpr(vcpu, 5, get_tb());
> > +		return rc;
> > +	case H_IPOLL:
> > +		rc = kvmppc_h_ipoll(vcpu, kvmppc_get_gpr(vcpu, 4));
> > +		return rc;
> > +	}
> > +
> >  	/* Check for real mode returning too hard */
> >  	if (xics->real_mode)
> >  		return kvmppc_xics_rm_complete(vcpu, req);
> 
> Could you explain what's going on here relative to  
> kvmppc_xics_rm_complete()?  What does "returning too hard" mean, and  
> why must rm_action not be checked for these hcalls?

This is related to how we handle some hcalls in real mode as a fast
path. The real-mode stuff cannot handle cases that require for example a
re-emit of the interrupt, a reject, etc... so in some cases, it returns
H_TOO_HARD which causes KVM to exit and try to handle the hcall again in
kernel virtual mode.

When doing so as the result of a XICS hcall, it sets a bit mask of
"tasks" to handle in virtual mode (because it will have already
partially done the operation, it cannot just re-play the whole hcall).

So when real-mode is supported we must not just call the normal virtual
mode version of the hcalls, we instead go to kvmppc_xics_rm_complete()
to handle those "tasks".

However, for those 2 "missing" hcalls, we have no real mode
implementation at all (we didn't bother, we will do that later if
needed, it's purely a performance issue). So we need to fully handle
them in virtual mode, and we know there will be no "tasks" to handle in
rm_complete.

We could have done a real mode variant but we wanted to keep the patch
as small as possible for 3.10.

Cheers,
Ben.
