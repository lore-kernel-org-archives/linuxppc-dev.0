Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8947E1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:40:17 +1000 (AEST)
Date: Tue, 2 Jun 2015 11:09:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 31/34] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Use DMA windows API in ownership control
Message-ID: <20150602010921.GD3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-32-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
In-Reply-To: <1432889098-22924-32-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:55PM +1000, Alexey Kardashevskiy wrote:
> Before the IOMMU user (VFIO) would take control over the IOMMU table
> belonging to a specific IOMMU group. This approach did not allow sharing
> tables between IOMMU groups attached to the same container.
>=20
> This introduces a new IOMMU ownership flavour when the user can not
> just control the existing IOMMU table but remove/create tables on demand.
> If an IOMMU implements take/release_ownership() callbacks, this lets
> the user have full control over the IOMMU group. When the ownership
> is taken, the platform code removes all the windows so the caller must
> create them.
> Before returning the ownership back to the platform code, VFIO
> unprograms and removes all the tables it created.
>=20
> This changes IODA2's onwership handler to remove the existing table
> rather than manipulating with the existing one. From now on,
> iommu_take_ownership() and iommu_release_ownership() are only called
> from the vfio_iommu_spapr_tce driver.
>=20
> Old-style ownership is still supported allowing VFIO to run on older
> P5IOC2 and IODA IO controllers.
>=20
> No change in userspace-visible behaviour is expected. Since it recreates
> TCE tables on each ownership change, related kernel traces will appear
> more often.
>=20
> This adds a pnv_pci_ioda2_setup_default_config() which is called
> when PE is being configured at boot time and when the ownership is
> passed from VFIO to the platform code.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbQJBAAoJEGw4ysog2bOSuLoQANsBjf/AqljUSTpstcK0iEfZ
X2HOKACt0mL9NVxM31gW1puJEWCbylJXswqlOdneIyjGPqFbpdm3SlgQ+8XH9qce
L2OMCL3pr5wnH7TXA3lH2SBjBlYafMoFksdU65CpNjUsB7pZ453goLyUk7RR1Kp2
Mr95MFu6aSbGzCCLHNdR9Avp6GaPlA+KjPfo6DCFjsMAgZU2DOB52NBTsSU+Pz6N
te8z8e7ZtcG2TliW5hLO7o9toWBZg4M+uexiMGbz4wsOTs2lpCLOSeUNz45RIrHC
4l75BRKsCfP0yuu2jhG67hE8oM9Ketuxw97pbI8trw9bQb3JJyAu7VwquDITPu+q
a40qDcf+YZy9vHZY81x8v0NyNYlAQKZv27QM4OYgb+AMMunAREoOlnibsB8Chy6E
tUT6q30EdUbQJqYyZhWhKeQBAQp5ThsyXDco9s5IIVvA71F95DrtgvoKi11k7jQV
PG22S82BdSRR82hkfabhb/Lm6l1se96w8K52VyekwG9QzJPyl80t6DGHr4OfQkda
jz9ud52daQM2vPonfF8BJ9tchJAtUNlndfnshJYe4nUZDivjZEH2ca0ah/cNxg7I
c2tcuNzCrj5h81hwzzN6Re1weGJWkcSamy+S8mXrhkxXhzI5m7T6+kQ5ut0kTdd+
dlB0wuqzUh3TJFZiYvcw
=NSMW
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
