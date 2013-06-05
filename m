Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B66EB2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 19:23:34 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Date: Wed, 5 Jun 2013 09:23:00 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF44F1FA@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1370292868-2697-5-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:26 2013)
 <1370385365.748.19@snotra>
In-Reply-To: <1370385365.748.19@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > + * Simulate AltiVec unavailable fault to load guest state
> > + * from thread to AltiVec unit.
> > + * It requires to be called with preemption disabled.
> > + */
> > +static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
> > +{
> > +#ifdef CONFIG_ALTIVEC
> > +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > +		if (!(current->thread.regs->msr & MSR_VEC)) {
> > +			load_up_altivec(NULL);
> > +			current->thread.regs->msr |=3D MSR_VEC;
> > +		}
> > +	}
> > +#endif
>=20
> Why not use kvmppc_supports_altivec()?  In fact, there's nothing
> KVM-specific about these functions...

I will do so, I had this code before kvmppc_supports_altivec() :)

> >  static inline bool kvmppc_supports_spe(void)
> >  {
> >  #ifdef CONFIG_SPE
> > @@ -947,7 +1016,7 @@ int kvmppc_handle_exit(struct kvm_run *run,
> > struct kvm_vcpu *vcpu,
> >  		 */
> >  		bool handled =3D false;
> >
> > -		if (kvmppc_supports_spe()) {
> > +		if (kvmppc_supports_altivec() || kvmppc_supports_spe())
> > {
> >  #ifdef CONFIG_SPE
> >  			if (cpu_has_feature(CPU_FTR_SPE))
> >  				if (vcpu->arch.shared->msr & MSR_SPE) {
>=20
> The distinction between how you're handling SPE and Altivec here
> doesn't really have anything to do with SPE versus Altivec -- it's
> PR-mode versus HV-mode.

I was mislead by MSR_SPE bit, we should rename it as MSR_SPV.

-Mike
