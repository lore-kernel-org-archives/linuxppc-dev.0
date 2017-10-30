Return-Path: <broonie@sirena.co.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQZB02tBHzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 23:51:52 +1100 (AEDT)
Date: Mon, 30 Oct 2017 12:51:33 +0000
From: Mark Brown <broonie@kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Paul Mackerras <paulus@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with Linus' tree
Message-ID: <20171030125133.ce5vb6z67dqjb7oj@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pjzkpwinnfkbqw2f"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pjzkpwinnfkbqw2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kvm/powerpc.c

between commit:

  ac64115a66c1 ("KVM: PPC: Fix oops when checking KVM_CAP_PPC_HTM")

=66rom Linus' tree and commit:

  2a3d6553cbd7 ("KVM: PPC: Tie KVM_CAP_PPC_HTM to the user-visible TM featu=
re")

=66rom the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/powerpc/kvm/powerpc.c
index ee279c7f4802,a3746b98ec11..000000000000
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@@ -644,7 -644,8 +644,8 @@@ int kvm_vm_ioctl_check_extension(struc
  		break;
  #endif
  	case KVM_CAP_PPC_HTM:
- 		r =3D cpu_has_feature(CPU_FTR_TM_COMP) && hv_enabled;
 -		r =3D is_kvmppc_hv_enabled(kvm) &&
++		r =3D hv_enabled &&
+ 		    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);
  		break;
  	default:
  		r =3D 0;

--pjzkpwinnfkbqw2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln3IFQACgkQJNaLcl1U
h9Ab8AgAhwJjx54LMyKCbrA77wSUkGcb6NcCyKpq5TsvteP5kdvJRXNeq7Tnopr+
EmGGRm6Bb5aInCZcG5U8QzWSFzfSYzmkFHTKWHpSDP1ARMU0pUX8KZFRVa7DqP6r
fWZJqYJPZbp6PWpkn7ru4GV3u59m+XyUGJVxLTLvv7Q4J5DNaVt8Nmml2PCC7cBe
R3NxTHwDC0OKb7jNHCv9UKltw8TkCf6sOIhDeumyXu1HseJ+9OZXiwGZcPKsWptv
1PBo5cn/61E3h5p9saw4OjL7iJSctgGxgNE/jMCmrdXphuPGVRIwqnotGUCDWinX
Ul1S8iCIS4nvNBJS5DVslzmiAr93LA==
=nPIF
-----END PGP SIGNATURE-----

--pjzkpwinnfkbqw2f--
