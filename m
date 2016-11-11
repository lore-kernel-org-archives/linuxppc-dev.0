Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFMt91L2vzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:35:12 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAB1YaMD054106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:35:11 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26n35bc20j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:35:10 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 18:35:10 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Move hpte encode routine to platform specific
 files
In-Reply-To: <8f4553b4-a943-bebd-3344-f4d833d32abe@gmail.com>
References: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
 <4be06fb7-dbef-2c99-c6b5-ed56edf51bbd@gmail.com>
 <8f4553b4-a943-bebd-3344-f4d833d32abe@gmail.com>
Date: Fri, 11 Nov 2016 07:04:58 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tsq23zx.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 11/11/16 10:54, Balbir Singh wrote:
>> 
>> 
>> On 10/11/16 20:24, Aneesh Kumar K.V wrote:
>>> They differ between powernv and pseries. While we are at it copy
>>> a version for ps3 too. For now this is same as what we have for pSeries.
>>>
>>> Fixes: 50de596de8be6 ("powerpc/mm/hash: Add support for Power9 Hash")
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> 
>> I have not looked at the patch closely, but do we want all of this
>> duplication. I was wondering if instead of
>> 
>> cpu_has_feature() we could firmware_has_feature() for now
>> 
>
> Basically something like
>
> Not-yet-signed-off-by: Balbir Singh <bsingharora@gmail.com>
>
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index ac6d26e..2b23366 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -282,7 +282,8 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
>  	 */
>  	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
>  	v <<= HPTE_V_AVPN_SHIFT;
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300) ||
> +		firmware_has_feature(FW_FEATURE_LPAR))
>  		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;

I looked at this before and in the end decided to go otherwise. A large
part of that patch is comment duplication. My thinking was if the
encoding needs to be different, then it is better to have seperate
functions to do the encoding.

>  	return v;
>  }
> @@ -310,7 +311,8 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
>  					  int actual_psize, int ssize)
>  {
>
> -	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> +		!firmware_has_feature(FW_FEATURE_LPAR))
>  		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
>
>  	/* A 4K page needs no special encoding */

-aneesh
