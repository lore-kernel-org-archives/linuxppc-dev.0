Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 168B2B6F0A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 14:43:41 +1100 (EST)
Date: Mon, 21 Dec 2009 21:48:19 -0600
From: Olof Johansson <olof@lixom.net>
To: Peter Tyser <ptyser@xes-inc.com>
Subject: Re: [PATCH v2 2/3] powerpc: Add support for creating FIT uImages
Message-ID: <20091222034819.GA24012@lixom.net>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Dec 21, 2009 at 07:50:42PM -0600, Peter Tyser wrote:
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index bb2465b..e56ec21 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -310,6 +310,9 @@ $(obj)/zImage.iseries: vmlinux
>  $(obj)/uImage: vmlinux $(wrapperbits)
>  	$(call if_changed,wrap,uboot)
>  
> +$(obj)/uImage.fit.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> +	$(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb)
> +
>  $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>  	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
>  
> @@ -349,7 +352,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
>  
>  # anything not in $(targets)
>  clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
> -	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
> +	uImage.* zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \

Please no. It's not entirely uncommon that I will save a "known good"
binary in the build tree for a while, by copying it aside with a different
suffix. That'd give me one very big surprise in this case.


-Olof
