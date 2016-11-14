Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHBC22FrLzDvQr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:26:06 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 144so5142466pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 16:26:06 -0800 (PST)
Received: from balbir.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id y134sm7007514pfg.81.2016.11.13.16.26.02
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Nov 2016 16:26:03 -0800 (PST)
Subject: Re: [PATCH] powerpc/64: Simplify adaptation to new ISA v3.00 HPTE
 format
To: linuxppc-dev@lists.ozlabs.org
References: <20161111055503.z4b6urq7xkgworrw@oak.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <cf75750b-5c11-ce06-381b-a208da30b7b3@gmail.com>
Date: Mon, 14 Nov 2016 11:26:00 +1100
MIME-Version: 1.0
In-Reply-To: <20161111055503.z4b6urq7xkgworrw@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/11/16 16:55, Paul Mackerras wrote:
> This changes the way that we support the new ISA v3.00 HPTE format.
> Instead of adapting everything that uses HPTE values to handle either
> the old format or the new format, depending on which CPU we are on,
> we now convert explicitly between old and new formats if necessary
> in the low-level routines that actually access HPTEs in memory.
> This limits the amount of code that needs to know about the new
> format and makes the conversions explicit.  This is OK because the
> old format contains all the information that is in the new format.
> 
> This also fixes operation under a hypervisor, because the H_ENTER
> hypercall (and other hypercalls that deal with HPTEs) will continue
> to require the HPTE value to be supplied in the old format.  At
> present the kernel will not boot in HPT mode on POWER9 under a
> hypervisor.
> 
> This fixes and partially reverts commit 50de596de8be
> ("powerpc/mm/hash: Add support for Power9 Hash", 2016-04-29).
> 
> Fixes: 50de596de8be
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 47 ++++++++++++++++++++++-----
>  arch/powerpc/mm/hash_native_64.c              | 30 +++++++++++++----
>  arch/powerpc/platforms/ps3/htab.c             |  2 +-
>  arch/powerpc/platforms/pseries/lpar.c         |  2 +-
>  4 files changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index e407af2..2e6a823 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -70,7 +70,9 @@
>  
>  #define HPTE_V_SSIZE_SHIFT	62
>  #define HPTE_V_AVPN_SHIFT	7
> +#define HPTE_V_COMMON_BITS	ASM_CONST(0x000fffffffffffff)
>  #define HPTE_V_AVPN		ASM_CONST(0x3fffffffffffff80)
> +#define HPTE_V_AVPN_3_0		ASM_CONST(0x000fffffffffff80)
>  #define HPTE_V_AVPN_VAL(x)	(((x) & HPTE_V_AVPN) >> HPTE_V_AVPN_SHIFT)
>  #define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & 0xffffffffffffff80UL))
>  #define HPTE_V_BOLTED		ASM_CONST(0x0000000000000010)
> @@ -80,14 +82,16 @@
>  #define HPTE_V_VALID		ASM_CONST(0x0000000000000001)
>  
>  /*
> - * ISA 3.0 have a different HPTE format.
> + * ISA 3.0 has a different HPTE format.
>   */
>  #define HPTE_R_3_0_SSIZE_SHIFT	58
> +#define HPTE_R_3_0_SSIZE_MASK	(3ull << HPTE_R_3_0_SSIZE_SHIFT)
>  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
>  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
>  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
>  #define HPTE_R_RPN_SHIFT	12
>  #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
> +#define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
>  #define HPTE_R_PP		ASM_CONST(0x0000000000000003)
>  #define HPTE_R_PPP		ASM_CONST(0x8000000000000003)
>  #define HPTE_R_N		ASM_CONST(0x0000000000000004)
> @@ -316,12 +320,43 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
>  	 */
>  	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
>  	v <<= HPTE_V_AVPN_SHIFT;
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> -		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
> +	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
>  	return v;
>  }
>  
>  /*
> + * ISA v3.0 defines a new HPTE format, which differs from the old
> + * format in having smaller AVPN and ARPN fields, and the B field
> + * in the second dword instead of the first.
> + */
> +static inline unsigned long hpte_old_to_new_v(unsigned long v)
> +{
> +	/* trim AVPN, drop B */
> +	return v & HPTE_V_COMMON_BITS;
> +}
> +
> +static inline unsigned long hpte_old_to_new_r(unsigned long v, unsigned long r)
> +{
> +	/* move B field from 1st to 2nd dword, trim ARPN */
> +	return (r & ~HPTE_R_3_0_SSIZE_MASK) |
> +		(((v) >> HPTE_V_SSIZE_SHIFT) << HPTE_R_3_0_SSIZE_SHIFT);
> +}
> +
> +static inline unsigned long hpte_new_to_old_v(unsigned long v, unsigned long r)
> +{
> +	/* insert B field */
> +	return (v & HPTE_V_COMMON_BITS) |
> +		((r & HPTE_R_3_0_SSIZE_MASK) <<
> +		 (HPTE_V_SSIZE_SHIFT - HPTE_R_3_0_SSIZE_SHIFT));
> +}
> +
> +static inline unsigned long hpte_new_to_old_r(unsigned long r)
> +{
> +	/* clear out B field */
> +	return r & ~HPTE_R_3_0_SSIZE_MASK;
> +}
> +

I wonder if we can encapsulate the name and ISA version check inside the helpers and like
Aneesh suggested call them as newv3 as opposed to new_?

> +/*
>   * This function sets the AVPN and L fields of the HPTE  appropriately
>   * using the base page size and actual page size.
>   */
> @@ -341,12 +376,8 @@ static inline unsigned long hpte_encode_v(unsigned long vpn, int base_psize,
>   * aligned for the requested page size
>   */
>  static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
> -					  int actual_psize, int ssize)
> +					  int actual_psize)
>  {
> -
> -	if (cpu_has_feature(CPU_FTR_ARCH_300))
> -		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
> -
>  	/* A 4K page needs no special encoding */
>  	if (actual_psize == MMU_PAGE_4K)
>  		return pa & HPTE_R_RPN;
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index 83ddc0e..ad9fd52 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -221,13 +221,18 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
>  		return -1;
>  
>  	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
> -	hpte_r = hpte_encode_r(pa, psize, apsize, ssize) | rflags;
> +	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
>  
>  	if (!(vflags & HPTE_V_BOLTED)) {
>  		DBG_LOW(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
>  			i, hpte_v, hpte_r);
>  	}
>  
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		hpte_r = hpte_old_to_new_r(hpte_v, hpte_r);
> +		hpte_v = hpte_old_to_new_v(hpte_v);

I don't think its called out, but it seems like we have a depedency where
hpte_old_to_new_r MUST be called prior to hpte_old_to_new_v, since we need
the v bit to be extracted and moved to the _r bit. I suspect one way to avoid
that dependency is to pass the ssize_field or to do both conversions at once.

Otherwise this looks good

Balbir Singh
