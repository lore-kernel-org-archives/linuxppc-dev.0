Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13EE1B711C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 03:52:09 +1000 (EST)
Date: Tue, 28 Sep 2010 12:52:06 -0500
From: Olof Johansson <olof@lixom.net>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 1/1  v2 ]  Add kernel parameter to disable batched hcalls
Message-ID: <20100928175206.GA15783@lixom.net>
References: <1285364655.3016.25.camel@lexx> <20100926034903.GA5473@lixom.net>
	<1285693371.2843.43.camel@lexx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285693371.2843.43.camel@lexx>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nice. I've got minor nits below, and you might also want to run the patch
through checkpatch and fix up some of the whitespace warnings.


-Olof

On Tue, Sep 28, 2010 at 12:02:51PM -0500, Will Schmidt wrote:
> 
> This introduces a pair of kernel parameters that can be used to disable
> the MULTITCE and BULK_REMOVE h-calls. 
> 
> By default, those hcalls are enabled, active, and good for throughput
> and performance.  The ability to disable them will be useful for some of
> the PREEMPT_RT related investigation and work occurring on Power.
> 
> 
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> cc: Olof Johansson <olof@lixom.net>
> cc: Anton Blanchard <anton@samba.org>
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
> 
> v2 - Per feedback from Olof, the code is reworked to utilize kernel
> parameter runtime checks, rather than CONFIG options.
>    - Added relevant change to kernel-parameters.txt
> 
> 
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index e2c7487..5c40801 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -426,6 +426,10 @@ and is between 256 and 4096 characters. It is defined in the file
>  	bttv.pll=	See Documentation/video4linux/bttv/Insmod-options
>  	bttv.tuner=	and Documentation/video4linux/bttv/CARDLIST
>  
> +	bulk_remove=off	[PPC]  This parameter disables the use of the pSeries
> +			firmware feature for flushing multiple hpte entries
> +			at a time.
> +
>  	BusLogic=	[HW,SCSI]
>  			See drivers/scsi/BusLogic.c, comment before function
>  			BusLogic_ParseDriverOptions().
> @@ -1499,6 +1503,10 @@ and is between 256 and 4096 characters. It is defined in the file
>  	mtdparts=	[MTD]
>  			See drivers/mtd/cmdlinepart.c.
>  
> +	multitce=off	[PPC]  This parameter disables the use of the pSeries
> +			firmware feature for updating multiple TCE entries
> +			at a time.
> +
>  	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
>  
>  			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 902987d..e174a2f 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -625,3 +625,19 @@ void iommu_init_early_pSeries(void)
>  	set_pci_dma_ops(&dma_iommu_ops);
>  }
>  
> +static int __init disable_multitce(char *str)
> +{
> +	if (strcmp(str,"off")==0) {
> +		if (firmware_has_feature(FW_FEATURE_LPAR)) {
> +			if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
> +				printk(KERN_INFO "Disabling MULTITCE firmware feature\n");
> +				ppc_md.tce_build = tce_build_pSeriesLP;
> +				ppc_md.tce_free	 = tce_free_pSeriesLP;
> +				powerpc_firmware_features &= ~FW_FEATURE_MULTITCE;
> +			}
> +		}
> +	}

I personally prefer to keep cases like these in one if statement to save indentation:

	if (strcmp(str, "off") == 0 &&
	    firmware_has_feature(FW_FEATURE_LPAR) &&
	    firmware_has_feature(FW_FEATURE_MULTITCE)) {
		<...>
	}

> +	return 1;
> +}
> +
> +__setup("multitce=",disable_multitce);
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 0707653..82d15e7 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -599,6 +599,19 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
>  		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
>  }
>  
> +static int __init disable_bulk_remove(char *str)
> +{
> +	if (strcmp(str,"off")==0) {
> +		if (firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
> +			printk(KERN_INFO "Disabling BULK_REMOVE firmware feature");
> +			powerpc_firmware_features &= ~FW_FEATURE_BULK_REMOVE;
> +		}
> +	}

Same here.

> +	return 1;
> +}
> +
> +__setup("bulk_remove=",disable_bulk_remove);
> +
>  void __init hpte_init_lpar(void)
>  {
>  	ppc_md.hpte_invalidate	= pSeries_lpar_hpte_invalidate;
> 
