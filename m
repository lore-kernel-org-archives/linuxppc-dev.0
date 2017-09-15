Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xw1NG4j5TzDrbD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 17:43:42 +1000 (AEST)
Date: Fri, 15 Sep 2017 18:59:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20170915085937.GO5250@umbus.fritz.box>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <20170915004839.GA5250@umbus.fritz.box>
 <20170915075249.0e9879a4@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
In-Reply-To: <20170915075249.0e9879a4@bahia.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 07:52:49AM +0200, Greg Kurz wrote:
> Dang! The mail relay at OVH has blacklisted Paul's address :-\
>=20
> <paulus@samba.org>: host smtp.samba.org[144.76.82.148] said: 550-blacklis=
ted at
>     zen.spamhaus.org 550 https://www.spamhaus.org/sbl/query/SBL370982 (in=
 reply
>     to RCPT TO command)
>=20
> Cc'ing Paul at ozlabs.org
>=20
> On Fri, 15 Sep 2017 10:48:39 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Sep 14, 2017 at 11:56:25PM +0200, Greg Kurz wrote:
> > > The following program causes a kernel oops:
> > >=20
> > > #include <sys/types.h>
> > > #include <sys/stat.h>
> > > #include <fcntl.h>
> > > #include <sys/ioctl.h>
> > > #include <linux/kvm.h>
> > >=20
> > > main()
> > > {
> > >     int fd =3D open("/dev/kvm", O_RDWR);
> > >     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
> > > }
> > >=20
> > > This happens because when using the global KVM fd with
> > > KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
> > > called with a NULL kvm argument, which gets dereferenced
> > > in is_kvmppc_hv_enabled(). Spotted while reading the code.
> > >=20
> > > Let's use the hv_enabled fallback variable, like everywhere
> > > else in this function.
> > >=20
> > > Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
> > > Cc: stable@vger.kernel.org # v4.7+
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > I don't think this is right.  I'm pretty sure you want to fall back to
> > hv_enabled *only when* kvm is NULL.  Otherwise if you have a PR guest
> > on an HV capable machine, this will give the wrong answer, when called
> > for that specific VM.
> >=20
>=20
> Hmmm... this is what we get with this patch applied:
>=20
> open("/dev/kvm", O_RDWR)                =3D 3
> ioctl(3, KVM_CHECK_EXTENSION, 0x84)     =3D 1 <=3D=3D if HV is present
> ioctl(3, KVM_CREATE_VM, 0x1)            =3D 4 <=3D=3D HV
> ioctl(4, KVM_CHECK_EXTENSION, 0x84)     =3D 1
> ioctl(3, KVM_CREATE_VM, 0x2)            =3D 5 <=3D=3D PR
> ioctl(5, KVM_CHECK_EXTENSION, 0x84)     =3D 0
>=20
> The hv_enabled variable is set as follows:
>=20
> 	/* Assume we're using HV mode when the HV module is loaded */
> 	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;
>=20
> 	if (kvm) {
> 		/*
> 		 * Hooray - we know which VM type we're running on. Depend on
> 		 * that rather than the guess above.
> 		 */
> 		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
> 	}
>=20
> so we're good. :)

Oh, sorry, missed that bit.  In that case.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>



> The last sentence in the commit message is maybe^wprobably not comprehens=
ive
> enough...
>=20
> What about the following ?
>=20
> The hv_enabled variable is initialized to 1 if HV is loaded or 0 otherwis=
e.
> In the case KVM_CHECK_EXTENSION is used with a VM fd, hv_enabled is updat=
ed
> to is_kvmppc_hv_enabled(kvm). Let's use it here, like everywhere else in =
this
> function.
>=20
> > > ---
> > >  arch/powerpc/kvm/powerpc.c |    3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > > index 3480faaf1ef8..ee279c7f4802 100644
> > > --- a/arch/powerpc/kvm/powerpc.c
> > > +++ b/arch/powerpc/kvm/powerpc.c
> > > @@ -644,8 +644,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,=
 long ext)
> > >  		break;
> > >  #endif
> > >  	case KVM_CAP_PPC_HTM:
> > > -		r =3D cpu_has_feature(CPU_FTR_TM_COMP) &&
> > > -		    is_kvmppc_hv_enabled(kvm);
> > > +		r =3D cpu_has_feature(CPU_FTR_TM_COMP) && hv_enabled;
> > >  		break;
> > >  	default:
> > >  		r =3D 0;
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7lnkACgkQbDjKyiDZ
s5IvmhAAqMkY232v9BkO3XCwKDUrTiCWURnw5hAH96/SVtZYdm6rh4KdzyA99m/n
stJhzxFHRrU1qWPL9Jf4b3AhrSWyGo+4mVmwefXG783ef3auXhge/1hMzCAK8214
c3Vf4jY7VeRG4ZJ0u1l9TmJ+rHdL9+beXMqk9+CQww6g5Y0VIHUPzSRBKPQN3viq
zGLhrfjdNkE0p/6lDbvLRikRDRZA83SHJFTemIeftG5tRTYYjoqhYTH0+IV8ZWIA
doAZPmtQnnutmg+WN1euIoSVifnkMlWd5h2VJsW0MOzP8OIogTpfP4Bd8jYLGmjL
tE1psssfn3bLxRq0Z1MVe462MmRPfjIxiT+5rEuhddpKutFa9iM//kd8XrgC2bMQ
iU1lB2SvoJcP2Om2cd8amx0mp4eL7l6MMyH0rAsGfoZs2+jalp8irXVODivAsjOA
ZA+xNngpUA8YPcvpTNSrEcoDOrffrpNjpSlr2AsSr6sJLhBuLXzCbJeV0yINeeAt
dD+KXmyyAJKeKx2UFlgXPlLFakKnrkLQpGUOK9LzpFhG63fOOuFyFAtx4UU0qilg
xYwEIuZFyRhI94JrAGUOX2T5ZlcTv090T/9zfQSopV90scsiCYmzvpb7w3wPqX5L
aOIxPNGuXBD76GSyM1rNe1vQStYk0ewH8tg/dOozEcgndiEUY2A=
=5LV8
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--
