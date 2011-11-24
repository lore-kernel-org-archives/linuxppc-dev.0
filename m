Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CACDB1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:51:12 +1100 (EST)
Subject: Re: [PATCH] net: fsl_pq_mdio: fix oops when using uninitialized mutex
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAKWjMd5WCx8pSJiL5U_WkD6XA5dSZLgLZkvMA6sjAKNuAz7PKg@mail.gmail.com>
Date: Thu, 24 Nov 2011 01:50:58 -0600
Message-Id: <2465EDAB-01F8-4D5B-9950-E5F180E8A435@kernel.crashing.org>
References: <59b050a97a9b5382918b66f2850a80c86e52f409.1320736936.git.baruch@tkos.co.il>
 <CAKWjMd5WCx8pSJiL5U_WkD6XA5dSZLgLZkvMA6sjAKNuAz7PKg@mail.gmail.com>
To: Andy Fleming <afleming@gmail.com>
Cc: netdev@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
 linuxppc-dev@lists.ozlabs.org, Andy Fleming <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 9, 2011, at 2:10 PM, Andy Fleming wrote:

>> Fix this by moving the of_mdiobus_register() call earlier.
>>=20
>> Cc: Andy Fleming <afleming@freescale.com>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  drivers/net/ethernet/freescale/fsl_pq_mdio.c |   14 +++++++-------
>>  1 files changed, 7 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c =
b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
>> index 52f4e8a..e17fd2f 100644
>> --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
>> +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
>> @@ -385,6 +385,13 @@ static int fsl_pq_mdio_probe(struct =
platform_device *ofdev)
>>                        tbiaddr =3D *prop;
>>        }
>>=20
>> +       err =3D of_mdiobus_register(new_bus, np);
>> +       if (err) {
>> +               printk (KERN_ERR "%s: Cannot register as MDIO bus\n",
>> +                               new_bus->name);
>> +               goto err_free_irqs;
>> +       }
>> +
>=20
>=20
> This fix totally breaks the point of setting tbipa beforehand.
> mdiobus_register will cause the bus to be scanned, and if any of the
> PHYs are at the default address for tbipa, they won't be found. I have
> a different fix which I will (re)submit today.

What happened here, did you send a patch?

- k=
