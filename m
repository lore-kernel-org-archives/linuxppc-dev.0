Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CB30DDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 10:05:08 +1100 (EST)
Date: Tue, 23 Dec 2008 10:04:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: testing (Was: Re: linux-next: scsi-post-merge tree build failure)
Message-Id: <20081223100456.bb556b19.sfr@canb.auug.org.au>
In-Reply-To: <1229979392.4360.15.camel@pasglop>
References: <20081223012545.5b1e7f5e.sfr@canb.auug.org.au>
	<1229979392.4360.15.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__23_Dec_2008_10_04_56_+1100_alZ25LbOBXWMwSbX"
Cc: Blanchard <hollisb@us.ibm.com>, Hollis, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Dec_2008_10_04_56_+1100_alZ25LbOBXWMwSbX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Tue, 23 Dec 2008 07:56:32 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Tue, 2008-12-23 at 01:25 +1100, Stephen Rothwell wrote:
> > Hi Paul, Ben,
> >=20
> > Today's linux-next build (powerpc ppc44x_config) failed like this:
> >=20
> > arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_put':
> > arch/powerpc/kvm/powerpc.c:333: error: implicit declaration of function=
 '_tlbil_all'
> >=20
> > Probably caused by commit 2a4aca1144394653269720ffbb5a325a77abd5fa
> > ("powerpc/mm: Split low level tlb invalidate for nohash processors").
> > Reverting just that commit was too difficult, so I have reverted the
> > powerpc tree for today.
>=20
> You can't revert that without reverting my whole series.

I know that ... I tried.

> Adding a #include ../mm/mmu_decl.h to the kvm code should fix it for
> now.
>=20
> I need to talk to hollis about the right way to do that stuff in
> the long run but it might be it... those _tlbil things are low level
> stuff that aren't supposed to be used by the outside world which is
> why I moved the declarations there, but KVM is also low level :-)

So, why is this series in powerpc/next at all if some of the modified
files haven't even been compiled?  A simple ppc44x_defconfig build of the
powerpc/next tree fails - which I would have thought would be part of the
testing since KVM is only implemented for 44x on powerpc.

(Sorry, I am annoyed - it was late when I finally found this build
failure on top of everything else.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__23_Dec_2008_10_04_56_+1100_alZ25LbOBXWMwSbX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklQHRgACgkQjjKRsyhoI8wF8wCePvm7BJbBHjR/XFvEbAhSdHeE
3hYAnA6FQrFtA29+U+/2C3fRefdgxJ2r
=bM/H
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Dec_2008_10_04_56_+1100_alZ25LbOBXWMwSbX--
