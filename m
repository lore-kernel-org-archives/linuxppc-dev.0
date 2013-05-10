Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 801692C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 08:44:07 +1000 (EST)
Date: Fri, 10 May 2013 17:43:57 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/4] kvm/ppc/booke64: Fix lazy ee handling in
 kvmppc_handle_exit()
To: Bhushan Bharat-R65777 <R65777@freescale.com>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-3-git-send-email-scottwood@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700F847@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700F847@039-SN2MPN1-011.039d.mgd.msft.net>
 (from R65777@freescale.com on Fri May 10 00:01:19 2013)
Message-ID: <1368225837.19683.13@snotra>
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

On 05/10/2013 12:01:19 AM, Bhushan Bharat-R65777 wrote:
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
> > Subject: [PATCH v2 2/4] kvm/ppc/booke64: Fix lazy ee handling in
> > kvmppc_handle_exit()
> >
> > EE is hard-disabled on entry to kvmppc_handle_exit(), so call
> > hard_irq_disable() so that PACA_IRQ_HARD_DIS is set, and =20
> soft_enabled
> > is unset.
> >
> > Without this, we get warnings such as =20
> arch/powerpc/kernel/time.c:300,
> > and sometimes host kernel hangs.
> >
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> >  arch/powerpc/kvm/booke.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 1020119..705fc5c 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -833,6 +833,11 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu
> > *vcpu,
> >  	int r =3D RESUME_HOST;
> >  	int s;
> >
> > +#ifdef CONFIG_PPC64
> > +	WARN_ON(local_paca->irq_happened !=3D 0);
> > +#endif
> > +	hard_irq_disable();
>=20
> It is not actually to hard disable as EE is already clear but to make =20
> it looks like hard_disable to host. Right?
> If so, should we write a comment here on why we are doing this?

Yes, I can add a comment.

-Scott=
