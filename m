Return-Path: <lorenzo.pieralisi@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yd6fn6tgFzDr0n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:49:51 +1100 (AEDT)
Date: Thu, 16 Nov 2017 16:49:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "M.h. Lian" <minghuan.lian@nxp.com>, robh+dt@kernel.org
Cc: Leo Li <leoyang.li@nxp.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Sumit Garg <sumit.garg@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
 Andy Tang <andy.tang@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "songxiaowei@hisilicon.com" <songxiaowei@hisilicon.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Z.q. Hou" <zhiqiang.hou@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
Message-ID: <20171116164939.GA30182@e107981-ln.cambridge.arm.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-2-xiaowei.bao@nxp.com>
 <20b8f1d2-f817-469f-afbf-66f25d6f8c46@ti.com>
 <AM4PR0401MB16999BD34AFBB1362BD32EBD8F540@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <VI1PR04MB161516288A0FF2F507DAA9BEE82B0@VI1PR04MB1615.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR04MB161516288A0FF2F507DAA9BEE82B0@VI1PR04MB1615.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 13, 2017 at 02:35:48AM +0000, M.h. Lian wrote:

[...]

> > > On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> > > > Add the property of inbound and outbound windows number for ep driver.
> > > >
> > > > Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> > > > Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
> > > > ---
> > > >  v2:
> > > >  - no change
> > > >  v3:
> > > >  - modify the commit message
> > > >  v4:
> > > >  - no change
> > > >
> > > >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > >
> > > $subject should start with something like
> > > arm64: dts: ls1046a: **

Indeed.

> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > > b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > > index 06b5e12d04d8..f8332669663c 100644
> > > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > > @@ -674,6 +674,8 @@
> > > >  			device_type = "pci";
> > > >  			dma-coherent;
> > > >  			num-lanes = <4>;
> > > > +			num-ib-windows = <6>;
> > > > +			num-ob-windows = <6>;
> > >
> > > EP specific properties shouldn't be added in RC dt node. Ideally you
> > > should have a separate dt node for RC and EP.
> > 
> > It is a single PCIe controller which can be configured to either RC
> > mode or EP mode.  Wouldn't it conflict with the device tree
> > principles to have two device tree nodes for the same PCIe
> > controller?  And obviously the two modes cannot be used at the same
> > time so we cannot have two drivers both probe on the same hardware.
> > 
> [Minghuan Lian]  There is only one PCIe dts node in the dts file. PCIe
> dts node describes the PCIe controller's hardware properties and does
> not have work mode.  The new properties  "num-ib-windows " and
> "num-ob-windows" are used to describe the inbound/outbound window
> number included in the PCIe hardware. These windows are used in both
> RC and EP mode.  We can change work mode when resetting via RCW(reset
> configuration word).

I am not happy about this (that's what I am asking Rob to chime in
please on DT side).

1) I do not think it is allowed to have two DT nodes in a dts with same unit
   address (ie same reg property)

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/dra7.dtsi?h=v4.14

2) In the Synopsis Designware PCIe interface bindings we have some
   properties that are for RC mode and some for EP mode but there is
   no way from a *binding* perspective to detect in what mode the
   controller is:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/designware-pcie.txt?h=v4.14

3) You can't use properties that in the bindings above are declared EP
   only for RC mode, we define bindings to respect their rules.

4) I think that a) a compatible should be added to the designware-pcie
   bindings to define endpoint mode and b) the same should be done for
   the ls1046a bindings. If the RC is programmed in EP mode DT firmware
   should be able to provide the information to an operating system, it
   is actually a _different_ component but on this I need DT people to
   chime in to define the best way forward.

I cannot review/merge this code until the points above are clarified.

Thanks,
Lorenzo
