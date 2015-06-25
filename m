Return-Path: <pebolle@tiscali.nl>
Received: from lb3-smtp-cloud3.xs4all.net (lb3-smtp-cloud3.xs4all.net
 [194.109.24.30])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CDC61A0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 09:28:54 +1000 (AEST)
Message-ID: <1435274929.28572.28.camel@tiscali.nl>
Subject: Re: [v2,8/9] fsl/fman: Add FMan Port Support
From: Paul Bolle <pebolle@tiscali.nl>
To: igal.liberman@freescale.com, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com,
 madalin.bucur@freescale.com
Date: Fri, 26 Jun 2015 01:28:49 +0200
In-Reply-To: <1435174659-6876-1-git-send-email-igal.liberman@freescale.com>
References: <1435174659-6876-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-24 at 22:37 +0300, igal.liberman@freescale.com wrote:
> --- a/drivers/net/ethernet/freescale/fman/fm_drv.c
> +++ b/drivers/net/ethernet/freescale/fman/fm_drv.c

> +struct fm_port_t *fm_port_drv_handle(const struct fm_port_drv_t *port)
> +{
> +	return port->fm_port;
> +}
> +EXPORT_SYMBOL(fm_port_drv_handle);

I couldn't find any users of this function.

> +void fm_port_get_buff_layout_ext_params(struct fm_port_drv_t *port,
> +> 	> 	> 	> 	> 	struct fm_port_params *params)

(Evolution 3.16 is a piece of ...).

> +{
> +	params->data_align = 0;
> +}
> +EXPORT_SYMBOL(fm_port_get_buff_layout_ext_params);

Ditto.

> +int fm_get_tx_port_channel(struct fm_port_drv_t *port)
> +{
> +	return port->tx_ch;
> +}
> +EXPORT_SYMBOL(fm_get_tx_port_channel);

Ditto.

> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/fm_port_drv.c

> +void fm_set_rx_port_params(struct fm_port_drv_t *port,
> +			   struct fm_port_params *params)
> +{
+	[...]
> +}
> +EXPORT_SYMBOL(fm_set_rx_port_params);

Ditto.

(If you hear about my arrest for randomly attacking innocent people:
blame evolution 3.16!)

> +void fm_set_tx_port_params(struct fm_port_drv_t *port,
> +			   struct fm_port_params *params)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(fm_set_tx_port_params);

Ditto.

> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/port/fm_port.c

> +u64 *fm_port_get_buffer_time_stamp(const struct fm_port_t *p_fm_port,
> +				   char *p_data)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(fm_port_get_buffer_time_stamp);

Ditto.

> +int fm_port_disable(struct fm_port_t *p_fm_port)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(fm_port_disable);

This exports a function that I think is only used inside this file.

> +int fm_port_enable(struct fm_port_t *p_fm_port)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(fm_port_enable);

And here I could again find no users of this function.

Thanks,


Paul Bolle
