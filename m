Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 029252C0374
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 15:30:28 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 09:56:44 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 780E0125804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 10:01:22 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r264UK2722282458
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 10:00:20 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r264UMpA032689
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 15:30:23 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V1 09/24] powerpc: Decode the pte-lp-encoding bits
 correctly.
In-Reply-To: <20130305020205.GB2888@iris.ozlabs.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130304054848.GE27523@drongo> <87y5e31jem.fsf@linux.vnet.ibm.com>
 <20130305020205.GB2888@iris.ozlabs.ibm.com>
Date: Wed, 06 Mar 2013 10:00:21 +0530
Message-ID: <87a9qh880y.fsf@linux.vnet.ibm.com>
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

> On Mon, Mar 04, 2013 at 05:11:53PM +0530, Aneesh Kumar K.V wrote:
>> Paul Mackerras <paulus@samba.org> writes:
>> >> +static inline int hpte_actual_psize(struct hash_pte *hptep, int psiz=
e)
>> >> +{
>> >> +	unsigned int mask;
>> >> +	int i, penc, shift;
>> >> +	/* Look at the 8 bit LP value */
>> >> +	unsigned int lp =3D (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
>> >> +
>> >> +	penc =3D 0;
>> >> +	for (i =3D 0; i < MMU_PAGE_COUNT; i++) {
>> >> +		/* valid entries have a shift value */
>> >> +		if (!mmu_psize_defs[i].shift)
>> >> +			continue;
>> >> +
>> >> +		/* encoding bits per actual page size */
>> >> +		shift =3D mmu_psize_defs[i].shift - 11;
>> >> +		if (shift > 9)
>> >> +			shift =3D 9;
>> >> +		mask =3D (1 << shift) - 1;
>> >> +		if ((lp & mask) =3D=3D mmu_psize_defs[psize].penc[i])
>> >> +			return i;
>> >> +	}
>> >> +	return -1;
>> >> +}
>> >
>> > This doesn't look right to me.  First, it's not clear what the 11 and
>> > 9 refer to, and I think the 9 should be LP_BITS (i.e. 8).  Secondly,
>> > the mask for the comparison needs to depend on the actual page size
>> > not the base page size.
>>=20
>> That 11 should be 12.That depends on the fact that we have below mapping
>
> And the 12 should be LP_SHIFT, shouldn't it?

LP_SHIFT would indicate how many bit poisition need to be shifted to get
to the LP field in HPTE. I guess what we want here is shift value for 4K
page.  How about=20

shift =3D mmu_psize_defs[i].shift - mmu_psize_defs[MMU_PAGE_4K].shift;


>
>>  rrrr rrrz 	=E2=89=A58KB
>>=20
>> Yes, that 9 should be LP_BITs.=20
>>=20
>> We are generating mask based on actual page size above (variable i in
>> the for loop).
>
> OK, yes, you're right.
>
>> > I don't see where in this function you set the penc[] elements for
>> > invalid actual page sizes to -1.
>>=20
>> We do the below
>>=20
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -125,7 +125,7 @@ static struct mmu_psize_def mmu_psize_defaults_old[]=
 =3D {
>>         [MMU_PAGE_4K] =3D {
>>                 .shift  =3D 12,
>>                 .sllp   =3D 0,
>> -               .penc   =3D 0,
>> +               .penc   =3D { [0 ... MMU_PAGE_COUNT - 1] =3D -1 },
>>                 .avpnm  =3D 0,
>
> Yes, which sets them for the entries you initialize, but not for the
> others.  For example, the entry for MMU_PAGE_64K will initially be all
> zeroes.  Then we find an entry in the ibm,segment-page-sizes property
> for 64k pages, so we set mmu_psize_defs[MMU_PAGE_64K].shift to 16,
> making that entry valid, but we never set any of the .penc[] entries
> to -1, leading your other code to think that it can do (say) 1M pages
> in a 64k segment using an encoding of 0.
>

Noticed that earlier. This is what i currently have.

+static void mmu_psize_set_default_penc(struct mmu_psize_def *mmu_psize)
+{
+	int bpsize, apsize;
+	for (bpsize =3D 0; bpsize < MMU_PAGE_COUNT; bpsize++)
+		for (apsize =3D 0; apsize < MMU_PAGE_COUNT; apsize++)
+			mmu_psize[bpsize].penc[apsize] =3D -1;
+}
+
 static void __init htab_init_page_sizes(void)
 {
 	int rc;
=20
+	mmu_psize_set_default_penc(mmu_psize_defaults_old);
+
 	/* Default to 4K pages only */
 	memcpy(mmu_psize_defs, mmu_psize_defaults_old,
 	       sizeof(mmu_psize_defaults_old));
@@ -411,6 +443,8 @@ static void __init htab_init_page_sizes(void)
 	if (rc !=3D 0)  /* Found */
 		goto found;
=20
+	mmu_psize_set_default_penc(mmu_psize_defaults_gp);
+
 	/*
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
	Modified   arch/powerpc/mm/hugetlbpage-hash64.c



> Also, I noticed that the code in the if (base_idx < 0) statement is
> wrong.  It needs to advance prop (and decrease size) by 2 * lpnum,
> not just 2.
>

Ok. Fixed now.

-aneesh
