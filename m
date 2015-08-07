Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 922B91A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:49:05 +1000 (AEST)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A2DFB14010F
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:49:04 +1000 (AEST)
Received: by pabxd6 with SMTP id xd6so59724709pab.2
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 20:49:03 -0700 (PDT)
Message-ID: <1438919211.6796.5.camel@axtens.net>
Subject: Re: [PATCH] powerpc/powernv: move dma_get_required_mask from
 pnv_phb to pci_controller_ops
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Date: Fri, 07 Aug 2015 13:46:51 +1000
In-Reply-To: <1438919154-6179-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1438919154-6179-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-gyfxVO/fVz1OA1jA9N2P"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-gyfxVO/fVz1OA1jA9N2P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2015-08-07 at 13:45 +1000, Andrew Donnellan wrote:
> Simplify the dma_get_required_mask call chain by moving it from pnv_phb t=
o
> pci_controller_ops, similar to commit 763d2d8df1ee2b92ff09c
> ("powerpc/powernv: Move dma_set_mask from pnv_phb to pci_controller_ops")=
.
>=20
> Previous call chain:
>=20
>   0) call dma_get_required_mask() (kernel/dma.c)
>   1) call ppc_md.dma_get_required_mask, if it exists. On powernv, that
>      points to pnv_dma_get_required_mask() (platforms/powernv/setup.c)
>   2) device is PCI, therefore call pnv_pci_dma_get_required_mask()
>      (platforms/powernv/pci.c)
>   3) call phb->dma_get_required_mask if it exists
>   4) it only exists in the ioda case, where it points to
>        pnv_pci_ioda_dma_get_required_mask() (platforms/powernv/pci-ioda.c=
)
>=20
> New call chain:
>=20
>   0) call dma_get_required_mask() (kernel/dma.c)
>   1) device is PCI, therefore call pci_controller_ops.dma_get_required_ma=
sk
>      if it exists
>   2) in the ioda case, that points to pnv_pci_ioda_dma_get_required_mask(=
)
>      (platforms/powernv/pci-ioda.c)
>=20
> In the p5ioc2 case, the call chain remains the same -
> dma_get_required_mask() does not find either a ppc_md call or
> pci_controller_ops call, so it calls __dma_get_required_mask().
>=20
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>=20
Reviewed-by: Daniel Axtens <dja@axtens.net>

--=20
Regards,
Daniel

--=-gyfxVO/fVz1OA1jA9N2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVxCorAAoJEPC3R3P2I92FiuoP/1UiaXurp0AID3Rkmr2Zll/C
hygPbsu+DWyXApXrcIofrYtetUn4wEOjCNLc80Wu/bWuDgNTVEI07PUlbTN5sbBg
Ce98b6Csf2y1WXmJ7f8K+w8l+WWSqVd1UNsoHOhHQOE4lBBGQILzf7we8Qjn8fTN
CNQ4xW/KsKKX2fMszO3K4QqY4hf9RehdhVi6qbLotF4lRUZn31sujpUmFbJZiLVI
CA00TS0/iqTZ/I1Nbg6udwI+ieAktNAjpmA7B1DSbRXOcYZO6TIYpa9T86cwZoO2
UMIb86LJgKs8PW5gnp2G6k6xhrePCFscPyJFn3WQmKh/xsJghYJByhkFnTl5f73P
HSksy3s+nq3TQ2euPvKSSTpDgKISlLjuWDhhJOw+Mdmz43VrzsnPYVU5fE2Lc7XQ
2Aqmo5qqAf/7JbU8fV5SElQhbl1EJa+B5DPpPJpdf2DIq10ZxSkJ/AX9z1e8S77M
FOs3dzTI6sXBd+qepjockD43nsdylY3JZftjZXGLqW/PckfUv/5oPp8fxicoiObD
Z9gZODBpsqtupeJSzRkvts7mSfiwYz2wFVmA+py/VSbFqB7fy7S/+4MuN1OfdOi8
uw1KjUzeO09TrA6VC+zhM4KL39719H8XGLlD7+7EBXCQqChzNY7t5BKY6NAWTF7q
cNqeQ/YKtJqOxbFZx7WF
=82ZU
-----END PGP SIGNATURE-----

--=-gyfxVO/fVz1OA1jA9N2P--
