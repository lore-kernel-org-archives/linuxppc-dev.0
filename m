Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F89EDE052
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:57:49 +1100 (EST)
Subject: Re: [PATCH] [powerpc v2] update xmon slb code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
In-Reply-To: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
References: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 11:57:41 +1100
Message-Id: <1193792261.9928.82.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-30 at 16:50 -0500, Will Schmidt wrote:
> [powerpc] update xmon slb code
> 
> This adds a bit more detail to the xmon SLB output.  When the valid bit is
> set, This displays the ESID and VSID values, as well as decoding the
> segment size. (1T or 256M).  This supresses the output for any slb entries
> that contain only zeros.
> 
> sample output from power6 (1T segment support):

 .../....

> 
> Tested on power5 and power6.
> 
> Signed-Off-By: Will Schmidt <will_schmidt@vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> This version adds padding around the ESID and VSID fields, and the LLP bits
> are displayed too.  (Per request from Olof and Ben).
> I'll try to follow up sometime later with code that will handle decoding page
> sizes.  I dont have a testcase handy to properly exercise that yet. :-)
> ---
> 
>  arch/powerpc/xmon/xmon.c |   27 +++++++++++++++++++++------
>  1 files changed, 21 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 121b04d..93c26c3 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2527,16 +2527,31 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
>  static void dump_slb(void)
>  {
>  	int i;
> -	unsigned long tmp;
> +	unsigned long esid,vsid,valid;
> +	unsigned long llp_bits;
>  
>  	printf("SLB contents of cpu %x\n", smp_processor_id());
>  
>  	for (i = 0; i < SLB_NUM_ENTRIES; i++) {
> -		asm volatile("slbmfee  %0,%1" : "=r" (tmp) : "r" (i));
> -		printf("%02d %016lx ", i, tmp);
> -
> -		asm volatile("slbmfev  %0,%1" : "=r" (tmp) : "r" (i));
> -		printf("%016lx\n", tmp);
> +		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
> +		asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
> +		valid = (esid & SLB_ESID_V);
> +		if (valid | esid | vsid) {
> +			printf("%02d %016lx %016lx", i, esid, vsid);
> +			if (valid) {
> +				llp_bits = vsid & SLB_VSID_LLP;
> +				if (vsid & SLB_VSID_B_1T) {
> +					printf("  1T  ESID=%9lx  VSID=%10lx LLP bits:%3lx \n",
> +						GET_ESID_1T(esid),vsid >> SLB_VSID_SHIFT_1T,
> +						llp_bits);
> +				} else {
> +					printf(" 256M ESID=%9lx  VSID=%10lx LLP bits:%3lx \n",
> +						GET_ESID(esid),vsid >> SLB_VSID_SHIFT,
> +						llp_bits);
> +				}
> +			} else
> +				printf("\n");
> +		}
>  	}
>  }
>  
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
