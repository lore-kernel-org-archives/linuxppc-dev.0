Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Add irq_free_host() to free an irq_host
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1210834512.8297.87.camel@pasglop>
References: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
	<1210834512.8297.87.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5RqiS7Yi2IsaA9MfXXRr"
Date: Thu, 15 May 2008 17:00:37 +1000
Message-Id: <1210834837.17568.21.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5RqiS7Yi2IsaA9MfXXRr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-05-14 at 23:55 -0700, Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-08 at 14:23 +1000, Michael Ellerman wrote:
> > +void irq_free_host(struct irq_host *host)
> > +{
> > +       /* If it's still very early in boot we can't free, oh well. */
> > +       if (mem_init_done)
> > +               kfree(host);
> > +}
>=20
> Hrm... that means that a host that was allocated before mem_init_done
> and freed later will call kfree on memory obtained from bootmem... no
> good.

God damn mem_init_done crap .. gah you're right.

> In which case do we need to free and irq host other than failure in
> irq_alloc_host ?

Well most code either doesn't check the return value, or panics. There's
two callers at the moment (after my patch) of irq_free_host(),
axon_msi.c and ipic.c - they both call free from the same function as
alloc so they're safe.

We could just do the free in irq_alloc_host()'s error path and have
irq_free_host() not actually free anything, just drop the reference
count. What a mess.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5RqiS7Yi2IsaA9MfXXRr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIK9+VdSjSd0sB4dIRAgDwAJ0erpPmvOz94pkFBk8PIV84TjRAtwCgtu7l
s/HSXsdRhtkyhEVwlpZOP2E=
=Ojqz
-----END PGP SIGNATURE-----

--=-5RqiS7Yi2IsaA9MfXXRr--
