Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 22CDEB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 02:26:21 +1100 (EST)
Subject: Re: [PATCH] p1010rdb: gianfar config does not have queues.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D429@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 21 Mar 2012 10:26:15 -0500
Message-Id: <A95D9547-D22C-4A75-AA55-40B0F59967AA@kernel.crashing.org>
References: <20110811142500.GD4926@sgi.com>
 <22426CFF-79AE-4F2B-86C2-EB90F70630B0@kernel.crashing.org>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D429@039-SN2MPN1-013.039d.mgd.msft.net>
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
Cc: Chauhan Pankaj-B32944 <B32944@freescale.com>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 Srivastava Rajan-B34330 <B34330@freescale.com>,
 U Bhaskar-B22300 <B22300@freescale.com>, Robin Holt <holt@sgi.com>,
 PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 17, 2012, at 12:37 AM, Aggrwal Poonam-B10812 wrote:

> Hello Pankaj, Rajan
>=20
> DO you have any comments on the below patch of gianfar?
>>> -			fsl,num_rx_queues =3D <0x8>;
>>> -			fsl,num_tx_queues =3D <0x8>;
> Have been removed from P1010RDB device tree to avoid a kernel panic.
>=20

Ah, right.

> Kumar, as such I see this is the old dts format. Also in the latest =
sdk tree these properties are defined, not sure it is working on =
P1010RDB.
> I can check on this and get back.

Mostly, can you check that p1010rdb boots and works w/my next branch.

- k

>=20
>=20
> Regards
> Poonam
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, March 16, 2012 8:50 PM
>> To: Aggrwal Poonam-B10812
>> Cc: Robin Holt; U Bhaskar-B22300; PPC list; Eric Dumazet
>> Subject: Re: [PATCH] p1010rdb: gianfar config does not have queues.
>>=20
>>=20
>> On Aug 11, 2011, at 9:25 AM, Robin Holt wrote:
>>=20
>>> If I have the the fsl,num_rx_queues and fsl,num_tx_queues properties
>>> defined in the p1010's device tree file, I get a kernel panic very
>>> shortly after boot.  The failure indicates we are configuring the
>>> gianfar.c driver for a queue depth greater than actual.  Removing =
the
>>> properties got the problem resolved.
>>>=20
>>> Signed-off-by: Robin Holt <holt@sgi.com>
>>> To: U Bhaskar-B22300 <B22300@freescale.com>
>>> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
>>> Cc: Eric Dumazet <eric.dumazet@gmail.com>
>>=20
>> Poonam,
>>=20
>> Can you comment on this patch, does it look correct?
>>=20
>> - k
>>=20
>>>=20
>>> diff --git a/arch/powerpc/boot/dts/p1010si.dtsi
>>> b/arch/powerpc/boot/dts/p1010si.dtsi
>>> index 7f51104..91566aa 100644
>>> --- a/arch/powerpc/boot/dts/p1010si.dtsi
>>> +++ b/arch/powerpc/boot/dts/p1010si.dtsi
>>> @@ -258,8 +258,6 @@
>>> 			device_type =3D "network";
>>> 			model =3D "eTSEC";
>>> 			compatible =3D "fsl,etsec2";
>>> -			fsl,num_rx_queues =3D <0x8>;
>>> -			fsl,num_tx_queues =3D <0x8>;
>>> 			local-mac-address =3D [ 00 00 00 00 00 00 ];
>>> 			interrupt-parent =3D <&mpic>;
>>>=20
>>> @@ -280,8 +278,6 @@
>>> 			device_type =3D "network";
>>> 			model =3D "eTSEC";
>>> 			compatible =3D "fsl,etsec2";
>>> -			fsl,num_rx_queues =3D <0x8>;
>>> -			fsl,num_tx_queues =3D <0x8>;
>>> 			local-mac-address =3D [ 00 00 00 00 00 00 ];
>>> 			interrupt-parent =3D <&mpic>;
>>>=20
>>> @@ -302,8 +298,6 @@
>>> 			device_type =3D "network";
>>> 			model =3D "eTSEC";
>>> 			compatible =3D "fsl,etsec2";
>>> -			fsl,num_rx_queues =3D <0x8>;
>>> -			fsl,num_tx_queues =3D <0x8>;
>>> 			local-mac-address =3D [ 00 00 00 00 00 00 ];
>>> 			interrupt-parent =3D <&mpic>;
>>>=20
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>=20
>=20
