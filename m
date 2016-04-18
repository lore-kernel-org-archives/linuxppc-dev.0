Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpFFw6bqBzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:16:36 +1000 (AEST)
In-Reply-To: <20160415120613.1bbdc5d5@kryten>
To: Unknown sender due to SPF <linuxppc-dev@lists.ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: [1/3] powerpc: scan_features() updates incorrect bits
Message-Id: <3qpFFw5n3Gz9t3x@ozlabs.org>
Date: Mon, 18 Apr 2016 14:16:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-15-04 at 02:06:13 UTC, Unknown sender due to SPF wrote:
> The real LE feature entry in the ibm_pa_feature struct has the
> wrong number of elements. Instead of checking for byte 5, bit 0,
> we check for byte 0, bit 0, and we also incorrectly update cpu user
> feature bit 5.
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 7030b03..9a3a7c6 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -158,7 +158,7 @@ static struct ibm_pa_feature {
>  	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
>  	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>  	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
> -	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
> +	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 0, 5, 0, 0},

This should be:

> +	{CPU_FTR_REAL_LE, 0, PPC_FEATURE_TRUE_LE, 5, 0, 0},

Because the struct layout is:

static struct ibm_pa_feature {
	unsigned long	cpu_features;	/* CPU_FTR_xxx bit */
	unsigned long	mmu_features;	/* MMU_FTR_xxx bit */
	unsigned int	cpu_user_ftrs;	/* PPC_FEATURE_xxx bit */
	unsigned int	cpu_user_ftrs2;	/* PPC_FEATURE2_xxx bit */
	unsigned char	pabyte;		/* byte number in ibm,pa-features */
	unsigned char	pabit;		/* bit number (big-endian) */
	unsigned char	invert;		/* if 1, pa bit set => clear feature */
}


I'll fix it up locally.

cheers
