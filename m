Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DB452C0314
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 22:53:01 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 4 Mar 2013 17:19:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7FBC41258055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 17:23:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r24BqmAb24051942
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Mar 2013 17:22:48 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r24BqowD030245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Mar 2013 22:52:50 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V1 09/24] powerpc: Decode the pte-lp-encoding bits
 correctly.
In-Reply-To: <20130304054848.GE27523@drongo>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130304054848.GE27523@drongo>
Date: Mon, 04 Mar 2013 17:22:50 +0530
Message-ID: <87vc971iwd.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Feb 26, 2013 at 01:34:59PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>=20
>> +static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
>> +{
>> +	unsigned int mask;
>> +	int i, penc, shift;
>> +	/* Look at the 8 bit LP value */
>> +	unsigned int lp =3D (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
>> +
>> +	penc =3D 0;
>> +	for (i =3D 0; i < MMU_PAGE_COUNT; i++) {
>> +		/* valid entries have a shift value */
>> +		if (!mmu_psize_defs[i].shift)
>> +			continue;
>> +
>> +		/* encoding bits per actual page size */
>> +		shift =3D mmu_psize_defs[i].shift - 11;
>> +		if (shift > 9)
>> +			shift =3D 9;
>> +		mask =3D (1 << shift) - 1;
>> +		if ((lp & mask) =3D=3D mmu_psize_defs[psize].penc[i])
>> +			return i;
>> +	}
>> +	return -1;
>> +}
>
> This doesn't look right to me.  First, it's not clear what the 11 and
> 9 refer to, and I think the 9 should be LP_BITS (i.e. 8).  Secondly,
> the mask for the comparison needs to depend on the actual page size
> not the base page size.

How about the below. I am yet to test this in user space.=20

static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
{
	unsigned int mask;
	int i, penc, shift;
	/* Look at the 8 bit LP value */
	unsigned int lp =3D (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);

	penc =3D 0;
	for (i =3D 0; i < MMU_PAGE_COUNT; i++) {
		/* valid entries have a shift value */
		if (!mmu_psize_defs[i].shift)
			continue;
		/*
		 * encoding bits per actual page size
		 *        PTE LP     actual page size
		 *    rrrr rrrz		=E2=89=A58KB
		 *    rrrr rrzz		=E2=89=A516KB
		 *    rrrr rzzz		=E2=89=A532KB
		 *    rrrr zzzz		=E2=89=A564KB
		 * .......
		 */
		shift =3D mmu_psize_defs[i].shift -
				mmu_psize_defs[MMU_PAGE_4K].shift;
		if (shift > LP_BITS)
			shift =3D LP_BITS;
		mask =3D (1 << shift) - 1;
		if ((lp & mask) =3D=3D mmu_psize_defs[psize].penc[i])
			return i;
	}
	return -1;
}
