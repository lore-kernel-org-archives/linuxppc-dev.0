Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF6E7DDF23
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 18:04:50 +1100 (EST)
Date: Fri, 07 Mar 2008 16:04:21 +0900 (JST)
Message-Id: <20080307.160421.-1300529901.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 2/11] celleb: move the base part for celleb support
In-Reply-To: <200803051236.57425.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 March 2008, Ishizaki Kou wrote:
> > This patch moves the base code for celleb support into platforms/cell/.
> > All files in this patch are used by celleb-beat and celleb-native commonly.
> 
> Moving around the files this way is good, but
> 
> > +++ b/arch/powerpc/platforms/cell/Makefile       2008-03-04 14:00:28.000000000  +0900 
> > @@ -26,3 +26,20 @@
> >                                          ? spufs/
> > 
> >  obj-$(CONFIG_PCI_MSI)                  += axon_msi.o
> > +
> > +
> > +# celleb stuff
> > +ifeq ($(CONFIG_PPC_CELLEB),y)
> > +obj-y                                  += celleb_setup.o \
> > +                                          celleb_pci.o celleb_scc_epci.o \
> > +                                          celleb_scc_pciex.o \
> > +                                          celleb_scc_uhc.o \
> > +                                          beat.o beat_htab.o beat_hvCall.o \
> > +                                          beat_interrupt.o beat_iommu.o \
> > +                                          io-workarounds.o spider-pci.o
> > +
> > +obj-$(CONFIG_SMP)                      += beat_smp.o
> > +obj-$(CONFIG_PPC_UDBG_BEAT)            += beat_udbg.o
> > +obj-$(CONFIG_SERIAL_TXX9)              += celleb_scc_sio.o
> > +obj-$(CONFIG_SPU_BASE)                 += beat_spu_priv1.o
> > +endif
> 
> This looks like you are referencing files in the Makefile that are moved
> in the later patches. In order to make the git-bisect work correctly
> on the kernel after the patches are applied, I'd suggest either moving
> all files at once, or to modify the Makefile in every step of the way
> so that the kernel still builds.

Thanks for your advice.

I'll split changing the Makefile because the moving patches is too
large to be one patch.

Best regards,
Kou Ishizaki
