Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB4872C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 12:07:23 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V6] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Tue, 2 Jul 2013 02:07:14 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01CDFF24@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1372656366-769-1-git-send-email-hongtao.jia@freescale.com>
 <1372723115.8183.99@snotra>
In-Reply-To: <1372723115.8183.99@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, July 02, 2013 7:59 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> galak@kernel.crashing.org; Li Yang-R58472; Jia Hongtao-B38951
> Subject: Re: [PATCH V6] powerpc/MPIC: Add get_version API both for
> internal and external use
>=20
> On 07/01/2013 12:26:06 AM, Jia Hongtao wrote:
> > From: Hongtao Jia <hongtao.jia@freescale.com>
> >
> > MPIC version is useful information for both mpic_alloc() and
> > mpic_init().
> > The patch provide an API to get MPIC version for reusing the code.
> > Also, some other IP block may need MPIC version for their own use.
> > The API for external use is also provided.
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > V6:
> > * Fix compile error on mpc83xx.
>=20
> I already applied V5 before realizing that it was this patch that you
> updated, rather than the MSI patch that depends on it.  There is no
> compile error until the MSI patch that starts using this (which I haven't
> yet applied, due to the error).  Could you send a followup patch that
> just adds the stub?

Yep, sure.

>=20
> > +/* Get the version of primary MPIC */ #ifdef CONFIG_MPIC extern u32
> > +fsl_mpic_primary_get_version(void);
> > +#else
> > +static inline u32 fsl_mpic_primary_get_version(void)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +#endif
> [snip]
> > +static u32 fsl_mpic_get_version(struct mpic *mpic) {
> > +	u32 brr1;
> > +
> > +	if (!(mpic->flags & MPIC_FSL))
> > +		return 0;
>=20
> In one case, calling this without having an FSL MPIC returns -ENOTSUPP,
> and in another case it returns 0...  Shouldn't it be consistent?
>=20
> Also returning a negative number as a u32 is not very nice.
>=20
> -Scott

My mistake.
Will be fixed.

Thanks.
-Hongtao
