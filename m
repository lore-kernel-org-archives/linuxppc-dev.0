Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 16:40:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/6] bootwrapper: Add a cuImage target.
Message-ID: <20070323054048.GA27940@localhost.localdomain>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194928.GE31965@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194928.GE31965@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 02:49:28PM -0500, Scott Wood wrote:
> The cuImage target calls the wrapper with a cuboot platform chosen
> based on the kernel config, as opposed to the uboot platform.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/Makefile        |    2 +-
>  arch/powerpc/boot/.gitignore |    3 +++
>  arch/powerpc/boot/Makefile   |   13 +++++++++++--
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index a00fe72..e6c3add 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
>  
>  CPPFLAGS_vmlinux.lds	:= -Upowerpc
>  
> -BOOT_TARGETS = zImage zImage.initrd uImage
> +BOOT_TARGETS = zImage zImage.initrd uImage cuImage
>  
>  PHONY += $(BOOT_TARGETS)
>  
> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index 0734b2f..eec7af7 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -18,6 +18,9 @@ kernel-vmlinux.strip.c
>  kernel-vmlinux.strip.gz
>  mktree
>  uImage
> +cuImage
> +cuImage.bin.gz
> +cuImage.elf
>  zImage
>  zImage.chrp
>  zImage.coff
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 43179b4..93c25f8 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -43,7 +43,8 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
>  src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>  		gunzip_util.c $(zlib) devtree.c
> -src-plat := of.c
> +cuboot-plats :=
> +src-plat := of.c $(cuboot-plats:%=cuboot-%.c)

Rather than this special cuboot-plats stuff, I suggest you just list
each cuboot platform in src-plat independently.  We can also git rid
of the need for a CONFIG option specifying the dts (and thereby taking
us back to the one-config-per-board era) by using rules like:

$(obj)/uImage.83xx.%: vmlinux $(wrapperbits) $(srctree)/$(src)/dts/%.dts
	$(call if_changed,wrap,cuboot-83xx,$(srctree)/$(src)/dts/$*)

And to get the right things built use something like:
image-$(CONFIG-83xx)	+= $(mpx83xx-boards:%=uImage.83xx.%)

Or optionally add a batch of bool config options for each board
variant.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
