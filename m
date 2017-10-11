Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yC3BZ4hVbzDr5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 05:57:26 +1100 (AEDT)
Date: Wed, 11 Oct 2017 13:57:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, marc.zyngier@arm.com,
 robh+dt@kernel.org, mark.rutland@arm.com, bhelgaas@google.com,
 shawnguo@kernel.org, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
 roy.zang@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
Message-ID: <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2017 at 05:26:53PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set adds ls1012a MSI and PCIe support, including driver
> and device tree nodes. The ls1046a's MSI support patch and PCIe
> driver patch has been applied, so only adds the PCIe device tree
> nodes.
> 
> Hou Zhiqiang (5):
>   irqchip/ls-scfg-msi: add LS1012a MSI support
>   arm64: dts: ls1012a: Add MSI controller DT node
>   PCI: layerscape: Add support for ls1012a
>   arm64: dts: ls1012a: Add PCIe controller DT node
>   arm64: dts: ls1046a: add PCIe controller DT nodes
> 
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
>  .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75 ++++++++++++++++++++++
>  drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
>  drivers/pci/dwc/pci-layerscape.c                   |  1 +
>  6 files changed, 110 insertions(+)

I'm not 100% sure who should take these.  They trivially touch PCI and
I haven't seen anybody else respond, so I put them on
pci/host-layerscape with Rob's acks.

If somebody else wants to take them, just let me know and I'll drop
them.

They really should be acked by Minghuan or Mingkai, who are listed as
the maintainers of drivers/pci/dwc/pci-layerscape.c and are presumably
responsible for the related dtsi files, too.

Thomas, Jason, and Marc are listed as maintainers of
drivers/irqchip/irq-ls-scfg-msi.c.  It's a trivial change, but I added
them to the cc list.
