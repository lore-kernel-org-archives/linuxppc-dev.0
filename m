Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4114EDDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 16:28:19 +1000 (EST)
In-Reply-To: <1181715391.9397.16.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
	<f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
	<1181715391.9397.16.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4a8562ccb7046ccde1ab81c725139878@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 08:28:08 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	np = of_find_node_by_name(NULL, "global-utilities");
> +	if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {

If this of_get_property fails...

> +		const u32 *prop = of_get_property(np, "reg", NULL);
> +		if (prop) {
> +			/* map reset control register
> +			 * 0xE00B0 is offset of reset control register
> +			 */
> +			rstcr = ioremap(get_immrbase() + *prop + 0xB0, 0xff);
> +			if (!rstcr)
> +				printk (KERN_EMERG "Error: reset control \
> +					register not mapped, spinning!\n");
> +		}
> +		of_node_put(np);

...you still leak a reference.


Segher
