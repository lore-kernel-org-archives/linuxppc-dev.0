Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96E7DB7DA8
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 07:20:23 +1000 (EST)
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1274298809-12772-1-git-send-email-timur@freescale.com>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 07:20:13 +1000
Message-ID: <1274304013.1931.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-19 at 14:53 -0500, Timur Tabi wrote:
> Add the DTS_PADDING Kconfig option, which allows users and board defconfig
> files to specify a padding value when compiling device trees.
> 
> When a device tree source (DTS) is compiled into a binary (DTB), a hard-coded
> padding of 1024 bytes is used (i.e. dtc command-line parameter "-p 1024").
> Although this has worked so far, it may not be sufficient in the future for
> some boards.  Newer versions of U-boot perform more and more fixup on the
> device tree, and eventually it will run out.
> 
> So to accommodate future boards where more padding is needed, we make the
> option for the -p parameter configurable.

Can't u-boot just allocate more space ?

Ben.

> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/boot/Makefile     |    4 ++--
>  arch/powerpc/platforms/Kconfig |   13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index bb2465b..750fa6b 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -35,7 +35,7 @@ endif
>  
>  BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
>  
> -DTS_FLAGS	?= -p 1024
> +DTS_FLAGS	?= -p ${CONFIG_DTS_PADDING}
>  
>  $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
>  $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
> @@ -331,7 +331,7 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>  # Rule to build device tree blobs
>  DTC = $(objtree)/scripts/dtc/dtc
>  
> -$(obj)/%.dtb: $(dtstree)/%.dts
> +$(obj)/%.dtb: $(dtstree)/%.dts $(srctree)/.config
>  	$(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(dtstree)/$*.dts
>  
>  # If there isn't a platform selected then just strip the vmlinux.
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index d1663db..2b0a9c3 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -41,6 +41,19 @@ config PPC_OF_BOOT_TRAMPOLINE
>  
>  	  In case of doubt, say Y
>  
> +config DTS_PADDING
> +	int "Padding for the device tree binary"
> +	default 1024
> +	help
> +	  Specify the padding value to be used when compiling a DTS (device
> +	  tree source) file into a DTB (device tree binary).  The padding is
> +	  used to ensure enough space for any additional nodes and properties
> +	  that the boot loader adds during fix-up.  If your boot loader
> +	  complains about lack of space during fix-up, try increasing this
> +	  value.
> +
> +	  If unsure, leave this value at the default.
> +
>  config UDBG_RTAS_CONSOLE
>  	bool "RTAS based debug console"
>  	depends on PPC_RTAS
