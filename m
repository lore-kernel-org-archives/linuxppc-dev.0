Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 668ECDDF08
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 03:04:30 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/7] powerpc: allow localbus compatible serial ports for
	console device
Date: Mon, 7 Jan 2008 17:04:22 +0100
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<200801071533.47018.arnd@arndb.de> <47824641.8090208@windriver.com>
In-Reply-To: <47824641.8090208@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801071704.23151.arnd@arndb.de>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 January 2008, Paul Gortmaker wrote:
>=20
> I'd thought about doing that, but there are slight differences
> in each test. =A0To remain 100% faithful to the original implementation
> you'd have to have a table or similar that had these various fields
> and loop over that -- something like:
>=20
> compat =A0 =A0 =A0parent =A0 pnt-compat =A0pnt-type =A0 add-fcn
> ---------------------------------------------------------------
> ns16550 =A0 =A0 NULL =A0 =A0 NULL =A0 =A0 =A0 =A0soc =A0 =A0 =A0 =A0add_l=
egacy_soc_port
> NULL =A0 =A0 =A0 =A0isa =A0 =A0 =A0NULL =A0 =A0 =A0 =A0NULL =A0 =A0 =A0 a=
dd_legacy_isa_port
> ns16550 =A0 =A0 NULL =A0 =A0 NULL =A0 =A0 =A0 =A0tsi-bridge add_legacy_so=
c_port
> ns16550 =A0 =A0 NULL =A0 =A0 ibm,opb =A0 =A0 opb =A0 =A0 =A0 =A0add_legac=
y_soc_port
> ns16550 =A0 =A0 NULL =A0 =A0 localbus =A0 =A0NULL =A0 =A0 =A0 add_legacy_=
soc_port
>=20
> But, if we were willing to move away from checks based on
> the parent->type and stick with parent->compat, then the
> unification would be a lot cleaner and easier to implement.

Unfortunately, some of our cell blades don't have the right
'compatible' property, so you still need to check the type for
the opb case.

> (we could also leave the ISA one out as an oddball, and then
> not have to carry an add-fcn either).

yes, that seems reasonable.

	Arnd <><
