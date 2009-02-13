Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 002/002] de2104x: support for systems lacking cache
	coherence
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Risto Suominen <risto.suominen@gmail.com>
In-Reply-To: <46e1c7760902120322r11cffbdcgff330a242ca586fb@mail.gmail.com>
References: <46e1c7760902120322r11cffbdcgff330a242ca586fb@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 14:25:57 +1100
Message-Id: <1234495557.26036.0.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-12 at 13:22 +0200, Risto Suominen wrote:
> Here is a patch that helped me to get my de2104x NIC working on my
> PowerMac 5500. As an interesting side effect, it also made my mesh
> module crash.
> 
> Background can be found here: http://www.spinics.net/lists/netdev/msg88488.html

I'll catch up with the discussion in netdev, I think the workaround
should be in the driver... Or if not, we can do special dma-ops just for
that device.

Just to make sure I didn't miss something, please send me a tarball
of /proc/device-tree of your machine.

Cheers,
Ben.

> Risto
> 
> Allow setting NOT_COHERENT_CACHE explicitly.
> 
> Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
> ---
> The testing is done on kernel version 2.6.24.
> 
> --- a/arch/powerpc/platforms/powermac/Kconfig.org	2008-01-25
> 00:58:37.000000000 +0200
> +++ b/arch/powerpc/platforms/powermac/Kconfig	2009-02-10
> 17:44:24.000000000 +0200
> @@ -18,4 +18,10 @@ config PPC_PMAC64
>  	select PPC_970_NAP
>  	default y
> 
> -
> +config NOT_COHERENT_CACHE
> +	bool "Incoherent cache"
> +	default n
> +	help
> +	  Setting this option may be necessary for avoiding cache-related
> +	  problems with some network cards on some platforms. An example is
> +	  2104x and PowerMac 5500.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
