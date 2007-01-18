Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10098DDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:39:40 +1100 (EST)
Subject: Re: [PATCH 17/19] powerpc: hypervisor console driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701120117.l0C1HbGR010830@toshiba.co.jp>
References: <200701120117.l0C1HbGR010830@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:40:04 +1100
Message-Id: <1169080804.4965.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +/* temp */
> +static int hvc_beat_init(void)
> +{
> +	struct hvc_struct *hp;
> +
> +	hp = hvc_alloc(0, NO_IRQ, &hvc_beat_get_put_ops, 16);
> +	if (IS_ERR(hp))
> +		return PTR_ERR(hp);
> +	hvc_beat_dev = hp;
> +	return 0;
> +}

Please test your are running on beat before initializing your stuff as
your driver might be built as part of a kernel that can boot other
machines. 

> +static void __exit hvc_beat_exit(void)
> +{
> +	if (hvc_beat_dev)
> +		hvc_remove(hvc_beat_dev);
> +}
> +
> +module_init(hvc_beat_init);
> +module_exit(hvc_beat_exit);
> +
> +__setup("hvc_beat=", hvc_beat_config);
> +
> +console_initcall(hvc_beat_console_init);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
