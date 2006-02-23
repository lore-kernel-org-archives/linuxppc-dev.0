Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: parsing of some early cmdline options
Date: Fri, 24 Feb 2006 10:40:50 +1100
References: <Pine.LNX.4.44.0602231658210.16092-100000@gate.crashing.org>
	<1140736753.8264.55.camel@localhost.localdomain>
In-Reply-To: <1140736753.8264.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13124548.YxcArkY8J3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200602241040.54060.michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart13124548.YxcArkY8J3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 24 Feb 2006 10:19, Benjamin Herrenschmidt wrote:
> On Thu, 2006-02-23 at 17:02 -0600, Kumar Gala wrote:
> > Guys,
> >
> > I noticed that we have code in arch/powerpc/kernel/prom_init.c to handle
> > parsing iommu=3D, mem=3D, and crashkernel=3D.
> >
> > The problem I have is that we only use/build prom_init.c on MULTIPLATFO=
RM
> > (coming from true OF).

> > Any ideas on how to handle this for the !MULTIPLATFORM cases.  I'm most
> > concerned about mem=3D.

mem=3D is a bit tricky because you need to know about it really early, othe=
rwise=20
your bootloader might violate the limit. But we could certainly check for i=
t=20
again in prom.c. And you can always just set /chosen/linux,memory-limit.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart13124548.YxcArkY8J3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/kgGdSjSd0sB4dIRAsbHAJwMm3XiD0XPr2LtVvbw8HEAPd1d3ACgpu1s
AePAhfIvr+8KnKsBKkd+oWk=
=OCzW
-----END PGP SIGNATURE-----

--nextPart13124548.YxcArkY8J3--
