Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CF571A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 10:22:06 +1000 (AEST)
Received: by payr10 with SMTP id r10so61216794pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 17:22:05 -0700 (PDT)
Message-ID: <1433290876.438.46.camel@axtens.net>
Subject: Re: [PATCH v1 5/9]powerpc/powernv: nest pmu feature detection support
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 10:21:16 +1000
In-Reply-To: <1433260778-26497-6-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-6-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-WiplLsmig3HvitoOinBu"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-WiplLsmig3HvitoOinBu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
> Patch adds a device tree function to detect the nest pmu
> support. Function will look for specific dt property "ibm,ima-chip"
> as a detection mechanism for the nest pmu.
>=20
> For Nest pmu, device tree will have two set of information.
> 1) Per-chip Homer address region for nest pmu counter collection area.
> 2) Supported Nest PMUs and events
What's HOMER?

> =20
> +static int nest_ima_detect_parse(void)
> +{
> +	const __be32 *gcid;
> +	const __be64 *chip_ima_reg;
> +	const __be64 *chip_ima_size;
> +	struct device_node *dev;
> +	int rc =3D -EINVAL, idx;
> +
> +	for_each_node_with_property(dev, "ibm,ima-chip") {
> +		gcid =3D of_get_property(dev, "ibm,chip-id", NULL);
> +		chip_ima_reg =3D of_get_property(dev, "reg", NULL);
> +		chip_ima_size =3D of_get_property(dev, "size", NULL);
> +		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
> +			pr_err("%s: device %s missing property \n",
> +				__func__, dev->full_name);
This is not a particularly informative error message. It'd be good if it
mentioned that it was for PMU.
> +			return rc;
> +		}
> +
> +		idx =3D (uint32_t)be32_to_cpup(gcid);
> +		p8_perchip_nest_info[idx].pbase =3D be64_to_cpup(chip_ima_reg);
> +		p8_perchip_nest_info[idx].size =3D be64_to_cpup(chip_ima_size);
> +		p8_perchip_nest_info[idx].vbase =3D (uint64_t)
> +			phys_to_virt(p8_perchip_nest_info[idx].pbase);
> +
> +		rc =3D 0;
> +	}
> +
> +	return rc;

I'm not sure your rc handling is correct. As I understand it:
 - Start with rc =3D -EINVAL.
 - If your first node is missing a property, return -EINVAL.
 - Once your first node succeeds, set rc =3D 0
 - If any subsequent node is missing a property, return 0.
 - Return 0 if any node is successfully processed, otherwise return
-EINVAL.

If that's what you intended (especially with regards to returning 0 when
a subsequent node is missing a property), a comment explaining it would
be great.=20

Also, why bail out if a property is missing on any node? Why not try all
of them and see if any succeed?

> +}
> +
>  static int __init nest_pmu_init(void)
>  {
>  	int ret =3D 0;
> @@ -256,6 +287,12 @@ static int __init nest_pmu_init(void)
> =20
>  	cpumask_chip();
> =20
> +	/*
> +	 * Detect the Nest PMU feature
> +	 */
> +	if (nest_ima_detect_parse())
> +		return 0;
> +
>  	return 0;
>  }
Zero is returned regardless of the output of nest_ima_detect_parse. Is
that intentional? If so, do you need the 'if'?

>  device_initcall(nest_pmu_init);

Regards,
Daniel Axtens


--=-WiplLsmig3HvitoOinBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVbkh8AAoJEPC3R3P2I92F0vcP/0PPfo3yN9HdRCPxoTmX8d3w
Pf62tT3yrHxDghkIlx45/CaYcu1f6Y9Coh3EiIPmUV0OmvIyJF1O57wBn66kytYZ
sOiRfnLs01d3+NkCZBbF+dTEAQTDlLp0g3H595BRXv5ByqCbJ361xpGZ5S+CYeVQ
opt7rf5DX7qhZ0O07Hx4cJXhil5c8HOmK+mwggyh42BnQAtjngj6H5eGjku3Axuk
sUgoenqrcfdIwe5xGXOxmmixIYk3oZYrlj+PTn1UmtxRts6tQ3mHKlw8lN9xXjyM
h+fZqReXC462QydTn/c5FDOtRsmAK0AexWqfnH92hG55qQ+omD1gTnpoQNaNLCag
0veAD+NWDpWvMuxRPJ2j7JrZxenFVOZFNKbU3jY7qmpCcnApiwnuNYnB38ikzxCM
B56DuiZm+sB2qcP4g/eItahjzlYwyJ65+fyXvoENhYgeYbDPMM7CwIhMkA0w5WNq
kUriQBE9iQI6Mib1s5LPzUsHzmDxEKZbeB88DnBIwXRr+FT+tVAO94a+Evi8eqVb
dBI7kAk7GcFSoD9IJ5XaTHNjQD0iFMYteoDmqsGbuI1ErxUaS69s3izZfCqoVB66
/XeWZyelDV7HAaU/Y0qvRzSkUDPC8vwi4DADiPFcH2Dh9bsuTXDuAE1I4CQJCuz2
BmPkzVBDqnrWVvKFh54e
=Saxn
-----END PGP SIGNATURE-----

--=-WiplLsmig3HvitoOinBu--
