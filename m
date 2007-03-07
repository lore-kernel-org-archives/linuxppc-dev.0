Return-Path: <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] Fix interrupt distribution in ppc970
From: Michael Ellerman <michael@ellerman.id.au>
To: vgoyal@in.ibm.com
In-Reply-To: <20070307060623.GA5469@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com> <20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070307060623.GA5469@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2kP/jPIIx/cxkNsN4qd9"
Date: Wed, 07 Mar 2007 11:46:31 +0100
Message-Id: <1173264391.5101.44.camel@concordia.ozlabs.ibm.com>
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


--=-2kP/jPIIx/cxkNsN4qd9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-07 at 11:36 +0530, Vivek Goyal wrote:
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
> >=20
>=20
> Logically speaking, there is no need to bring up all the cpus in the
> system to capture the dump. A single cpu can do the job, may be in
> relatively lesser memory. Just because we see bugs with maxcpus=3D1, does
> not mean we should try to bring up all the cpus in second kernel. I think
> we should try to clean maxcpus=3D1 path instead.

Sure it'd be nice. But in reality I think the memory reductions are
miniscule, it's still an SMP kernel, it still allocates per-cpu data for
every cpu, they're still spinning. The only thing that maxcpus does is
not bring them online ... and cause lots of bugs.

But the distros have made the call, so I'll just shutup now :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2kP/jPIIx/cxkNsN4qd9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF7pgHdSjSd0sB4dIRAlc4AJwNlLsbtAuiEYILsVLQmzSq7UEnywCgychi
JWF5hKKz57Er7lZSUJY1JtM=
=QR+e
-----END PGP SIGNATURE-----

--=-2kP/jPIIx/cxkNsN4qd9--
