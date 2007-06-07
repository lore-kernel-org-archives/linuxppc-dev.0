Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A00BDDEAB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 23:06:00 +1000 (EST)
In-Reply-To: <1181148145.5674.121.camel@rhino>
References: <1181148145.5674.121.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2a56a9d008269d393c68959f1804c21d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] When checking I8042 io port,
	use of_find_compatible_node() instead of of_find_node_by_type()
Date: Thu, 7 Jun 2007 15:05:51 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In check_legacy_ioport(), instead of using of_find_node_by_type() to
> find the 8042 node, use of_find_compatible_node() to find either the
> keyboard or mouse node.

Why?

>  	switch(base_port) {
>  	case I8042_DATA_REG:
> -		np = of_find_node_by_type(NULL, "8042");
> +		np = of_find_compatible_node(NULL, NULL, "pnpPNP,303");
> +		if (!np)
> +			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
> +		if (np) {
> +			parent = of_get_parent(np);
> +			of_node_put(np);
> +			np = parent;
> +		}

This breaks other boards using 8042, if those exist --
if this code is board-specific, it is in the wrong file.


Segher
