Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
	<m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AI/47MCA4d7zbDWJGkkc"
Date: Sun, 28 Jan 2007 19:12:43 +1100
Message-Id: <1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-AI/47MCA4d7zbDWJGkkc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-01-27 at 23:16 -0700, Eric W. Biederman wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> > I guess I wasn't clear enough in my original post, but I fully expect
> > that I'll need to tweak parts of the core to make Intel fit. That's
> > still a work in progress.
>=20
> Ok.  To be very clear.
>=20
> Any plan that does not involve using drivers/pci/msi.c for the
> raw hardware operations is flawed.  Yes that code is a mess
> but it works today, and appears to capture all of the requirements.
> Where there are issues that code should be fixed not ignored.

Which is what I plan to do. I already have a patch which turns the
current code into a backend for my code, its ugly as hell, it maintains
msi_info and the msi_descs which is stupid, but it seems to work.

We should probably just stop talking until I've got that series worked
out and posted, and then you can tell me what you think of it :)

> The architecture specific bits of the current msi code roughly
> correspond to your alloc and free routines.  All that is
> needed going from generic code to architecture specific code
> is the ability to allocate and free an msi irq.  You have
> a lot more operations than that and it is overkill.

Except you keep ignoring the hypervisor case, which we have to support.
I realise you'd rather not think about it, sure it's ugly, but that's
our reality. We could isolate all of that in arch/powerpc, but Greg has
said he doesn't want two implementations, and I think in the long term
that's the right approach - we should be able to come up with a common
implementation.

> As a practical measure you current operations are such a bad fit
> for the architectures a port would be very difficult.  Basically
> setup_msi_message is simply a bad idea.  You need to use a
> write_msi_message call from the architecture to the generic code
> instead.

i386's msi_compose_msg() would just become setup_msi_message(), the
setup of the irq chip etc. would go in alloc. For irq affinity, for now
we'll just keep exporting read/write_msi_msg(). But I don't see what the
fundamental problem is.

> I have some patches cooking to cleanup msi.c so it can be used
> as is.  I'm pretty much their but it looks like I need to slay
> msi_lock to make things sane.

If you can post them soon that would be good. I'm already heavily
hacking the intel code to work as a backend for me so anything you do
will conflict with that work.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-AI/47MCA4d7zbDWJGkkc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvFr7dSjSd0sB4dIRAhqMAKCEytkjqNxiuA6FRqjHfzcLLeNdFACgiHk8
vwXpIuC2CfBqvB/IdE638Xw=
=mugL
-----END PGP SIGNATURE-----

--=-AI/47MCA4d7zbDWJGkkc--
