Return-Path: <jdl@jdl.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile 
In-Reply-To: Your message of "Wed, 18 Oct 2006 17:26:35 PDT."
	<20061019002635.GA2356@mag.az.mvista.com>
References: <20061019002635.GA2356@mag.az.mvista.com> 
Date: Thu, 19 Oct 2006 09:03:18 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GaYUQ-0001jb-20@jdl.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Mark A. Greer" mumbled:
> 
> This would be used by the sandpoint, say, by adding the following rules
> to the Makefile in the appropriate places:
> 
> 	$(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
> 		$(call cmd,wrap_dts,sandpoint)
> 
> 	$(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
> 		$(call cmd,wrap_dts_initrd,sandpoint)
> 
> and:
> 
> 	image-$(CONFIG_SANDPOINT)               += zImage.sandpoint
> 
> Comments?

Isn't there a way to do this without hardcoding the
platform name in the makefiles directly?  I fear for
the one-per-platform effect that is yet to come with
the conversion of many of the legacy boards.


> +++ b/arch/powerpc/boot/Makefile
> @@ -117,6 +117,13 @@ quiet_cmd_wrap	= WRAP    $@
>  quiet_cmd_wrap_initrd = WRAP    $@
>        cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
>  				-i $(obj)/ramdisk.image.gz vmlinux
> +quiet_cmd_wrap_dts = WRAP_DTS    $@
> +      cmd_wrap_dts =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> +				-s $(obj)/dts/$2.dts vmlinux
> +quiet_cmd_wrap_dts_initrd = WRAP_DTS    $@
> +      cmd_wrap_dts_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 \
> +				$(CROSSWRAP) -s $(obj)/dts/$2.dts \
> +				-i $(obj)/ramdisk.image.gz vmlinux
>  
>  $(obj)/zImage.chrp: vmlinux $(wrapperbits)
>  	$(call cmd,wrap,chrp)

Which I guess means this patch is OK, but the zImage.chrp use
around it is suspect.... :-)

jdl
