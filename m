Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45F1CB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 15:00:30 +1000 (EST)
Subject: Re: [PATCH] Add cmd64x IDE driver to default pmac32 config
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: lawrence rust <lawrence@softsystem.co.uk>
In-Reply-To: <1278181316.3232.45.camel@gagarin>
References: <1278181316.3232.45.camel@gagarin>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 15:00:21 +1000
Message-ID: <1278565221.28659.74.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-07-03 at 20:21 +0200, lawrence rust wrote:
> The Blue/White Apple PowerMac G3 and early G4's use a cmd64x compatible
> IDE disk controller.  E.g. lspci shows...
> 
> 01:01.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 07)
> 
> Unfortunately the default pmac32 configuration does not include this
> driver and so PowerMac G3's can't load a root filesystem.  This is an
> issue on a least Ubuntu since version 9.04, which uses the default
> config as a starting point.
> 
> Signed-off-by: Lawrence Rust <lawrence at softsystem.co.uk>

Shouldn't we just switch the whole thing to libata now anyways ?

Cheers,
Ben.

> diff -uprN a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig 
> --- a/arch/powerpc/configs/pmac32_defconfig	2010-05-16 23:17:36.000000000 +0200
> +++ b/arch/powerpc/configs/pmac32_defconfig	2010-07-03 20:11:10.000000000 +0200
> @@ -738,7 +738,7 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
>  # CONFIG_BLK_DEV_AEC62XX is not set
>  # CONFIG_BLK_DEV_ALI15X3 is not set
>  # CONFIG_BLK_DEV_AMD74XX is not set
> -# CONFIG_BLK_DEV_CMD64X is not set
> +CONFIG_BLK_DEV_CMD64X=y
>  # CONFIG_BLK_DEV_TRIFLEX is not set
>  # CONFIG_BLK_DEV_CS5520 is not set
>  # CONFIG_BLK_DEV_CS5530 is not set
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
