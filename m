Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/7] powerpc numa: Consolidate assignment of cpus to nodes
Date: Wed, 22 Mar 2006 10:34:58 +1100
References: <11429014352189-git-send-email-nathanl@austin.ibm.com>
	<200603221009.19523.michael@ellerman.id.au>
	<1142983379.28864.9.camel@pants.austin.ibm.com>
In-Reply-To: <1142983379.28864.9.camel@pants.austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2288532.pD9kv6q5J2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603221035.04438.michael@ellerman.id.au>
Cc: Nathan Lynch <nathanl@austin.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2288532.pD9kv6q5J2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 22 Mar 2006 10:22, Nathan Lynch wrote:
> On Wed, 2006-03-22 at 10:09 +1100, Michael Ellerman wrote:
> > On Wed, 22 Mar 2006 06:16, Nathan Lynch wrote:
> > > On Tue, 2006-03-21 at 10:38 -0800, Dave Hansen wrote:
> > > > By the way, what do the "l" and "h" in front of "cpu" mean anyway?
> > >
> > > "logical" and "hot"?  I dunno, just seemed to be the convention in
> > > other cpu notifiers at the time the code was written.
> >
> > Ouch, that's unfortunate. In the powerpc code hcpu _usually_ means hard
> > cpu number, as opposed to logical (lcpu).
>
> Grep begs to differ:
>
> $ grep -rw hcpu arch/powerpc include/asm-powerpc
> arch/powerpc/kernel/sysfs.c:                                  unsigned lo=
ng
> action, void *hcpu) arch/powerpc/kernel/sysfs.c:    unsigned int cpu =3D
> (unsigned int)(long)hcpu; arch/powerpc/mm/numa.c:                      vo=
id
> *hcpu)
> arch/powerpc/mm/numa.c: unsigned long lcpu =3D (unsigned long)hcpu;

You're right, it's actually a mixture of pcpu, hw_cpuid, hardid etc. So the=
re=20
should be no confusion by using hcpu for "hot" cpu.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart2288532.pD9kv6q5J2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEII2odSjSd0sB4dIRArVeAJ4pHIPFpajHSRZytTYCLOro99xHQQCghCl/
mK4CX4IMlYxgTq8Ttz1GZS4=
=p7do
-----END PGP SIGNATURE-----

--nextPart2288532.pD9kv6q5J2--
