Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95920B7B99
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 16:42:03 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nA55fxni022386
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 22:41:59 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nA55jW90026106
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 23:45:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] fsl_pq_mdio: Fix compiler/sparse warnings (part 1)
Date: Thu, 5 Nov 2009 11:11:56 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81B95069E@zin33exm22.fsl.freescale.net>
References: <20091104225256.GA29537@oksana.dev.rtsoft.ru> 
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: "Kumar Gopalpet-B05799" <B05799@freescale.com>,
	"Anton Vorontsov" <avorontsov@ru.mvista.com>
Cc: netdev@vger.kernel.org, Fleming Andy-AFLEMING <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
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
>From: Kumar Gopalpet-B05799=20
>Sent: Thursday, November 05, 2009 10:31 AM
>To: 'Anton Vorontsov'
>Cc: Fleming Andy-AFLEMING; netdev@vger.kernel.org;=20
>linuxppc-dev@ozlabs.org; David Miller
>Subject: RE: [PATCH 1/3] fsl_pq_mdio: Fix compiler/sparse=20
>warnings (part 1)
>
>=20
>
>>-----Original Message-----
>>From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]
>>Sent: Thursday, November 05, 2009 4:23 AM
>>To: David Miller
>>Cc: Fleming Andy-AFLEMING; Kumar Gopalpet-B05799;=20
>>netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
>>Subject: [PATCH 1/3] fsl_pq_mdio: Fix compiler/sparse=20
>warnings (part 1)
>>
>>commit 1d2397d742b7a2b39b2f09dd9da3b9d1463f55e9 ("fsl_pq_mdio:=20
>>Add Suport for etsec2.0 devices") introduced the following warnings:
>>
>>  CHECK   fsl_pq_mdio.c
>>fsl_pq_mdio.c:287:22: warning: incorrect type in initializer=20
>(different=20
>>base types)
>>fsl_pq_mdio.c:287:22:    expected unknown type 11 const *__mptr
>>fsl_pq_mdio.c:287:22:    got unsigned long long [unsigned]=20
>>[assigned] [usertype] addr
>>fsl_pq_mdio.c:287:19: warning: incorrect type in assignment=20
>(different=20
>>base types)
>>fsl_pq_mdio.c:287:19:    expected unsigned long long=20
>>[unsigned] [usertype] ioremap_miimcfg
>>fsl_pq_mdio.c:287:19:    got struct fsl_pq_mdio *<noident>
>>  CC      fsl_pq_mdio.o
>>fsl_pq_mdio.c: In function 'fsl_pq_mdio_probe':
>>fsl_pq_mdio.c:287: warning: initialization makes pointer from integer=20
>>without a cast
>>fsl_pq_mdio.c:287: warning: assignment makes integer from pointer=20
>>without a cast
>>
>>These warnings are not easy to fix without ugly __force casts.=20
>>So, instead of introducing the casts, rework the code to=20
>substitute an=20
>>offset from an already mapped area. This makes the code a lot simpler=20
>>and less duplicated.
>>
>>Plus, from now on we don't actually map reserved registers on=20
>>non-etsec2.0 devices, so we have more chances to catch programming=20
>>errors.
>>
>>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>---
>> drivers/net/fsl_pq_mdio.c |   31 ++++++++++++-------------------
>> 1 files changed, 12 insertions(+), 19 deletions(-)
>>
>>diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c=20
>>index 4065b7c..fb8c8d9 100644
>>--- a/drivers/net/fsl_pq_mdio.c
>>+++ b/drivers/net/fsl_pq_mdio.c
>>@@ -262,10 +262,11 @@ static int fsl_pq_mdio_probe(struct of_device=20
>>*ofdev,
>> 	struct device_node *np =3D ofdev->node;
>> 	struct device_node *tbi;
>> 	struct fsl_pq_mdio __iomem *regs =3D NULL;
>>+	void __iomem *map;
>> 	u32 __iomem *tbipa;
>> 	struct mii_bus *new_bus;
>> 	int tbiaddr =3D -1;
>>-	u64 addr =3D 0, size =3D 0, ioremap_miimcfg =3D 0;
>>+	u64 addr =3D 0, size =3D 0;
>> 	int err =3D 0;
>>=20
>> 	new_bus =3D mdiobus_alloc();
>>@@ -279,28 +280,20 @@ static int fsl_pq_mdio_probe(struct of_device=20
>>*ofdev,
>> 	fsl_pq_mdio_bus_name(new_bus->id, np);
>>=20
>> 	/* Set the PHY base address */
>>-	if (of_device_is_compatible(np,"fsl,gianfar-mdio") ||
>>-		of_device_is_compatible(np, "fsl,gianfar-tbi") ||
>>-		of_device_is_compatible(np, "fsl,ucc-mdio") ||
>>-		of_device_is_compatible(np,"ucc_geth_phy" )) {
>>-		addr =3D of_translate_address(np,=20
>>of_get_address(np, 0, &size, NULL));
>>-		ioremap_miimcfg =3D  container_of(addr, struct=20
>>fsl_pq_mdio, miimcfg);
>>-		regs =3D ioremap(ioremap_miimcfg, size +
>>-				offsetof(struct fsl_pq_mdio, miimcfg));
>>-	} else if (of_device_is_compatible(np,"fsl,etsec2-mdio") ||
>>-			of_device_is_compatible(np, "fsl,etsec2-tbi")) {
>>-		addr =3D of_translate_address(np,=20
>>of_get_address(np, 0, &size, NULL));
>>-		regs =3D ioremap(addr, size);
>>-	} else {
>>-		err =3D -EINVAL;
>>-		goto err_free_bus;
>>-	}
>>-
>>-	if (NULL =3D=3D regs) {
>>+	addr =3D of_translate_address(np, of_get_address(np, 0,
>>&size, NULL));
>>+	map =3D ioremap(addr, size);
>>+	if (!map) {
>> 		err =3D -ENOMEM;
>> 		goto err_free_bus;
>> 	}
>>=20
>>+	if (of_device_is_compatible(np, "fsl,gianfar-mdio") ||
>>+			of_device_is_compatible(np,
>>"fsl,gianfar-tbi") ||
>>+			of_device_is_compatible(np, "fsl,ucc-mdio") ||
>>+			of_device_is_compatible(np, "ucc_geth_phy"))
>>+		map -=3D offsetof(struct fsl_pq_mdio, miimcfg);
>>+	regs =3D map;
>>+
>> 	new_bus->priv =3D (void __force *)regs;
>>=20
>> 	new_bus->irq =3D kcalloc(PHY_MAX_ADDR, sizeof(int), GFP_KERNEL);
>>--
>
>HI Anton, thanks for the changes. I have only one concern, has=20
>this code been tried for ucc_geth ? I remember I had some=20
>issues with getting the ucc_geth mdio also working. I will=20
>take in these changes and try at my end for ucc_geth.

Sorry, if my earlier statement was confusing. What I meant was with
similar changes as Anton's changes
I had some issues with ucc_geth mdio ( may be Anton's changes don't have
that issue).


--

Thanks
Sandeep
