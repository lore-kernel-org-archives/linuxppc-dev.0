Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 126B72C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 19:33:57 +1100 (EST)
Message-ID: <1389083623.11795.162.camel@snotra.buserror.net>
Subject: Re: [02/12,v3] pci: fsl: add structure fsl_pci
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <b31939@freescale.com>
Date: Tue, 7 Jan 2014 02:33:43 -0600
In-Reply-To: <52CA48C0.2020307@freescale.com>
References: <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
 <20140103221923.GB22546@home.buserror.net> <52CA48C0.2020307@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-06 at 14:10 +0800, Lian Minghuan-b31939 wrote:
> On 01/04/2014 06:19 AM, Scott Wood wrote:
> > I don't like the extent to which this duplicates (not moves) PPC's struct
> > pci_controller.  Also this leaves some fields like "indirect_type"
> > unexplained (PPC_INDIRECT_TYPE_xxx is only in the PPC header).
> >
> > Does the arch-independent part of the driver really need all this?  Given
> > how closely this tracks the PPC code, how would this work on ARM?
> [Minghuan] I added the duplicate fields because PPC's struct 
> pci_controller need them.

I think a better approach would be to create a cleanly architected
arch-independent driver.  Share what you reasonably can with the current
fsl_pci.c, but not to the extent of propagating PPCisms that don't match
up with what we ultimately want to see in generic code, or copying
things that ought to be controller-independent infrastructure into
controller-specific code.

See these threads:
http://www.spinics.net/lists/linux-pci/msg25769.html
https://lkml.org/lkml/2013/5/4/103

> The following is for ARM, I will submit them after verification:
[snip]
> +static int fsl_pcie_register(struct fsl_pcie *pcie)
> +{
> +    pcie->controller = fsl_hw_pcie.nr_controllers;
> +    fsl_hw_pcie.nr_controllers = 1;
> +    fsl_hw_pcie.private_data = (void **)&pcie;

I believe this should be:
	fsl_hw_pcie.private_data = pcie;

> +    pci_common_init(&fsl_hw_pcie);
> +    pci_assign_unassigned_resources();
> +#ifdef CONFIG_PCI_DOMAINS
> +    fsl_hw_pcie.domain++;
> +#endif

What serializes that non-atomic increment?

-Scott
