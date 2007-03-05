Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id D50CDDDF7E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 04:10:52 +1100 (EST)
Date: Mon, 5 Mar 2007 10:10:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070305171053.GC32672@mag.az.mvista.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.EDB2BDDF1D@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070305032452.EDB2BDDF1D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> This patch adds support for building a zImage wrapper suitable for the
> Ebony (440GP) evaluation board.  This supports booting both from uboot
> (old versions which don't supply a flattened device tree) and IBM
> Openbios (aka "treeboot").
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---

<snip>

> Index: working-2.6/arch/powerpc/boot/Makefile
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-26 13:25:31.000000000 +1100
> +++ working-2.6/arch/powerpc/boot/Makefile	2007-02-26 13:25:33.000000000 +1100

<snip>

> @@ -120,6 +128,13 @@ quiet_cmd_wrap_initrd = WRAP    $@
>        cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
>  				-i $(obj)/ramdisk.image.gz vmlinux
>  
> +quiet_cmd_wrap_dtb	= WRAP    $@
> +      cmd_wrap_dtb	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> +				-d $3 vmlinux
> +quiet_cmd_wrap_dtb_initrd = WRAP    $@
> +      cmd_wrap_dtb_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> +				-d $3 -i $(obj)/ramdisk.image.gz vmlinux
> +

David,

I think we more-or-less agreed to go with Scott Wood's 'wrap' method
(unless there is a problem with it).

http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031337.html

Mark
