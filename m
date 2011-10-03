Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6876DB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 05:07:19 +1100 (EST)
Message-ID: <4E89F8C1.3040509@freescale.com>
Date: Mon, 3 Oct 2011 13:02:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [PATCH v2] powerpc: book3e: WSP: Add Chroma as a new WSP/PowerEN
	platform.
References: <1317349675-18661-1-git-send-email-jimix@pobox.com>
In-Reply-To: <1317349675-18661-1-git-send-email-jimix@pobox.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/29/2011 09:27 PM, Jimi Xenidis wrote:
> diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
> index ea2811c..a3eef8e 100644
> --- a/arch/powerpc/platforms/wsp/Kconfig
> +++ b/arch/powerpc/platforms/wsp/Kconfig
> @@ -1,6 +1,7 @@
>  config PPC_WSP
>  	bool
>  	select PPC_A2
> +	select GENERIC_TBSYNC
>  	select PPC_ICSWX
>  	select PPC_SCOM
>  	select PPC_XICS
> @@ -8,14 +9,20 @@ config PPC_WSP
>  	select PCI
>  	select PPC_IO_WORKAROUNDS if PCI
>  	select PPC_INDIRECT_PIO if PCI
> +	select PPC_WSP_COPRO
>  	default n
>  
>  menu "WSP platform selection"
>  	depends on PPC_BOOK3E_64
>  
>  config PPC_PSR2
> -	bool "PSR-2 platform"
> -	select GENERIC_TBSYNC
> +	bool "PowerEN System Reference Platform 2"
> +	select EPAPR_BOOT
> +	select PPC_WSP
> +	default y
> +
> +config PPC_CHROMA
> +	bool "PowerEN PCIe Chroma Card"
>  	select EPAPR_BOOT
>  	select PPC_WSP
>  	default y

This is an existing problem with PSR2, but please don't hide "default y"
in a menu (at least make it a menuconfig).  As is, it's not obvious from
looking at the toplevel platforms menu that these platforms are enabled
at all.

Further, PPC_WSP doesn't build on non-SMP (undefined references to
boot_cpuid and get_hard_smp_processor_id in ics.c), but the platforms
that select it don't depend on SMP.

-Scott
