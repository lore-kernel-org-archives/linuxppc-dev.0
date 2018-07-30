Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fMH82xBXzF16W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:23:00 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6UEEQfd098570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 10:22:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kj338v2r6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 10:22:57 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 30 Jul 2018 15:22:55 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Subject: Re: [PATCH 3/3] powerpc/pseries/mm: call H_BLOCK_REMOVE
In-Reply-To: <877elcj0oa.fsf@concordia.ellerman.id.au>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
 <877elcj0oa.fsf@concordia.ellerman.id.au>
Date: Mon, 30 Jul 2018 19:52:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87fu00olaf.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi Laurent,
>
> Just one comment below.
>
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platfo=
rms/pseries/lpar.c
>> index 96b8cd8a802d..41ed03245eb4 100644
>> --- a/arch/powerpc/platforms/pseries/lpar.c
>> +++ b/arch/powerpc/platforms/pseries/lpar.c
>> @@ -418,6 +418,73 @@ static void pSeries_lpar_hpte_invalidate(unsigned l=
ong slot, unsigned long vpn,
>>  	BUG_ON(lpar_rc !=3D H_SUCCESS);
>>  }
>>=20=20
>> +
>> +/*
>> + * As defined in the PAPR's section 14.5.4.1.8
>> + * The control mask doesn't include the returned reference and change b=
it from
>> + * the processed PTE.
>> + */
>> +#define HBLKR_AVPN		0x0100000000000000UL
>> +#define HBLKR_CTRL_MASK		0xf800000000000000UL
>> +#define HBLKR_CTRL_SUCCESS	0x8000000000000000UL
>> +#define HBLKR_CTRL_ERRNOTFOUND	0x8800000000000000UL
>> +#define HBLKR_CTRL_ERRBUSY	0xa000000000000000UL
>> +
>> +/**
>> + * H_BLOCK_REMOVE caller.
>> + * @idx should point to the latest @param entry set with a PTEX.
>> + * If PTE cannot be processed because another CPUs has already locked t=
hat
>> + * group, those entries are put back in @param starting at index 1.
>> + * If entries has to be retried and @retry_busy is set to true, these e=
ntries
>> + * are retried until success. If @retry_busy is set to false, the retur=
ned
>> + * is the number of entries yet to process.
>> + */
>> +static unsigned long call_block_remove(unsigned long idx, unsigned long=
 *param,
>> +				       bool retry_busy)
>> +{
>> +	unsigned long i, rc, new_idx;
>> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
>> +
>> +again:
>> +	new_idx =3D 0;
>> +	BUG_ON((idx < 2) || (idx > PLPAR_HCALL9_BUFSIZE));
>
> I count 1 ..
>
>> +	if (idx < PLPAR_HCALL9_BUFSIZE)
>> +		param[idx] =3D HBR_END;
>> +
>> +	rc =3D plpar_hcall9(H_BLOCK_REMOVE, retbuf,
>> +			  param[0], /* AVA */
>> +			  param[1],  param[2],  param[3],  param[4], /* TS0-7 */
>> +			  param[5],  param[6],  param[7],  param[8]);
>> +	if (rc =3D=3D H_SUCCESS)
>> +		return 0;
>> +
>> +	BUG_ON(rc !=3D H_PARTIAL);
>
> 2 ...
>
>> +	/* Check that the unprocessed entries were 'not found' or 'busy' */
>> +	for (i =3D 0; i < idx-1; i++) {
>> +		unsigned long ctrl =3D retbuf[i] & HBLKR_CTRL_MASK;
>> +
>> +		if (ctrl =3D=3D HBLKR_CTRL_ERRBUSY) {
>> +			param[++new_idx] =3D param[i+1];
>> +			continue;
>> +		}
>> +
>> +		BUG_ON(ctrl !=3D HBLKR_CTRL_SUCCESS
>> +		       && ctrl !=3D HBLKR_CTRL_ERRNOTFOUND);
>
> 3 ...
>
> BUG_ON()s.
>
> I know the code in this file is already pretty liberal with the use of
> BUG_ON() but I'd prefer if we don't make it any worse.
>
> Given this is an optimisation it seems like we should be able to fall
> back to the existing implementation in the case of error (which will
> probably then BUG_ON() =F0=9F=98=82)
>
> If there's some reason we can't then I guess I can live with it.

It would be nice to log the error in case we are not expecting the
error return. We recently did
https://marc.info/?i=3D20180629083904.29250-1-aneesh.kumar@linux.ibm.com

-aneesh
