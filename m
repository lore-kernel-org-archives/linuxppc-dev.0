Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 685422C040F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 18:57:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v5 3/5] dma: of: Add common xlate function for
 matching by channel id
Date: Fri, 1 Nov 2013 08:52:05 +0100
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-4-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1383290374-17484-4-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201311010852.05709.arnd@arndb.de>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 01 November 2013, Alexander Popov wrote:

> + * of_dma_xlate_by_chan_id - Translate dt property to DMA channel by channel id
> + * @dma_spec:	pointer to DMA specifier as found in the device tree
> + * @of_dma:	pointer to DMA controller data
> + *
> + * This function can be used as the of xlate callback for DMA driver which wants
> + * to match the channel based on the channel id. When using this xlate function
> + * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
> + * The data parameter of of_dma_controller_register must be a pointer to the
> + * dma_device struct the function should match upon.
> + *
> + * Returns pointer to appropriate dma channel on success or NULL on error.
> + */
> +struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct of_dma_filter_by_chan_id_args args;
> +	dma_cap_mask_t cap;
> +
> +	args.dev = ofdma->of_dma_data;
> +	if (!args.dev)
> +		return NULL;
> +
> +	if (dma_spec->args_count != 1)
> +		return NULL;
> +
> +	dma_cap_zero(cap);
> +	dma_cap_set(DMA_SLAVE, cap);
> +
> +	args.chan_id = dma_spec->args[0];
> +
> +	return dma_request_channel(cap, of_dma_filter_by_chan_id, &args);
> +}
> +EXPORT_SYMBOL_GPL(of_dma_xlate_by_chan_id);

This seems rather clumsy, now that we have added the dma_get_slave_channel interface.
Can you try using that instead of dma_request_channel() now?
