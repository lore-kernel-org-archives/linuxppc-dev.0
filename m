Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2802BDDF13
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 03:50:33 +1000 (EST)
Message-ID: <48691BA2.3050001@denx.de>
Date: Mon, 30 Jun 2008 19:45:06 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] powerpc/bootwrapper: Add documentation of boot wrapper
	targets
References: <20080628050407.6067.90225.stgit@trillian.secretlab.ca>
In-Reply-To: <20080628050407.6067.90225.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> There have been many questions on and off the mailing list about how
> exactly the bootwrapper is used for embedded targets.  Add some
> documentation and help text to try and clarify the system.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

<snip>

> diff --git a/Documentation/powerpc/bootwrapper.txt b/Documentation/powerpc/bootwrapper.txt
> new file mode 100644
> index 0000000..a03d73c
> --- /dev/null
> +++ b/Documentation/powerpc/bootwrapper.txt
> @@ -0,0 +1,141 @@
> +The PowerPC boot wrapper
> +------------------------
> +Copyright (C) Secret Lab Technologies Ltd.
> +
> +PowerPC image targets compresses and wraps the kernel image (vmlinux) with
> +a boot wrapper to make it usable by the system firmware.  There is no
> +standard PowerPC firmware interface, so the boot wrapper is designed to
> +be adaptable for each kind of image that needs to be built.
> +
> +The boot wrapper can be found in the arch/powerpc/boot/ directory.  The
> +Makefile in that directory has targets for all the available image types.
> +The different image types are used to support all of the various firmware
> +interfaces found on PowerPC platforms.  OpenFirmware is the most commonly
> +used firmare type on general purpose PowerPC systems from Apple, IBM and

typo, s/firmare/firmware/

<snip>

> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index b7d4c4c..754c7eb 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -169,12 +169,25 @@ bootwrapper_install %.dtb:
>  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
>  define archhelp
> -  @echo '* zImage          - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> +  @echo '* zImage          - Build default images selected by kernel config'
> +  @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> +  @echo '  uImage          - U-Book native image format'

typo, s/U-Book/U-Boot/

> +  @echo '  cuImage.<dt>    - Backwards compatible U-Boot image for older'
> +  @echo '                    versions which do not support device trees'
> +  @echo '  dtbImage.<dt>   - zImage with an embedded device tree blob'
> +  @echo '  simpleImage.<dt> - Firmware independant image.'

typo, s/independant/independent/

Cheers,
Anatolij
