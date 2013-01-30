Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 991A72C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 18:24:06 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 30 Jan 2013 17:20:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5B1492CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 18:24:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0U7C51D2687434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 18:12:05 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0U7Nw1f016387
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 18:23:59 +1100
Message-ID: <5108CA89.4080305@linux.vnet.ibm.com>
Date: Wed, 30 Jan 2013 15:23:53 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix hash computation function
References: <1359524442-5861-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1359524442-5861-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=GB2312
Cc: paulus@samba.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the fix, the machine can boot up successfully

Tested-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

ÓÚ 2013/1/30 13:40, Aneesh Kumar K.V Ð´µÀ:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> The ASM version of hash computation function was truncating the upper bit.
> Make the ASM version similar to hpt_hash function. Remove masking vsid bits.
> Without this patch, we observed hang during bootup due to not satisfying page
> fault request correctly. The fault handler used wrong hash values to update
> the HPTE. Hence we kept looping with page fault.
>
> hash_page(ea=000001003e260008, access=203, trap=300 ip=3fff91787134 dsisr 42000000
> The computed value of hash 000000000f22f390
> update: avpnv=4003e46054003e00, hash=000000000722f390, f=80000006, psize: 2 ...
>
> Reported-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_low_64.S |   62 +++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
> index 5658508..7443481 100644
> --- a/arch/powerpc/mm/hash_low_64.S
> +++ b/arch/powerpc/mm/hash_low_64.S
> @@ -115,11 +115,13 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	sldi	r29,r5,SID_SHIFT - VPN_SHIFT
>  	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
>  	or	r29,r28,r29
> -
> -	/* Calculate hash value for primary slot and store it in r28 */
> -	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
> -	rldicl	r0,r3,64-12,48		/* (ea >> 12) & 0xffff */
> -	xor	r28,r5,r0
> +	/*
> +	 * Calculate hash value for primary slot and store it in r28
> +	 * r3 = va, r5 = vsid
> +	 * r0 = (va >> 12) & ((1ul << (28 - 12)) -1)
> +	 */
> +	rldicl	r0,r3,64-12,48
> +	xor	r28,r5,r0		/* hash */
>  	b	4f
>
>  3:	/* Calc vpn and put it in r29 */
> @@ -130,11 +132,12 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	/*
>  	 * calculate hash value for primary slot and
>  	 * store it in r28 for 1T segment
> +	 * r3 = va, r5 = vsid
>  	 */
> -	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
> -	clrldi	r5,r5,40		/* vsid & 0xffffff */
> -	rldicl	r0,r3,64-12,36		/* (ea >> 12) & 0xfffffff */
> -	xor	r28,r28,r5
> +	sldi	r28,r5,25		/* vsid << 25 */
> +	/* r0 =  (va >> 12) & ((1ul << (40 - 12)) -1) */
> +	rldicl	r0,r3,64-12,36
> +	xor	r28,r28,r5		/* vsid ^ ( vsid << 25) */
>  	xor	r28,r28,r0		/* hash */
>
>  	/* Convert linux PTE bits into HW equivalents */
> @@ -407,11 +410,13 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	 */
>  	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
>  	or	r29,r28,r29
> -
> -	/* Calculate hash value for primary slot and store it in r28 */
> -	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
> -	rldicl	r0,r3,64-12,48		/* (ea >> 12) & 0xffff */
> -	xor	r28,r5,r0
> +	/*
> +	 * Calculate hash value for primary slot and store it in r28
> +	 * r3 = va, r5 = vsid
> +	 * r0 = (va >> 12) & ((1ul << (28 - 12)) -1)
> +	 */
> +	rldicl	r0,r3,64-12,48
> +	xor	r28,r5,r0		/* hash */
>  	b	4f
>
>  3:	/* Calc vpn and put it in r29 */
> @@ -426,11 +431,12 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	/*
>  	 * Calculate hash value for primary slot and
>  	 * store it in r28  for 1T segment
> +	 * r3 = va, r5 = vsid
>  	 */
> -	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
> -	clrldi	r5,r5,40		/* vsid & 0xffffff */
> -	rldicl	r0,r3,64-12,36		/* (ea >> 12) & 0xfffffff */
> -	xor	r28,r28,r5
> +	sldi	r28,r5,25		/* vsid << 25 */
> +	/* r0 = (va >> 12) & ((1ul << (40 - 12)) -1) */
> +	rldicl	r0,r3,64-12,36
> +	xor	r28,r28,r5		/* vsid ^ ( vsid << 25) */
>  	xor	r28,r28,r0		/* hash */
>
>  	/* Convert linux PTE bits into HW equivalents */
> @@ -752,25 +758,27 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
>  	or	r29,r28,r29
>
> -	/* Calculate hash value for primary slot and store it in r28 */
> -	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
> -	rldicl	r0,r3,64-16,52		/* (ea >> 16) & 0xfff */
> -	xor	r28,r5,r0
> +	/* Calculate hash value for primary slot and store it in r28
> +	 * r3 = va, r5 = vsid
> +	 * r0 = (va >> 16) & ((1ul << (28 - 16)) -1)
> +	 */
> +	rldicl	r0,r3,64-16,52
> +	xor	r28,r5,r0		/* hash */
>  	b	4f
>
>  3:	/* Calc vpn and put it in r29 */
>  	sldi	r29,r5,SID_SHIFT_1T - VPN_SHIFT
>  	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT_1T - VPN_SHIFT)
>  	or	r29,r28,r29
> -
>  	/*
>  	 * calculate hash value for primary slot and
>  	 * store it in r28 for 1T segment
> +	 * r3 = va, r5 = vsid
>  	 */
> -	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
> -	clrldi	r5,r5,40		/* vsid & 0xffffff */
> -	rldicl	r0,r3,64-16,40		/* (ea >> 16) & 0xffffff */
> -	xor	r28,r28,r5
> +	sldi	r28,r5,25		/* vsid << 25 */
> +	/* r0 = (va >> 16) & ((1ul << (40 - 16)) -1) */
> +	rldicl	r0,r3,64-16,40
> +	xor	r28,r28,r5		/* vsid ^ ( vsid << 25) */
>  	xor	r28,r28,r0		/* hash */
>
>  	/* Convert linux PTE bits into HW equivalents */
