Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB9F46801B
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:47:40 +1100 (EST)
Subject: Re: [PATCH 5/5] [POWERPC] 8xx: Add mpc885ads support and common
	mpc8xx.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20061114012831.17455.32542.stgit@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012831.17455.32542.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 13:47:34 +1100
Message-Id: <1163472455.5940.75.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Few comments..

> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +int __init mpc8xx_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "mpc8xx"))
> +		return 1;
> +
> +	return 0;
> +}

Why hooks on that ?

Normally, board support files test for their specific board. Thus they
have their own probe() function, generally static just before the ppc_md
definition. You probably want to remove the above,.

> +define_machine(mpc885_ads) {
> +	.name			= "MPC885 ADS",
> +	.probe			= mpc8xx_probe,

Do your own probe function that specifically checks for and MPC885 ADS
board.
