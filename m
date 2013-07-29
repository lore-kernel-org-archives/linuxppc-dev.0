Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41AA22C00E4
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jul 2013 04:10:11 +1000 (EST)
Date: Mon, 29 Jul 2013 13:10:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/3] powerpc/85xx: Add C293PCIE board support
To: Liu Po-B43644 <B43644@freescale.com>
In-Reply-To: <D473A0D087F4EA47A30C37E4637E25E609DB3735@039-SN2MPN1-023.039d.mgd.msft.net>
 (from B43644@freescale.com on Sun Jul 28 21:20:11 2013)
Message-ID: <1375121403.30721.49@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2013 09:20:11 PM, Liu Po-B43644 wrote:
>=20
>=20
> >  -----Original Message-----
> >  From: Wood Scott-B07421
> >  Sent: Saturday, July 27, 2013 5:59 AM
> >  To: Liu Po-B43644
> >  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming =20
> Andy-
> >  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
> >  Subject: Re: [PATCH v2 3/3] powerpc/85xx: Add C293PCIE board =20
> support
> >
> >  On 07/25/2013 09:41:19 PM, Po Liu wrote:
> >  > +		partition@1900000 {
> >  > +			/* 7MB for User Area */
> >  > +			reg =3D <0x01900000 0x00700000>;
> >  > +			label =3D "NAND User area";
> >  > +		};
> >  > +
> >  > +		partition@2000000 {
> >  > +			/* 96MB for Root File System */
> >  > +			reg =3D <0x02000000 0x06000000>;
> >  > +			label =3D "NAND Root File System";
> >  > +		};
> >  > +
> >  > +		partition@8000000 {
> >  > +			/* 3968MB for Others */
> >  > +			reg =3D <0x08000000 0xF8000000>;
> >  > +			label =3D "NAND Others";
> >  > +		};
> >
> >  Again, what is the difference between "user area" and "others"?  =20
> I'm not
> >  even sure why it needs to be separate from "root file system", but =20
> at
> >  least the root filesystem should be larger given the size of the =20
> overall
> >  flash.
> Do you mean just merge up four partition into one "RFS"? Or merge up =20
> four partition into "RFS" and "User area" is better?

If you don't have a reason for separating them, then probably yes, =20
merge them all into one.  If you do keep RFS and "user area" separate, =20
then "user area" should be the larger of the two, but the RFS should be =20
more than just 96 MiB.

> >  > +			partition@580000 {
> >  > +				/* 10.5MB for Compressed RFS =20
> Image */
> >  > +				reg =3D <0x00580000 0x00a80000>;
> >  > +				label =3D "SPI Flash Compressed =20
> RFSImage";
> >  > +			};
> >
> >  Space before "Image".  Why specifiy that it's compressed, versus =20
> some
> >  other filesystem type?
> >
> Remove all the "compressed" comments when express the RFS partition?

Yes.

-Scott=
