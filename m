Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8711FDDEBF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 04:04:51 +1100 (EST)
Message-ID: <47A9E8AB.1050804@freescale.com>
Date: Wed, 06 Feb 2008 11:04:43 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3] [POWERPC] bootwrapper: build multiple cuImages
References: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
In-Reply-To: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> -ifneq ($(CONFIG_DEVICE_TREE),"")
> -image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
> -image-$(CONFIG_PPC_EP88XC)		+= zImage.ep88xc
> -image-$(CONFIG_EP405)			+= zImage.ep405
> -image-$(CONFIG_8260)			+= cuImage.pq2
> -image-$(CONFIG_EP8248E)			+= zImage.ep8248e
> -image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
> -image-$(CONFIG_STORCENTER)		+= cuImage.824x
> -image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
> -image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
> -ifeq ($(CONFIG_CPM2),y)
> -image-$(CONFIG_PPC_85xx)		+= cuImage.85xx-cpm2
> -endif
> -image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
> +#
> +# Targets which embed a device tree blob
> +#
> +# Theses are default targets to build images which embed device tree blobs.
> +# They are only required on boards which do not have FDT support in firmware.
> +# Boards with newish u-boot firmare can use the uImage target above
> +#
> +
> +# Board ports in arch/powerpc/platform/40x/Kconfig
> +image-$(CONFIG_EP405)			+= zImage-dtb.ep405
> +image-$(CONFIG_WALNUT)			+= treeImage.walnut
> +
> +# Board ports in arch/powerpc/platform/44x/Kconfig
>  image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
>  image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
>  image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
>  image-$(CONFIG_RAINIER)			+= cuImage.rainier
> -image-$(CONFIG_WALNUT)			+= treeImage.walnut
>  image-$(CONFIG_TAISHAN)			+= cuImage.taishan
>  image-$(CONFIG_KATMAI)			+= cuImage.katmai
>  image-$(CONFIG_WARP)			+= cuImage.warp
> -endif
>  
> -ifneq ($(CONFIG_REDBOOT),"")
> -image-$(CONFIG_PPC_8xx)			+= zImage.redboot-8xx
> -endif
> +# Board ports in arch/powerpc/platform/8xx/Kconfig
> +image-$(CONFIG_PPC_MPC86XADS)		+= cuImage.mpc866ads
> +image-$(CONFIG_PPC_MPC885ADS)		+= zImage-dtb.mpc885ads

mpc885ads is cuImage.

> +# Board ports in arch/powerpc/platform/83xx/Kconfig
> +image-$(CONFIG_MPC8313_RDB)		+= cuImage.mpc8313erdb

I don't think we need cuImage for this board (no pre-device-tree u-boot).

> +image-$(CONFIG_MPC837x_MDS)		+= cuImage.mpc8377_mds \
> +					   cuImage.mpc8378_mds \
> +					   cuImage.mpc8379_mds

I really hope we don't need cuImage for these. :-)

I wish CONFIG_BOARD_FOO could be annotated with properties such as image 
   name and bootwrapper platform, rather than having to maintain 
separate lists...  Oh well.

-Scott
