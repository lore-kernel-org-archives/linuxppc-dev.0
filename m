Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24F0F2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 10:15:59 +1000 (EST)
Message-ID: <5036C7AE.9020500@freescale.com>
Date: Thu, 23 Aug 2012 19:15:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V9] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345714301-13027-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1345714301-13027-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2012 04:31 AM, Jia Hongtao wrote:
> +static void mpc85xx_cds_pci_assign_primary(void)
> +{
> +#ifdef CONFIG_PCI
> +	struct device_node *np;
> +
> +	if (fsl_pci_primary)
> +		return;
> +
> +	/*
> +	 * MPC85xx_CDS has ISA bridge but unfortunately there is no
> +	 * isa node in device tree. We now looking for i8259 node as
> +	 * a temporary workaround for such a broken device tree.
> +	 * This can go away once the device tree is updated.
> +	 */

It cannot go away once the device tree is updated, because we maintain
support for old device trees within reason.  It's not like this is core
kernel code; the cost of having this compatibility here is minimal, even
if the device trees we're staying compatible with are technically
broken.  Compare that to customer support effort if this breaks
someone's custom board with a forked device tree, or if upgrading the
device tree breaks someone's old U-Boot.

-Scott
