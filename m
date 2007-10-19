Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 275C4DDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:07:02 +1000 (EST)
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7D8D790@corpexc01.corp.networkrobots.com>
References: <mailman.1363.1192734606.3099.linuxppc-dev@ozlabs.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D7D8D790@corpexc01.corp.networkrobots.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB4A8767-275D-4DBB-A573-99F858D29D4A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Building zImage
Date: Fri, 19 Oct 2007 08:07:42 -0500
To: Siva Prasad <sprasad@bivio.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 6:22 PM, Siva Prasad wrote:

> Hi,
>
> When I tried to build zImage (make zImage V=1) based on the 2.6.19
> kernel for 8641HPCN board, I got the following error...
>
> make -f scripts/Makefile.build obj=lib
> make -f
> /export/beavis/work/sprasad/2.6.19/linux-2.6.19/scripts/ 
> Makefile.modpost
> vmlinux
>   scripts/mod/modpost -m  -o
> /export/beavis/work/sprasad/2.6.19/linux-2.6.19/Module.symvers
> vmlinux
> rm -f .old_version
> make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot
> arch/powerpc/boot/zImage
> ln: accessing `arch/powerpc/boot/zImage': No such file or directory
> make[1]: *** [arch/powerpc/boot/zImage] Error 1
> make: *** [zImage] Error 2
>
> When I looked into the Makefile, "image-y" was having no value. So,  
> "ln"
> was failing. Do I have to select one of the below options of zImage. I
> am not really sure which one to use for 8641 supported by FreeScale.
>
> image-$(CONFIG_PPC_PSERIES)             += zImage.pseries
> image-$(CONFIG_PPC_MAPLE)               += zImage.pseries
> image-$(CONFIG_PPC_IBM_CELL_BLADE)      += zImage.pseries
> image-$(CONFIG_PPC_CHRP)                += zImage.chrp
> image-$(CONFIG_PPC_PMAC)                += zImage.pmac
> image-$(CONFIG_DEFAULT_UIMAGE)          += uImage
>
> Well!... we are not using U-Boot, so uImage is not an option, and that
> builds fine.
>
> Any way, I tried to make uImage, but I am not sure if it is including
> the dts file in the final uImage built, as the wrapper was passed the
> value of platform as "uboot". I am confused.
>
> Thanks for your help in advance.

uImage's do NOT include device trees as part of the image.

- k
