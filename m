Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B02012C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 17:57:15 +1000 (EST)
Message-ID: <1376035026.32100.24.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/eeh: powerpc/eeh: Fix undefined variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 17:57:06 +1000
In-Reply-To: <1375855279-28592-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1375855279-28592-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-07 at 02:01 -0400, Mike Qiu wrote:
> 'pe_no' hasn't been defined, it should be an typo error,
> it should be 'frozen_pe_no'.

For some reason I can't find v3 of this in my mailbox, but it's
on patchwork so I tried applying it and it breaks the build
because %d doesn't work for a u64. Have you even tested it ?

Ben.

> Also '__func__' has missed iz IODA_EEH_DBG(),
> 
> For safety reasons, use pr_info() directly, instead
> of use IODA_EEH_DBG()
> 
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-ioda.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index 0cd1c4a..8bc19c8 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -36,13 +36,6 @@
>  #include "powernv.h"
>  #include "pci.h"
>  
> -/* Debugging option */
> -#ifdef IODA_EEH_DBG_ON
> -#define IODA_EEH_DBG(args...)	pr_info(args)
> -#else
> -#define IODA_EEH_DBG(args...)
> -#endif
> -
>  static char *hub_diag = NULL;
>  static int ioda_eeh_nb_init = 0;
>  
> @@ -823,17 +816,17 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>  
>  		/* If OPAL API returns error, we needn't proceed */
>  		if (rc != OPAL_SUCCESS) {
> -			IODA_EEH_DBG("%s: Invalid return value on "
> -				     "PHB#%x (0x%lx) from opal_pci_next_error",
> -				     __func__, hose->global_number, rc);
> +			pr_info("%s: Invalid return value on "
> +				"PHB#%x (0x%lx) from opal_pci_next_error",
> +				__func__, hose->global_number, rc);
>  			continue;
>  		}
>  
>  		/* If the PHB doesn't have error, stop processing */
>  		if (err_type == OPAL_EEH_NO_ERROR ||
>  		    severity == OPAL_EEH_SEV_NO_ERROR) {
> -			IODA_EEH_DBG("%s: No error found on PHB#%x\n",
> -				     __func__, hose->global_number);
> +			pr_info("%s: No error found on PHB#%x\n",
> +				__func__, hose->global_number);
>  			continue;
>  		}
>  
> @@ -842,8 +835,9 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>  		 * highest priority reported upon multiple errors on the
>  		 * specific PHB.
>  		 */
> -		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
> -			err_type, severity, pe_no, hose->global_number);
> +		pr_info("%s: Error (%d, %d, %d) on PHB#%x\n",
> +			__func__, err_type, severity,
> +			frozen_pe_no, hose->global_number);
>  		switch (err_type) {
>  		case OPAL_EEH_IOC_ERROR:
>  			if (severity == OPAL_EEH_SEV_IOC_DEAD) {
