Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 14:46:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/8] boot: use a common zImage rule
Message-ID: <20070322034649.GL2295@localhost.localdomain>
References: <boot-2-00.miltonm@bga.com> <boot-2-08.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-2-08.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 09:03:23AM -0600, Milton Miller wrote:
> Before the plethora of platforms gets any worse, establish a common
> rule to invoke the wrapper for any platform.  Add arguments to
> the rule for initrd, dts, dtb, etc.   Show example usage with initrd.
> 
> Create default rules for zImage, and zImage.initrd.  initrd targets
> depend on the ramdisk file.
> 
> Don't consider targets for zImage.initrd that are targets for zImage.
> This means uImage is no longer considered a target for
> zImage.initrd.

This seems happy enough on Ebony now (with Ebony overriding the
default targets).

Just one nit..

> Index: kernel/arch/powerpc/boot/Makefile
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/Makefile	2007-03-21 03:27:37.000000000 -0500
> +++ kernel/arch/powerpc/boot/Makefile	2007-03-21 03:37:32.000000000 -0500
> @@ -116,50 +116,10 @@ CROSSWRAP := -C "$(CROSS_COMPILE)"
>  endif
>  endif
>  
> +# args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
>  quiet_cmd_wrap	= WRAP    $@
> -      cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) vmlinux
> -quiet_cmd_wrap_initrd = WRAP    $@
> -      cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> -				-i $(obj)/ramdisk.image.gz vmlinux

The mixture of tabs and spaces in the line above causes emacs to
whinge about a suspicious line every time you try to save.  Needless
to say, that's kind of irritating...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
