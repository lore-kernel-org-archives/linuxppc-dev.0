Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0DAADDF82
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:43:17 +1000 (EST)
Subject: Re: [Patch ] Kexec Kdump support for POWER6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sachinp@in.ibm.com
In-Reply-To: <465D099B.3020207@in.ibm.com>
References: <465D099B.3020207@in.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:43:03 +1000
Message-Id: <1180525383.19517.264.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 10:50 +0530, Sachin P. Sant wrote:
> Paul, here is the final version of the patch with all review
> comments incorporated. 
> 
> Thanks
> -Sachin
> 
> 
> plain text document attachment (kexec-kdump-support-on-POWER6)
> * On Power machines supporting VRMA, Kexec/Kdump does not work.
> * Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
> * Make sure these hpte entries are left untouched.
> *
> * This patch also adds plpar_pte_read_raw() on the lines of
> * plpar_pte_remove_raw().
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---

> diff -Naurp a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> --- a/arch/powerpc/platforms/pseries/lpar.c	2007-05-19 09:36:17.000000000 +0530
> +++ b/arch/powerpc/platforms/pseries/lpar.c	2007-05-29 10:45:34.000000000 +0530
> @@ -373,12 +373,23 @@ static void pSeries_lpar_hptab_clear(voi
>  {
>  	unsigned long size_bytes = 1UL << ppc64_pft_size;
>  	unsigned long hpte_count = size_bytes >> 4;
> -	unsigned long dummy1, dummy2;
> +	unsigned long dummy1, dummy2, dword0;
> +	long lpar_rc;
>  	int i;
>  
>  	/* TODO: Use bulk call */
> -	for (i = 0; i < hpte_count; i++)
> -		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +	for (i = 0; i < hpte_count; i++) {
> +		/* dont remove HPTEs with VRMA mappings */
> +		lpar_rc = plpar_pte_remove_raw(H_ANDCOND, i, HPTE_V_1TB_SEG,
> +						&dummy1, &dummy2);
> +		if (lpar_rc == H_NOT_FOUND) {
> +			lpar_rc = plpar_pte_read_raw(0, i, &dword0, &dummy1);
> +			if (!lpar_rc && ((dword0 & HPTE_V_VRMA_MASK)
> +				!= HPTE_V_VRMA_MASK))
> +				/* Can be hpte for 1TB Seg. So remove it */
> +				plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +		}
> +	}
>  }
>  
>  /*
> diff -Naurp a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
> --- a/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-19 09:36:17.000000000 +0530
> +++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-25 12:20:38.000000000 +0530
> @@ -108,6 +108,21 @@ static inline long plpar_pte_read(unsign
>  	return rc;
>  }
>  
> +/* plpar_pte_read_raw can be called in real mode. It calls plpar_hcall_raw */
> +static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
> +		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
> +{
> +	long rc;
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> +
> +	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
> +
> +	*old_pteh_ret = retbuf[0];
> +	*old_ptel_ret = retbuf[1];
> +
> +	return rc;
> +}
> +
>  static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
>  		unsigned long avpn)
>  {
> diff -Naurp a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
> --- a/include/asm-powerpc/mmu-hash64.h	2007-05-19 09:36:17.000000000 +0530
> +++ b/include/asm-powerpc/mmu-hash64.h	2007-05-29 10:46:22.000000000 +0530
> @@ -94,6 +94,9 @@ extern char initial_stab[];
>  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
>  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
>  
> +#define HPTE_V_1TB_SEG          ASM_CONST(0x4000000000000000)
> +#define HPTE_V_VRMA_MASK        ASM_CONST(0x4001ffffff000000)
> +
>  /* Values for PP (assumes Ks=0, Kp=1) */
>  /* pp0 will always be 0 for linux     */
>  #define PP_RWXX	0	/* Supervisor read/write, User none */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
