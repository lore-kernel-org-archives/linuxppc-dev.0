Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 14:56:59 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 6/6] powerpc: Use generic code for exception
 handling
Message-ID: <20130410045659.GB15929@concordia>
References: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1364551221-23177-7-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364551221-23177-7-git-send-email-zhong@linux.vnet.ibm.com>
Cc: fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, paulus@samba.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 29, 2013 at 06:00:21PM +0800, Li Zhong wrote:
> After the exception handling moved to generic code, and some changes in
...
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 360fba8..eeab30f 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -33,6 +33,7 @@
>  #include <linux/init.h>
>  #include <linux/signal.h>
>  #include <linux/memblock.h>
> +#include <linux/context_tracking.h>
>  
>  #include <asm/processor.h>
>  #include <asm/pgtable.h>
> @@ -56,7 +57,6 @@
>  #include <asm/fadump.h>
>  #include <asm/firmware.h>
>  #include <asm/tm.h>
> -#include <asm/context_tracking.h>
>  
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
> @@ -919,13 +919,17 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>  	const struct cpumask *tmp;
>  	int rc, user_region = 0, local = 0;
>  	int psize, ssize;
> +	enum ctx_state prev_state;
> +
> +	prev_state = exception_enter();
>  
>  	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
>  		ea, access, trap);
>  
>  	if ((ea & ~REGION_MASK) >= PGTABLE_RANGE) {
>  		DBG_LOW(" out of pgtable range !\n");
> - 		return 1;
> +		rc = 1;
> +		goto exit;
>  	}
>  
>  	/* Get region & vsid */

This no longer applies on mainline, please send an updated version.

cheers
