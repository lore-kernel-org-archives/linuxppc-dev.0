From: Michele.Pallaro@alcatel.it
Message-ID: <402270F3.AD39E32@alcatel.it>
Date: Thu, 05 Feb 2004 17:36:03 +0100
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: eric lescouet <eric.lescouet@Jaluna.COM>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux kernel and u-boot for mpc8540
References: <4021F487.660E680B@alcatel.it> <40220DC0.2050105@Jaluna.COM> <20040205091232.A15092@home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I try to download from ppc.bkbits.net, but I have a proxy problem.
About the metrowerks I'll try to contact.

Thanks
    Michele

Matt Porter wrote:

> On Thu, Feb 05, 2004 at 10:32:48AM +0100, eric lescouet wrote:
> >
> > Michele,
> >
> > Support for mpc8540 is already in linuxppc-2.4 tree.
> > see ppc.bkbits.net
>
> Actually, the linuxppc-2.4 support is incomplete, there's no TSEC/FEC
> driver or other on-chip peripheral drivers in that tree to make it
> really useful. You could just use a PCI network card to nfsroot a
> filesystem and get started, though.
>
> http://www.metrowerks.com/MW/Develop/Embedded/Linux/BSP.htm has
> an 8560ADS BSP for download...it probably has some drivers for
> on-chip peripherals included.
>
> BTW, you'll need the following patch to linuxppc-2.4 to fix outbound
> PCI mem cycles:
>
> ===== arch/ppc/platforms/mpc85xx_ads_common.c 1.3 vs edited =====
> --- 1.3/arch/ppc/platforms/mpc85xx_ads_common.c Thu Jan 22 12:58:25 2004
> +++ edited/arch/ppc/platforms/mpc85xx_ads_common.c      Thu Feb  5 09:10:34 2004@@ -316,8 +316,8 @@
>         pci->piwar2 = 0;
>         pci->piwar3 = 0;
>
> -       /* Setup 128M outbound mem window @ 0xe0000000 */
> -       pci->potar1 = 0x00000000;
> +       /* Setup 128M Phys:PCI 1:1 outbound mem window @ 0xe0000000 */
> +       pci->potar1 = (MPC85XX_ADS_PCI_LOWER_MEM >> 12) & 0x000fffff;
>         pci->potear1 = 0x00000000;
>         pci->powbar1 = (MPC85XX_ADS_PCI_LOWER_MEM >> 12) & 0x000fffff;
>         pci->powar1 = 0x8004401a;       /* Enable, Mem R/W, 128M */
>
> -Matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
