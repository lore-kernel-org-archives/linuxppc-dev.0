Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413wcp18mlzF3C1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 11:37:45 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so11371316pll.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 18:37:45 -0700 (PDT)
Date: Mon, 11 Jun 2018 11:37:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/64s: remove POWER9 DD1 support
Message-ID: <20180611113734.136fce95@roar.ozlabs.ibm.com>
In-Reply-To: <20180610225811.35006b61@naga.suse.cz>
References: <20180610133027.16819-1-npiggin@gmail.com>
 <20180610225811.35006b61@naga.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 10 Jun 2018 22:58:11 +0200
Michal Such=C3=A1nek <msuchanek@suse.de> wrote:

> On Sun, 10 Jun 2018 23:30:27 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> > POWER9 DD1 was never a product. It is no longer supported by upstream
> > firmware, and it is not effectively supported in Linux due to lack of
> > testing.
> >  =20
>=20
> > diff --git a/arch/powerpc/kvm/book3s_xive_template.c
> > b/arch/powerpc/kvm/book3s_xive_template.c index
> > 99c3620b40d9..487f1f6650cc 100644 ---
> > a/arch/powerpc/kvm/book3s_xive_template.c +++
> > b/arch/powerpc/kvm/book3s_xive_template.c @@ -25,18 +25,6 @@ static
> > void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc) */
> >  	eieio();
> > =20
> > -	/*
> > -	 * DD1 bug workaround: If PIPR is less favored than CPPR
> > -	 * ignore the interrupt or we might incorrectly lose an IPB
> > -	 * bit.
> > -	 */
> > -	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> > -		__be64 qw1 =3D __x_readq(__x_tima + TM_QW1_OS);
> > -		u8 pipr =3D be64_to_cpu(qw1) & 0xff;
> > -		if (pipr >=3D xc->hw_cppr)
> > -			return;
> > -	}
> > -
> >  	/* Perform the acknowledge OS to register cycle. */
> >  	ack =3D be16_to_cpu(__x_readw(__x_tima + TM_SPC_ACK_OS_REG));
> > =20
> > @@ -105,7 +93,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq,
> > struct xive_irq_data *xd) *
> >  		 * For LSIs, using the HW EOI cycle works around a
> > problem
> >  		 * on P9 DD1 PHBs where the other ESB accesses don't
> > work
> > -		 * properly.
> > +		 * properly. XXX: can this be removed?
> >  		 */
> >  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> >  			__x_readq(__x_eoi_page(xd) + =20
>=20
> Maybe this should be really removed or the comment changed to why it is
> still useful?

Good point, I meant to ask Ben about that.

Thanks,
Nick
