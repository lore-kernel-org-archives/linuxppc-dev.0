Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20070307045341.GG7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com> <20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jVM5s4y5HBCdHwnTYQ07"
Date: Wed, 07 Mar 2007 11:52:32 +0100
Message-Id: <1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jVM5s4y5HBCdHwnTYQ07
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-07 at 10:23 +0530, Mohan Kumar M wrote:
> On Tue, Mar 06, 2007 at 06:37:14PM +0100, Michael Ellerman wrote:
> > On Tue, 2007-03-06 at 22:25 +0530, Mohan Kumar M wrote:
> > > On Tue, Mar 06, 2007 at 03:16:55PM +0100, Michael Ellerman wrote:
> > > > First, I don't know why we keep telling people to use maxcpus=3D1 f=
or
> > > > kexec/kdump - it's causing bugs, and I don't know of any that it fi=
xes?
> > >=20
> > > Some distros want to use maxcpus=3D1 for kdump.
> >=20
> > Yeah OK.
> >=20
> > > > Second, the way you've written this is not so good. The xics code s=
hould
> > > > not be checking that "maxcpus" exists on the command line, it shoul=
d be
> > > > checking that the distrib server points to a cpu that is online - u=
sing
> > > > cpu_online() etc.
> > > >
> > >=20
> > > In get_irq_server function in xics.c, "noirqdistrib" command line
> > > parameter is indirectly checked for routing the interrupts either to =
a
> > > specific cpu or to all cpus. So I think checking for maxcpus=3D comma=
nd
> > > line parameter in xics.c is not a problem.
> >=20
> > No, it checks a flag, it doesn't run strstr on the saved command line.
> >
> What if I use a flag (or existing global variable if any) to check for
> the presence of maxcpus kernel paramter?

There's already maxcpus in init/main.c, that would probably be better,
though still ugly.

> > > Also during the xics_init_IRQ function other cpus (secondary cpus) wi=
ll
> > > not be online, they are made online at a later stage. So using
> > > cpu_online() function at xics_init_IRQ will return true only for boot
> > > cpu id.
> >=20
> > OK, so you should be able to use cpus possible map or something similar=
.
> >
> Hmm, I think cpus possible map will have an entry for the offline cpu
> also.

You're right, it will, did I mention that maxcpus=3D is broken :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jVM5s4y5HBCdHwnTYQ07
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF7plwdSjSd0sB4dIRAhidAJ0fodEx0rXo4T1k2gKC1Np2GAQT5wCfUPqi
VTDIlnQmlXZhP4vqEZ4kNYw=
=4r62
-----END PGP SIGNATURE-----

--=-jVM5s4y5HBCdHwnTYQ07--
