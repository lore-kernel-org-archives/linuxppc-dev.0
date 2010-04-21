Return-Path: <michael@ellerman.id.au>
Subject: Re: Badness in xics_ipi_dispatch
From: Michael Ellerman <michael@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <4BCE27E8.4090101@linux.vnet.ibm.com>
References: <4BCE27E8.4090101@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1ZXDSTeykhMRvsibu4Sc"
Date: Wed, 21 Apr 2010 11:43:54 +1000
Message-ID: <1271814234.13262.36.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-1ZXDSTeykhMRvsibu4Sc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-20 at 17:17 -0500, Brian King wrote:
> In stress testing enabling and disabling of SMT, we are regularly
> seeing the badness warning below. Looking through the cpu offline
> path, this is what I see:
>=20
> 1. stop_cpu: IRQ's get disabled
> 2. pseries_cpu_disable: set cpu offline (no barriers after this)
> 3. xics_migrate_irqs_away: Remove ourselves from the GIQ, but still allow
>     IPIs
> 4. stop_cpu: IRQ's get enabled again (local_irq_enable)
>=20
> It looks to me like there is plenty of opportunity between 1 and 2 for
> an IPI to get queued, resulting in the badness below. Is there something
> in xics_migrate_irqs_away that should clear any pending IPIs? If there
> is, maybe the solution is as simple as adding a barrier after marking
> the cpu offline. Or is the warning bogus and we should just remove it?

It looks like xics_migrate_irqs_away() doesn't do anything about IPIs,
at least the comment says "Allow IPIs again". So I don't see what's to
stop you just taking another IPI after you reenable interrupts in
stop_cpu(). Maybe xics_ipi_dispatch() should just return if the cpu is
offline?

cheers

--=-1ZXDSTeykhMRvsibu4Sc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvOWFkACgkQdSjSd0sB4dI2owCfURP+MMZ5P4yF84rLZ0F1aU/L
QmkAoMx1Rj0xe4a3b2s2/7fvtwwRxntT
=oaIK
-----END PGP SIGNATURE-----

--=-1ZXDSTeykhMRvsibu4Sc--
