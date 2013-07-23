Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB9432C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 11:51:02 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 07:12:52 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 583F9E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:20:49 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6N1okOn45154396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:20:46 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6N1omb0028879
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 11:50:48 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH -V2] powerpc/mm: Use the correct SLB(LLP) encoding in
 tlbie instruction
In-Reply-To: <1372914285-30562-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1372914285-30562-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 23 Jul 2013 07:20:45 +0530
Message-ID: <87ob9um4cq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> The sllp value is stored in mmu_psize_defs in such a way that we can easily OR
> the value to get the operand for slbmte instruction. ie, the L and LP bits are
> not contiguous. Decode the bits and use them correctly in tlbie.
> regression is introduced by 1f6aaaccb1b3af8613fe45781c1aefee2ae8c6b3
> "powerpc: Update tlbie/tlbiel as per ISA doc"
>
> Reported-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from V1:
> * use #define constants instead of opencoded values
>
>  arch/powerpc/mm/hash_native_64.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index 0530ff7..c33d939 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -43,6 +43,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>  {
>  	unsigned long va;
>  	unsigned int penc;
> +	unsigned long sllp;
>
>  	/*
>  	 * We need 14 to 65 bits of va for a tlibe of 4K page
> @@ -64,7 +65,9 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>  		/* clear out bits after (52) [0....52.....63] */
>  		va &= ~((1ul << (64 - 52)) - 1);
>  		va |= ssize << 8;
> -		va |= mmu_psize_defs[apsize].sllp << 6;
> +		sllp = ((mmu_psize_defs[apsize].sllp & SLB_VSID_L) >> 6) |
> +			((mmu_psize_defs[apsize].sllp & SLB_VSID_LP) >> 4);
> +		va |= sllp << 5;
>  		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
>  			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
>  			     : "memory");
> @@ -98,6 +101,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>  {
>  	unsigned long va;
>  	unsigned int penc;
> +	unsigned long sllp;
>
>  	/* VPN_SHIFT can be atmost 12 */
>  	va = vpn << VPN_SHIFT;
> @@ -113,7 +117,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>  		/* clear out bits after(52) [0....52.....63] */
>  		va &= ~((1ul << (64 - 52)) - 1);
>  		va |= ssize << 8;
> -		va |= mmu_psize_defs[apsize].sllp << 6;
> +		sllp = ((mmu_psize_defs[apsize].sllp & SLB_VSID_L) >> 6) |
> +			((mmu_psize_defs[apsize].sllp & SLB_VSID_LP) >> 4);
> +		va |= sllp << 5;
>  		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
>  			     : : "r"(va) : "memory");
>  		break;


Any update on this ?

-aneesh
