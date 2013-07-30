Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3705C2C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 10:19:33 +1000 (EST)
Date: Mon, 29 Jul 2013 19:19:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
Subject: Re: [1/1] MPC831x: fix PCI express probing
Message-ID: <20130730001913.GA8120@home.buserror.net>
References: <1369657783-19962-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1369657783-19962-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 27, 2013 at 02:29:43PM +0200, Sergey Gerasimov wrote:
> For MPC831x the bus probing function also needs the fixup to assign
> addresses to the PCI devices as it was for MPC85xx and MPC86xx.
> The fixup of the bridge vendor and device ID should be done early in
> PCI probing. Else the bridge is not detected as FIXUP_HEADER is called
> too late.
> 
> Signed-off-by: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
> 
> ---
> arch/powerpc/sysdev/fsl_pci.c | 68 +++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 028ac1f..94d1bd4 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -84,6 +84,34 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
>  	return 0;
>  }
>  
> +void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
> +	int i;
> +
> +
> +	if ((bus->parent == hose->bus)
> +		&& ((fsl_pcie_bus_fixup
> +			&& pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP))
> +			|| (hose->indirect_type
> +				& PPC_INDIRECT_TYPE_NO_PCIE_LINK))) {
> +		for (i = 0; i < 4; ++i) {
> +			struct resource *res = bus->resource[i];
> +			struct resource *par = bus->parent->resource[i];
> +			if (res) {
> +				res->start = 0;
> +				res->end   = 0;
> +				res->flags = 0;
> +			}
> +			if (res && par) {
> +				res->start = par->start;
> +				res->end   = par->end;
> +				res->flags = par->flags;
> +			}
> +		}
> +	}
> +}

Why are you moving this function?  This makes it hardaer to see the
changes you make -- and is likely the cause of unintended changes being
made due to a bad conflict resolution.  In particular, you seem to be
reverting commit 13635dfdc6aa8d2890e02dc441decfcb4ae63e14
("powerpc/fsl/pci: Fix PCIe fixup regression").

Also please confirm that the problem still exists in after "Fix PCIe
fixup regression".

-Scott
