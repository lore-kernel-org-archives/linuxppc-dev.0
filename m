Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: disable MSI using new interface if possible
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
References: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-FIiytpJpz0SjVDHzMVEh"
Date: Fri, 04 Mar 2011 12:05:29 +1100
Message-ID: <1299200729.3630.52.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-FIiytpJpz0SjVDHzMVEh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-03-03 at 11:39 -0800, Nishanth Aravamudan wrote:
> On upcoming hardware, we have a PCI adapter with two functions, one of
> which uses MSI and the other uses MSI-X. This adapter, when MSI is
> disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
> signals an MSI-X interrupt and triggers an EEH. We are working with the
> vendor to ensure that the hardware is not at fault, but if we use the
> "new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
> automatically disable MSI-X and the adapter does not appear to signal
> any stray MSI-X interrupt.

It seems this could also be a firmware bug, have we heard anything from
them? PAPR explicitly says that RTAS_CHANGE_FN (function=3D1) should
disable MSI _and_ MSI-X (R1=E2=80=937.3.10.5.1=E2=80=931).

> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Cc: Milton Miller <miltonm@bga.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>

Cc: Me  :)

> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platform=
s/pseries/msi.c
> index 1164c34..9434576 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -93,8 +93,18 @@ static void rtas_disable_msi(struct pci_dev *pdev)
>  	if (!pdn)
>  		return;
> =20
> -	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) !=3D 0)
> -		pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
> +	/*
> +	 * disabling MSI with the explicit interface also disables MSI-X
> +	 */
> +	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) !=3D 0) {
> +		/*=20
> +		 * may have failed due to lacking
> +		 * "ibm,change-msix-capable" property
> +		 */
> +		if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) !=3D 0) {
> +			pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
> +		}
> +	}
>  }

This is probably a pretty safe change anyway, ie. use the newer API if
it is present. The comment is backward though, the call fails because
the new interface is not implemented, and that fact is signalled by the
absence of the property.

cheers


--=-FIiytpJpz0SjVDHzMVEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1wOtkACgkQdSjSd0sB4dIa8gCfZdsBjN0rG+0DHN8hHET8SFZ2
u/AAn1043Ulb+c1gq/gSKg43PhE4ou0U
=TWQB
-----END PGP SIGNATURE-----

--=-FIiytpJpz0SjVDHzMVEh--
