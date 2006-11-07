Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D028667C1B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 13:04:43 +1100 (EST)
Subject: Re: [PATCH 2/5] [RFC] Add support for lite5200b to arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <11628596753992-git-send-email-grant.likely@secretlab.ca>
References: <11628596653052-git-send-email-grant.likely@secretlab.ca>
	<11628596751096-git-send-email-grant.likely@secretlab.ca>
	<11628596753992-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 13:04:32 +1100
Message-Id: <1162865073.28571.390.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static int __init lite5200_probe(void)
> +{
> +	unsigned long node = of_get_flat_dt_root();
> +	const char *model = of_get_flat_dt_prop(node, "model", NULL);
> +
> +	if (!of_flat_dt_is_compatible(node, "mpc52xx"))
> +		return 0;
> +	pr_debug("%s board w/ mpc52xx found\n", model ? model : "unknown");
> +
> +	return 1;
> +}

Are you creating a "generic" mpc52xx machine or a "lite5200b" machine ?

If you do the former, it will try to match on any board with that
compatible propery, thus any mpc52xx based board. That is probably not
what you want.

Put something like model "lite5200b" compatible "lite5200" "lite5200b"
in your / and check for that. Call you board lite5200, not mpc52xx.

Ben.
