Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 9026568802
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Dec 2005 03:36:58 +1100 (EST)
Message-ID: <1133631393.4391d7a100a42@webmail.televes.com:443>
Date: Sat,  3 Dec 2005 18:36:33 +0100
From: Alex BASTOS <alebas@televes.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <1133520697.4390273987a6a@webmail.televes.com:443>
	<4390223C.8060103@ru.mvista.com>
	<1133531801.4390529995cfa@webmail.televes.com:443>
	<1133534967.43905ef73521a@webmail.televes.com:443>
	<4390604D.50002@ru.mvista.com>
In-Reply-To: <4390604D.50002@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly,


> Alex,
> please probe this. If it will not help, pq2ads_setup_pci should be digged for
> some board specifics.
>

I'll give it a try. Unfortunately (or fortunately), i won't be in the lab for
a week (i am on holidays). I will comment you then.


> Also, check if hose->set_cfg_type is 1 as done for ads8272.
>
Yes, it is.


Best regards,

Alex


> -------- Original Message --------
> Subject: [patch 01/34] ppc32: Fix incorrect PCI frequency value
> Date: Thu, 01 Dec 2005 00:51:15 -0800
> From: akpm@osdl.org
> To: torvalds@osdl.org
> CC: akpm@osdl.org, vbordug@ru.mvista.com, galak@kernel.crashing.org
>
>
> From: Vitaly Bordug <vbordug@ru.mvista.com>
>
> The time to wait after deasserting PCI_RST has been counted with incorrect
> value - this patch fixes the issue.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/ppc/syslib/m82xx_pci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
>
> diff -puN arch/ppc/syslib/m82xx_pci.c~ppc32-fix-incorrect-pci-frequency-value
> arch/ppc/syslib/m82xx_pci.c
> ---
>
devel/arch/ppc/syslib/m82xx_pci.c~ppc32-fix-incorrect-pci-frequency-value	2005-11-30
> 23:58:00.000000000 -0800
> +++ devel-akpm/arch/ppc/syslib/m82xx_pci.c	2005-11-30 23:58:00.000000000
> -0800
> @@ -248,7 +248,8 @@ pq2ads_setup_pci(struct pci_controller *
>  	pci_div = ( (sccr & SCCR_PCI_MODCK) ? 2 : 1) *
>  			( ( (sccr & SCCR_PCIDF_MSK) >> SCCR_PCIDF_SHIFT) + 1);
>  	freq = (uint)((2*binfo->bi_cpmfreq)/(pci_div));
> -	time = (int)666666/freq;
> +	time = (int)66666666/freq;
> +
>  	/* due to PCI Local Bus spec, some devices needs to wait such a long
>  	time after RST 	deassertion. More specifically, 0.508s for 66MHz & twice
> more for 33 */
>  	printk("%s: The PCI bus is %d Mhz.\nWaiting %s after deasserting
> RST...\n",__FILE__,freq,
> _
>
>
>
> --
> Sincerely,
> Vitaly
>
