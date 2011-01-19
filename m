Return-Path: <kumar.gala@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [157.55.116.160])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DF0DB70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Jan 2011 17:10:32 +1100 (EST)
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4D3639FB.10608@pobox.com>
Date: Tue, 18 Jan 2011 23:23:56 -0600
Message-ID: <95A8843E-F05C-474F-BB5D-52B2D20A66F5@freescale.com>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com> <4D3639FB.10608@pobox.com>
To: Roy Zang <tie-fei.zang@freescale.com>, Xulei <B33228@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2011, at 7:10 PM, Jeff Garzik wrote:

> On 01/17/2011 06:47 AM, Sergei Shtylyov wrote:
>> Hello.
>>=20
>> On 17-01-2011 10:10, Xulei wrote:
>>=20
>>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
>>> information is at bit28 instead of bit22.
>>=20
>>> This patch adds FSL sata v2 probe and resolve this difference.
>>=20
>>> Signed-off-by: Xulei <B33228@freescale.com>
>>=20
>> AFAIK, full name is required.
>>=20
>>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>> [...]
>>=20
>>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
>>> b/arch/powerpc/boot/dts/p1022ds.dts
>>> index 2bbecbb..9ad41dd 100644
>>> --- a/arch/powerpc/boot/dts/p1022ds.dts
>>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
>>> @@ -475,14 +475,14 @@
>>> };
>>>=20
>>> sata@18000 {
>>> - compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
>>> + compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
>>> reg =3D<0x18000 0x1000>;
>>> cell-index =3D<1>;
>>> interrupts =3D<74 0x2>;
>>> };
>>>=20
>>> sata@19000 {
>>> - compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
>>> + compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
>>> reg =3D<0x19000 0x1000>;
>>> cell-index =3D<2>;
>>> interrupts =3D<41 0x2>;
>>=20
>> Please put this into the separate patch and push thru the PPC tree.
>=20
> I think it's OK to send 100% of this via the PPC tree.  The sata_fsl.c =
patch for data_snoop variability directly keys off a call to =
platform-specific detail (of_device_is_compatible call).
>=20
> Acked-by: Jeff Garzik <jgarzik@redhat.com>

With Jeff's ack I'll pull this in via the powerpc tree's.

Can we make the minor updates that Sergei has commented on.

- k=
