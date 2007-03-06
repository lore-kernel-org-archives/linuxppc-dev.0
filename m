Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20070306165529.GD7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com> <20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-20u2ivDuHhEYp/tqVqpB"
Date: Tue, 06 Mar 2007 18:37:14 +0100
Message-Id: <1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
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


--=-20u2ivDuHhEYp/tqVqpB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-06 at 22:25 +0530, Mohan Kumar M wrote:
> On Tue, Mar 06, 2007 at 03:16:55PM +0100, Michael Ellerman wrote:
> > On Tue, 2007-03-06 at 19:27 +0530, Mohan Kumar M wrote:
> > > Hi,
> > >=20
> > > Here comes the revised version of patch to fix the interrupt missing
> > > problem when a kdump kernel is booted with "maxcpus=3D1" kernel param=
eter.
> > >=20
> > > In the xics initialization code a check is made to detemine whether
> > > maxcpus kernel parameter is present and if its present then
> > > default_distrib_server variable is initialized to the current boot cp=
u
> > > id (by default_server variable). So that when ever a kernel is booted
> > > with maxcpus kernel parameter all interrupts are routed to the boot c=
pu
> > > only.
> > >=20
> > > Tested on POWER5 and JS20 systems.
> >=20
> > First, I don't know why we keep telling people to use maxcpus=3D1 for
> > kexec/kdump - it's causing bugs, and I don't know of any that it fixes?
>=20
> Some distros want to use maxcpus=3D1 for kdump.

Yeah OK.

> > Second, the way you've written this is not so good. The xics code shoul=
d
> > not be checking that "maxcpus" exists on the command line, it should be
> > checking that the distrib server points to a cpu that is online - using
> > cpu_online() etc.
> >
>=20
> In get_irq_server function in xics.c, "noirqdistrib" command line
> parameter is indirectly checked for routing the interrupts either to a
> specific cpu or to all cpus. So I think checking for maxcpus=3D command
> line parameter in xics.c is not a problem.

No, it checks a flag, it doesn't run strstr on the saved command line.

> Also during the xics_init_IRQ function other cpus (secondary cpus) will
> not be online, they are made online at a later stage. So using
> cpu_online() function at xics_init_IRQ will return true only for boot
> cpu id.

OK, so you should be able to use cpus possible map or something similar.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-20u2ivDuHhEYp/tqVqpB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF7abKdSjSd0sB4dIRApAfAKC882It0VxCc9GwXQ5YpH7YqNIONQCeMtfS
YVGSSA9qZAFbMFAhka3xX0Q=
=Hrdl
-----END PGP SIGNATURE-----

--=-20u2ivDuHhEYp/tqVqpB--
