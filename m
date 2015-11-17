Return-Path: <dja@axtens.net>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D75081A036D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 11:29:41 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so191374878pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 16:29:40 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 21/50] powerpc/powernv: Increase PE# capacity
In-Reply-To: <1446642770-4681-22-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-22-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 17 Nov 2015 11:29:26 +1100
Message-ID: <87y4dxbh95.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> Each PHB maintains an array helping to translate 2-bytes Request
> ID (RID) to PE# with the assumption that PE# takes one byte, meaning
> that we can't have more than 256 PEs. However, pci_dn->pe_number
> already had 4-bytes for the PE#.
>
> This extends the PE# capacity so that each of them will be 4-bytes
> long. Then we can reuse IODA_INVALID_PE to check the PE# stored in
> phb->pe_rmap[] is valid or not.

Just for clarity, could you make it clear in the commit message that
you're increasing the PE# capacity _in the PHB_? I just found it a bit
confusing the first time I read it.

With that clarified I'll be happy to add my reviewed-by tag.

Regards,
Daniel
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
>  arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 0e66c4d..ef93a01 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -766,7 +766,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *ph=
b, struct pnv_ioda_pe *pe)
>=20=20
>  	/* Clear the reverse map */
>  	for (rid =3D pe->rid; rid < rid_end; rid++)
> -		phb->ioda.pe_rmap[rid] =3D 0;
> +		phb->ioda.pe_rmap[rid] =3D IODA_INVALID_PE;
>=20=20
>  	/* Release from all parents PELT-V */
>  	while (parent) {
> @@ -3164,6 +3164,10 @@ static void __init pnv_pci_init_ioda_phb(struct de=
vice_node *np,
>  	if (prop32)
>  		phb->ioda.reserved_pe_idx =3D be32_to_cpup(prop32);
>=20=20
> +	/* Invalidate RID to PE# mapping */
> +	for (i =3D 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
> +		phb->ioda.pe_rmap[i] =3D IODA_INVALID_PE;
> +
>  	/* Parse 64-bit MMIO range */
>  	pnv_ioda_parse_m64_window(phb);
>=20=20
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 0802fcd..5df945f 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -162,11 +162,8 @@ struct pnv_phb {
>  			struct list_head	pe_list;
>  			struct mutex            pe_list_mutex;
>=20=20
> -			/* Reverse map of PEs, will have to extend if
> -			 * we are to support more than 256 PEs, indexed
> -			 * bus { bus, devfn }
> -			 */
> -			unsigned char		pe_rmap[0x10000];
> +			/* Reverse map of PEs, indexed by {bus, devfn} */
> +			int			pe_rmap[0x10000];
>=20=20
>  			/* TCE cache invalidate registers (physical and
>  			 * remapped)
> --=20
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWSnTnAAoJEPC3R3P2I92FOTUQAIPGUQDll+7Uc1lau7ToBOR2
jvP/H0wVrZGZEOBpXRaz0rFFmiUgKythKkGFCm2w8dq0cjexn02qvh4CmQEHeJRS
D+Si7rfSNezDahJL9QMu/MOUwUaFexFRCPJQxFFLwxrvulUGhUvlv1oB83fw2IAB
Eq1gVqW0Hs1zceSJ7ebYjJoEhj0ZRSQFx7Jp2Yj6sWKRVlvcMYECWZ83lrn4ixn1
DPkCC3SfVle/aANMKUK4sY1FqaGSvX8s3Fe6PXpXhvfr2xoIso6dlJmFhNMTgP8r
AmNWyaT+s3pg9tEsFKwQTJWQvK7G/ScPg01ywfiaOk1PuIA7zQcCpILtwbHloo+q
4okga3e17nBS7HYGAKTN3JDZgI5Jr8F7Fd2K2qO/Tkgsov3DsPP0dMT+vYSAXk4y
WZ3oQXgYzCf/4uABQ72zl2/0L8pnUHK5omcBNex/2IQRvF0D2E8t6sRaX7NpqQjg
AKGFBXCXed9SRuKwetYurtHrHbem1roQm1tD94x23LBbYqnp5zakhEIX4riDzwbE
MSerG1y04jlwxyy72aEFNGuRVi18R5aO+3h0hZH/PonE+nCIWvxem6mmgC8aeTll
juv0Dg5RPfdcTAXR534EOQqz5BV7p5TjH5Ny7q7ufbBSzyyY9cudNzD8IknviA38
z3V6mdbW9gx4H6b4FpNJ
=WeRL
-----END PGP SIGNATURE-----
--=-=-=--
