Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
	<m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
	<1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
	<m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
	<1170015292.26655.6.camel@localhost.localdomain>
	<m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
	<1170019048.26655.27.camel@localhost.localdomain>
	<m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
	<1170026259.26655.114.camel@localhost.localdomain>
	<m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TS2Zh4VQlWZNVr2rTRLy"
Date: Mon, 29 Jan 2007 11:59:03 +1100
Message-Id: <1170032343.19887.41.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>,
	Greg Kroah-Hartman <greg@kroah.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-TS2Zh4VQlWZNVr2rTRLy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-01-28 at 16:38 -0700, Eric W. Biederman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>=20
> >> Because it mixes concerns that do not need to be mixed, and it complic=
ates
> >> the code.  The hypervisor has no need to understand how a hardware
> >> device is built, and how it's registers operate.  It just needs to
> >> know that the given hardware device will generate an msi message on
> >> the bus.
> >
> > I'd be happy for you to go explain your view of what an hypervisor
> > should or should not do to IBM HV architects :-)=20
>=20
> Sure think you can setup a meeting, or give me an email introduction to t=
hem.
>=20
> > But in the meantime,
> > that's how they have defined it and how it's been implemented and how w=
e
> > have to support it. And I have a strong feeling that they won't be the
> > only ones to do it that way (I'd like to be proven wrong tho).
>=20
> No the general linux kernel does not have to support it, and if we don't
> I suspect that message would get back fairly clearly to the IBM HV archit=
ects.

OT, but: No, it wouldn't. It would just play into the hands of people
who think Linux is immature, unpredictable and risky. IBM has another
UNIX remember.

> I haven't been watching closely but I haven heard any rumors on the x86
> side that they are looking in that direction.
>=20
> >> Right, so some way needs to be found to cope with that situation.
> >> Likely that involves bypassing all of the code that talks directly to
> >> the hardware for MSI.
> >
> > Which can be done by having the alloc() and free() hooks do all the wor=
k
> > provide they aren't done per-msi but per-call like in Michael's
> > approach. That is, in the MSI-X case, alloc is called once for all of
> > the MSI-X requested.
> >
> > I understand that this conflicts with your idea of requesting new MSI-X
> > on the fly but I don't think that trying to add/remove MSI-X that way i=
s
> > a sane approach anyway. If you are concerned about HW problems, I think
> > by doing so, you'll indeed hit them hard.
>=20
> That isn't even the reason it is that way.  It is because allocating
> 4096 irqs in a single vector is a bad idea, and because it requires you
> to pass type information of what kind of msi you are dealing with to the
> lower levels in an allocation routine that make it bad idea.  Because
> if you don't consider the IBM HV it provides not benefit and just puts
> unnecessary loops, and type information in architecture code.

I'm not sure what the issue with 4096 irqs is.

As far as passing type information to the alloc routine, it's only there
_if_ the alloc routine needs it.

If you'd prefer we could not pass the type explicitly to the alloc
routine, but rather just have it sitting in the msi_info ... which is
exactly what the current code does, the type is stored in the msi_desc.

What we could do is move the msi_msg into the msix_entry struct, then we
could do alloc like below and remove the need for setup_msi_msg:

int arch_setup_msi_irqs(struct pci_dev *pdev, int num,
                       struct msix_entry *entries)
{
        int i;

        for (i =3D 0; i < num; i++) {
       		int irq, ret;
       		irq =3D create_irq();
       		if (irq < 0)
               		return irq;

       		set_irq_msi(irq, desc);
       		ret =3D msi_compose_msg(dev, irq, &entries[i].msg);
       		if (ret < 0) {
               		destroy_irq(irq);
               		return ret;
       		}

                entries[i].vector =3D irq;

       		set_irq_chip_and_handler_name(irq, &msi_chip, handle_edge_irq, "ed=
ge");
        }
}

Which is almost exactly the same as the current code, except it's inside
a for loop - and it saves the msg and vector to be written later by the
enable hook - which will basically be write_msi_msg() in a loop.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-TS2Zh4VQlWZNVr2rTRLy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvUbXdSjSd0sB4dIRAh4TAJ4y0l2sA7OCbBnGZ/5fJhXehee+tACcCiI0
hkjoO5eGkPWPWu2P7zRQYEc=
=oD7U
-----END PGP SIGNATURE-----

--=-TS2Zh4VQlWZNVr2rTRLy--
