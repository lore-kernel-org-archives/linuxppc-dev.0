Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49D321A0404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 11:31:03 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so194394031pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 16:31:01 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 22/50] powerpc/powernv: Introduce pnv_ioda_init_pe()
In-Reply-To: <1446642770-4681-23-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-23-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 17 Nov 2015 11:30:49 +1100
Message-ID: <87wpthbh6u.fsf@gamma.ozlabs.ibm.com>
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

> This introduces pnv_ioda_init_pe() to initialize the specified PE
> instance (phb->ioda.pe_array[x]). It's used by pnv_ioda_alloc_pe()
> and pnv_ioda_reserve_pe(). No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index ef93a01..488e0f8 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -129,6 +129,14 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned l=
ong flags)
>  		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>  }
>=20=20
> +static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_=
no)
> +{
> +	phb->ioda.pe_array[pe_no].phb =3D phb;
> +	phb->ioda.pe_array[pe_no].pe_number =3D pe_no;
> +
> +	return &phb->ioda.pe_array[pe_no];
You have the function returning the newly initalized PE here...

> +}
> +
>  static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>  {
>  	if (!(pe_no >=3D 0 && pe_no < phb->ioda.total_pe_num)) {
> @@ -141,8 +149,7 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, =
int pe_no)
>  		pr_debug("%s: PE %d was reserved on PHB#%x\n",
>  			 __func__, pe_no, phb->hose->global_number);
>=20=20
> -	phb->ioda.pe_array[pe_no].phb =3D phb;
> -	phb->ioda.pe_array[pe_no].pe_number =3D pe_no;
> +	pnv_ioda_init_pe(phb, pe_no);
... but then you ignore the result here and in the other function you've
modified.

It looks like you're using the result in the next patch though, so I
wonder if you would be better to merge this patch with the next
one. However, as I said before I'll defer to Alexey on decisions about
how to split the patch series if he has a different opinion.

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWSnU5AAoJEPC3R3P2I92FoQYP/RyPK8sKCfwmjcdRe7vr+o+y
aT6YLYeZ1HFfwO6tOLxwo0C8oBHbY0P5L1l5BuMB0fxW7J0n/nYhan1mEqNAlsrh
k2YXRT6CT7UZPZ8gaHtefYA5Z78WnHYr02aFydqg7klJVj2seV3ZcBlsHj74XwJ2
Aqdytc7aJ9YPZrZpAWz+GFol705t+f8P9TQwyurEyI6oDW8RWSEp1DBPdhQWdXnK
ngJo3QMS1BwA3v7aeYqrykM7G2MIBsTVkWdYC8VRpZbz7v1s7fmpsl1Y8K54AsHP
5zfJQzh7Je7EvmhbbO2uphXCWUNVVIoEtm+Wcs1nRSzJ+F9vnjte6PkQh+gIcK9y
0tUpV4EWk8SMZngrW6dDrs38unS0sZqj+9ElqGSKdyqb65SpgAVyV5rZpMidlIJE
FPylauU29ijvywDEYPjV3CZ/oZQ3psqKbpzPuv4xG/8McWfkPoVtldWp3N8rF+qs
M2vQVxNVf9tXczpfhTYy53LFn4Xs/7bchlwwmGuXjgsB4n+oM2ZfSlOLbmd+RG4J
87bRBV4xVJZL5HyZYqJwTqf5BRW1NYr44qlRv/OKjB7Y1r6mSc3G8bxySLAYhdxQ
Zhn7qZXX7CsEKeRvUTjrdXcSdgpjz85Qb0VEvEG2LjdBHwxPQf/WovRUpLTz4Tx3
XVFOTZ1dzEJLmU+eBp4v
=nTkJ
-----END PGP SIGNATURE-----
--=-=-=--
