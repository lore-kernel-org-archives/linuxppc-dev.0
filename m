Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5DXC4qj3zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 18:37:31 +1100 (AEDT)
Date: Mon, 2 Oct 2017 17:57:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org, pbonzini@redhat.com
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: Fix server always zero from
 kvmppc_xive_get_xive()
Message-ID: <20171002065745.GA2755@umbus.fritz.box>
References: <4585437e86d14900985c7e16bfd4afef672b26c7.1506408341.git.sam.bobroff@au1.ibm.com>
 <20170928014505.GW12504@umbus>
 <1506586033.25626.9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <1506586033.25626.9.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 10:07:13AM +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2017-09-28 at 11:45 +1000, David Gibson wrote:
> > On Tue, Sep 26, 2017 at 04:47:04PM +1000, Sam Bobroff wrote:
> > > In KVM's XICS-on-XIVE emulation, kvmppc_xive_get_xive() returns the
> > > value of state->guest_server as "server". However, this value is not
> > > set by it's counterpart kvmppc_xive_set_xive(). When the guest uses
> > > this interface to migrate interrupts away from a CPU that is going
> > > offline, it sees all interrupts as belonging to CPU 0, so they are
> > > left assigned to (now) offline CPUs.
> > >=20
> > > This patch removes the guest_server field from the state, and returns
> > > act_server in it's place (that is, the CPU actually handling the
> > > interrupt, which may differ from the one requested).
> > >=20
> > > Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE
> > > interrupt controller")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > > ---
> > > The other obvious way to patch this would be to set state->guest_serv=
er in
> > > kvmppc_xive_set_xive() and that does also work because act_server is =
usually
> > > equal to guest_server.
> > >=20
> > > However, in the cases where guest_server differed from act_server, th=
e guest
> > > would only move IRQs correctly if it got act_server (the CPU actually=
 handling
> > > the interrupt) here. So, that approach seemed better.
> >=20
> > Paolo, again this is a pretty urgent fix for KVM on Power and Paulus
> > is away.  We're hoping BenH will ack shortly (he's the logical
> > technical reviewer), after which can you merge this direct into the
> > KVM staging tree?  (RHBZ 1477391, and we suspect several more are
> > related).
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> As a subsequent cleanup we should probably rename act_server to server.
>=20
> Note: We know of a remaining theorical race that isn't fixed yet with
> CPU unplug. If an interrupt is already in the queue of the CPU calling
> xics_migrate_irqs_away (guest), then that irq never gets pulled out of
> that queue and thus the bug this patch is fixing will re-occur.
>=20
> Fix isn't trivial, I'm working on it, though I'm tempted to make some
> assumptions about how linux does things to keep it (much) simpler.
>=20
> I'll elaborate later (at Kernel Recipes right now)

Paolo,

Here's BenH's ack.  Again, this is a pretty important fix for us, and
Paulus is away.  Can you take this into the KVM tree please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnR42kACgkQbDjKyiDZ
s5L3UA//VJyvEboL3ZRlu1pArUqLQlYOnW+mpvy7DM7lsllQy+8Q2zL2SScV9KIi
ZOH5x8yto0PYvZ+z3MHzQ+/IRqjwFQ2ZEfGxYUCiMEkF64ayUh7u2Adou0ZRqeBZ
WP88GiZF3Ab+vQkOjsXsJMXmFWBGWxMezvMtZJ8SPNVnSCnvGyGYXWM/Dxe3gMlg
byw78DvrWxv2Ob3ZwBkfl4f0fuFvaDbKcN04+6qnZSDIPhW4cvpeW/+Qxf2WgLd7
314xoj962HSCewaVq2tLhTXkdPQQmi/mMcgZiKcZCeB8VEIVND1/oJC1rhJs5NfU
+FfSPpijl3oPilO7bdsmHKyKlQfMq5OExw0gWo4ANUSn3HU8nZvqdKMHljZ8PZk2
AeK+URJAebkSp+NCGihyOUNbBlZNZKdYyPjjefHl7GyFFhhx4Cyt3vwOCKbD9l/E
ltitq9LtDRTG4mEdOIaJ18evOYIU2xw4bP+sPskLqpwLn3fX25jiKnABqEqA7sWo
VgvNod++rghyFbBEKykSUHIdu6VB1FWvqD+hPTzTh00127RixeH6yR5lD2c1H8uS
Jwx0AJ3B1+2IGyRbz4UEmNI6eEdcjBCw7VtVqq/861YKc97gFeOedeua28ohwwM1
5P/VG8AprXpxI5kGCsIvZxYK5qb65Isc20DikyLUwvaSjVutK9g=
=SIsJ
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
