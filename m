Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48566B70CC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:38:16 +1100 (EST)
Subject: Re: [PATCH] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers (fix)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101007062909.GA27110@oksana.dev.rtsoft.ru>
Date: Thu, 7 Oct 2010 01:37:25 -0500
Message-Id: <0778A3B9-E242-4BCC-B318-154BE9ECB2C6@kernel.crashing.org>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
	<20100721182108.5a22c822@schlenkerla.am.freescale.net>
	<20100801105419.GA352@oksana.dev.rtsoft.ru>
	<5628792F-9A5F-4200-90B3-FB3939F02969@kernel.crashing.org>
	<20101007062909.GA27110@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, Peter Tyser <ptyser@xes-inc.com>,
	Doug Thompson <dougthompson@xmission.com>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>=20
> It's already in Linus' tree.

Yeah, the problem is what's merged in linus's tree has p4080 listed and =
it shouldn't

>=20
> Thanks,
>=20
> - - - -
> commit cd1542c8197fc3c2eb3a8301505d5d9738fab1e4
> Author: Anton Vorontsov <avorontsov@mvista.com>
> Date:   Tue Aug 10 18:03:21 2010 -0700
>=20
>    edac: mpc85xx: add support for new MPCxxx/Pxxxx EDAC controllers
>=20
>    Simply add proper IDs into the device table.
>=20
>    Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
>    Cc: Scott Wood <scottwood@freescale.com>
>    Cc: Peter Tyser <ptyser@xes-inc.com>
>    Cc: Dave Jiang <djiang@mvista.com>
>    Cc: Doug Thompson <dougthompson@xmission.com>
>    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index fdbad55..af75e27 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -647,7 +647,10 @@ static struct of_device_id =
mpc85xx_l2_err_of_match[] =3D {
> 	{ .compatible =3D "fsl,mpc8555-l2-cache-controller", },
> 	{ .compatible =3D "fsl,mpc8560-l2-cache-controller", },
> 	{ .compatible =3D "fsl,mpc8568-l2-cache-controller", },
> +	{ .compatible =3D "fsl,mpc8569-l2-cache-controller", },
> 	{ .compatible =3D "fsl,mpc8572-l2-cache-controller", },
> +	{ .compatible =3D "fsl,p1020-l2-cache-controller", },
> +	{ .compatible =3D "fsl,p1021-l2-cache-controller", },
> 	{ .compatible =3D "fsl,p2020-l2-cache-controller", },
> 	{},
> };
> @@ -1125,7 +1128,10 @@ static struct of_device_id =
mpc85xx_mc_err_of_match[] =3D {
> 	{ .compatible =3D "fsl,mpc8569-memory-controller", },
> 	{ .compatible =3D "fsl,mpc8572-memory-controller", },
> 	{ .compatible =3D "fsl,mpc8349-memory-controller", },
> +	{ .compatible =3D "fsl,p1020-memory-controller", },
> +	{ .compatible =3D "fsl,p1021-memory-controller", },
> 	{ .compatible =3D "fsl,p2020-memory-controller", },
> +	{ .compatible =3D "fsl,p4080-memory-controller", },

This line should be here ;)

> 	{},
> };
> MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
