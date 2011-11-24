Return-Path: <afleming@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D3EEBB70B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 04:47:51 +1100 (EST)
From: Fleming Andy-AFLEMING <afleming@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] net: fsl_pq_mdio: fix oops when using uninitialized mutex
Date: Thu, 24 Nov 2011 17:46:40 +0000
Message-ID: <64079AFE-7F15-4207-BEC2-E5F9CC7D7C93@freescale.com>
References: <59b050a97a9b5382918b66f2850a80c86e52f409.1320736936.git.baruch@tkos.co.il>
 <CAKWjMd5WCx8pSJiL5U_WkD6XA5dSZLgLZkvMA6sjAKNuAz7PKg@mail.gmail.com>,
 <2465EDAB-01F8-4D5B-9950-E5F180E8A435@kernel.crashing.org>
In-Reply-To: <2465EDAB-01F8-4D5B-9950-E5F180E8A435@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Fleming <afleming@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Baruch Siach <baruch@tkos.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, I sent a patch. Then he sent another patch which breaks things differe=
ntly. I have not yet submitted my fix. My fix is to revert his patch, and t=
hen modify your updated device trees to automatically set the tbi to someth=
ing.

On Nov 24, 2011, at 1:51, "Kumar Gala" <galak@kernel.crashing.org> wrote:

>=20
> On Nov 9, 2011, at 2:10 PM, Andy Fleming wrote:
>=20
>>> Fix this by moving the of_mdiobus_register() call earlier.
>>>=20
>>> Cc: Andy Fleming <afleming@freescale.com>
>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>> ---
>>> drivers/net/ethernet/freescale/fsl_pq_mdio.c |   14 +++++++-------
>>> 1 files changed, 7 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net=
/ethernet/freescale/fsl_pq_mdio.c
>>> index 52f4e8a..e17fd2f 100644
>>> --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
>>> +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
>>> @@ -385,6 +385,13 @@ static int fsl_pq_mdio_probe(struct platform_devic=
e *ofdev)
>>>                       tbiaddr =3D *prop;
>>>       }
>>>=20
>>> +       err =3D of_mdiobus_register(new_bus, np);
>>> +       if (err) {
>>> +               printk (KERN_ERR "%s: Cannot register as MDIO bus\n",
>>> +                               new_bus->name);
>>> +               goto err_free_irqs;
>>> +       }
>>> +
>>=20
>>=20
>> This fix totally breaks the point of setting tbipa beforehand.
>> mdiobus_register will cause the bus to be scanned, and if any of the
>> PHYs are at the default address for tbipa, they won't be found. I have
>> a different fix which I will (re)submit today.
>=20
> What happened here, did you send a patch?
>=20
> - k
