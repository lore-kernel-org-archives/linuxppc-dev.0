Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05FD31A002C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 06:53:32 +1000 (EST)
Message-ID: <1409086376.6510.82.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc: fsl_pci: Add forced PCI Agent enumeration
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 26 Aug 2014 15:52:56 -0500
In-Reply-To: <2036664217.106423.1409010857961.JavaMail.zimbra@xes-inc.com>
References: <2036664217.106423.1409010857961.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Minghuan Lian <minghuan.lian@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-25 at 18:54 -0500, Aaron Sierra wrote:
> The following commit prevents the MPC8548E on the XPedite5200 PrPMC
> module from enumerating its PCI/PCI-X bus:
> 
>     powerpc/fsl-pci: use 'Header Type' to identify PCIE mode
> 
> The previous patch prevents any Freescale PCI-X bridge from enumerating
> the bus, if it is hardware strapped into Agent mode.
> 
> In PCI-X, the Host is responsible for driving the PCI-X initialization
> pattern to devices on the bus, so that they know whether to operate in
> conventional PCI or PCI-X mode as well as what the bus timing will be.
> For a PCI-X PrPMC, the pattern is driven by the mezzanine carrier it is
> installed onto. Therefore, PrPMCs are PCI-X Agents, but one per system
> may still enumerate the bus.
> 
> This patch causes the device node of any PCI/PCI-X bridge strapped into
> Agent mode to be checked for the fsl,pci-agent-force-enum property. If
> the property is present in the node, the bridge will be allowed to
> enumerate the bus.
> 
> Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  .../bindings/pci/fsl,pci-agent-force-enum.txt      | 27 ++++++++++++++++++++++
>  arch/powerpc/sysdev/fsl_pci.c                      |  3 ++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,pci-agent-force-enum.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,pci-agent-force-enum.txt b/Documentation/devicetree/bindings/pci/fsl,pci-agent-force-enum.txt
> new file mode 100644
> index 0000000..d8ac4a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,pci-agent-force-enum.txt

This ought to be part of a general fsl,pci binding, rather than its own
file.  Unfortunately there isn't such a binding yet, but let's call this
something like "fsl,pci.txt" anyway so that there's a place to add the
rest of the binding to.

Also, CC devicetree@vger.kernel.org on all device tree patches.

Otherwise it looks OK.

-Scott
