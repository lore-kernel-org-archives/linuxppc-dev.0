Return-Path: <afleming@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 83D23B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 02:06:14 +1100 (EST)
Subject: Re: [PATCH] net: fsl_pq_mdio: fix non tbi phy access
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Andy Fleming <afleming@freescale.com>
In-Reply-To: <20111115051713.GA4052@sapphire.tkos.co.il>
Date: Tue, 15 Nov 2011 09:06:03 -0600
Message-ID: <74631EEB-F6F8-4969-AD05-81DEAFB0EAB4@freescale.com>
References: <b693b45a689d42b60a8a9e29dcdd2fb27e20df82.1321251618.git.baruch@tkos.co.il>
 <C89A2124-7AB4-45B6-ACD1-8C5936027531@freescale.com>
 <20111115051713.GA4052@sapphire.tkos.co.il>
To: Baruch Siach <baruch@tkos.co.il>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 14, 2011, at 11:17 PM, Baruch Siach wrote:

> Hi Andy,
>=20
> On Mon, Nov 14, 2011 at 09:04:47PM +0000, Fleming Andy-AFLEMING wrote:
>> Well, this got applied quickly, so I guess I can't NAK, but this =
requires discussion.
>>=20
>> On Nov 14, 2011, at 0:22, "Baruch Siach" <baruch@tkos.co.il> wrote:
>>=20
>>> Since 952c5ca1 (fsl_pq_mdio: Clean up tbi address configuration) =
.probe returns
>>> -EBUSY when the "tbi-phy" node is missing. Fix this.
>>=20
>> It returns an error because it finds no tbi node. Because without the =
tbi=20
>> node, there is no way for the driver to determine which address to =
set.
>>=20
>> Your solution is to ignore the error, and hope. That's a broken =
approach. =20
>> The real solution for a p1010 should be to have a tbi node in the =
dts.
>=20
> Can you elaborate a bit on why this approach is broken? The PHY used =
to work=20
> for me until 952c5ca1, and with this applied.


Yes, well, just because a problem goes away when a patch is applied does =
not mean that the patch is correct, or that it made things work.

An explanation:

In order to support certain types of serial data interfaces with =
external PHYs (like SGMII), it is necessary to translate the MAC's data =
signaling into the serialized signaling. On Freescale parts, this is =
done via a SerDes block, but the SerDes link needs a small amount of =
management. To perform this management, we have an onboard "TBI" PHY. =
This PHY is highly integrated with the MAC and MDIO devices. Each MAC =
has two relevant components:

1) a TBIPA register, which declares the address of the TBI PHY
2) an associated MDIO controller.

In order to configure the SerDes link, it is necessary to communicate =
via the "local" MDIO controller with the TBI PHY. For most of the MACs, =
this is simple: Choose an address for TBIPA, and then use that address =
to communicate with the TBI PHY. However, the *first* MDIO controller is =
also used to communicate with external PHYs. On this controller, we have =
to be fairly particular about which address we put in TBIPA, because all =
transactions to that address will go to the TBI PHY. On older parts, =
this value defaulted to "0", but it now defaults to "31", I believe.

Ok, so now we're at this code. The of_mdiobus_register() function will =
parse the device tree, and find all of the PHYs on the MDIO bus, and =
register them as devices. In order to ensure that all of those PHYs are =
accessible, we *MUST* set TBIPA to something that won't conflict with =
any existing addresses. The mechanism we have chosen for this is to =
assign the address in the device tree, via a tbi-phy node.

My recent patch changed the behavior, because we used to try to find a =
free address via scanning, but this was somewhat ugly, and failed (as =
you noticed) due to uninitialized mutexes.

The reason your latest patch is wrong is because it doesn't set the =
TBIPA register at all if there is no tbi-phy node. Instead, it just =
relies on luck, hoping that the TBIPA register was set to something that =
doesn't conflict already. It will work if 0x1f or 0 aren't necessary PHY =
addresses for your board, or if the firmware set it to something =
sensible.


>=20
>> And looking at the p1010si.dtsi, I see that it's automatically there =
for=20
>> you.
>>=20
>> How were you breaking?
>=20
> Adding linuxppc to Cc.
>=20
> My board is P1011 based, the single core version of P1020, not P1010. =
In=20
> p1020si.dtsi I see no tbi node. In p1020rdb.dts I see a tbi node but =
only for=20
> mdio@25000, not mdio@24000, which is what I'm using.
>=20
> Am I missing something?


Well, that's a bug. In truth, the silicon dtsi trees should not have tbi =
nodes, as that's highly machine-specific. The p1020rdb is apparently =
relying on the old behavior, which is broken, and due to the fact that =
the first ethernet interface doesn't *use* the TBI PHY.

You should add this to your board tree:

                mdio@24000 {

                        tbi0: tbi-phy@11 {
                                reg =3D <0x11>;
                                device_type =3D "tbi-phy";
                        };
                };

And add the PHYs you use, as well as set reg (and the value after the =
"@") to something that makes sense for your board.

I am going to go right now, and add tbi nodes for all of the Freescale =
platforms. I will also modify the fsl_pq_mdio code to be more explicit =
about its reason for failure.

Andy=
