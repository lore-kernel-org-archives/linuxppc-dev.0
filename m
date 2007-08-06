Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AD1CDDEBF
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:24:02 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76MNwwk029242
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 18:23:58 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76MNwBH268446
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 16:23:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76MNwfc010172
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 16:23:58 -0600
Message-ID: <46B79F7D.6080305@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2007 17:23:57 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Use 1TB segments
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
In-Reply-To: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>   
A couple of hunks fail in this file when applying to the current tree.

...
> diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
> index 695962f..053f86b 100644
> --- a/include/asm-powerpc/mmu-hash64.h
> +++ b/include/asm-powerpc/mmu-hash64.h
> @@ -47,6 +47,8 @@ extern char initial_stab[];
>
>  /* Bits in the SLB VSID word */
>  #define SLB_VSID_SHIFT		12
> +#define SLB_VSID_SHIFT_1T	24
> +#define SLB_VSID_SSIZE_SHIFT	62
>  #define SLB_VSID_B		ASM_CONST(0xc000000000000000)
>  #define SLB_VSID_B_256M		ASM_CONST(0x0000000000000000)
>  #define SLB_VSID_B_1T		ASM_CONST(0x4000000000000000)
> @@ -66,6 +68,7 @@ extern char initial_stab[];
>  #define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS|SLB_VSID_C)
>
>  #define SLBIE_C			(0x08000000)
> +#define SLBIE_SSIZE_SHIFT	25
>
>  /*
>   * Hash table
> @@ -77,7 +80,7 @@ extern char initial_stab[];
>  #define HPTE_V_AVPN_SHIFT	7
>  #define HPTE_V_AVPN		ASM_CONST(0x3fffffffffffff80)
>  #define HPTE_V_AVPN_VAL(x)	(((x) & HPTE_V_AVPN) >> HPTE_V_AVPN_SHIFT)
> -#define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & HPTE_V_AVPN))
> +#define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & 0xffffffffffffff80))
>  #define HPTE_V_BOLTED		ASM_CONST(0x0000000000000010)
>  #define HPTE_V_LOCK		ASM_CONST(0x0000000000000008)
>  #define HPTE_V_LARGE		ASM_CONST(0x0000000000000004)
> @@ -164,16 +167,25 @@ struct mmu_psize_def
>  #define MMU_SEGSIZE_256M	0
>  #define MMU_SEGSIZE_1T		1
>
> +/*
> + * Supported segment sizes
> + */
> +#define MMU_SEGSIZE_256M	0
> +#define MMU_SEGSIZE_1T		1
>   
It looks like this is repeating the definitions just above it.


Jon
