Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 829A6DDF22
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2007 22:04:36 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Mon, 2 Jul 2007 14:03:29 +0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	while ((node = of_get_next_child(adap_node, node))) {

of_for_each_child_node() or whatever it is called?

> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> +			continue;

Addresses aren't 16 bit AFAIK?

> +		name = of_get_property(node, "compatible", NULL);
> +		if (!name)
> +			name = node->name;
> +		if (!name)
> +			continue;

Look at "name" first, then look at "compatible", not
the other way around.

> +		model = of_get_property(node, "model", NULL);
> +		if (!model)
> +			model = name;

No way.  "model" and "name" have nothing in common
semantically.

> +		/* FIXME: the i2c code should allow drivers to specify
> +		 * multiple match names; board code shouldn't need to
> +		 * know what driver will handle a given type.
> +		 */

This should be handled by the OF matching stuff, there
is no direct connection between device tree naming and
Linux driver naming.  I don't want to see this patch
going in without this problem being fixed first.


Segher
