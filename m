Return-Path: <mgreer@mvista.com>
Date: Thu, 19 Apr 2007 13:03:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/10] zImage wrapper for Ebony
Message-ID: <20070419200325.GA11628@mag.az.mvista.com>
References: <20070418063517.GB29312@localhost.localdomain>
	<20070418063626.E6AADDDE3B@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070418063626.E6AADDDE3B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2007 at 04:36:26PM +1000, David Gibson wrote:
> This patch adds support for building a zImage wrapper suitable for the
> Ebony (440GP) evaluation board.  This supports booting both from uboot
> (old versions which don't supply a flattened device tree) and IBM
> Openbios (aka "treeboot").

<snip>

> Index: working-2.6/arch/powerpc/boot/Makefile
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/Makefile	2007-04-18 14:42:52.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/Makefile	2007-04-18 14:43:14.000000000 +1000

<snip>

> @@ -159,6 +168,21 @@ $(obj)/zImage.ps3: vmlinux
>  $(obj)/zImage.initrd.ps3: vmlinux
>  	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
>  
> +$(obj)/zImage.ebony-elf: vmlinux $(wrapperbits) $(obj)/ebony.dtb
> +	$(call if_changed,wrap,ebony,,$(obj)/ebony.dtb)
> +
> +$(obj)/zImage.initrd.ebony-elf: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/ramdisk.image.gz
> +	$(call if_changed,wrap,ebony,,$(obj)/ebony.dtb,$(obj)/ramdisk.img.gz)
> +
> +$(obj)/zImage.ebony: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/mktree
> +	$(call if_changed,wrap,ebony-tree,,$(obj)/ebony.dtb)
> +
> +$(obj)/zImage.initrd.ebony: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/mktree
> +	$(call if_changed,wrap,ebony-tree,,$(obj)/ebony.dtb,$(obj)/ramdisk.img.gz)
> +
> +$(obj)/uImage.ebony: vmlinux $(wrapperbits)  $(obj)/ebony.dtb
> +	$(call if_changed,wrap,ebony-uboot,,$(obj)/ebony.dtb)
> +
>  $(obj)/uImage: vmlinux $(wrapperbits)
>  	$(call if_changed,wrap,uboot)

Hi David,

It would be better to write generic rules for dtb sort of thing like
what Milton did (and what I did in "[PATCH] powerpc: Add Makefile rule
to wrap dts file in zImage")?  It'll keep our Makefile much cleaner
over the long run.

Mark
