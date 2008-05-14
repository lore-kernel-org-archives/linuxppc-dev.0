Return-Path: <dan.j.williams@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by ozlabs.org (Postfix) with ESMTP id B2B6DDDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 09:46:19 +1000 (EST)
Subject: Re: [patch 1/1] fsldma: the MPC8377MDS board device tree node for
	fsldma	driver
From: Dan Williams <dan.j.williams@intel.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <482B7588.1010201@freescale.com>
References: <200805142317.m4ENHNlm026461@imap1.linux-foundation.org>
	<482B7588.1010201@freescale.com>
Content-Type: text/plain
Date: Wed, 14 May 2008 16:36:30 -0700
Message-Id: <1210808190.17120.1.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Cc: "Nelson, Shannon" <shannon.nelson@intel.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, galak@gate.crashing.org,
	akpm@linux-foundation.org, leoli@freescale.com, wei.zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[adding Li Yang (new fsldma maintainer) to the cc]

On Wed, 2008-05-14 at 16:28 -0700, Scott Wood wrote:
> akpm@linux-foundation.org wrote:
> > From: Zhang Wei <wei.zhang@freescale.com>
> >
> > The fsldma driver is tested on MPC8377MDS board.  The patch adds fsldma driver
> > support into MPC8377MDS device tree.
> >
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > Cc: "Nelson, Shannon" <shannon.nelson@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Kumar Gala <galak@gate.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  arch/powerpc/boot/dts/mpc8377_mds.dts |   27 ++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff -puN arch/powerpc/boot/dts/mpc8377_mds.dts~fsldma-the-mpc8377mds-board-device-tree-node-for-fsldma-driver arch/powerpc/boot/dts/mpc8377_mds.dts
> > --- a/arch/powerpc/boot/dts/mpc8377_mds.dts~fsldma-the-mpc8377mds-board-device-tree-node-for-fsldma-driver
> > +++ a/arch/powerpc/boot/dts/mpc8377_mds.dts
> > @@ -295,6 +295,33 @@
> >                       };
> >               };
> > 
> > +             dma@82a8 {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +                     compatible = "fsl,mpc8349-dma";
> > +                     reg = <0x82a8 4>;
> > +                     ranges = <0 0x8100 0x1a8>;
> > +                     interrupt-parent = <&ipic>;
> > +                     interrupts = <0x47 8>;
> > +                     cell-index = <0>;
> > +                     dma-channel@0 {
> > +                             compatible = "fsl,mpc8349-dma-channel";
> > +                             reg = <0 0x80>;
> > +                     };
> > +                     dma-channel@80 {
> > +                             compatible = "fsl,mpc8349-dma-channel";
> > +                             reg = <0x80 0x80>;
> > +                     };
> > +                     dma-channel@100 {
> > +                             compatible = "fsl,mpc8349-dma-channel";
> > +                             reg = <0x100 0x80>;
> > +                     };
> > +                     dma-channel@180 {
> > +                             compatible = "fsl,mpc8349-dma-channel";
> > +                             reg = <0x180 0x28>;
> > +                     };
> 
> According to booting-without-of.txt, the interrupts property should be
> repeated in each channel.  The driver also needs to be fixed to remember
> whether it registered a DMA-block-level interrupt handler already, and
> not try to register a channel interrupt.
> 
> -Scott
> 
> 
