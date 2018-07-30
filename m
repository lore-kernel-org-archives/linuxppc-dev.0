Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fLTf6GB6zF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 23:47:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 npiggin@gmail.com
Subject: Re: [PATCH 3/3] powerpc/pseries/mm: call H_BLOCK_REMOVE
In-Reply-To: <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
Date: Mon, 30 Jul 2018 23:47:01 +1000
Message-ID: <877elcj0oa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Laurent,

Just one comment below.

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platfor=
ms/pseries/lpar.c
> index 96b8cd8a802d..41ed03245eb4 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -418,6 +418,73 @@ static void pSeries_lpar_hpte_invalidate(unsigned lo=
ng slot, unsigned long vpn,
>  	BUG_ON(lpar_rc !=3D H_SUCCESS);
>  }
>=20=20
> +
> +/*
> + * As defined in the PAPR's section 14.5.4.1.8
> + * The control mask doesn't include the returned reference and change bi=
t from
> + * the processed PTE.
> + */
> +#define HBLKR_AVPN		0x0100000000000000UL
> +#define HBLKR_CTRL_MASK		0xf800000000000000UL
> +#define HBLKR_CTRL_SUCCESS	0x8000000000000000UL
> +#define HBLKR_CTRL_ERRNOTFOUND	0x8800000000000000UL
> +#define HBLKR_CTRL_ERRBUSY	0xa000000000000000UL
> +
> +/**
> + * H_BLOCK_REMOVE caller.
> + * @idx should point to the latest @param entry set with a PTEX.
> + * If PTE cannot be processed because another CPUs has already locked th=
at
> + * group, those entries are put back in @param starting at index 1.
> + * If entries has to be retried and @retry_busy is set to true, these en=
tries
> + * are retried until success. If @retry_busy is set to false, the return=
ed
> + * is the number of entries yet to process.
> + */
> +static unsigned long call_block_remove(unsigned long idx, unsigned long =
*param,
> +				       bool retry_busy)
> +{
> +	unsigned long i, rc, new_idx;
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> +
> +again:
> +	new_idx =3D 0;
> +	BUG_ON((idx < 2) || (idx > PLPAR_HCALL9_BUFSIZE));

I count 1 ..

> +	if (idx < PLPAR_HCALL9_BUFSIZE)
> +		param[idx] =3D HBR_END;
> +
> +	rc =3D plpar_hcall9(H_BLOCK_REMOVE, retbuf,
> +			  param[0], /* AVA */
> +			  param[1],  param[2],  param[3],  param[4], /* TS0-7 */
> +			  param[5],  param[6],  param[7],  param[8]);
> +	if (rc =3D=3D H_SUCCESS)
> +		return 0;
> +
> +	BUG_ON(rc !=3D H_PARTIAL);

2 ...

> +	/* Check that the unprocessed entries were 'not found' or 'busy' */
> +	for (i =3D 0; i < idx-1; i++) {
> +		unsigned long ctrl =3D retbuf[i] & HBLKR_CTRL_MASK;
> +
> +		if (ctrl =3D=3D HBLKR_CTRL_ERRBUSY) {
> +			param[++new_idx] =3D param[i+1];
> +			continue;
> +		}
> +
> +		BUG_ON(ctrl !=3D HBLKR_CTRL_SUCCESS
> +		       && ctrl !=3D HBLKR_CTRL_ERRNOTFOUND);

3 ...

BUG_ON()s.

I know the code in this file is already pretty liberal with the use of
BUG_ON() but I'd prefer if we don't make it any worse.

Given this is an optimisation it seems like we should be able to fall
back to the existing implementation in the case of error (which will
probably then BUG_ON() =F0=9F=98=82)

If there's some reason we can't then I guess I can live with it.

cheers
