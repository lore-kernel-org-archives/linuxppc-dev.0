Return-Path: <B45475@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DCBD2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 12:58:44 +1000 (EST)
From: Zhao Qiang-B45475 <B45475@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Liu Shengzhou-B36685
 <B36685@freescale.com>
Subject: RE: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy in
 device tree
Date: Fri, 13 Sep 2013 02:58:36 +0000
Message-ID: <36B508A30383C943B69CE30E685EB89CEA3494@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378871354-22763-1-git-send-email-B45475@freescale.com>
 <CE821871-A927-4A65-AA69-05F63AF2C6A1@kernel.crashing.org>
 <3F453DDFF675A64A89321A1F35281021ABA9F8@039-SN1MPN1-004.039d.mgd.msft.net>
 <D8AFFF30-31B1-4B3B-B9D0-DC209A5A3BCD@kernel.crashing.org>
In-Reply-To: <D8AFFF30-31B1-4B3B-B9D0-DC209A5A3BCD@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do you have any solutions?

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Friday, September 13, 2013 12:42 AM
To: Liu Shengzhou-B36685
Cc: Zhao Qiang-B45475; linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy in =
device tree


On Sep 12, 2013, at 1:54 AM, Liu Shengzhou-B36685 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Wednesday, September 11, 2013 11:13 PM
>> To: Zhao Qiang-B45475
>> Cc: linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
>> Subject: Re: [PATCH] powerpc/p1010rdb:remove interrupts of=20
>> ethernet-phy in device tree
>>=20
>>=20
>> On Sep 10, 2013, at 10:49 PM, Zhao Qiang wrote:
>>=20
>>> Since P1010RDB-PA and P1010RDB-PB boards use different external PHY=20
>>> interrupt signals.
>>> And actually the PHY interrupt is not used effectively with=20
>>> corresponding interrupt handler.
>>> So we can remove the interrupts node without side-effect to comply=20
>>> with both P1010RDB-PA and P1010RDB-PB.
>>>=20
>>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>>> Signed-off-by: Zhao Qiang <B45475@freescale.com>
>>> ---
>>> arch/powerpc/boot/dts/p1010rdb.dtsi | 3 ---
>>> 1 file changed, 3 deletions(-)
>>>=20
>>=20
>> NAK.  The device tree should represent the HW not what drivers decide=20
>> to do with it.
>>=20
>> If different board revs have different interrupt signals than create=20
>> dts's to handle the 2 board revs.
>>=20
>> - k
>>=20
> You mean we need to create p1010rdb-pa.dtsi and p1010rdb-pb.dtsi replacin=
g current p1010rdb.dtsi just because of the unused phy interrupt?
> and phy interrupt is not present in those dts of P3/P4/P5 platforms.
> Actually currently many hardware are not present in dts, such as a lot of=
 i2c devices, temperature monitor, etc.
>=20
> -Shengzhou
>=20

I'm saying of the board revs are different w/regards to how the PHY interru=
pt is wired, than create two .dts one for each of the board revs.

If the p3/p4/p5 platforms are missing the phy interrupt in the .dts than it=
s an error.

Other devices like i2c, temp mon, etc should be added.  There is a differen=
ce between something not existing because people haven't gotten around to i=
t / there isn't a binding vs a using the lack of information as a configura=
tion mechanism.

- k
