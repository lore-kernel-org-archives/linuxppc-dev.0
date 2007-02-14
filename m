Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E091DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:21:37 +1100 (EST)
Subject: Re: [PATCH] celleb: fix CONFIG_KEXEC dependency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200702140655.l1E6tFlp005523@toshiba.co.jp>
References: <200702140655.l1E6tFlp005523@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:21:30 +1100
Message-Id: <1171488090.20192.165.camel@localhost.localdomain>
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

On Wed, 2007-02-14 at 15:55 +0900, Ishizaki Kou wrote:
> celleb_kexec_cpu_down() depends on CONFIG_KEXEC.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
> diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.23
> --- linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.1.1.1	Thu Feb  8 11:38:20 2007
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c	Fri Feb  9 18:31:50 2007
> @@ -137,10 +137,12 @@
>  	return -ENODEV;
>  }
>  
> +#ifdef CONFIG_KEXEC
>  static void celleb_kexec_cpu_down(int crash, int secondary)
>  {
>  	beatic_deinit_IRQ();
>  }
> +#endif
>  
>  static struct of_device_id celleb_bus_ids[] = {
>  	{ .type = "scc", },
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
