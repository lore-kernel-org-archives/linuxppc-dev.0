Return-Path: <tmb@mandriva.org>
Received: from mbox2.netikka.net (mbox2.netikka.net [213.250.81.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F3F6B6EEE
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 07:03:40 +1000 (EST)
Message-ID: <4C5732A7.2050003@mandriva.org>
Date: Tue, 03 Aug 2010 00:03:35 +0300
From: Thomas Backlund <tmb@mandriva.org>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: make 3.82 fails on powerpc defconfig update [was: Linux 2.6.35]
References: <AANLkTim8FALeVG+NPLNLEQChu=dPD=GHSpnxmZHYgsNx@mail.gmail.com>
	<4C5686FF.9010803@mandriva.org>
	<20100802182848.GA16394@merkur.ravnborg.org>
	<4C572EB0.7060706@mandriva.org>
	<20100802205121.GA16520@merkur.ravnborg.org>
In-Reply-To: <20100802205121.GA16520@merkur.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"bug-make@gnu.org" <bug-make@gnu.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Backlund <tmb@mandriva.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

02.08.2010 23:51, Sam Ravnborg skrev:
>>
>> Thanks, this seems to fix the first issue, but then I get the same erro on the following line 190:
>>
>> 190: bootwrapper_install %.dtb:
>> 191:        $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>>
> 
> Obviously - dunno how I missed that.
> Updated patch below.
> 
> I will do a proper submission after you
> confirm that powerpc build is working with make 3.82.
> 

Yeah, that was an obvious fix, thanks!

One small typo fix below...
(a missing ':')

Otherwise it works here, so:

Tested-by: Thomas Backlund <tmb@mandriva.org>

> 	Sam
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 77cfe7a..ace7a3e 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -163,9 +163,11 @@ drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
>  # Default to zImage, override when needed
>  all: zImage
>  
> -BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
> +# With make 3.82 we cannot mix normal and wildcard targets
> +BOOT_TARGETS1 := zImage zImage.initrd uImaged
> +BOOT_TARGETS2 := zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
>  
> -PHONY += $(BOOT_TARGETS)
> +PHONY += $(BOOT_TARGETS1) $(BOOT_TARGETS2)
>  
>  boot := arch/$(ARCH)/boot
>  
> @@ -180,10 +182,16 @@ relocs_check: arch/powerpc/relocs_check.pl vmlinux
>  zImage: relocs_check
>  endif
>  
> -$(BOOT_TARGETS): vmlinux
> +$(BOOT_TARGETS1): vmlinux
> +	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
> +$(BOOT_TARGETS2): vmlinux
> +	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
> +
> +
> +bootwrapper_install

bootwrapper_install:

>  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
> -bootwrapper_install %.dtb:
> +%.dtb:
>  	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>  
>  define archhelp
> .
> 

--
Thomas
