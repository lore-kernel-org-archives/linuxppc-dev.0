Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ1Sg03SyzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 17:15:47 +1100 (AEDT)
Date: Wed, 16 Mar 2016 16:55:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 06/10] powerpc/powernv/npu: Simplify DMA setup
Message-ID: <20160316055550.GG9032@voom>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MFsiPQgyXjZUSlqD"
In-Reply-To: <1457504946-40649-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MFsiPQgyXjZUSlqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:29:02PM +1100, Alexey Kardashevskiy wrote:
> NPU devices are quite specific, in fact they represent side DMA channel
> of a GPU device. The GPU/NPU driver never actually configures DMA
> for NPU devices, instead it relies on the platform code to propagate
> DMA setup to NPU devices when a main GPU device is being configured.
> When GPU is being set up, the same configuration - bypass or 32bit DMA -
> is used for NPU. This makes DMA setup explicit.
>=20
> pnv_npu_ioda_controller_ops::pnv_npu_dma_set_mask is moved to pci-ioda,
> made static and prints warning as dma_set_mask() should never be called
> on this function as in any case it will not configure GPU; so we make
> this explicit.
>=20
> Instead of using PNV_IODA_PE_PEER and peers[] (which next patch will
> remove), we test every PCI device if there are corresponding NVLink
> devices. If there are any, we propagate bypass mode to just found NPU
> devices by calling the setup helper directly (which takes @bypass) and
> avoid guessing (i.e. calculating from DMA mask) whether we need bypass
> or not on NPU devices. Since DMA setup happens in very rare occasion,
> this will not slow down booting or VFIO start/stop much.
>=20
> This renames pnv_npu_disable_bypass to pnv_npu_dma_set_32 to make it
> more clear what the function really does which is programming 32bit
> table address to the TVT ("disabling bypass" means writing zeroes to
> the TVT).
>=20
> This removes pnv_npu_dma_set_bypass() from pnv_npu_ioda_fixup() as
> the DMA configuration on NPU does not matter until dma_set_mask() is
> called on GPU and that will do the NPU DMA configuration.
>=20
> This removes phb->dma_dev_setup initialization for NPU as
> pnv_pci_ioda_dma_dev_setup is no-op for it anyway.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I'm having trouble making sense of the commit message, but the actual
changes look fine as best I can tell.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MFsiPQgyXjZUSlqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6PVmAAoJEGw4ysog2bOSVzMP/35LKCtB6ycMlYIlhhI0TPxi
rMpb5Z7b3blUfoJpYYbUNdbwPj9XWMZ3DkPSUsJzk2garQpHIdWNeOgkE7l0lPyq
WQxgOUeLe7RuqIKtA2m1BaMcZiYdFOGY4PY5co0RoCDWmxNu5To4fmaaTa/a4xDQ
ZHS6r2kghKGERC9OlbTvcWvwD1QndCkI/D3puqtUo7SuSLzFNRNH5DEwZE8WgWfg
WllyJ51ZqCrW3B3fiYng+KGo1/kU3lS59SK3/+P2NM5yBDqXAWDpDptNIhCiQFGd
hCbE/jbWWgBiVn7+8CxJIUNbvGavTP3n52LCRqcvX4y7HhOPPU+KaDgkC2Os8QZ5
Y3+D1fUhJlv3JInTmVUwUHcBh6wj25ME3kRIc6DnBOOTXoIBaLqWGUsPZ3bKoiY5
fuhtu0iTRqZ7805ecTbRrd0LsnpV32VDzipbYsfhbFBorBclH7f3aKUr7CQhrfl6
AoMtKpMl+srihMNaXx8+1x2lxe/XRr+pNBqu2bcDFyGU6vmgV7PMY/GATm/XUmXp
4Fg34qi2N0n/6WTyOpEBh3A5Y4+4DGrW5Fp5CIEBIBOS2tZTnEJvyf7H3tF1+W1t
YeRbUI/97Rkg4cZwHHMYLDIV80Gajt3OJeTYP8wkxThzOKTLZiWc2xOob13mIq0F
u035G4Ofn28p9h8c+RE9
=K9JV
-----END PGP SIGNATURE-----

--MFsiPQgyXjZUSlqD--
