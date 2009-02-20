Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91C45DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 14:37:29 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1K3bPBW007025
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 20:37:26 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n1K3bNbs017465
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 21:37:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC v1] virtio: add virtio-over-PCI driver
Date: Fri, 20 Feb 2009 11:37:21 +0800
Message-ID: <7DF0AF56456B8F4081E3C44CCCE311DE151B64@zch01exm23.fsl.freescale.net>
In-Reply-To: <20090219161438.GA12795@ovro.caltech.edu>
References: <20090217222425.GA18801@ovro.caltech.edu>
	<7DF0AF56456B8F4081E3C44CCCE311DE15199F@zch01exm23.fsl.freescale.net>
	<20090219161438.GA12795@ovro.caltech.edu>
From: "Zang Roy-R61911" <tie-fei.zang@freescale.com>
To: "Ira Snyder" <iws@ovro.caltech.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
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
> From: Ira Snyder [mailto:iws@ovro.caltech.edu]=20
> Sent: Friday, February 20, 2009 0:15 AM
> To: Zang Roy-R61911
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
> netdev@vger.kernel.org; Rusty Russell; Arnd Bergmann;=20
> Jan-Bernd Themann
> Subject: Re: [RFC v1] virtio: add virtio-over-PCI driver
>=20
> On Thu, Feb 19, 2009 at 02:10:08PM +0800, Zang Roy-R61911 wrote:
> > =20
> >=20
> > > -----Original Message-----
> > > From:=20
> > > linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@ozlabs.org=20
> > > [mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@ozlabs
> > > .org] On Behalf Of Ira Snyder
> > > Sent: Wednesday, February 18, 2009 6:24 AM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: linuxppc-dev@ozlabs.org; netdev@vger.kernel.org; Rusty=20
> > > Russell; Arnd Bergmann; Jan-Bernd Themann
> > > Subject: [RFC v1] virtio: add virtio-over-PCI driver
> > snip
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index 3dd6294..efcf56b 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -33,3 +33,25 @@ config VIRTIO_BALLOON
> > > =20
> > >  	 If unsure, say M.
> > > =20
> > > +config VIRTIO_OVER_PCI_HOST
> > > +	tristate "Virtio-over-PCI Host support (EXPERIMENTAL)"
> > > +	depends on PCI && EXPERIMENTAL
> > > +	select VIRTIO
> > > +	---help---
> > > +	  This driver provides the host support necessary for=20
> > > using virtio
> > > +	  over the PCI bus with a Freescale MPC8349EMDS=20
> > > evaluation board.
> > > +
> > > +	  If unsure, say N.
> > > +
> > > +config VIRTIO_OVER_PCI_FSL
> > > +	tristate "Virtio-over-PCI Guest support (EXPERIMENTAL)"
> > > +	depends on MPC834x_MDS && EXPERIMENTAL
> > > +	select VIRTIO
> > > +	select DMA_ENGINE
> > > +	select FSL_DMA
> > > +	---help---
> > > +	  This driver provides the guest support necessary for=20
> > > using virtio
> > > +	  over the PCI bus.
> > > +
> > > +	  If unsure, say N.
> > > +
> > > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > > index 6738c44..f31afaa 100644
> > > --- a/drivers/virtio/Makefile
> > > +++ b/drivers/virtio/Makefile
> > > @@ -2,3 +2,5 @@ obj-$(CONFIG_VIRTIO) +=3D virtio.o
> > >  obj-$(CONFIG_VIRTIO_RING) +=3D virtio_ring.o
> > >  obj-$(CONFIG_VIRTIO_PCI) +=3D virtio_pci.o
> > >  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o
> > > +obj-$(CONFIG_VIRTIO_OVER_PCI_HOST) +=3D vop_host.o
> > > +obj-$(CONFIG_VIRTIO_OVER_PCI_FSL) +=3D vop_fsl.o
> > I suppose we  need to build the kernel twice. one for=20
> vop_host  (on host
> > with pci enabled) and the
> > other is for vop_fsl ( on agent with pci disabled). Is it=20
> possible to
> > build one image for both host and=20
> > agent.  We do not scan the pci bus if the controller is=20
> configured to
> > agent.
> >=20
>=20
> You should be able to build a kernel with support for both host and
> guest operation, and then use the device tree to switch which=20
> driver you
> get. The host driver won't be used without a PCI bus, and the guest
> driver won't be used without the message unit.
Good.
Is it necssary to commit a extra dts for the agent mode? or just
document it?

>=20
> > Also, is it possible to include mpc85xx architecture? They should be
> > same.
> > There is some code for 85xx in Fresscale BSP.
> >=20
> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8568MDS_PCI_A
> gent_PCIe_
> > EP_Drvier.patch
>=20
> I looked at the cardnet driver before I implemented my PCINet=20
> driver. I
> hunch it would be rejected for the same reasons, but maybe=20
> not.=20
That is also our concern :-(

>Also, it
> makes no use of DMA, which is critical for good transfer speed. Using
> memcpy() in PCINet gives performance around 10 mbit/sec, which is
> terrible.
I can see your improvement for performance.

>=20
> I'm sure the driver isn't very hard to port to 85xx, I just don't have
> any 85xx boards to test with. The driver only directly interacts with
> the messaging unit, which is a pretty simple piece of hardware.
No matter. It is OK to just support 83xx boards currently.
85xx baords can be dealed with later.
Finally, I hope this driver can support 83xx /85xx boards pci and pci
express mode.
Roy
