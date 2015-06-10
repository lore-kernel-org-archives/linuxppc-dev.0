Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26C731A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 15:50:26 +1000 (AEST)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 940461402AD
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 15:50:25 +1000 (AEST)
Received: by padev16 with SMTP id ev16so27810415pad.0
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2015 22:50:22 -0700 (PDT)
Message-ID: <1433915365.3096.44.camel@axtens.net>
Subject: Re: [PATCH V8 08/10] powerpc, perf: Change POWER8 PMU configuration
 to work with SW filters
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Wed, 10 Jun 2015 15:49:25 +1000
In-Reply-To: <1433763511-5270-8-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-8-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-toTTCBsKtwBSKM65n/2B"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-toTTCBsKtwBSKM65n/2B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
> The kernel now supports SW based branch filters for book3s systems with
> some specific requirements while dealing with HW supported branch filters
> in order to achieve overall OR semantics prevailing in perf branch stack
> sampling framework. This patch adapts the BHRB branch filter configuratio=
n
> to meet those protocols. POWER8 PMU can only handle one HW based branch
> filter request at any point of time. For all other combinations PMU will
> pass it on to the SW.
>=20
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/power8-pmu.c | 51 ++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pm=
u.c
> index 5e17cb5..8fccf6c 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -656,6 +656,16 @@ static int power8_generic_events[] =3D {
> =20

This is, I think, the third time you've modified this function in this
patch series. I appreciate the fact that you're trying to keep logical
changes separate, but it seems to me like this change might be able to
be combined with patch 4, and given a single commit message that clearly
explains the complete scope of the changes.
>  static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *bhrb_filt=
er)
>  {
> +	u64 x, pmu_bhrb_filter;
> +
> +	pmu_bhrb_filter =3D 0;
> +	*bhrb_filter =3D 0;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY) {
> +		*bhrb_filter =3D PERF_SAMPLE_BRANCH_ANY;
> +		return pmu_bhrb_filter;
> +	}
> +
>  	/* BHRB and regular PMU events share the same privilege state
>  	 * filter configuration. BHRB is always recorded along with a
>  	 * regular PMU event. As the privilege state filter is handled
> @@ -666,15 +676,42 @@ static u64 power8_bhrb_filter_map(u64 branch_sample=
_type, u64 *bhrb_filter)
>  	/* Ignore user, kernel, hv bits */
>  	branch_sample_type &=3D ~PERF_SAMPLE_BRANCH_PLM_ALL;
> =20
> -	/* No branch filter requested */
> -	if (branch_sample_type =3D=3D PERF_SAMPLE_BRANCH_ANY)
> -		return 0;
> +	/*
> +	 * POWER8 does not support ORing of PMU HW branch filters. Hence
> +	 * if multiple branch filters are requested which may include filters
> +	 * supported in PMU, still go ahead and clear the PMU based HW branch
> +	 * filter component as in this case all the filters will be processed
> +	 * in SW.
> +	 */
> =20
> -	if (branch_sample_type =3D=3D PERF_SAMPLE_BRANCH_ANY_CALL)
> -		return POWER8_MMCRA_IFM1;
> +	for_each_branch_sample_type(x) {
> +		/* Ignore privilege branch filters */
> +		if ((x =3D=3D PERF_SAMPLE_BRANCH_USER)
> +			|| (x =3D=3D PERF_SAMPLE_BRANCH_KERNEL)
> +				|| (x =3D=3D PERF_SAMPLE_BRANCH_HV))
> +			continue;
> +
> +		if (!(branch_sample_type & x))
> +			continue;
> +
> +		/* Supported individual PMU branch filters */
> +		if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
> +			branch_sample_type &=3D ~PERF_SAMPLE_BRANCH_ANY_CALL;
> +			if (branch_sample_type) {
> +				/* Multiple filters will be processed in SW */
> +				pmu_bhrb_filter =3D 0;
> +				*bhrb_filter =3D 0;
> +				return pmu_bhrb_filter;
> +			} else {
> +				/* Individual filter will be processed in HW */
> +				pmu_bhrb_filter |=3D POWER8_MMCRA_IFM1;
> +				*bhrb_filter    |=3D PERF_SAMPLE_BRANCH_ANY_CALL;
> +				return pmu_bhrb_filter;
> +			}
> +		}
> +	}
> =20
> -	/* Every thing else is unsupported */
> -	return -1;
> +	return pmu_bhrb_filter;
>  }

Regards,
Daniel

--=-toTTCBsKtwBSKM65n/2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVd8/lAAoJEPC3R3P2I92FE8EP/3sUoWBE1Bl/UyRs/90mk6tr
GLh2yZPMVj5aVVDScHpuK8Y/wJPQacx9gPNxFVSRxsv1emtLLYnEGT9xL/h4Y4/i
b1T47s3II0pPBc83CSu9AScBW7ZQ5nWB1Ttg1xEGeapWs1B71MTDBagA7M+SIGUE
AA5GcuYRXfBeLmYXFiJMgXyLFD6lw05DXh7UcgmuG6Yz4COKzgP5iZOUpOHwF/BL
orMKvybApxRQ+wPzqi/ibqdmuqvIeJxHmKt7fc0g/L16kVUDrOGu2bOvKNBQsu/1
7/FTNSXszgOO53YpRn2fL7FvS38wY2FhlHnuXjkfbJUCUNbmpOKYDptj12U/AG/R
J26N1wNbGI73P0eO7tpTpKyd0JcsRVpGESUOFRzMJZNYBArgTT73rA6dIbFcHnYc
xCxrqNQH1NyRkn8a6xXmAHawI5y4cpTdEHVcpRwg6e2Y2LLLFkFotUCT67vu35AJ
DzGZ9k9YHUo1c779efgfaH2avSLRcGwULkLjiU05EF6TIRkpOL32t4To/ns7j1U3
IZhdTK/FzYD7FwkyNPTFBKEJf07rZd2CU6INYl4iKeTju90uqXaiTQ9R0pphYXaA
DOEMDYPj49vb/h1HvvwtFH9688MJQ13lU0E/drogIbflZtHwc37G4upR0stiZmEX
wJxpvW3bL5Z6J5Ym6fvR
=pGYB
-----END PGP SIGNATURE-----

--=-toTTCBsKtwBSKM65n/2B--
