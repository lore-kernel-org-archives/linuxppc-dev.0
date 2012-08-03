Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B48AD2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2012 12:21:39 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V4 2/3] powerpc/swiotlb: Enable at early stage and
 disable if not necessary
Date: Fri, 3 Aug 2012 02:21:29 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A359C3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-3-git-send-email-B38951@freescale.com>
 <6DEE036D-C59B-41C6-80F3-762D7E4AF2C1@kernel.crashing.org>
In-Reply-To: <6DEE036D-C59B-41C6-80F3-762D7E4AF2C1@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, August 02, 2012 8:55 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH V4 2/3] powerpc/swiotlb: Enable at early stage and
> disable if not necessary
>=20
>=20
> On Aug 2, 2012, at 6:42 AM, Jia Hongtao wrote:
>=20
> > Remove the dependency on PCI initialization for SWIOTLB initialization.
> > So that PCI can be initialized at proper time.
> >
> > SWIOTLB is partly determined by PCI inbound/outbound map which is
> assigned
> > in PCI initialization. But swiotlb_init() should be done at the stage
> of
> > mem_init() which is much earlier than PCI initialization. So we reserve
> the
> > memory for SWIOTLB first and free it if not necessary.
> >
> > All boards are converted to fit this change.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
>=20
> This doesn't seem like it addresses our issue w/regards to not being able
> to map all of memory from PCI.

PCI init will determine ppc_swiotlb_enable due to PCI map. swiotlb_late_ini=
t
will handle all swiotlb things depend on the result of pci init.

>=20
>=20
> > arch/powerpc/include/asm/swiotlb.h       |    6 ++++++
> > arch/powerpc/kernel/dma-swiotlb.c        |   20 ++++++++++++++++++++
> > arch/powerpc/mm/mem.c                    |    3 +--
> > arch/powerpc/platforms/44x/currituck.c   |   10 ++--------
> > arch/powerpc/platforms/85xx/mpc85xx_ds.c |    1 +
> > arch/powerpc/platforms/85xx/qemu_e500.c  |    2 +-
> > arch/powerpc/sysdev/fsl_pci.c            |    5 +----
> > 7 files changed, 32 insertions(+), 15 deletions(-)
>=20
> Don't we also want to update all these:
>=20
> arch/powerpc/platforms/85xx/corenet_ds.c:
> ppc_swiotlb_enable =3D 1;
> arch/powerpc/platforms/85xx/ge_imp3a.c:         ppc_swiotlb_enable =3D 1;
> arch/powerpc/platforms/85xx/mpc8536_ds.c:
> ppc_swiotlb_enable =3D 1;
> arch/powerpc/platforms/85xx/mpc85xx_mds.c:
> ppc_swiotlb_enable =3D 1;
> arch/powerpc/platforms/85xx/p1022_ds.c:         ppc_swiotlb_enable =3D 1;
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c:
> ppc_swiotlb_enable =3D 1;
>=20

They are works fine at this point.

I will update all these boards after
[PATCH 3/3] Unify pci/pcie initialization code

>=20
> >
> > diff --git a/arch/powerpc/include/asm/swiotlb.h
> b/arch/powerpc/include/asm/swiotlb.h
> > index 8979d4c..de99d6e 100644
> > --- a/arch/powerpc/include/asm/swiotlb.h
> > +++ b/arch/powerpc/include/asm/swiotlb.h
> > @@ -22,4 +22,10 @@ int __init swiotlb_setup_bus_notifier(void);
> >
> > extern void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev);
> >
> > +#ifdef CONFIG_SWIOTLB
> > +void swiotlb_detect_4g(void);
> > +#else
> > +static inline void swiotlb_detect_4g(void) {}
> > +#endif
> > +
> > #endif /* __ASM_SWIOTLB_H */
> > diff --git a/arch/powerpc/kernel/dma-swiotlb.c
> b/arch/powerpc/kernel/dma-swiotlb.c
> > index 4ab88da..aa85550 100644
> > --- a/arch/powerpc/kernel/dma-swiotlb.c
> > +++ b/arch/powerpc/kernel/dma-swiotlb.c
> > @@ -104,3 +104,23 @@ int __init swiotlb_setup_bus_notifier(void)
> > 			      &ppc_swiotlb_plat_bus_notifier);
> > 	return 0;
> > }
> > +
> > +void swiotlb_detect_4g(void)
> > +{
> > +	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
> > +		ppc_swiotlb_enable =3D 1;
> > +}
> > +
> > +static int __init swiotlb_late_init(void)
> > +{
> > +	if (ppc_swiotlb_enable) {
> > +		swiotlb_print_info();
> > +		set_pci_dma_ops(&swiotlb_dma_ops);
> > +		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> > +	} else {
> > +		swiotlb_free();
> > +	}
> > +
> > +	return 0;
> > +}
> > +subsys_initcall(swiotlb_late_init);
> > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > index baaafde..f23c4e0 100644
> > --- a/arch/powerpc/mm/mem.c
> > +++ b/arch/powerpc/mm/mem.c
> > @@ -300,8 +300,7 @@ void __init mem_init(void)
> > 	unsigned long reservedpages =3D 0, codesize, initsize, datasize,
> bsssize;
> >
> > #ifdef CONFIG_SWIOTLB
> > -	if (ppc_swiotlb_enable)
> > -		swiotlb_init(1);
> > +	swiotlb_init(0);
> > #endif
> >
> > 	num_physpages =3D memblock_phys_mem_size() >> PAGE_SHIFT;
> > diff --git a/arch/powerpc/platforms/44x/currituck.c
> b/arch/powerpc/platforms/44x/currituck.c
> > index 9f6c33d..6bd89a0 100644
> > --- a/arch/powerpc/platforms/44x/currituck.c
> > +++ b/arch/powerpc/platforms/44x/currituck.c
> > @@ -21,7 +21,6 @@
> >  */
> >
> > #include <linux/init.h>
> > -#include <linux/memblock.h>
> > #include <linux/of.h>
> > #include <linux/of_platform.h>
> > #include <linux/rtc.h>
> > @@ -159,13 +158,8 @@ static void __init ppc47x_setup_arch(void)
> >
> > 	/* No need to check the DMA config as we /know/ our windows are all
> of
> >  	 * RAM.  Lets hope that doesn't change */
> > -#ifdef CONFIG_SWIOTLB
> > -	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
> > -		ppc_swiotlb_enable =3D 1;
> > -		set_pci_dma_ops(&swiotlb_dma_ops);
> > -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> > -	}
> > -#endif
> > +	swiotlb_detect_4g();
> > +
> > 	ppc47x_smp_init();
> > }
> >
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > index 6d3265f..56f8c8f 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > @@ -159,6 +159,7 @@ static void __init mpc85xx_ds_setup_arch(void)
> > 	if (ppc_md.progress)
> > 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
> >
> > +	swiotlb_detect_4g();
> > 	mpc85xx_ds_pci_init();
> > 	mpc85xx_smp_init();
> >
> > diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c
> b/arch/powerpc/platforms/85xx/qemu_e500.c
> > index 95a2e53..04260cd 100644
> > --- a/arch/powerpc/platforms/85xx/qemu_e500.c
> > +++ b/arch/powerpc/platforms/85xx/qemu_e500.c
> > @@ -41,7 +41,7 @@ static void __init qemu_e500_setup_arch(void)
> > {
> > 	ppc_md.progress("qemu_e500_setup_arch()", 0);
> >
> > -	fsl_pci_init();
> > +	swiotlb_detect_4g();
>=20
> removing fsl_pci_init() seems wrong.

You are right. I will fix this.
Thanks.

-Hongtao.

>=20
> > 	mpc85xx_smp_init();
> > }
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> b/arch/powerpc/sysdev/fsl_pci.c
> > index 6938792..da7a3d7 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -872,11 +872,8 @@ void __devinit fsl_pci_init(void)
> > 	 * we need SWIOTLB to handle buffers located outside of
> > 	 * dma capable memory region
> > 	 */
> > -	if (memblock_end_of_DRAM() - 1 > max) {
> > +	if (memblock_end_of_DRAM() - 1 > max)
> > 		ppc_swiotlb_enable =3D 1;
> > -		set_pci_dma_ops(&swiotlb_dma_ops);
> > -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> > -	}
> > #endif
> > }
> > #endif
> > --
> > 1.7.5.1
> >
>=20
