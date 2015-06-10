Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A9451A0452
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 13:22:27 +1000 (AEST)
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9CFA71401E7
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 13:22:25 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so27765839pdj.0
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2015 20:22:23 -0700 (PDT)
Message-ID: <1433906475.3096.1.camel@axtens.net>
Subject: Re: [PATCH V8 01/10] powerpc, perf: Drop the branch sample when
 'from' cannot be fetched
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Wed, 10 Jun 2015 13:21:15 +1000
In-Reply-To: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-r1FVUOuQhjf7oloifdt7"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-r1FVUOuQhjf7oloifdt7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

Was there a cover letter for this series that I missed?

On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
> BHRB is a rolling buffer. Hence we might end up in a situation where
Could you spell out what BHRB stands for?

> we have read one target address but when we try to read the next entry
>  indicating the from address of the targe, the buffer just overflows.
target?

> In this case, the captured from address will be zero which indicates
> the end of the buffer.
>=20
In what sort of situations would this occur? It seems like something we
would want to avoid if possible?

> This patch drops the entire branch record which would have otherwise
> confused the user space tools.
>=20
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-boo=
k3s.c
> index 12b6384..c246e65 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -452,7 +452,6 @@ static void power_pmu_bhrb_read(struct cpu_hw_events =
*cpuhw)
>  			 *    In this case we need to read the instruction from
>  			 *    memory to determine the target/to address.
>  			 */
> -
>  			if (val & BHRB_TARGET) {
>  				/* Target branches use two entries
>  				 * (ie. computed gotos/XL form)
> @@ -463,6 +462,8 @@ static void power_pmu_bhrb_read(struct cpu_hw_events =
*cpuhw)
> =20
>  				/* Get from address in next entry */
>  				val =3D read_bhrb(r_index++);
> +				if (!val)
> +					break;
>  				addr =3D val & BHRB_EA;
>  				if (val & BHRB_TARGET) {
>  					/* Shouldn't have two targets in a


--=-r1FVUOuQhjf7oloifdt7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVd602AAoJEPC3R3P2I92FZo4P/1WhRzhduOnY4UozO2YpFoII
TZj+hXVtpDhtMtZ5S8+btiCbTfstSir8xIJU9mCpeZmi3wr1KYGBXJZWcBno5Q1a
cNSc2qKQhWPWdHt63HaAla0wtVLctPLOJc27lHM5VW07K4FvS15AUD/jI0XJsff1
E9KEfR2eUG9aPMhDphJXsEZVS26isQnnJSHPKLcCGeD6AHoUGVB8WJNVejTKHiBq
9Pp/NZAWVcfR+PomGSCkHwCRYrk1AXr6RY+X/qklbQURHM3k1LAx4GHUtAc57Vsj
CsUPg3uK1njLUJVaR2S1vgp2RMU98/wBZP22fwhuERiBFLSd7YXuSaa/HZxV+QDf
Cde0CqqnbWFrTSvmcpN+CBMPTqdHsFek1TT8SJOHTPPe8bbgSU03NXy++kZPQCyZ
otgSvwTK9w9vjLjS0lQD7opSLD+ON6MFVdE3cfuoaW29+Fv82YEO2GLsHqXOeHFR
WfO9LjvoWGgD3M9RaPBnisGZqPvxHQpSf1pTsmFfrKzW/a5+P5Kw0Y9iXSMpSxmM
4ydY5sAZGl5dPARNrdgRo3lT8mD0oLmukpZ/EvajR9fePxx1bHEGF/zafEu/Ogcq
5LLeMuCNpD1Cj7MLqu1FGXYwgs2HDsMcWLYNPrCY32jQwR4/QoUyng3FCSBl6ASf
xIwXgIVjSlK6p4ubgBXz
=iRVW
-----END PGP SIGNATURE-----

--=-r1FVUOuQhjf7oloifdt7--
