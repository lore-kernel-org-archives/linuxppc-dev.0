Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CQ3d0ZXvzF1t3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 02:08:12 +1100 (AEDT)
Date: Fri, 30 Mar 2018 17:07:46 +0200
Message-ID: <20180330170746.Horde.NVPhcnYSIfUXJm-KY0wMEw5@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 benh@kernel.crashing.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm/hash: Move the slb_addr_limit check within
 PPC_MM_SLICES
References: <20180307121539.20745-1-aneesh.kumar@linux.vnet.ibm.com>
 <87a7upzqpo.fsf@concordia.ellerman.id.au>
In-Reply-To: <87a7upzqpo.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> Should not have any impact, because we always select PP_MM_SLICES=20=20
>>=20these days.
>> Nevertheless it is good to indicate that slb_addr_limit is available onl=
y
>> with slice code.
>
> That file can only be built if PPC_MM_SLICES=3Dy.
>
> So let's just remove the ifdef entirely.
>
> These days PPC_MM_SLICES =3D=3D PPC_BOOK3S_64, so we should remove
> PPC_MM_SLICES #defines wherever possible and replace them with
> PPC_BOOK3S_64 otherwise IMO.

PPC8xx also selects PPC_MM_SLICES when hugepages is selected.

Christophe

>
> cheers
>
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index c66cb06e73a1..337ef162851d 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -166,6 +166,8 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>>  	 */
>>  	cmpdi	r9, 0
>>  	bne-	8f
>> +
>> +#ifdef CONFIG_PPC_MM_SLICES
>>          /*
>>           * user space make sure we are within the allowed limit
>>  	 */
>> @@ -183,7 +185,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>>  	 * really do dynamic patching unfortunately as processes might flip
>>  	 * between 4k and 64k standard page size
>>  	 */
>> -#ifdef CONFIG_PPC_MM_SLICES
>>  	/* r10 have esid */
>>  	cmpldi	r10,16
>>  	/* below SLICE_LOW_TOP */
>> --
>> 2.14.3
