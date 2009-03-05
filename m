Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 11C4DDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 18:11:47 +1100 (EST)
Date: Thu, 5 Mar 2009 01:13:56 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Only build Axon MSI driver for IBM Cell
	Blades
Message-ID: <20090305071356.GA9412@lixom.net>
References: <e9c405aaec255c2a3d34209fc35ae093fcae8efc.1236228043.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9c405aaec255c2a3d34209fc35ae093fcae8efc.1236228043.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 05, 2009 at 03:41:41PM +1100, Michael Ellerman wrote:
> The hardware is only present on those machines, and the driver
> depends on infrastructure which is selected by the Kconfig for
> cell blades.

Wouldn't it make more sense to make a separate (AXON_MSI) config option
depend on PPC_IBM_CELL_BLADE?


-Olof

> --- a/arch/powerpc/platforms/cell/Makefile
> +++ b/arch/powerpc/platforms/cell/Makefile
> @@ -28,7 +28,9 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
>  					   $(spu-manage-y) \
>  					   spufs/
>  
> +ifeq ($(CONFIG_PPC_IBM_CELL_BLADE),y)
>  obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
> +endif
>  
>  # qpace setup
>  obj-$(CONFIG_PPC_CELL_QPACE)		+= qpace_setup.o
