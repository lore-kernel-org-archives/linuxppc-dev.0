Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EAAEDDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 15:53:54 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4L5rmLu003817
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:53:48 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4L5rkcs013666
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:53:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
Date: Wed, 21 May 2008 13:53:45 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A915892@zch01exm27.fsl.freescale.net>
In-Reply-To: <F5D33911-1265-4D4F-9D37-D2965120DB77@kernel.crashing.org>
References: <1211270856-26579-1-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-2-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-3-git-send-email-Jason.jin@freescale.com>
	<177599B6-6236-4292-A69B-CA13617A6576@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A91586D@zch01exm27.fsl.freescale.net>
	<F5D33911-1265-4D4F-9D37-D2965120DB77@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, May 21, 2008 11:39 AM
> To: Jin Zhengxiong
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
>=20
>=20
> On May 20, 2008, at 10:29 PM, Jin Zhengxiong wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Tuesday, May 20, 2008 9:24 PM
> >> To: Jin Zhengxiong
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH 3/4 V4] Enable MSI support for=20
> MPC8610HPCD board
> >>
> >>> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/=20
> >>> powerpc/platforms/86xx/mpc8610_hpcd.c
> >>> index dea1320..290d717 100644
> >>> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> >>> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> >>> @@ -71,9 +71,13 @@ static void __init mpc86xx_hpcd_init_irq(void)
> >>> 	/* Alloc mpic structure and per isu has 16 INT entries. */
> >>> 	mpic1 =3D mpic_alloc(np, res.start,
> >>> 			MPIC_PRIMARY | MPIC_WANTS_RESET |
> >> MPIC_BIG_ENDIAN,
> >>> -			0, 256, " MPIC     ");
> >>> +			64, 256, " MPIC     ");
> >>> 	BUG_ON(mpic1 =3D=3D NULL);
> >>>
> >>> +	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
> >>> +	mpic_assign_isu(mpic1, 1, res.start + 0x10800);
> >>> +	mpic_assign_isu(mpic1, 2, res.start + 0x11600);
> >>> +
> >>
> >> I don't understand why you are breaking the interrupts up=20
> like this.
> >>
> >> If you leave as it was, the MSIs would start at hw irq 176
> >
> > If the ISU size is 0, mpic will only initialize the=20
> interrupt source=20
> > num reading from Feature Reporting Register(FRR), For 8610=20
> it's 104,=20
> > for 8572 it is 108, As the address space of the interrupt source=20
> > configuration register is not continuous(between=20
> 0xa00-0x1600), with=20
> > ISU=3D0, actually only the 16 externel interrupts and 64 internal=20
> > interrupts were initialized.
> > the Messaging interrupts and MSI interrupts were not intialized.
> >
> > With the original code. the Messaging interrupts would=20
> start at hwirq
> > 176 and the MSIs would
> > start at hwirq 224.
> > By setting the ISU=3D64, the Messaging interrupts would start=20
> at 128 and=20
> > the MSIs start at 176.
> > And all the interrupt sources will be initialized.
>=20
> Yeah, I remember this now.  What about something like:
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c=20
> b/arch/powerpc/sysdev/mpic.c index 8619f2a..90de869 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1251,6 +1251,8 @@ void __init mpic_init(struct mpic *mpic)
>          if (mpic->irq_count =3D=3D 0)
>                  mpic->irq_count =3D mpic->num_sources;
>=20
> +       mpic->num_sources =3D max(mpic->num_sources, mpic->irq_count);
> +
>          /* Do the HT PIC fixups on U3 broken mpic */
>          DBG("MPIC flags: %x\n", mpic->flags);
>          if ((mpic->flags & MPIC_U3_HT_IRQS) && (mpic->flags &
> MPIC_PRIMARY)) {
>=20

Moving this code earlier to mpic_alloc like following patch, can make
mpic
initialize all the "irq_count" interrupt sources, although a little
difficult to understand
for those did not know the background.=20
On the other side, IF the reserved space was somewhat enlarged in the
source
configuration register, We need to enlarge the irq-count for those
unexist interrupts.

Jason

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8619f2a..baa9df1 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1143,11 +1143,14 @@ struct mpic * __init mpic_alloc(struct
device_node *node,
        greg_feature =3D mpic_read(mpic->gregs,
MPIC_INFO(GREG_FEATURE_0));
        mpic->num_cpus =3D ((greg_feature &
MPIC_GREG_FEATURE_LAST_CPU_MASK)
                          >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
-       if (isu_size =3D=3D 0)
+       if (isu_size =3D=3D 0) {
                mpic->num_sources =3D
                        ((greg_feature &
MPIC_GREG_FEATURE_LAST_SRC_MASK)
                         >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
=20
+               mpic->num_sources =3D max(mpic->num_sources,
mpic->irq_count);
+       }
+
        /* Map the per-CPU registers */
        for (i =3D 0; i < mpic->num_cpus; i++) {
                mpic_map(mpic, paddr, &mpic->cpuregs[i],
