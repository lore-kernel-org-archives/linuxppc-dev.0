Return-Path: <qiang.zhao@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10056.outbound.protection.outlook.com [40.107.1.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG4Z12PwBzDqs9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 12:09:29 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>
CC: "valentin.longchamp@keymile.com" <valentin.longchamp@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] qe: fix compile issue for arm64
Date: Mon, 24 Jul 2017 02:09:23 +0000
Message-ID: <AM3PR04MB11857554B054D7288727D4D191BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1500603550-5567-1-git-send-email-qiang.zhao@nxp.com>
 <87mv7ye1sg.fsf@concordia.ellerman.id.au>
In-Reply-To: <87mv7ye1sg.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-21 at 02:34PM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Friday, July 21, 2017 2:34 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>; oss@buserror.net
> Cc: valentin.longchamp@keymile.com; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
> Subject: Re: [PATCH] qe: fix compile issue for arm64
>=20
> Zhao Qiang <qiang.zhao@nxp.com> writes:
>=20
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> >  drivers/soc/fsl/qe/qe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c index
> > 2ef6fc6..d48fa4a 100644
> > --- a/drivers/soc/fsl/qe/qe.c
> > +++ b/drivers/soc/fsl/qe/qe.c
> > @@ -229,7 +229,9 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate,
> unsigned int multiplier)
> >  	/* Errata QE_General4, which affects some MPC832x and MPC836x
> SOCs, says
> >  	   that the BRG divisor must be even if you're not using divide-by-16
> >  	   mode. */
> > +#ifdef CONFIG_PPC
> >  	if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x)
> > +#endif
> >  		if (!div16 && (divisor & 1) && (divisor > 3))
> >  			divisor++;
>=20
> Are you sure that's what you want to do on arm64 ?

Is there any problem?

Best Regards
Qiang Zhao
