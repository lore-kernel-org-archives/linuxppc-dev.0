Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33166DE0A8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 04:01:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5HI1qRL022668
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 11:01:53 -0700 (MST)
Message-ID: <4857FC11.8080903@freescale.com>
Date: Tue, 17 Jun 2008 13:01:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH] MPC5121 FEC support
References: <1213724880-14965-1-git-send-email-jrigby@freescale.com>
In-Reply-To: <1213724880-14965-1-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch should go through Jeff Garzik and be CCed to 
netdev@vger.kernel.org.

John Rigby wrote:
>   drivers/net/fs_enet/fs_enet-main.c
>     Add a routine for conditionally copying TX skb's that
>     are not aligned.  Only do this if fep->fpi->align_tx_packets
>     is set.
>     In fs_enet_probe set fpi->align_tx_packets to 1 if
>     the device node has the property fsl,align-tx-packets.

How about setting the property to the size that it needs to be aligned to?

> +/*
> + * The 5121 FEC doc says transmit buffers must have 4 byte alignment,
> + * however testing has shown that 2 byte alignment works fine except
> + * for buffers that end in 0x1e.
> + *
> + * Testing with iperf shows about 30% cpu load when copying all packets
> + * vs 19% when only copying 0x1e packets.
> + */
> +static struct sk_buff *align_tx_skb(struct net_device *dev, struct sk_buff *skb)
> +{
> +	struct sk_buff *skbn;
> +	int align = ((unsigned long)skb->data) & (0x1e);
> +
> +	if (align != 0x1e)
> +		return skb;

Are we guaranteed that skb->data is always 2-byte aligned, even with 
obscure protocols?

> +	if (!skbn) {
> +		printk(KERN_WARNING DRV_MODULE_NAME
> +			": %s Memory squeeze, dropping tx packet.\n",
> +			dev->name);

Does this need to be rate-limited?

> -	if (!IS_FEC(match)) {
> +	if (IS_FEC(match)) {
> +		if (of_get_property(ofdev->node, "fsl,align-tx-packets", NULL))
> +			fpi->align_tx_packets = 1;

Might as well check for the property regardless of which ethernet type 
it is, in case a similar bug crops up elsewhere.

-Scott
