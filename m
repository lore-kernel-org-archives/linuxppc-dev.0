Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A21E7DDDCA
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 12:14:39 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l722EXsG015879
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 19:14:34 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l722EWeO026730
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 21:14:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [U-Boot-Users] MPC83xx - previous patch to set MBAR
Date: Thu, 2 Aug 2007 10:14:31 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635AAD0C5@zch01exm21.fsl.freescale.net>
In-Reply-To: <20070801192009.656fc2e0.kim.phillips@freescale.com>
References: <20070801133056.GP3972@stusta.de><fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com><5EACFDEA24DADE42BF109303D305A8093120A6@MAIL.clearcube.com>
	<20070801192009.656fc2e0.kim.phillips@freescale.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Phillips Kim-R1AAHA" <Kim.Phillips@freescale.com>,
	"Keith Mund" <keith.mund@clearcube.com>
Cc: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > The end result simply adds a line to set MBAR to match IMMRBAR.
> >=20
> >         lis     r3, CFG_IMMRBAR@h
> >         ori     r3, r3, CFG_IMMRBAR@l
> >         stw     r3, IMMRBAR(r4)
> > +       mtspr   MBAR, r3
> >=20
> > Are these patches routinely added to the mainstream u-boot code?=20
> >=20
> > Is there any reason why this fix is not a good idea?
> >=20
> does setting MBAR really fix anything?
>=20
> MBAR doesn't live up to its name.  It's a general-purpose scratch
> register - the hardware doesn't do anything with it.  So, wrt=20

Kim is right.

MBAR setting is added by two years ago, it is not really fix anything.

I set the MBAR to be easier to use the CodeWarriror. The CodeWarrior
must set the MBAR first, then it will be able to access the IMMR.

Dave
