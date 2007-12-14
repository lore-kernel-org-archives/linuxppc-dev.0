Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80350DE0E7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 20:26:04 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lBE9PwbR008086
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 02:25:59 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBE9PvDF010808
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 03:25:57 -0600 (CST)
Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
From: Li Li <r64360@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
References: <1196764760.2573.10.camel@Guyver>
	<97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
	<995B09A8299C2C44B59866F6391D2635DB0633@zch01exm21.fsl.freescale.net>
	<90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 14 Dec 2007 17:13:47 +0800
Message-Id: <1197623627.5016.1.camel@Guyver>
Mime-Version: 1.0
Cc: Phillips Kim <Kim.Phillips@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jin Zhengxiong <Jason.Jin@freescale.com>,
	Li Tony <Tony.Li@freescale.com>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-12-14 at 16:52 +0800, Kumar Gala wrote:
>=20
> On Dec 14, 2007, at 2:47 AM, Li Tony wrote:
>=20
> >=20
> > Hi,=20
> >=20
> > I think it is possible to make common code to support both IPIC
> and =20
> > MPIC.=20
> > Currently, the MPIC has already implemented MSI which is different =20
> > from IPIC and embedded into the mpic code body.=20
> > If want to unifiy MSI code, we need to remove the current MPIC MSI =20
> > implementation.
>=20
> The MPIC is going to have to support several MSI styles (IBM/U3, =20
> PaSemi, and FSL) since we all seem to handle it differently.
>=20

Yes, you are right. I misunderstands here.

> > Micheal, what is your opinion ??=20
> >=20
> > Jin is working on 86xx msi now.
>=20
> What PCIe cards are you using to test MSIs?
>=20

Intel PRO1000 PCIE network card and SysKonnect card.

> - k
>=20
> >> -----Original Message-----=20
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> >> Sent: 2007=E5=B9=B412=E6=9C=8814=E6=97=A5 13:45=20
> >> To: Li Tony=20
> >> Cc: Phillips Kim; michael@ellerman.id.au; linuxppc-dev=20
> >> Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support=20
> >>=20
> >>=20
> >> On Dec 4, 2007, at 4:39 AM, Li Li wrote:=20
> >>=20
> >>> Modified based on discussion on list.=20
> >>>=20
> >>> 1. Adopt virq_to_hw routine=20
> >>> 2. Correct a legacy bug=20
> >>>=20
> >>> Implements the IPIC MSI as two level interrupt controller.=20
> >>>=20
> >>> Signed-off-by: Tony Li <tony.li@freescale.com>=20
> >>=20
> >> Tony, have you looked at the 85xx/86xx PCIe MSI mechanism?=20
> >> The 2nd level PIC handling seems like its pretty similar=20
> >> between IPIC and MPIC.  Would like to see if we could somehow=20
> >> make the code common for to handle MSIs from both?=20
> >>=20
> >> - k=20
> >>
>=20
