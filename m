Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 399B8DDF6C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:23:42 +1100 (EST)
Date: Tue, 18 Mar 2008 00:23:04 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: powerpc: cuImage.* creation error
Message-ID: <20080317222304.GA1931@cs181133002.pp.htv.fi>
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
	<20080317200754.GA7383@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080317200754.GA7383@windriver.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 04:07:55PM -0400, Paul Gortmaker wrote:
> In message: powerpc: cuImage.* creation error
> on 17/03/2008 Adrian Bunk wrote:
> 
> > When building all powerpc defconfigs in 2.6.25-rc6 exactly three of 
> > them fail to build, and all with similar problems:
> > 
> > <--  snip  -->
> > 
> > 
> > sbc8548_defconfig:
> > 
> > <--  snip  -->
> > 
> > ...
> > Entry Point:  0x00000000
> > make[2]: *** No rule to make target `arch/powerpc/boot/cuImage.tqm8548', needed by `arch/powerpc/boot/zImage'.  Stop.
> > 
> 
> Untested, but I'll guess that this is at least part of the problem for
> the sbc one...

It doesn't fix the build, and adds sbc8560_defconfig to the list of 
non-compiling defconfigs:

<--  snip  -->

...
  WRAP    arch/powerpc/boot/cuImage.sbc8560
DTC: dts->dtb  on file "/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/dts/sbc8560.dts"
powerpc64-linux-ld: arch/powerpc/boot/cuboot-sbc8560.o: No such file: No such file or directory
make[2]: *** [arch/powerpc/boot/cuImage.sbc8560] Error 1

<--  snip  -->

> Thanks,
> Paul.
> 
> ---
> 
> Author: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date:   Mon Mar 17 15:47:03 2008 -0400
> 
>     cuimage: fix board names in Makefile
>     
>     Fix the copy and paste error from 25431333813686654907ab987fb5de10c10a16db
>     for the sbc8548 and sbc8560
>     
>     Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 4974d9e..1aded8f 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -253,8 +253,8 @@ image-$(CONFIG_TQM8540)			+= cuImage.tqm8540
>  image-$(CONFIG_TQM8541)			+= cuImage.tqm8541
>  image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
>  image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
> -image-$(CONFIG_SBC8548)			+= cuImage.tqm8548
> -image-$(CONFIG_SBC8560)			+= cuImage.tqm8560
> +image-$(CONFIG_SBC8548)			+= cuImage.sbc8548
> +image-$(CONFIG_SBC8560)			+= cuImage.sbc8560
>  
>  # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
>  image-$(CONFIG_STORCENTER)		+= cuImage.storcenter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
