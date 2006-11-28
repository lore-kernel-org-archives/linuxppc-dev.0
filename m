Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF9B067BE2
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 11:59:52 +1100 (EST)
Message-ID: <456B89FD.5000007@am.sony.com>
Date: Mon, 27 Nov 2006 16:59:41 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [POWERPC 7/9] ps3: add a default zImage target
References: <20061127181851.796747000@arndb.de>
	<20061127182431.436201000@arndb.de>
In-Reply-To: <20061127182431.436201000@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> It's currently not possible to build the default zImage
> target if PS3 is the only selected platform. This is
> a hack to fall back to building the pseries style
> zImage, so the build is successful. This will probably
> change in the future, if someone writes a PS3 specific
> boot wrapper.
> 
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> Index: linux-2.6/arch/powerpc/boot/Makefile
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/boot/Makefile
> +++ linux-2.6/arch/powerpc/boot/Makefile
> @@ -155,6 +155,7 @@ $(obj)/uImage: vmlinux $(wrapperbits)
>  image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
>  image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
>  image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
> +image-$(CONFIG_PPC_PS3)			+= zImage.pseries
>  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
>  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
>  image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage

A better solution here is to make image-$(CONFIG_PPC_PS3) a stripped
vmlinux, which the current PS3 bootloader (2.6.16 kboot) will be able
to load.

I'll set that up and send out a new patch.

I started work on that zImage bootwrapper, but I have other items I'm
tring to finish up.

-Geoff
