Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED029DDEEE
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:14:39 +1000 (EST)
Subject: Re: [PATCH 4/7] Update axon_msi to use dcr_host_t.base
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <2a6b3b82775119b4a1e1fd9b290051b1fef66d55.1190009070.git.michael@ellerman.id.au>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<2a6b3b82775119b4a1e1fd9b290051b1fef66d55.1190009070.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:14:15 +1000
Message-Id: <1191302055.6310.72.camel@pasglop>
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
> Now that dcr_host_t contains the base address, we can use that in the
> axon_msi code, rather than storing it separately.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/axon_msi.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 74407af..23e039a 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -69,7 +69,6 @@ struct axon_msic {
>  	dcr_host_t dcr_host;
>  	struct list_head list;
>  	u32 read_offset;
> -	u32 dcr_base;
>  };
>  
>  static LIST_HEAD(axon_msic_list);
> @@ -78,12 +77,12 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
>  {
>  	pr_debug("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
>  
> -	dcr_write(msic->dcr_host, msic->dcr_base + dcr_n, val);
> +	dcr_write(msic->dcr_host, msic->dcr_host.base + dcr_n, val);
>  }
>  
>  static u32 msic_dcr_read(struct axon_msic *msic, unsigned int dcr_n)
>  {
> -	return dcr_read(msic->dcr_host, msic->dcr_base + dcr_n);
> +	return dcr_read(msic->dcr_host, msic->dcr_host.base + dcr_n);
>  }
>  
>  static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
> @@ -324,7 +323,7 @@ static int axon_msi_setup_one(struct device_node *dn)
>  	struct page *page;
>  	struct axon_msic *msic;
>  	unsigned int virq;
> -	int dcr_len;
> +	int dcr_base, dcr_len;
>  
>  	pr_debug("axon_msi: setting up dn %s\n", dn->full_name);
>  
> @@ -335,17 +334,17 @@ static int axon_msi_setup_one(struct device_node *dn)
>  		goto out;
>  	}
>  
> -	msic->dcr_base = dcr_resource_start(dn, 0);
> +	dcr_base = dcr_resource_start(dn, 0);
>  	dcr_len = dcr_resource_len(dn, 0);
>  
> -	if (msic->dcr_base == 0 || dcr_len == 0) {
> +	if (dcr_base == 0 || dcr_len == 0) {
>  		printk(KERN_ERR
>  		       "axon_msi: couldn't parse dcr properties on %s\n",
>  			dn->full_name);
>  		goto out;
>  	}
>  
> -	msic->dcr_host = dcr_map(dn, msic->dcr_base, dcr_len);
> +	msic->dcr_host = dcr_map(dn, dcr_base, dcr_len);
>  	if (!DCR_MAP_OK(msic->dcr_host)) {
>  		printk(KERN_ERR "axon_msi: dcr_map failed for %s\n",
>  		       dn->full_name);
