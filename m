Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7692DDE37
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 07:55:20 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l73LtER8029812
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 14:55:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l73LtEsS024135
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 16:55:14 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Fri, 3 Aug 2007 14:55:16 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA303156076@az33exm25.fsl.freescale.net>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > > > +		MPIC: interrupt-controller@d {
> > > > +			device_type =3D "open-pic";
> > > >=20
> > > > device_type =3D "interrupt-controller".
> >=20
> > Not according to the binding in booting-without-of.txt
>=20
> My understanding here, though possibly flawed, is that the current
> implementation has "open-pic" but _should_ have "interrupt-controller"
> as that is the officially correct name.
>=20
> I _think_ this means we need a transitional period where we update
> the code to look for "interrupt-controller", and obsoletedly, looks
> for the "open-pic", while we transition to the new, correct name.

"open-pic" is the correct value for the device_type property.
See the binding at:
http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps
That is the definition for open pic interrupt controllers (AFAIK).

I am not aware of any official binding with "interrupt-controller"=20
as the device_type.

However, the interrupt mapping spec says that all interrupt
controller (regardless of device_type) must have a=20
property named "interrupt-controller" to identify
the device node as an interrupt controller and root of
a interrupt tree.
See: http://playground.sun.com/1275/practice/imap/imap0_9d.html

Stuart
