Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5452DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 15:03:14 +1000 (EST)
Subject: Re: [v2 PATCH 1/1] Fix 64bit Maple Host Bridge 'reg' property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tiejun.china@gamil.com
In-Reply-To: <1239704021-12431-1-git-send-email-tiejun.china@gamil.com>
References: <1239704021-12431-1-git-send-email-tiejun.china@gamil.com>
Content-Type: text/plain
Date: Fri, 01 May 2009 15:02:21 +1000
Message-Id: <1241154141.1781.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-04-14 at 18:13 +0800, tiejun.china@gamil.com wrote:
> In the DTB tree created by firmware on some Maple 64bit targets, such as ATCA6101, 
> the "reg" property of host bridge node is incorrectly encoded as if #address-cells 
> and #size-cells were 1. So we have to provide one fixup function to fix that.
> 
> Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>

Almost there :-)

> +	/*  FIXME: This may be used for more Maple targets not only ATCA6101. */
> +	node = call_prom("finddevice", 1, 1, ADDR("/"));
> +	model = prom_getprop(node, "model", prop, sizeof(prop));

Couldn't you use _prom->root above ?

> +	if (model != PROM_ERROR && (strcmp(prop, "Motorola,ATCA-6101") == 0))
> +                fixup_device_tree_atca6101();
>  
>  	name = "/ht@0/isa@4";
>  	isa = call_prom("finddevice", 1, 1, ADDR(name));

Cheers,
Ben.
