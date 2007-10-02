Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACC85DDE16
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:20:40 +1000 (EST)
Subject: Re: [PATCH 7/7] Remove msic_dcr_read() and use dcr_map_reg() in
	axon_msi.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <f2d1c6be4dd138a847c2573ae1cde5c2ac253dfa.1190009070.git.michael@ellerman.id.au>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<f2d1c6be4dd138a847c2573ae1cde5c2ac253dfa.1190009070.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:20:21 +1000
Message-Id: <1191302421.6310.82.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> msic_dcr_read() doesn't really do anything useful, just replace it with
> direct calls to dcr_read().
> 
> Use dcr_map_reg() in the axon_msi setup code, rather than essentially doing
> it by hand.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/axon_msi.c |   22 +++-------------------
>  1 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 26a5e88..57a6149 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -80,18 +80,13 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
>  	dcr_write(msic->dcr_host, dcr_n, val);
>  }
>  
> -static u32 msic_dcr_read(struct axon_msic *msic, unsigned int dcr_n)
> -{
> -	return dcr_read(msic->dcr_host, dcr_n);
> -}
> -
>  static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct axon_msic *msic = get_irq_data(irq);
>  	u32 write_offset, msi;
>  	int idx;
>  
> -	write_offset = msic_dcr_read(msic, MSIC_WRITE_OFFSET_REG);
> +	write_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG);
>  	pr_debug("axon_msi: original write_offset 0x%x\n", write_offset);
>  
>  	/* write_offset doesn't wrap properly, so we have to mask it */
> @@ -306,7 +301,7 @@ static int axon_msi_notify_reboot(struct notifier_block *nb,
>  	list_for_each_entry(msic, &axon_msic_list, list) {
>  		pr_debug("axon_msi: disabling %s\n",
>  			  msic->irq_host->of_node->full_name);
> -		tmp  = msic_dcr_read(msic, MSIC_CTRL_REG);
> +		tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG);
>  		tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
>  		msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
>  	}
> @@ -323,7 +318,6 @@ static int axon_msi_setup_one(struct device_node *dn)
>  	struct page *page;
>  	struct axon_msic *msic;
>  	unsigned int virq;
> -	int dcr_base, dcr_len;
>  
>  	pr_debug("axon_msi: setting up dn %s\n", dn->full_name);
>  
> @@ -334,17 +328,7 @@ static int axon_msi_setup_one(struct device_node *dn)
>  		goto out;
>  	}
>  
> -	dcr_base = dcr_resource_start(dn, 0);
> -	dcr_len = dcr_resource_len(dn, 0);
> -
> -	if (dcr_base == 0 || dcr_len == 0) {
> -		printk(KERN_ERR
> -		       "axon_msi: couldn't parse dcr properties on %s\n",
> -			dn->full_name);
> -		goto out;
> -	}
> -
> -	msic->dcr_host = dcr_map(dn, dcr_base, dcr_len);
> +	msic->dcr_host = dcr_map_reg(dn, 0);
>  	if (!DCR_MAP_OK(msic->dcr_host)) {
>  		printk(KERN_ERR "axon_msi: dcr_map failed for %s\n",
>  		       dn->full_name);
