Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id F301EDE052
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 00:50:29 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1998005ywh.39
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Jan 2009 05:50:27 -0800 (PST)
Message-ID: <fa686aa40901030550w3d9f7f87i81b2d8447e891f78@mail.gmail.com>
Date: Sat, 3 Jan 2009 06:50:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Copy bootable images in the default install
	script
In-Reply-To: <20081220005720.23861.18505.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081220005720.23861.18505.stgit@localhost.localdomain>
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben, Kumar & Josh; any comments on this?

Thanks,
g.

On Fri, Dec 19, 2008 at 5:57 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch makes the default install script (arch/powerpc/boot/install.sh)
> copy the bootable image files into the install directory.  Before this
> patch only the vmlinux image file was copied.
>
> This patch makes the default 'make install' command useful for embedded
> development when $(INSTALL_PATH) is set in the environment.
>
> As a side effect, this patch changes the calling convention of the
> install.sh script.  Instead of a single 5th parameter, the script is now
> passed a list of all the target images stored in the $(image-y) Makefile
> variable.  This should be backwards compatible with existing install scripts
> since it just adds additional arguments and does not change existing ones.
>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/boot/Makefile   |    2 +-
>  arch/powerpc/boot/install.sh |   14 +++++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 3d3daa6..b6187ca 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -355,7 +355,7 @@ $(obj)/zImage.initrd:       $(addprefix $(obj)/, $(initrd-y))
>        @rm -f $@; ln $< $@
>
>  install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
> -       sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
> +       sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
>
>  # anything not in $(targets)
>  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
> diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
> index b002bfd..51b2387 100644
> --- a/arch/powerpc/boot/install.sh
> +++ b/arch/powerpc/boot/install.sh
> @@ -15,7 +15,7 @@
>  #   $2 - kernel image file
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
> -#   $5 - kernel boot file, the zImage
> +#   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
>  #
>
>  # User may have a custom install script
> @@ -38,3 +38,15 @@ fi
>
>  cat $2 > $4/$image_name
>  cp $3 $4/System.map
> +
> +# Copy all the bootable image files
> +path=$4
> +shift 4
> +while [ $# -ne 0 ]; do
> +       image_name=`basename $1`
> +       if [ -f $path/$image_name ]; then
> +               mv $path/$image_name $path/$image_name.old
> +       fi
> +       cat $1 > $path/$image_name
> +       shift
> +done;
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
