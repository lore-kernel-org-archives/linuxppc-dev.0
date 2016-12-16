Return-Path: <madalin.bucur@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40086.outbound.protection.outlook.com [40.107.4.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgGn74FyhzDw57
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 04:01:47 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: Scott Wood <scott.wood@nxp.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [upstream-release] [PATCH net 2/4] fsl/fman: arm: call
 of_platform_populate() for arm64 platfrom
Date: Fri, 16 Dec 2016 17:01:41 +0000
Message-ID: <AM4PR04MB16048BC5546038190CFDBF2BEC9C0@AM4PR04MB1604.eurprd04.prod.outlook.com>
References: <1481807497-4724-1-git-send-email-madalin.bucur@nxp.com>
 <1481807497-4724-3-git-send-email-madalin.bucur@nxp.com>
 <DB5PR0401MB1928F163614C64900D1458ED919D0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
In-Reply-To: <DB5PR0401MB1928F163614C64900D1458ED919D0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
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

> From: Scott Wood
> Sent: Thursday, December 15, 2016 8:42 PM
>=20
> On 12/15/2016 07:11 AM, Madalin Bucur wrote:
> > From: Igal Liberman <igal.liberman@freescale.com>
> >
> > Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> > ---
> >  drivers/net/ethernet/freescale/fman/fman.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/fman/fman.c
> b/drivers/net/ethernet/freescale/fman/fman.c
> > index dafd9e1..f36b4eb 100644
> > --- a/drivers/net/ethernet/freescale/fman/fman.c
> > +++ b/drivers/net/ethernet/freescale/fman/fman.c
> > @@ -2868,6 +2868,16 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
> >
> >  	fman->dev =3D &of_dev->dev;
> >
> > +#ifdef CONFIG_ARM64
> > +	/* call of_platform_populate in order to probe sub-nodes on arm64 */
> > +	err =3D of_platform_populate(fm_node, NULL, NULL, &of_dev->dev);
> > +	if (err) {
> > +		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
> > +			__func__);
> > +		goto fman_free;
> > +	}
> > +#endif
>=20
> Should we remove fsl,fman from the PPC of_device_ids[], so this doesn't
> need an ifdef?
>=20
> Why is it #ifdef CONFIG_ARM64 rather than #ifndef CONFIG_PPC?
>=20
> -Scott

Igal was working on adding ARM64 support when this patch was created, thus =
the
choice of #ifdef CONFIG_ARM64. Unifying this for PPC and ARM64 by always ca=
lling
of_platform_populate() sounds like the best approach. I would need to synch=
ronize
the introduction of this code with the removal of the fsl,fman entry from t=
he
of_device_ids[] array.

Dave, Michael, Scott, is it ok to add to v2 of this patch set the patch tha=
t removes
the compatible "fsl,fman" from arch/powerpc/platforms/85xx/corenet_generic.=
c?

Thanks,
Madalin
