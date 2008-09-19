Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id A326FDDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 17:57:08 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so285458rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 00:57:07 -0700 (PDT)
Date: Fri, 19 Sep 2008 00:56:53 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] bootwrapper: support u-boot multi component images
Message-ID: <20080919075653.GA10241@secretlab.ca>
References: <1221504833-5096-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1221504833-5096-1-git-send-email-jacmet@sunsite.dk>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 15, 2008 at 08:53:53PM +0200, Peter Korsgaard wrote:
> From: peter Korsgaard <jacmet@sunsite.dk>
> 
> Support uImage.<platform>, which are U-Boot multi component images
> containing a kernel, dtb and possibly an initrd.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  Documentation/powerpc/bootwrapper.txt |    4 ++++
>  arch/powerpc/boot/Makefile            |   11 +++++++++--
>  arch/powerpc/boot/wrapper             |   20 +++++++++++++++++++-
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/powerpc/bootwrapper.txt b/Documentation/powerpc/bootwrapper.txt
> index d60fced..f0b34b3 100644
> --- a/Documentation/powerpc/bootwrapper.txt
> +++ b/Documentation/powerpc/bootwrapper.txt
> @@ -91,6 +91,10 @@ Currently, the following image format targets exist:
>  			a device tree to the kernel at boot.  If using an older
>  			version of U-Boot, then you need to use a cuImage
>  			instead.
> +   uImage.thinx:	U-Boot multi component image. Similar to uImage,

Change this to "uImage.%:" to match the rest of this document.

> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 717a3bc..41ab6aa 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -352,7 +359,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
>  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
>  	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
>  	zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
> -	otheros.bld *.dtb
> +	otheros.bld uImage.* *.dtb

Actually, you can probably make this "uImage*" instead because plain
'uImage' targets are missing from this list.

>  
>  # clean up files cached by wrapper
>  clean-kernel := vmlinux.strip vmlinux.bin
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 965c237..b7c0b23 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -153,7 +153,7 @@ coff)
>      lds=$object/zImage.coff.lds
>      link_address='0x500000'
>      ;;
> -miboot|uboot)
> +miboot|uboot|uboot-*)

Similarly, uboot and uboot-* can probably be collapsed to 'uboot*'

g.
