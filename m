Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 May 2013 15:05:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/6] KVM: PPC: Add support for multiple-TCE hcalls
Message-ID: <20130507050514.GN13692@truffula.fritz.box>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
 <1367825157-27231-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mkHYMT4O8DyWoHkb"
In-Reply-To: <1367825157-27231-3-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mkHYMT4O8DyWoHkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 05:25:53PM +1000, Alexey Kardashevskiy wrote:
> This adds real mode handlers for the H_PUT_TCE_INDIRECT and
> H_STUFF_TCE hypercalls for QEMU emulated devices such as virtio
> devices or emulated PCI.  These calls allow adding multiple entries
> (up to 512) into the TCE table in one call which saves time on
> transition to/from real mode.
>=20
> This adds a guest physical to host real address converter
> and calls the existing H_PUT_TCE handler. The converting function
> is going to be fully utilized by upcoming VFIO supporting patches.
>=20
> This also implements the KVM_CAP_PPC_MULTITCE capability,
> so in order to support the functionality of this patch, QEMU
> needs to query for this capability and set the "hcall-multi-tce"
> hypertas property only if the capability is present, otherwise
> there will be serious performance degradation.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Fwiw, it would be nice to get this patch merged, regardless of the
rest of the VFIO/powerpc patches.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mkHYMT4O8DyWoHkb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGIi4oACgkQaILKxv3ab8btKwCdHj3FzLAniahSk7sv0r3TlKo5
NQYAn1Jd4jU6Ka7Lbpe9r7CWioi5AqFg
=bJLO
-----END PGP SIGNATURE-----

--mkHYMT4O8DyWoHkb--
