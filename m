Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B6262C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 17:58:52 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/fsl: mpic timer driver
Date: Tue, 31 Jul 2012 07:58:44 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DA4580@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1343370058-2983-1-git-send-email-Dongsheng.wang@freescale.com>
 <2F4F76E5-1ACD-4F30-A997-9811DCE82202@kernel.crashing.org>
In-Reply-To: <2F4F76E5-1ACD-4F30-A997-9811DCE82202@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, July 27, 2012 9:14 PM
> To: Wang Dongsheng-B40534
> Cc: benh@kernel.crashing.org; paulus@samba.org; Wood Scott-B07421;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/fsl: mpic timer driver
>=20
>=20
> On Jul 27, 2012, at 1:20 AM, <Dongsheng.wang@freescale.com>
> <Dongsheng.wang@freescale.com> wrote:
>=20
> > From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> >
> > Global timers A and B internal to the PIC. The two independent groups
> > of global timer, group A and group B, are identical in their
> functionality.
> > The hardware timer generates an interrupt on every timer cycle.
> > e.g
> > Power management can use the hardware timer to wake up the machine.
> >
> > Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
>=20
> How much of this is FSL specific vs openpic?  OpenPIC spec's timer
> support (only a single group).
>=20
[Wang Dongsheng] Yes, OpenPIC only a single group timer.
FSL: add more register, features and group.
This patch only to support FSL chip.
"mpic_timer.c" -> "fsl_mpic_timer.c"
I will modify the description of the patch. how about?

 > > +static int set_cascade_timer(struct group_priv *priv, u64 ticks,
> > +		unsigned int num)
> > +{
> > +	struct cascade_priv *casc_priv;
> > +	u32 tmp;
> > +	u32 tmp_ticks;
> > +	u32 rem_ticks;
> > +
> > +	/* set group tcr reg for cascade */
> > +	casc_priv =3D priv->timer[num].cascade_handle;
> > +	if (!casc_priv)
> > +		return -EINVAL;
> > +
> > +	tmp =3D casc_priv->tcr_value |
> > +		(casc_priv->tcr_value << MPIC_TIMER_TCR_ROVR_OFFSET);
> > +	setbits32(priv->group_tcr, tmp);
> > +
> > +	tmp_ticks =3D div_u64_rem(ticks, MAX_TIME_CASCADE, &rem_ticks);
> > +
> > +	out_be32(&priv->regs[num].gtccr, 0);
> > +	out_be32(&priv->regs[num].gtbcr, tmp_ticks | MPIC_TIMER_STOP);
> > +
> > +	out_be32(&priv->regs[num - 1].gtccr, 0);
> > +	out_be32(&priv->regs[num - 1].gtbcr, rem_ticks);
> > +
> > +	return 0;
> > +}
> > +
> > +struct mpic_timer *get_cascade_timer(u64 ticks) {
>=20
> should this be static?
>=20
[Wang Dongsheng] ok.

> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
