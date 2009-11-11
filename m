Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96C62B70CF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 15:27:14 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAB4RBFl016765
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 21:27:11 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAB4USJk025785
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 22:30:29 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/6] gianfar: Fix build with CONFIG_PM=y
Date: Wed, 11 Nov 2009 09:57:07 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81B95097A@zin33exm22.fsl.freescale.net>
In-Reply-To: <20091111001105.GC8817@oksana.dev.rtsoft.ru>
References: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
	<20091111001105.GC8817@oksana.dev.rtsoft.ru>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"David Miller" <davem@davemloft.net>
Cc: Jon Loeliger <jdl@jdl.com>, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Fleming Andy-AFLEMING <afleming@freescale.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

>-----Original Message-----
>From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
>Sent: Wednesday, November 11, 2009 5:41 AM
>To: David Miller
>Cc: Fleming Andy-AFLEMING; Jon Loeliger; Kumar=20
>Gopalpet-B05799; Lennert Buytenhek; Stephen Hemminger;=20
>netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
>Subject: [PATCH 3/6] gianfar: Fix build with CONFIG_PM=3Dy
>
>commit fba4ed030cfae7efdb6b79a57b0c5a9d72c9 ("gianfar: Add=20
>Multiple Queue Support") introduced the following build failure:
>
>  CC      gianfar.o
>gianfar.c: In function 'gfar_restore':
>gianfar.c:1249: error: request for member 'napi' in something=20
>not a structure or union
>
>This patch fixes the issue.
>
>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>---
> drivers/net/gianfar.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c=20
>index 79c28f5..a5b0038 100644
>--- a/drivers/net/gianfar.c
>+++ b/drivers/net/gianfar.c
>@@ -1246,7 +1246,7 @@ static int gfar_restore(struct device *dev)
> 		phy_start(priv->phydev);
>=20
> 	netif_device_attach(ndev);
>-	napi_enable(&priv->gfargrp.napi);
>+	enable_napi(priv);
>=20
> 	return 0;
> }


I am extreemely sorry for introducing this error, I missed it while
porting my last set of patches.

Thanks for fixing it.


--

Thanks
Sandeep
