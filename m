Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF971DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 19:25:38 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6O9PSiF019323
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 02:25:29 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6O9PRWO026781
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 04:25:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] Add a new member name to structure irq_host
Date: Tue, 24 Jul 2007 17:25:26 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C74CDC2@zch01exm26.fsl.freescale.net>
In-Reply-To: <1185251600.5439.204.camel@localhost.localdomain>
References: <11851892302391-git-send-email-g.chen@freescale.com><11851892311178-git-send-email-g.chen@freescale.com><1185228277.5439.141.camel@localhost.localdomain><1185232974.13740.11.camel@concordia.ozlabs.ibm.com><1185233771.5439.153.camel@localhost.localdomain><995B09A8299C2C44B59866F6391D2635A69C88@zch01exm21.fsl.freescale.net>
	<1185251600.5439.204.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Chen Gong-B11801" <G.Chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Ben,=20

Thanks! Please see my inline comments.

>=20
> Well, you would have to look at a cell blade or pSeries machine
> device-tree, I don't have one at hand in DTS form... but basically,
> those don't have a 1:1 relationship between hosts and nodes.

Is there any problem when the relationship between hosts and nodes is
not 1:1?

The mapping method is defined in irq_alloc_host(). If there is only one
host for many nodes,
then these nodes will use the same mapping. Such as iic_host, the
IRQ_HOST_MAP_LINEAR
is used for its all nodes. We do _not_ care which node, we just care
which virq is mapped from which host's hw irq.

>=20
> Anyway, I discussed with Michael today and it might be a good idea to
> provide an optional device node field in the host struct that can be
> used by the majority of the PICs that have one host =3D=3D one node, =
that
> would provide a good default for the name() function.
>=20

But we have some irq host which has not OF-node bound.

Cheers!
Wei.
