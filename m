Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG6QD6T0VzDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 13:32:52 +1000 (AEST)
Message-ID: <1500867155.3739.2.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Qiang Zhao <qiang.zhao@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "valentin.longchamp@keymile.com" <valentin.longchamp@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Sun, 23 Jul 2017 22:32:35 -0500
In-Reply-To: <AM3PR04MB11857554B054D7288727D4D191BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1500603550-5567-1-git-send-email-qiang.zhao@nxp.com>
 <87mv7ye1sg.fsf@concordia.ellerman.id.au>
 <AM3PR04MB11857554B054D7288727D4D191BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] qe: fix compile issue for arm64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-24 at 02:09 +0000, Qiang Zhao wrote:
> On Fri, 2017-07-21 at 02:34PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > -----Original Message-----
> > From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> > Sent: Friday, July 21, 2017 2:34 PM
> > To: Qiang Zhao <qiang.zhao@nxp.com>; oss@buserror.net
> > Cc: valentin.longchamp@keymile.com; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
> > Subject: Re: [PATCH] qe: fix compile issue for arm64
> > 
> > Zhao Qiang <qiang.zhao@nxp.com> writes:
> > 
> > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > ---
> > >  drivers/soc/fsl/qe/qe.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c index
> > > 2ef6fc6..d48fa4a 100644
> > > --- a/drivers/soc/fsl/qe/qe.c
> > > +++ b/drivers/soc/fsl/qe/qe.c
> > > @@ -229,7 +229,9 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate,
> > 
> > unsigned int multiplier)
> > >  	/* Errata QE_General4, which affects some MPC832x and MPC836x
> > 
> > SOCs, says
> > >  	   that the BRG divisor must be even if you're not using
> > > divide-by-16
> > >  	   mode. */
> > > +#ifdef CONFIG_PPC
> > >  	if (pvr_version_is(PVR_VER_836x) ||
> > > pvr_version_is(PVR_VER_832x)
> > > +#endif
> > >  		if (!div16 && (divisor & 1) && (divisor > 3))
> > >  			divisor++;
> > 
> > Are you sure that's what you want to do on arm64 ?
> 
> Is there any problem?
> 
> Best Regards
> Qiang Zhao

The comment says the workaround applies to MPC832x and MPC836x, but you're
applying the workaround on arm64 as well.

-Scott
