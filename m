Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCmqp2z5szDrBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 10:13:42 +1100 (AEDT)
Date: Fri, 13 Oct 2017 09:20:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20171012222023.GC28032@umbus.fritz.box>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <87wp40txl1.fsf@concordia.ellerman.id.au>
 <20171012145157.1879b34f@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
In-Reply-To: <20171012145157.1879b34f@bahia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 02:51:57PM +0200, Greg Kurz wrote:
> On Thu, 12 Oct 2017 22:27:54 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
> > Greg Kurz <groug@kaod.org> writes:
> > > The following program causes a kernel oops:
> > >
> > > #include <sys/types.h>
> > > #include <sys/stat.h>
> > > #include <fcntl.h>
> > > #include <sys/ioctl.h>
> > > #include <linux/kvm.h>
> > >
> > > main()
> > > {
> > >     int fd =3D open("/dev/kvm", O_RDWR);
> > >     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
> > > }
> > >
> > > This happens because when using the global KVM fd with
> > > KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
> > > called with a NULL kvm argument, which gets dereferenced
> > > in is_kvmppc_hv_enabled(). Spotted while reading the code.
> > >
> > > Let's use the hv_enabled fallback variable, like everywhere
> > > else in this function.
> > >
> > > Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
> > > Cc: stable@vger.kernel.org # v4.7+
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  arch/powerpc/kvm/powerpc.c |    3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
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
> > >  		r =3D 0; =20
> >=20
> > Did this go anywhere?
> >=20
> > cheers
>=20
> I'm afraid not... and I haven't tried to ping Paul yet, since he's
> supposed to be on vacation from what I've been told.

He's back now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnf6qQACgkQbDjKyiDZ
s5LEhw/+NUsKfqWdPjNvEyczlMLYPazDcP+EJMomMaxZ1ZOLaw0MvqTw8JBZTg7R
hwxKfQHLSgy4bXCeHKLGeWe8mgmKtrpCnc2V/iLtzjAKD5jPVQfBS3vICgi27soT
iXRonACNK1QUGxzlNWUguB9LUBqROuABdi9iem8HmMJU4WfowB6DtXfZl1LqkvG+
ycJkzewJiRk69xMhxzZu9EgPrba3D560Sju3kGVjzOQnhIVjQy47rqMMXjBjoGP6
2f8w6E2iXDMFITivXjoHr7gCTKiZVekZ109NttFhgysTEm55PPOuhvq9iDDuTxkJ
gT7MBciM1NP/wEfgQosOpdPh9yBBKsy64HDmRk71adF8hAXopwtM+UmJUGfl5stn
PAr5Wx0OjJKr00M6UqYdgV0CbDcVNduno98bi23bwHFzSAzK84YZKW98u75I+kWx
dP7/LkiuCGM2DonVNkoW0HUaFesWVH0Q1GfQPEcB4yZoT7z80qPV25fYNyZgtuvS
t/q2KxAISWoKFO+p1fD1a0NyH4HH+U36/FRfXL9bnnCc3uIwmPxgdg3P6XqiCLW7
EE8B+2A+g7mFvBRhI6i0hj4pEB5ukSnM5QqRqgRt0JhuDvY8/8Fksg/YqdvxQkq7
Os+wkppAOJvmgePBvqoDV4T1Kb7kQEvU/OVgyUQ8Us+mmdsOpGM=
=W3VZ
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
