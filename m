Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDA83DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 17:10:15 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1J6A9HI009912
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 23:10:10 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1J6A8kX018099
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 00:10:08 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC v1] virtio: add virtio-over-PCI driver
Date: Thu, 19 Feb 2009 14:10:08 +0800
Message-ID: <7DF0AF56456B8F4081E3C44CCCE311DE15199F@zch01exm23.fsl.freescale.net>
In-Reply-To: <20090217222425.GA18801@ovro.caltech.edu>
References: <20090217222425.GA18801@ovro.caltech.edu>
From: "Zang Roy-R61911" <tie-fei.zang@freescale.com>
To: "Ira Snyder" <iws@ovro.caltech.edu>, <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@ozlabs
> .org] On Behalf Of Ira Snyder
> Sent: Wednesday, February 18, 2009 6:24 AM
> To: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@ozlabs.org; netdev@vger.kernel.org; Rusty=20
> Russell; Arnd Bergmann; Jan-Bernd Themann
> Subject: [RFC v1] virtio: add virtio-over-PCI driver
snip
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 3dd6294..efcf56b 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -33,3 +33,25 @@ config VIRTIO_BALLOON
> =20
>  	 If unsure, say M.
> =20
> +config VIRTIO_OVER_PCI_HOST
> +	tristate "Virtio-over-PCI Host support (EXPERIMENTAL)"
> +	depends on PCI && EXPERIMENTAL
> +	select VIRTIO
> +	---help---
> +	  This driver provides the host support necessary for=20
> using virtio
> +	  over the PCI bus with a Freescale MPC8349EMDS=20
> evaluation board.
> +
> +	  If unsure, say N.
> +
> +config VIRTIO_OVER_PCI_FSL
> +	tristate "Virtio-over-PCI Guest support (EXPERIMENTAL)"
> +	depends on MPC834x_MDS && EXPERIMENTAL
> +	select VIRTIO
> +	select DMA_ENGINE
> +	select FSL_DMA
> +	---help---
> +	  This driver provides the guest support necessary for=20
> using virtio
> +	  over the PCI bus.
> +
> +	  If unsure, say N.
> +
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 6738c44..f31afaa 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -2,3 +2,5 @@ obj-$(CONFIG_VIRTIO) +=3D virtio.o
>  obj-$(CONFIG_VIRTIO_RING) +=3D virtio_ring.o
>  obj-$(CONFIG_VIRTIO_PCI) +=3D virtio_pci.o
>  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o
> +obj-$(CONFIG_VIRTIO_OVER_PCI_HOST) +=3D vop_host.o
> +obj-$(CONFIG_VIRTIO_OVER_PCI_FSL) +=3D vop_fsl.o
I suppose we  need to build the kernel twice. one for vop_host  (on host
with pci enabled) and the
other is for vop_fsl ( on agent with pci disabled). Is it possible to
build one image for both host and=20
agent.  We do not scan the pci bus if the controller is configured to
agent.

Also, is it possible to include mpc85xx architecture? They should be
same.
There is some code for 85xx in Fresscale BSP.
http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8568MDS_PCI_Agent_PCIe_
EP_Drvier.patch
Roy
