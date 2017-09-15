Return-Path: <groug@kaod.org>
Received: from 4.mo2.mail-out.ovh.net (4.mo2.mail-out.ovh.net [87.98.172.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtl1X0w0vzDrXS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 15:53:02 +1000 (AEST)
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0E4A0ABE1C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 07:52:58 +0200 (CEST)
Date: Fri, 15 Sep 2017 07:52:49 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, Paul Mackerras
 <paulus@ozlabs.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20170915075249.0e9879a4@bahia.lan>
In-Reply-To: <20170915004839.GA5250@umbus.fritz.box>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <20170915004839.GA5250@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/2v=IlCQP/zUiszbsYapkfca"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/2v=IlCQP/zUiszbsYapkfca
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dang! The mail relay at OVH has blacklisted Paul's address :-\

<paulus@samba.org>: host smtp.samba.org[144.76.82.148] said: 550-blackliste=
d at
    zen.spamhaus.org 550 https://www.spamhaus.org/sbl/query/SBL370982 (in r=
eply
    to RCPT TO command)

Cc'ing Paul at ozlabs.org

On Fri, 15 Sep 2017 10:48:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 14, 2017 at 11:56:25PM +0200, Greg Kurz wrote:
> > The following program causes a kernel oops:
> >=20
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <sys/ioctl.h>
> > #include <linux/kvm.h>
> >=20
> > main()
> > {
> >     int fd =3D open("/dev/kvm", O_RDWR);
> >     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
> > }
> >=20
> > This happens because when using the global KVM fd with
> > KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
> > called with a NULL kvm argument, which gets dereferenced
> > in is_kvmppc_hv_enabled(). Spotted while reading the code.
> >=20
> > Let's use the hv_enabled fallback variable, like everywhere
> > else in this function.
> >=20
> > Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
> > Cc: stable@vger.kernel.org # v4.7+
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I don't think this is right.  I'm pretty sure you want to fall back to
> hv_enabled *only when* kvm is NULL.  Otherwise if you have a PR guest
> on an HV capable machine, this will give the wrong answer, when called
> for that specific VM.
>=20

Hmmm... this is what we get with this patch applied:

open("/dev/kvm", O_RDWR)                =3D 3
ioctl(3, KVM_CHECK_EXTENSION, 0x84)     =3D 1 <=3D=3D if HV is present
ioctl(3, KVM_CREATE_VM, 0x1)            =3D 4 <=3D=3D HV
ioctl(4, KVM_CHECK_EXTENSION, 0x84)     =3D 1
ioctl(3, KVM_CREATE_VM, 0x2)            =3D 5 <=3D=3D PR
ioctl(5, KVM_CHECK_EXTENSION, 0x84)     =3D 0

The hv_enabled variable is set as follows:

	/* Assume we're using HV mode when the HV module is loaded */
	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;

	if (kvm) {
		/*
		 * Hooray - we know which VM type we're running on. Depend on
		 * that rather than the guess above.
		 */
		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
	}

so we're good. :)

The last sentence in the commit message is maybe^wprobably not comprehensive
enough...

What about the following ?

The hv_enabled variable is initialized to 1 if HV is loaded or 0 otherwise.
In the case KVM_CHECK_EXTENSION is used with a VM fd, hv_enabled is updated
to is_kvmppc_hv_enabled(kvm). Let's use it here, like everywhere else in th=
is
function.

> > ---
> >  arch/powerpc/kvm/powerpc.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 3480faaf1ef8..ee279c7f4802 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -644,8 +644,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
> >  		break;
> >  #endif
> >  	case KVM_CAP_PPC_HTM:
> > -		r =3D cpu_has_feature(CPU_FTR_TM_COMP) &&
> > -		    is_kvmppc_hv_enabled(kvm);
> > +		r =3D cpu_has_feature(CPU_FTR_TM_COMP) && hv_enabled;
> >  		break;
> >  	default:
> >  		r =3D 0;
> >  =20
>=20


--Sig_/2v=IlCQP/zUiszbsYapkfca
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbtqsQAKCRAC/DrrAQHb
wkw/AJ4hcObSU0V8DToF5lB4G8R7/oXVvQCginbzy+RwhmgfKqEf0nsX5zvJoR8=
=vUvB
-----END PGP SIGNATURE-----

--Sig_/2v=IlCQP/zUiszbsYapkfca--
