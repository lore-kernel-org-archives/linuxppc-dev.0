Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F222A2C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 08:53:32 +1000 (EST)
Date: Fri, 10 May 2013 17:53:23 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 4/4] kvm/ppc: IRQ disabling cleanup
To: Bhushan Bharat-R65777 <R65777@freescale.com>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-5-git-send-email-scottwood@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700F859@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700F859@039-SN2MPN1-011.039d.mgd.msft.net>
 (from R65777@freescale.com on Fri May 10 00:01:38 2013)
Message-ID: <1368226403.19683.15@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2013 12:01:38 AM, Bhushan Bharat-R65777 wrote:
>=20
>=20
> > -----Original Message-----
> > From: kvm-ppc-owner@vger.kernel.org =20
> [mailto:kvm-ppc-owner@vger.kernel.org] On
> > Behalf Of Scott Wood
> > Sent: Friday, May 10, 2013 8:40 AM
> > To: Alexander Graf; Benjamin Herrenschmidt
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; =20
> linuxppc-dev@lists.ozlabs.org;
> > Wood Scott-B07421
> > Subject: [PATCH v2 4/4] kvm/ppc: IRQ disabling cleanup
> >
> > -	WARN_ON_ONCE(!irqs_disabled());
> > +	WARN_ON(irqs_disabled());
> > +	hard_irq_disable();
>=20
> Here we hard disable in kvmppc_prepare_to_enter(), so my comment in =20
> other patch about interrupt loss is no more valid.
>=20
> So here
>   MSR.EE =3D 0
>   local_paca->soft_enabled =3D 0
>   local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
>=20
> > +
> >  	while (true) {
> >  		if (need_resched()) {
> >  			local_irq_enable();
>=20
> This will make the state:
>   MSR.EE =3D 1
>   local_paca->soft_enabled =3D 1
>   local_paca->irq_happened =3D PACA_IRQ_HARD_DIS;  //same as before
>=20
> Is that a valid state where interrupts are fully enabled and =20
> irq_happend in not 0?

PACA_IRQ_HARD_DIS will have been cleared by local_irq_enable(), as =20
Tiejun pointed out.

> int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> {
>         int r =3D 0;
>         WARN_ON_ONCE(!irqs_disabled());
>=20
>         kvmppc_core_check_exceptions(vcpu);
>=20
>         if (vcpu->requests) {
>                 /* Exception delivery raised request; start over */
>                 return 1;
>         }
>=20
>         if (vcpu->arch.shared->msr & MSR_WE) {
>                 local_irq_enable();
>                 kvm_vcpu_block(vcpu);
>                 clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
>                 local_irq_disable();
> ^^^
> We do not require hard_irq_disable() here?

Yes, that should be changed to hard_irq_disable(), and I'll add a =20
WARN_ON to double check that interrupts are hard-disabled (eventually =20
we'll probably want to make these critical-path assertions dependent on =20
a debug option...).  It doesn't really matter all that much, though, =20
since we don't have MSR_WE on any 64-bit booke chips. :-)

-Scott=
