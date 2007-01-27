Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1ay2rVGbGUQqAIT+f9PA"
Date: Sat, 27 Jan 2007 16:41:44 +1100
Message-Id: <1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
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


--=-1ay2rVGbGUQqAIT+f9PA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 23:18 -0700, Eric W. Biederman wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> > OK, here's a first cut at moving ops based MSI into the generic code. I=
'm
> > posting this now to make sure I'm not heading off into the weeds.
>=20
> First thanks for copying me on this.  I really appreciate it.

No worries, thanks for looking at it.

> I haven't done more than skim the patches yet but I am distressed.
>=20
> You code appears to be nice simple clean and to not support MSI in
> a useful way.  I may be reading too quickly but at the moment your infras=
tructure
> appears useless if you are on a platform that doesn't enforce MSI's get f=
iltered
> with a legacy interrupt controller.

That's what PowerPC does, but I don't think there's anything in the top
level interface that requires that - it's all up to the alloc routine.

> You don't have MSI-X support (which is the interesting case) and you don'=
t have
> suspend/resume support.

We have MSI-X support on RTAS ;), but that's cheating. I have 90% of
what I need for MSI-X, but I haven't implemented it yet, I will as part
of the port of the Intel code.

> You don't support the MSI mask bit.

IMHO that's a backend detail.

> Looking at your msi_ops it does not map to what I am doing on x86.  There
> is the implicit assumption that the msi_message is fixed for the lifetime
> of the msi.  Which is wrong.

Again, that's how PowerPC does it, but I don't think it's assumed. If
your backend needs to change the message then we can support that
reasonably easily I think.

> So in short summary I cannot use your msi_ops they are inappropriate for
> i386, x86_64 and ia64.
>=20
> So at the moment I am opposed to this code because as it sits it appears =
to
> be a serious regression.
>=20
> The additional bits that feel like this code was primarily targeted at su=
pporting
> the RTAS with real hardware support thrown in as an after thought just se=
em
> to add insult to injury.  To date I have no information that indicates to=
 me
> that the RTAS model is at all sane or makes any sense to duplicate elsewh=
ere.
> If supporting the RTAS is what is obscuring your vision of what is really
> needed to support MSI I don't want to see RTAS support in a patch set
> until we get a good multiple platform architecture, merged into the kerne=
l.
>=20
> Supporting the RTAS first and breaking everyone who actually has real
> hardware seems like very much the wrong approach to get a good
> multiple platform solution.

I agree. We didn't design it to be a multi platform solution, we
designed it to work for us. It does that. Now we're hoping to expand it
to work for the Intel case as well.

I guess I wasn't clear enough in my original post, but I fully expect
that I'll need to tweak parts of the core to make Intel fit. That's
still a work in progress.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1ay2rVGbGUQqAIT+f9PA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuuYYdSjSd0sB4dIRAnXfAJ4yxxeMFzdKGl1OkFV/A/UXhhtniACfQmuv
6vAGY86uqJXe/QDJiFRBV0g=
=58tj
-----END PGP SIGNATURE-----

--=-1ay2rVGbGUQqAIT+f9PA--
