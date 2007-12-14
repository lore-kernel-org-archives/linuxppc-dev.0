Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6C67FDDF32
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 20:39:44 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBE9dcnf018998
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 02:39:38 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lBE9db5G010783
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 03:39:37 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: [PATCH 2/2] powerpc: Add IPIC MSI support
Date: Fri, 14 Dec 2007 17:39:35 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A652C7D@zch01exm27.fsl.freescale.net>
In-Reply-To: <90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
References: <1196764760.2573.10.camel@Guyver>
	<97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
	<995B09A8299C2C44B59866F6391D2635DB0633@zch01exm21.fsl.freescale.net>
	<90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "Li Tony" <Tony.Li@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, December 14, 2007 4:52 PM
> To: Li Tony
> Cc: Phillips Kim; michael@ellerman.id.au; linuxppc-dev list;=20
> Jin Zhengxiong; Olof Johansson
> Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
>=20
>=20
> On Dec 14, 2007, at 2:47 AM, Li Tony wrote:
>=20
> >
> > Hi,
> >
> > I think it is possible to make common code to support both IPIC and=20
> > MPIC.
> > Currently, the MPIC has already implemented MSI which is different=20
> > from IPIC and embedded into the mpic code body.
> > If want to unifiy MSI code, we need to remove the current MPIC MSI=20
> > implementation.
>=20
> The MPIC is going to have to support several MSI styles=20
> (IBM/U3, PaSemi, and FSL) since we all seem to handle it differently.

I enabled the MSI interrrupts on 85xx/86xx board similar to the IBM/U3 =
board.
Did not enable another host as on 83xx board. Put the 256 MSI interrupts =
after the=20
256 system interrupts and use the same mpic host. This can work and can =
reuse most
of the mpic_msi codes. but since the host_map of MSI is something =
different with MPIC.
I also think it's good idea to make a 2 level PIC handling mechanism for =
MSI on 85xx/86xx board and=20
common the code to support for both IPIC and MPIC for fsl board.

=20
> > Micheal, what is your opinion ??
> >
> > Jin is working on 86xx msi now.
>=20
> What PCIe cards are you using to test MSIs?

I used a SysKonnect 1000M PCIe ether card and the SATA driver to test =
the MSI on 85xx/86xx board.

Best Regards,
Jason

> - k
>=20
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: 2007=C4=EA12=D4=C214=C8=D5 13:45
> >> To: Li Tony
> >> Cc: Phillips Kim; michael@ellerman.id.au; linuxppc-dev
> >> Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
> >>
> >>
> >> On Dec 4, 2007, at 4:39 AM, Li Li wrote:
> >>
> >>> Modified based on discussion on list.
> >>>
> >>> 1. Adopt virq_to_hw routine
> >>> 2. Correct a legacy bug
> >>>
> >>> Implements the IPIC MSI as two level interrupt controller.
> >>>
> >>> Signed-off-by: Tony Li <tony.li@freescale.com>
> >>
> >> Tony, have you looked at the 85xx/86xx PCIe MSI mechanism?
> >> The 2nd level PIC handling seems like its pretty similar=20
> between IPIC=20
> >> and MPIC.  Would like to see if we could somehow make the=20
> code common=20
> >> for to handle MSIs from both?
> >>
> >> - k
> >>
>=20
>=20
