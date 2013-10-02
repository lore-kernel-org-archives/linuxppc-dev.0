Return-Path: <michael@ellerman.id.au>
Date: Wed, 2 Oct 2013 12:18:14 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/kernel/sysfs: cleanup set up macros for
 PMC/non-PMC sprs
Message-ID: <20131002021813.GA22748@concordia>
References: <1380619393-1984-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380619393-1984-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 02:53:13PM +0530, Madhavan Srinivasan wrote:
> Currently PMC (Performance Monitor Counter) setup macros are used
> for other sprs. Since not all sprs are PMC related, this patch
> modifies the exisiting macro and uses it to setup both PMC and
> non PMC sprs accordingly.

"SPR" and "SPRs" :)

Also you should add olof@lixom.net to CC as he is the maintainer of the
pasemi platform, which most of the SPRs you're changing are for (PA6T).

> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 27a90b9..cb971c4 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -107,14 +107,14 @@ void ppc_enable_pmcs(void)
>  }
>  EXPORT_SYMBOL(ppc_enable_pmcs);
> 
> -#define SYSFS_PMCSETUP(NAME, ADDRESS) \
> +#define _SYSFS_SPRSETUP(NAME, ADDRESS, EXTRA) \

Usual style for this would be a double leading underscore, eg:

> +#define __SYSFS_SPRSETUP(NAME, ADDRESS, EXTRA) \

>  static void read_##NAME(void *val) \
>  { \
>  	*(unsigned long *)val = mfspr(ADDRESS);	\
>  } \
>  static void write_##NAME(void *val) \
>  { \
> -	ppc_enable_pmcs(); \
> +	EXTRA; \
>  	mtspr(ADDRESS, *(unsigned long *)val);	\
>  } \
>  static ssize_t show_##NAME(struct device *dev, \
> @@ -139,6 +139,11 @@ static ssize_t __used \
>  	return count; \
>  }
> 
> +#define SYSFS_EMPTY

You shouldn't need this.

> +#define SYSFS_PMCSETUP(NAME, ADDRESS)	\
> +	_SYSFS_SPRSETUP(NAME, ADDRESS, ppc_enable_pmcs())
> +#define SYSFS_SPRSETUP(NAME, ADDRESS)	\
> +	_SYSFS_SPRSETUP(NAME, ADDRESS, SYSFS_EMPTY)

Just passing "" should work.

> 
>  /* Let's define all possible registers, we'll only hook up the ones
>   * that are implemented on the current processor
> @@ -174,10 +179,10 @@ SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
>  SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
> 
>  SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
> -SYSFS_PMCSETUP(purr, SPRN_PURR);
> -SYSFS_PMCSETUP(spurr, SPRN_SPURR);
> -SYSFS_PMCSETUP(dscr, SPRN_DSCR);
> -SYSFS_PMCSETUP(pir, SPRN_PIR);
> +SYSFS_SPRSETUP(purr, SPRN_PURR);
> +SYSFS_SPRSETUP(spurr, SPRN_SPURR);
> +SYSFS_SPRSETUP(dscr, SPRN_DSCR);
> +SYSFS_SPRSETUP(pir, SPRN_PIR);
> 
>  static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
>  static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
> @@ -238,34 +243,34 @@ SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
>  SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
>  SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
>  #ifdef CONFIG_DEBUG_KERNEL
> -SYSFS_PMCSETUP(hid0, SPRN_HID0);
> -SYSFS_PMCSETUP(hid1, SPRN_HID1);
> -SYSFS_PMCSETUP(hid4, SPRN_HID4);
> -SYSFS_PMCSETUP(hid5, SPRN_HID5);
> -SYSFS_PMCSETUP(ima0, SPRN_PA6T_IMA0);
> -SYSFS_PMCSETUP(ima1, SPRN_PA6T_IMA1);
> -SYSFS_PMCSETUP(ima2, SPRN_PA6T_IMA2);
> -SYSFS_PMCSETUP(ima3, SPRN_PA6T_IMA3);
> -SYSFS_PMCSETUP(ima4, SPRN_PA6T_IMA4);
> -SYSFS_PMCSETUP(ima5, SPRN_PA6T_IMA5);
> -SYSFS_PMCSETUP(ima6, SPRN_PA6T_IMA6);
> -SYSFS_PMCSETUP(ima7, SPRN_PA6T_IMA7);
> -SYSFS_PMCSETUP(ima8, SPRN_PA6T_IMA8);
> -SYSFS_PMCSETUP(ima9, SPRN_PA6T_IMA9);
> -SYSFS_PMCSETUP(imaat, SPRN_PA6T_IMAAT);
> -SYSFS_PMCSETUP(btcr, SPRN_PA6T_BTCR);
> -SYSFS_PMCSETUP(pccr, SPRN_PA6T_PCCR);
> -SYSFS_PMCSETUP(rpccr, SPRN_PA6T_RPCCR);
> -SYSFS_PMCSETUP(der, SPRN_PA6T_DER);
> -SYSFS_PMCSETUP(mer, SPRN_PA6T_MER);
> -SYSFS_PMCSETUP(ber, SPRN_PA6T_BER);
> -SYSFS_PMCSETUP(ier, SPRN_PA6T_IER);
> -SYSFS_PMCSETUP(sier, SPRN_PA6T_SIER);
> -SYSFS_PMCSETUP(siar, SPRN_PA6T_SIAR);
> -SYSFS_PMCSETUP(tsr0, SPRN_PA6T_TSR0);
> -SYSFS_PMCSETUP(tsr1, SPRN_PA6T_TSR1);
> -SYSFS_PMCSETUP(tsr2, SPRN_PA6T_TSR2);
> -SYSFS_PMCSETUP(tsr3, SPRN_PA6T_TSR3);
> +SYSFS_SPRSETUP(hid0, SPRN_HID0);
> +SYSFS_SPRSETUP(hid1, SPRN_HID1);
> +SYSFS_SPRSETUP(hid4, SPRN_HID4);
> +SYSFS_SPRSETUP(hid5, SPRN_HID5);
> +SYSFS_SPRSETUP(ima0, SPRN_PA6T_IMA0);
> +SYSFS_SPRSETUP(ima1, SPRN_PA6T_IMA1);
> +SYSFS_SPRSETUP(ima2, SPRN_PA6T_IMA2);
> +SYSFS_SPRSETUP(ima3, SPRN_PA6T_IMA3);
> +SYSFS_SPRSETUP(ima4, SPRN_PA6T_IMA4);
> +SYSFS_SPRSETUP(ima5, SPRN_PA6T_IMA5);
> +SYSFS_SPRSETUP(ima6, SPRN_PA6T_IMA6);
> +SYSFS_SPRSETUP(ima7, SPRN_PA6T_IMA7);
> +SYSFS_SPRSETUP(ima8, SPRN_PA6T_IMA8);
> +SYSFS_SPRSETUP(ima9, SPRN_PA6T_IMA9);
> +SYSFS_SPRSETUP(imaat, SPRN_PA6T_IMAAT);
> +SYSFS_SPRSETUP(btcr, SPRN_PA6T_BTCR);
> +SYSFS_SPRSETUP(pccr, SPRN_PA6T_PCCR);
> +SYSFS_SPRSETUP(rpccr, SPRN_PA6T_RPCCR);
> +SYSFS_SPRSETUP(der, SPRN_PA6T_DER);
> +SYSFS_SPRSETUP(mer, SPRN_PA6T_MER);
> +SYSFS_SPRSETUP(ber, SPRN_PA6T_BER);
> +SYSFS_SPRSETUP(ier, SPRN_PA6T_IER);
> +SYSFS_SPRSETUP(sier, SPRN_PA6T_SIER);
> +SYSFS_SPRSETUP(siar, SPRN_PA6T_SIAR);
> +SYSFS_SPRSETUP(tsr0, SPRN_PA6T_TSR0);
> +SYSFS_SPRSETUP(tsr1, SPRN_PA6T_TSR1);
> +SYSFS_SPRSETUP(tsr2, SPRN_PA6T_TSR2);
> +SYSFS_SPRSETUP(tsr3, SPRN_PA6T_TSR3);
>  #endif /* CONFIG_DEBUG_KERNEL */
>  #endif /* HAS_PPC_PMC_PA6T */
> 
> --
> 1.7.10.4
> 
