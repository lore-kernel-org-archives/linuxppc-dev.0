Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C195C1007D5
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Dec 2011 09:44:46 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][v2] powerpc/85xx: Rework P1022DS device tree
Date: Tue, 6 Dec 2011 22:44:36 +0000
Message-ID: <CAOZdJXU3-r58oAsvQ+6v71eW6kLM04OnQXpO=yt2oVm4L-D5+A@mail.gmail.com>
References: <1321540377-3672-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321540377-3672-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 8:32 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:=0A=
>=0A=
> @@ -585,30 +222,11 @@=0A=
> =A0 =A0 =A0 =A0};=0A=
>=0A=
> =A0 =A0 =A0 =A0pci1: pcie@fffe0a000 {=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,p1022-pcie";=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <2>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <3>;=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf 0xffe0a000 0 0x1000>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-range =3D <0 255>;=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0x2000000 0x0 0xc0000000 0xc 0=
x40000000 0x0 0x20000000=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1000000 0x0 0x000000=
00 0xf 0xffc20000 0x0 0x10000>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <33333333>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <16 2 0 0>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map-mask =3D <0xf800 0 0 7>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x0 */=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 1 &mpic 0 1=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 2 &mpic 1 1=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 3 &mpic 2 1=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 4 &mpic 3 1=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pcie@0 {=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x0 0x0 0x0 0x0 0=
x0>;=0A=
=0A=
Did you forget to delete this 'reg' line?=0A=
=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <2>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <3>;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0x2000000 0x0 =
0xe0000000=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2000=
000 0x0 0xe0000000=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0 0x=
20000000=0A=
=0A=
-- =0A=
Timur Tabi=0A=
Linux kernel developer at Freescale=0A=
