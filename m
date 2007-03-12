Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67676DDFBB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:13:05 +1100 (EST)
In-Reply-To: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DDBDA810-5555-49CF-A31B-9327A7C96EB0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Date: Mon, 12 Mar 2007 16:12:07 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 12, 2007, at 3:42 PM, Scott Wood wrote:

> Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
> U-Boot, and inserts data from it into a device tree which has been
> compiled into the kernel.  This should help ease the transition to
> arch/powerpc in cases where U-Boot has not yet been updated to pass a
> device tree, or where upgrading firmware isn't practical.
>
> The device trees currently in the kernel tree must have
> /chosen/linux,stdout-path added to work with cuboot.
>
> The kernel command line, mac addresses, and various clocks will be  
> filled
> in based on the bd_t.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/Kconfig                      |   16 ++++
>  arch/powerpc/Makefile                     |    2 +-
>  arch/powerpc/boot/.gitignore              |    3 +
>  arch/powerpc/boot/Makefile                |   20 ++++-
>  arch/powerpc/boot/cuboot-83xx.c           |    4 +
>  arch/powerpc/boot/cuboot-85xx.c           |    4 +
>  arch/powerpc/boot/cuboot-86xx.c           |    4 +
>  arch/powerpc/boot/cuboot.c                |  137 ++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/boot/ppcboot.h               |  103 ++++++++++++++++++ 
> ++++
>  arch/powerpc/boot/wrapper                 |   46 ++++++++--
>  arch/powerpc/platforms/83xx/mpc834x_mds.c |    5 +-
>  11 files changed, 329 insertions(+), 15 deletions(-)
>  create mode 100644 arch/powerpc/boot/cuboot-83xx.c
>  create mode 100644 arch/powerpc/boot/cuboot-85xx.c
>  create mode 100644 arch/powerpc/boot/cuboot-86xx.c
>  create mode 100644 arch/powerpc/boot/cuboot.c
>  create mode 100644 arch/powerpc/boot/ppcboot.h
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6dfbd52..54f7b34 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -967,6 +967,22 @@ config SECCOMP
>
>  	  If unsure, say Y. Only embedded should say N here.
>
> +config CUIMAGE_DTS
> +	string "Device tree source file"
> +	depends on DEFAULT_UIMAGE
> +	help
> +	  This specifies the device tree source (.dts) file to be
> +	  compiled and included when building the cuImage target.  If a
> +	  relative filename is given, then it will be relative to
> +	  arch/powerpc/boot/dts.
> +
> +	  The cuImage target is used for booting on older U-Boot (and
> +	  PPCBoot) bootloaders that pass a bd_t instead of a device tree.
> +	  Such a kernel will not work with a newer U-Boot that passes the
> +	  device tree itself.  If your U-Boot does not mention a device
> +	  tree in "help bootm", then use the uImage target instead of
> +	  cuImage.
> +
>  endmenu

Why don't we make this more generic a reference the DTS regardless if  
you are using CUIMAGE?

- k
