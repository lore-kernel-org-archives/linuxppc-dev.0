Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A0C7B70C3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2011 07:18:00 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc/p3060qds: Add support for P3060QDS board
Date: Wed, 14 Sep 2011 21:17:49 +0000
Message-ID: <CAOZdJXW54KiExVB3PBj31WfQxgct4Tfk3eh3F0Fw_YCoL_AUTw@mail.gmail.com>
References: <1314905180-4417-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1314905180-4417-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Liu Shengzhou-B36685 <B36685@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 1, 2011 at 2:26 PM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:

> + =A0 =A0 =A0 localbus@ffe124000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xf 0xfe124000 0 0x1000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0 0xf 0xe8000000 0x08000000>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@0,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "cfi-flash";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 0 0x08000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device-width =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand@2,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,elbc-fc=
m-nand";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2 0x0 0x40000>;

The 'ranges' property is missing a line for the NAND device.  You need
something like this:

               ranges =3D <0 0 0xf 0xe8000000 0x08000000
     			       2 0 0xf 0xffa00000 0x00040000>;

I don't know if these are the right numbers, but the "2" line is missing.

--=20
Timur Tabi
Linux kernel developer at Freescale=
