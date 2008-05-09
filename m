Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39A9ADDDEE
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 19:53:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m499rHqD012238
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 02:53:17 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m499rFQW001555
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 04:53:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/4 V2] booting-without-of for Freescale MSI
Date: Fri, 9 May 2008 17:52:56 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C16ED@zch01exm27.fsl.freescale.net>
In-Reply-To: <c6e4b0f3534e38db766d76fd6450f163@kernel.crashing.org>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<c6e4b0f3534e38db766d76fd6450f163@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Segher.

Thanks=20
> > +    - compatible : set as "fsl,86xx-MSI" for 86xx cpu,=20
> "fsl,85xx-MSI"=20
> > for 85xx
> > +      cpu and "fsl,83xx-MSI" for 83xx cpu.
>=20
> Don't use "xx", use real device names instead.  If for=20
> example the oldest 86xx device that implements this is 8600,=20
> and you write a tree for the 8699, you'd write  compatible =3D=20
> "fsl,8699-msi", "fsl,8600-msi";  and the driver will look for=20
> "fsl,8600-msi" only usually, but it can take some special=20
> actions for 8699 if it needs to.
>=20
> If these MSI devices work really identical for 83xx, 85xx,=20
> 86xx, there is no need to distinguish between them for=20
> probing either -- you want to use the same driver for all, anyway
.
The driver can work for 83xx, 85xx and 86xx,  but the msiir offset=20
is different for 83xx and 85xx/86xx cpu. I need this to get different=20
msiir offset in the driver.

> Oh, and the norm is to write compatible values in lower case.

Ok.
> > +    - msi-available-ranges: use <start count> style=20
> section to define
> > which
> > +      msi interrupt can be used in the 256 msi interrupts.
>=20
> Please make this property optional, default to "all available".
>=20
The value setting for this property is "all available", and this ranges
maybe
useful for some other MSI controller.=20

Jason
