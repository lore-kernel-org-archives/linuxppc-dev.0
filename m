Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE051B6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 13:35:39 +1000 (EST)
Subject: Re: [PATCH 1/1]  powerpc/eeh: Add support for ibm,configure-pe
	RTAS call
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
In-Reply-To: <4D9CEE45.9000904@linux.vnet.ibm.com>
References: <4D9CEE45.9000904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Apr 2011 13:35:31 +1000
Message-ID: <1302147331.2458.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-06 at 15:50 -0700, Richard A Lary wrote:
> From: Richard A. Lary <rlary@linux.vnet.ibm.com>
> 
> Added support for ibm,configure-pe RTAS call introduced with
> PAPR 2.2.

Care to tell us a bit about the difference ? :-) There's nothing obvious
in the code.... Also you added calls to rtas_configure_bridge() and
eeh_restore_bars() to eeh_slot_error_Detail(), that might want some
explanation as well.

Cheers,
Ben.

> Signed-off-by: Richard A. Lary <rlary@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/eeh.c |   13 	12 +	1 -	0 !
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Index: b/arch/powerpc/platforms/pseries/eeh.c
> ===================================================================
> --- a/arch/powerpc/platforms/pseries/eeh.c
> +++ b/arch/powerpc/platforms/pseries/eeh.c
> @@ -95,6 +95,7 @@ static int ibm_slot_error_detail;
>   static int ibm_get_config_addr_info;
>   static int ibm_get_config_addr_info2;
>   static int ibm_configure_bridge;
> +static int ibm_configure_pe;
> 
>   int eeh_subsystem_enabled;
>   EXPORT_SYMBOL(eeh_subsystem_enabled);
> @@ -263,6 +264,8 @@ void eeh_slot_error_detail(struct pci_dn
>   	pci_regs_buf[0] = 0;
> 
>   	rtas_pci_enable(pdn, EEH_THAW_MMIO);
> +	rtas_configure_bridge(pdn);
> +	eeh_restore_bars(pdn);
>   	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
> 
>   	rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
> @@ -896,6 +899,7 @@ void
>   rtas_configure_bridge(struct pci_dn *pdn)
>   {
>   	int config_addr;
> +	int token;
>   	int rc;
> 
>   	/* Use PE configuration address, if present */
> @@ -903,7 +907,13 @@ rtas_configure_bridge(struct pci_dn *pdn
>   	if (pdn->eeh_pe_config_addr)
>   		config_addr = pdn->eeh_pe_config_addr;
> 
> -	rc = rtas_call(ibm_configure_bridge,3,1, NULL,
> +	/* Use new configure-pe function, if supported */
> +	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE)
> +		token = ibm_configure_pe;
> +	else
> +		token = ibm_configure_bridge;
> +
> +	rc = rtas_call(token, 3, 1, NULL,
>   	               config_addr,
>   	               BUID_HI(pdn->phb->buid),
>   	               BUID_LO(pdn->phb->buid));
> @@ -1079,6 +1089,7 @@ void __init eeh_init(void)
>   	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
>   	ibm_get_config_addr_info2 = rtas_token("ibm,get-config-addr-info2");
>   	ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
> +	ibm_configure_pe = rtas_token("ibm,configure-pe");
> 
>   	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
>   		return;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
