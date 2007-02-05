Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E96A5DDE2C
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 12:41:58 +1100 (EST)
Subject: Re: [PATCH] powermac: clean up PIC initialisation code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1170375448.4036.33.camel@johannes.berg>
References: <1170375448.4036.33.camel@johannes.berg>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 12:41:48 +1100
Message-Id: <1170639708.2620.77.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> --- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-02 01:09:19.949914899 +0100
> +++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2007-02-02 01:09:30.366914899 +0100
> @@ -756,7 +756,11 @@ define_machine(powermac) {
>  	.setup_arch		= pmac_setup_arch,
>  	.init_early		= pmac_init_early,
>  	.show_cpuinfo		= pmac_show_cpuinfo,
> +#ifdef CONFIG_PPC32
>  	.init_IRQ		= pmac_pic_init,
> +#else
> +	.init_IRQ		= pmac_mpic_init,
> +#endif

Not fan of having an ifdef here... I'd rather have a pmac_pic_init()
that does the right thing, maybe in setup.c

Ben.
