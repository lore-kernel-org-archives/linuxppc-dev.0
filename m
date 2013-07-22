Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 313952C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 12:01:00 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/msi: Fix compile error on mpc83xx
Date: Mon, 22 Jul 2013 02:00:51 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01CF8676@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1372728997-31665-1-git-send-email-hongtao.jia@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01CF350E@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01CF350E@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Jia Hongtao-B38951 <B38951@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

The fsl_msi.c build error on MPC83xx platform is fixed by this patch.

Could you please have a review?

Thanks.
-Hongtao

> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Wednesday, July 10, 2013 10:04 AM
> To: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Cc: galak@kernel.crashing.org; Li Yang-R58472; Jia Hongtao-B38951
> Subject: RE: [PATCH] powerpc/msi: Fix compile error on mpc83xx
>=20
> Hi Scott,
>=20
> I made this patch to fix msi compile error on mpc83xx.
> Could you please have a review.
>=20
> Thanks.
> -Hongtao
>=20
> > -----Original Message-----
> > From: Jia Hongtao-B38951
> > Sent: Tuesday, July 02, 2013 9:37 AM
> > To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421
> > Cc: galak@kernel.crashing.org; Li Yang-R58472; Jia Hongtao-B38951
> > Subject: [PATCH] powerpc/msi: Fix compile error on mpc83xx
> >
> > mpic_get_primary_version() is not defined when not using MPIC.
> > The compile error log like:
> >
> > arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
> > fsl_msi.c:(.text+0x150c): undefined reference to
> > `fsl_mpic_primary_get_version'
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > ---
> >  arch/powerpc/include/asm/mpic.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/powerpc/include/asm/mpic.h
> > b/arch/powerpc/include/asm/mpic.h index ea6bf72..97b5a63 100644
> > --- a/arch/powerpc/include/asm/mpic.h
> > +++ b/arch/powerpc/include/asm/mpic.h
> > @@ -394,7 +394,14 @@ struct mpic
> >  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109
> > PIC */
> >
> >  /* Get the version of primary MPIC */
> > +#ifdef CONFIG_MPIC
> >  extern u32 fsl_mpic_primary_get_version(void);
> > +#else
> > +static inline u32 fsl_mpic_primary_get_version(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >
> >  /* Allocate the controller structure and setup the linux irq descs
> >   * for the range if interrupts passed in. No HW initialization is
> > --
> > 1.8.0
