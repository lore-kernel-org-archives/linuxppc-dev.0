Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 67277B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 15:04:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] powerpc: Fix invalid page flags in create TLB CAM pathfor
	PTE_64BIT
Date: Fri, 24 Sep 2010 07:04:28 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C175@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <1285279157.5158.17.camel@pasglop>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com><20100923153347.4b517105@udp111988uds.am.freescale.net>
	<1285279157.5158.17.camel@pasglop>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Scott Wood" <scottwood@freescale.com>
Cc: "Gortmaker, Paul" <Paul.Gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.o
> zlabs.org] On Behalf Of Benjamin Herrenschmidt
> Sent: Friday, September 24, 2010 5:59 AM
> To: Scott Wood
> Cc: Gortmaker, Paul; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc: Fix invalid page flags in=20
> create TLB CAM pathfor PTE_64BIT
>=20
> On Thu, 2010-09-23 at 15:33 -0500, Scott Wood wrote:
> > I don't see a generic accessor that can test PTE flags for=20
> user access=20
> > -- in the absence of one, I guess we need an ifdef here. =20
> Or at least=20
> > put in a comment so anyone who adds a userspace use knows=20
> they need to=20
> > fix it.
>=20
> We could make up one in powerpc arch at least
>=20
> #define pte_user(val) ((val & _PAGE_USER) =3D=3D _PAGE_USER)
>=20

Looks good.=20

Ben and Scott,

But for the patched issue we're discussing we have to do #ifdef that as
my original modification. Right? Or do you have other suggestion? Then I
can improve that as v2.

Thanks
Tiejun=20

> would do
>=20
> Cheers,
> Ben.
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
