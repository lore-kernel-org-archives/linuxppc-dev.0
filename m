Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1185228277.5439.141.camel@localhost.localdomain>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Hi4ace7OMXPQJrQ4oDEh"
Date: Tue, 24 Jul 2007 09:22:54 +1000
Message-Id: <1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Hi4ace7OMXPQJrQ4oDEh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-07-24 at 08:04 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-07-23 at 19:13 +0800, Chen Gong wrote:
> > This patch adds a new member 'name' for irq host's name to
> > structure irq_host and modifies the definition of the
> > function irq_alloc_host(). The assignment to the
> > irq host's name is also added to irq_alloc_host().
>=20
> I would instead prefer adding a irq_name callback to host, which would
> return a per-irq name. In some cases, they could return the OF path to
> the host for example.

The pity is, for the 75% [1] of irq_hosts that have a device_node, they
will all have to implement the name callback, because they all store the
of node differently.

Which makes me think (again) that we should have an optional device_node
pointer in irq_host. I know you said you wanted the irq stuff to be OF
agnostic, but the reality is most of the implementations do have an OF
node. And all of the newer irq_host implementations do, with the
exception of PS3 and celleb - which are special.

cheers

[1] Yes I counted :)

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Hi4ace7OMXPQJrQ4oDEh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGpThOdSjSd0sB4dIRAt7wAKCgFaVr/NbIEB+n7DQWzFOJDpY46gCbBtSF
ynaVS6PVZtO/vZrb9KV5/aU=
=/hpL
-----END PGP SIGNATURE-----

--=-Hi4ace7OMXPQJrQ4oDEh--
